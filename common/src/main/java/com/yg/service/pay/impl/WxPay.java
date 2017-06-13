package com.yg.service.pay.impl;

import com.alibaba.fastjson.JSONArray;
import com.yg.base.BaseResult;
import com.yg.core.Constants;
import com.yg.pojo.Pay;
import com.yg.service.pay.IPay;
import com.yg.service.pay.IPaymentService;
import com.yg.service.pay.wx.BaseService;
import com.yg.service.pay.wx.Signature;
import com.yg.service.pay.wx.pay_protocol.RefundReqData;
import com.yg.service.pay.wx.pay_protocol.ScanPayReqData;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.dom4j.DocumentException;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.Serializable;
import java.net.MalformedURLException;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 支付宝支付处理
 * @Created: 潘锐 (2016-01-20 17:14)
 * $Rev: 573 $
 * $Author: panrui $
 * $Date: 2016-04-06 11:00:32 +0800 (周三, 06 四月 2016) $
 */
@Service
public class WxPay implements IPay {
    private Logger logger = LogManager.getLogger(WxPay.class);

    @Override
    public Map<String, String> getAuthInfo(Long id,String tradeType) {
        return JSONArray.parseArray(getPay().getHead(),Map.class).stream().filter(map -> tradeType.equals(map.get("tradeType"))).findFirst().get();
    }
    @Override
    public String getBodyInfo(final Map<String, String> params, IPaymentService.TradeType tradeType) {
        Pay pay = getPay();
        Map<String, String> contentMap = JSONArray.parseArray(pay.getContent(),Map.class).stream().filter(map -> tradeType.name().equals(map.get("tradeType"))).findFirst().get();
        Map<String, String> sParaTemp = new HashMap<>();
        //通用参数转换,要求表单参数Map中的key与数据库中的配置一样
        contentMap.forEach((k,v)->sParaTemp.put(v, params.get(k)));
        Map<String,String> authMap=getAuthInfo(getId(),tradeType.name());
        authMap.putAll(sParaTemp);
        Serializable reqObj=null;
        switch (tradeType) {
            case recharge:
                reqObj = new ScanPayReqData();break;
            case refund: reqObj=new RefundReqData();break;
        }
        Constants.mapToPO(authMap,reqObj);
        logger.info("请求的参数:");
//        authMap.forEach((k,v)->logger.info(k+"\t"+v));
        String apiUrl=getApis(tradeType.name()).get("apiUrl");
        String respStr="";
        try {
            Constants.ReflectUtil.setFieldValue(reqObj,"sign", Signature.getSign(reqObj));
            respStr= new BaseService(apiUrl).sendPost(reqObj);
        } catch (Exception e) {
            logger.error("微信退款失败....订单号为:"+authMap.get("out_trade_no"));
            e.printStackTrace();
        }
        return respStr;
    }

    @Override
    public BaseResult checkResult(Map<String,String> params,String... result) {
        //判断responsetTxt是否为true，isSign是否为true
        //responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
        //isSign不是true，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
        return null;
    }

    @Override
    public String deCode(Map<String,String> params,String... src) {
        boolean flag=false;
        try {
            flag=Signature.checkIsSignValidFromResponseString(src[1]);
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }
        return String.valueOf(flag);
    }

    /**
     * 签名
     * @param params 请求参数
     * @param src 包含 私钥,编码方式
     * @return
     */
    @Override
    public String enCode(Map<String,String> params,String... src) {
        String str=null;
        try {
            str=Signature.getSign(params);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return str;
    }

    @Override
    public Long getId() {
        return 1101l;
    }

    /**
     * MAP类型数组转换成NameValuePair类型
     * @param properties  MAP类型数组
     * @return NameValuePair类型数组
     */
/*    public List<NameValuePair> generatNameValuePair(Map<String, String> properties) {
        List<NameValuePair> nameValuePair = new ArrayList<>(properties.size());
        for (Map.Entry<String, String> entry : properties.entrySet()) {
            nameValuePair.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
        }
        return nameValuePair;
    }*/

    /**
     * 用于防钓鱼，调用接口query_timestamp来获取时间戳的处理函数
     * 注意：远程解析XML出错，与服务器是否支持SSL等配置有关
     * @return 时间戳字符串
     * @throws IOException
     * @throws DocumentException
     * @throws MalformedURLException
     */
/*    public static String query_timestamp() throws MalformedURLException,
            DocumentException, IOException {

        //构造访问query_timestamp接口的URL串
        String strUrl = ALIPAY_GATEWAY_NEW + "service=query_timestamp&partner=" + AlipayConfig.partner + "&_input_charset" +AlipayConfig.input_charset;
        StringBuffer result = new StringBuffer();

        SAXReader reader = new SAXReader();
        Document doc = reader.read(new URL(strUrl).openStream());

        List<Node> nodeList = doc.selectNodes("//alipay*//*");

        for (Node node : nodeList) {
            // 截取部分不需要解析的信息
            if (node.getName().equals("is_success") && node.getText().equals("T")) {
                // 判断是否有成功标示
                List<Node> nodeList1 = doc.selectNodes("//response/timestamp*//*");
                for (Node node1 : nodeList1) {
                    result.append(node1.getText());
                }
            }
        }

        return result.toString();
    }*/

}
