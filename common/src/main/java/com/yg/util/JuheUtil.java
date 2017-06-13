package com.yg.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.pojo.Order;
import com.yg.service.impl.OrderService;
import org.springframework.util.StringUtils;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * @Description: 聚合数据工具类
 * @Created: 潘锐 (2016-02-17 15:43)
 * $Rev: 759 $
 * $Author: panrui $
 * $Date: 2016-08-15 12:27:43 +0800 (周一, 15 八月 2016) $
 */
/**
 *短信API服务调用示例代码 － 聚合数据
 *在线接口文档：http://www.juhe.cn/docs/54
 **/

public class JuheUtil {
    public static final String DEF_CHATSET = "UTF-8";
    public static final int DEF_CONN_TIMEOUT = 30000;
    public static final int DEF_READ_TIMEOUT = 30000;
    public static String userAgent =  "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36";

    //配置您申请的KEY
//    public static final String APPKEY ="*************************";

    //1.发送短信
    public static BaseResult sendSms(Map<String,Object> param){
        BaseResult result=null;
        String url ="http://v.juhe.cn/sms/send";//请求接口地址
        Map<String,Object> params = new HashMap<String,Object>();//请求参数
        params.put("dtype","json");
        params.put("key","287fe86bf1c78394f2d44abca167f747");
        params.putAll(param);
        try {
           String respText =net(url, params, "GET");
            JSONObject jsonObject=JSON.parseObject(respText);
            Integer errorCode=(Integer)jsonObject.get("error_code");
            result = errorCode == 0 ? new BaseResult(0, jsonObject.get("result")) : new BaseResult(errorCode, jsonObject.get("reason"));
        } catch (Exception e) {
            e.printStackTrace();
            result = new BaseResult(ReturnCode.FAIL);
        }
        return result;
    }

    //2.查询快递
    public static BaseResult queryExp(Map<String,Object> param){
        BaseResult result=null;
        String url ="http://v.juhe.cn/exp/index";//请求接口地址
        Map<String,Object> params = new HashMap<String,Object>();//请求参数
        params.put("key","d426ea4af7f81c55e6908f7b34b8c4d0");//应用APPKEY(应用详细页查询)
        params.put("dtype","json");//返回数据的格式,xml或json，默认json
        params.putAll(param);
            OrderService orderService= (OrderService) Constants.applicationContext.getBean("orderService");
                List<Order> orders=orderService.queryByPros(ParamsMap.newMap("logisticsId", param.get("no")));
                if(orders==null||orders.isEmpty()) return new BaseResult(ReturnCode.FAIL);
        if(!StringUtils.isEmpty(orders.get(0).getLogisticsState()))
               return new BaseResult(0,ParamsMap.newMap("list", JSONArray.parse(orders.get(0).getLogisticsState())));
        try {
            String respText =net(url, params, "GET");
            ParamsMap<String,Object> para=ParamsMap.newMap("logisticsId",param.get("no"));
            JSONObject jsonObject=JSON.parseObject(respText);
            Integer errorCode = (Integer)jsonObject.get("error_code");
            if(errorCode==0){
                Map<String,Object> logisMap= (Map<String, Object>) jsonObject.get("result");
                result=new BaseResult(0,logisMap );
                List<Map<String,String>> logises= (List<Map<String, String>>) logisMap.get("list");
                JSONObject dates = StringUtils.isEmpty(orders.get(0).getEndDeliveryTime())?new JSONObject():JSON.parseObject(orders.get(0).getEndDeliveryTime());
                if(!logises.isEmpty())
                logises.forEach(map-> {
                    if (map.get("remark").contains("派送")) {
                        para.addParams("state", "5");
                        dates.put("5",map.get("datetime"));
//                        para.addParams("endDeliveryTime", dates.toJSONString());
                        return;
                    }
                });
                if(logisMap.get("status").equals("1")) {
                    if(orders.get(0).getState().equals("2") || orders.get(0).getState().equals("5"))
                    para.addParams("state","7");
                    dates.put("7",(logises.get(logises.size()-1)).get("datetime"));
                    para.addParams("endDeliveryTime", dates.toJSONString());
                    para.addParams("logisticsState", JSON.toJSONString(logises));
                }
                orderService.updateOrderByLogis(para);
            }else
            result=new BaseResult(errorCode, jsonObject.get("reason"));
        } catch (Exception e) {
            e.printStackTrace();
            result = new BaseResult(ReturnCode.FAIL);
        }
        return result;
    }



    /**
     *
     * @param strUrl 请求地址
     * @param params 请求参数
     * @param method 请求方法
     * @return  网络请求字符串
     * @throws Exception
     */
    public static String net(String strUrl, Map<String,Object> params,String method) throws Exception {
        HttpURLConnection conn = null;
        BufferedReader reader = null;
        String rs = null;
        try {
            StringBuffer sb = new StringBuffer();
            if(method==null || method.equals("GET")){
                strUrl = strUrl+"?"+urlencode(params);
            }
            URL url = new URL(strUrl);
            conn = (HttpURLConnection) url.openConnection();
            if(method==null || method.equals("GET")){
                conn.setRequestMethod("GET");
            }else{
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
            }
            conn.setRequestProperty("User-agent", userAgent);
            conn.setUseCaches(false);
            conn.setConnectTimeout(DEF_CONN_TIMEOUT);
            conn.setReadTimeout(DEF_READ_TIMEOUT);
            conn.setInstanceFollowRedirects(false);
            conn.connect();
            if (params!= null && method.equals("POST")) {
                try (DataOutputStream out = new DataOutputStream(conn.getOutputStream())) {
                    out.writeBytes(urlencode(params));
                }
            }
            InputStream is = conn.getInputStream();
            reader = new BufferedReader(new InputStreamReader(is, DEF_CHATSET));
            String strRead = null;
            while ((strRead = reader.readLine()) != null) {
                sb.append(strRead);
            }
            rs = sb.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                reader.close();
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
        return rs;
    }

    //将map型转为请求参数型
    public static String urlencode(Map<String,Object> data) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String,Object> i : data.entrySet()) {
            try {
                sb.append(i.getKey()).append("=").append(URLEncoder.encode(i.getValue()+"","UTF-8")).append("&");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }

}