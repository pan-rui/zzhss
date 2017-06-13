package com.yg.service.pay.impl;

import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.service.pay.IPay;
import com.yg.service.pay.IPaymentService;
import org.apache.http.HttpEntity;
import org.apache.http.NoHttpResponseException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.HttpRequestRetryHandler;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicHeader;
import org.apache.http.protocol.HttpContext;
import org.apache.http.protocol.HttpCoreContext;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLException;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.net.ConnectException;
import java.net.UnknownHostException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.Arrays;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Created by Administrator on 2015/10/20.
 */
@Service
public class PaymentService implements IPaymentService {
    private Logger logger = LogManager.getLogger(PaymentService.class);
    private static HttpClientBuilder builder;
    static {
        System.setProperty("log4j.configurationFile", "log4j2.xml");
        initHttpClient();
    }

    static void initHttpClient() {
        HttpRequestRetryHandler retryHandler = new HttpRequestRetryHandler() {
            @Override
            public boolean retryRequest(IOException e, int i, HttpContext httpContext) {
                if (i > 3)                 //请求失败重试次数
                    return false;
                if (e instanceof NoHttpResponseException)
                    return true;
                if (e instanceof UnknownHostException)
                    return false;
                if (e instanceof InterruptedIOException)
                    return false;
                if (e instanceof ConnectException)
                    return false;
                if (e instanceof SSLException)
                    return false;
                if (!new Boolean(String.valueOf(httpContext.getAttribute(HttpCoreContext.HTTP_REQ_SENT))))
                    return true;
                return false;

            }
        };
/*        SSLConnectionSocketFactory sssf=null;
        try {
            sssf=new SSLConnectionSocketFactory(SSLContext.getDefault());
        } catch (NoSuchAlgorithmException e) {
            System.err.println("SSL Connection could not be Initialized,Default SSLContext");
            e.printStackTrace();
        };*/
        PoolingHttpClientConnectionManager pcm = new PoolingHttpClientConnectionManager(3000L, TimeUnit.MILLISECONDS);
        pcm.setMaxTotal(20);
        pcm.setDefaultMaxPerRoute(128);
        builder = HttpClients.custom();
        builder.setRetryHandler(retryHandler);
        builder.setConnectionManager(pcm);
        builder.setDefaultHeaders(Arrays.asList(new BasicHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8"), new BasicHeader("Connection", "keep-alive")));
    }

    public static HttpClient getHttpClient(boolean ssl) {
        SSLContext ctx = null;
        SSLSocketFactory ssf=null;
        try {
            ctx = SSLContext.getInstance("TLS");
        X509TrustManager tm = new X509TrustManager() {
            public X509Certificate[] getAcceptedIssuers() {
                return null;
            }
            public void checkClientTrusted(X509Certificate[] arg0,
                                           String arg1) throws CertificateException {
            }
            public void checkServerTrusted(X509Certificate[] arg0,
                                           String arg1) throws CertificateException {
            }
        };
        ctx.init(null, new TrustManager[]{tm}, null);
        ssf = new SSLSocketFactory(ctx,
                SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }
        return ssl?builder.setSSLSocketFactory(ssf).build():builder.build();
    }

    public static String execute(HttpUriRequest request, String charset, String convertType) {
        //TODO:保存交易报文
        String resultData = "";
        try {
            request.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=" + charset);
            HttpEntity entity = getHttpClient(request.getURI().getScheme().startsWith("https")).execute(request).getEntity();
            if (convertType.equalsIgnoreCase("string"))//传输类型
                resultData = EntityUtils.toString(entity, charset);
            else resultData = new String(EntityUtils.toByteArray(entity), charset);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return resultData;
    }

    @Override
    public BaseResult recharge(Map<String, String> param) {
//        BaseDao baseDao = (BaseDao) Constants.applicationContext.getBean(payType.name());//AOP切入保存报文
        IPay pay = (IPay) Constants.applicationContext.getBean(param.remove("payType"));
        Object obj = pay.getBodyInfo(param, TradeType.recharge);
        if(obj instanceof HttpUriRequest){
            String resultData = execute((HttpUriRequest)obj, pay.getConfig().get("charset"), pay.getConfig().get("resultType"));
            return resultData.contains("<is_success>T") ? new BaseResult(0, param) : new BaseResult(1, resultData);
        }else if(obj instanceof String)
            return (new BaseResult(0, (String)obj));
        return new BaseResult(ReturnCode.FAIL);
    }

    @Override
    public BaseResult withdraw(Map<String, String> param) {
        IPay pay = (IPay) Constants.applicationContext.getBean(param.remove("payType"));
        Object obj = pay.getBodyInfo(param, TradeType.withdraw);
        if(obj instanceof HttpUriRequest){
            String resultData = execute((HttpUriRequest)obj, pay.getConfig().get("charset"), pay.getConfig().get("resultType"));
            return resultData.contains("<is_success>T") ? new BaseResult(0, param) : new BaseResult(1, resultData);
        }else if(obj instanceof String)
            return (new BaseResult(0, (String)obj));
        return new BaseResult(ReturnCode.FAIL);
    }

    @Override
    public BaseResult confirmPay(Map<String, String> param) {
        IPay pay = (IPay) Constants.applicationContext.getBean(param.remove("payType"));
        return pay.checkResult(param);
    }

    @Override
    public BaseResult checkResult( Map<String, String> param) {
        IPay pay = (IPay) Constants.applicationContext.getBean(param.remove("payType"));
        return pay.checkResult(param);
    }

    @Override
    public BaseResult refund(Map<String, String> param) {
        IPay pay = (IPay) Constants.applicationContext.getBean(param.remove("payType"));
        Object obj=null;
        try {
             obj= pay.getBodyInfo(param, TradeType.refund);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("调用退款失败...订单号为:"+param.get("orderId"));
        }
        if(obj instanceof HttpUriRequest){
            String resultData = execute((HttpUriRequest)obj, pay.getConfig().get("charset"), pay.getConfig().get("resultType"));
            return resultData.contains("<is_success>T") ? new BaseResult(0, param) : new BaseResult(1, resultData);
        }else if(obj instanceof String)
            return (new BaseResult(0, (String)obj));
        return new BaseResult(ReturnCode.FAIL);
    }

}
