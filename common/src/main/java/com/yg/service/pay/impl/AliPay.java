package com.yg.service.pay.impl;

import com.alibaba.fastjson.JSONArray;
import com.yg.base.BaseResult;
import com.yg.pojo.Pay;
import com.yg.service.pay.IPay;
import com.yg.service.pay.IPaymentService;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.dom4j.DocumentException;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: 支付宝支付处理
 * @Created: 潘锐 (2016-01-20 17:14)
 * $Rev: 759 $
 * $Author: panrui $
 * $Date: 2016-08-15 12:27:43 +0800 (周一, 15 八月 2016) $
 */
@Service
public class AliPay implements IPay {
    private Logger logger = LogManager.getLogger(AliPay.class);

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
        Map<String, String> sPara = buildRequestPara(authMap);
/*        logger.info("请求的参数:");
        sPara.forEach((k,v)->logger.info(k+"\t"+v));*/
//        HttpPost request = new HttpPost(getApis(tradeType.name()).get("apiUrl"));
//        HttpPost request = new HttpPost("http://localhost:8088/ui/testPay");
        //设置编码集
//        List<NameValuePair> nameValuePairs = new ArrayList<>();
//        sPara.forEach((k, v) -> nameValuePairs.add(new BasicNameValuePair(k,v)));
//            request.setEntity(new UrlEncodedFormEntity(nameValuePairs,getConfig().get("charset")));
        StringBuffer sbHtml = new StringBuffer();
        sbHtml.append("<html><body><form id=\"alipaysubmit\" name=\"alipaysubmit\" action=\"" + getApis(tradeType.name()).get("apiUrl") + "\" method=\"post\">");
            sPara.forEach((k,v)->sbHtml.append("<input type=\"hidden\" name=\"" + k + "\" value=\"" + v + "\"/>"));
        //submit按钮控件请不要含有name属性
        sbHtml.append("<input type=\"submit\" value=\"确认\" style=\"display:none;\"></form></body></html>");
        sbHtml.append("<script>document.forms['alipaysubmit'].submit();</script>");
        return sbHtml.toString();
    }

    @Override
    public BaseResult checkResult(Map<String,String> params,String... result) {
        //判断responsetTxt是否为true，isSign是否为true
        //responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
        //isSign不是true，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
        String responseTxt = "false";
        if(params.get("notify_id") != null) {
            String notify_id = params.get("notify_id");
            responseTxt = verifyResponse(notify_id);
        }
        String sign = "";
        if(params.get("sign") != null) {sign = params.get("sign");}
        logger.info("收到的sing--------->"+sign);
        logger.info("解析的sign------->"+deCode(params));
        return sign.equals(deCode(params)) && responseTxt.equals("true") ? new BaseResult(0, params):new BaseResult(1,responseTxt);
    }

    @Override
    public String deCode(Map<String,String> params,String... src) {
        Map<String, String> sPara = paraFilter(params);
        logger.info("解密的Map--------->");
        sPara.forEach((k, v) -> logger.info(k + "\t" + v));
        String pari = createLinkString(sPara) + (src==null||src.length<1 ? getPay().getAppKey() : src[0]);
        return DigestUtils.md5Hex(getContentBytes(pari,src!=null&&src.length>1?src[1]:getConfig().get("charset")));
    }

    /**
     * 签名
     * @param params 请求参数
     * @param src 包含 私钥,编码方式
     * @return
     */
    @Override
    public String enCode(Map<String,String> params,String... src) {
//        params.forEach((k, v) -> logger.info(k + "\t" + v));
        String pari = createLinkString(params) + (src.length < 1 ? getPay().getAppKey() : src[0]);
        return DigestUtils.md5Hex(getContentBytes(pari,src.length>1?src[1]:getConfig().get("charset")));
    }

    @Override
    public Long getId() {
        return 1100l;
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

    /**
     * 生成要请求给支付宝的参数数组
     * @param sParaTemp 请求前的参数数组
     * @return 要请求的参数数组
     */
    public Map<String, String> buildRequestPara(Map<String, String> sParaTemp) {
        //除去数组中的空值和签名参数
        Map<String, String> sPara = paraFilter(sParaTemp);
        //生成签名结果
        String mysign = enCode(sPara);
        //签名结果与签名方式加入请求提交参数组中
        sPara.put("sign", mysign);
        sPara.put("sign_type", getConfig().get("signType"));
        return sPara;
    }

    /**
     * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
     * @param params 需要排序并参与字符拼接的参数组
     * @return 拼接后字符串
     */
    public String createLinkString(Map<String, String> params) {
        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);
        String prestr = "";
        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            String value = params.get(key);

            if (i == keys.size() - 1) {//拼接时，不包括最后一个&字符
                prestr = prestr + key + "=" + value;
            } else {
                prestr = prestr + key + "=" + value + "&";
            }
        }
        return prestr;
    }

    /**
     * 除去数组中的空值和签名参数
     * @param sArray 签名参数组
     * @return 去掉空值与签名参数后的新签名参数组
     */
    public Map<String, String> paraFilter(Map<String, String> sArray) {
        Map<String, String> result = new HashMap<String, String>();
        if (sArray == null || sArray.size() <= 0) {
            return result;
        }
        for (String key : sArray.keySet()) {
            String value = sArray.get(key);
            if (key.equalsIgnoreCase("tradeType")||value == null || value.equals("") || key.equalsIgnoreCase("sign")
                    || key.equalsIgnoreCase("sign_type")) {
                continue;
            }
            result.put(key, value);
        }
        return result;
    }

    /**
     * 获取远程服务器ATN结果,验证返回URL
     * @param notify_id 通知校验ID
     * @return 服务器ATN结果
     * 验证结果集：
     * invalid命令参数不对 出现这个错误，请检测返回处理中partner和key是否为空
     * true 返回正确信息
     * false 请检查防火墙或者是服务器阻止端口问题以及验证时间是否超过一分钟
     */
    private String verifyResponse(String notify_id) {
        //获取远程服务器ATN结果，验证是否是支付宝服务器发来的请求
//        String partner = getConfig().get("businessSn");
        String veryify_url = getApis("recharge").get("checkUrl")+ notify_id;
        String inputLine = "";
        try {
            URL url = new URL(veryify_url);
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(urlConnection
                    .getInputStream()));
            inputLine = in.readLine().toString();
        } catch (Exception e) {
            logger.error("verify..............exception,notify_id-->"+notify_id);
            e.printStackTrace();
            inputLine = "";
        }
        return inputLine;
    }

}
