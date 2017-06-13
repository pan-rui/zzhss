package com.yg.service.pay;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.yg.base.BaseResult;
import com.yg.core.Constants;
import com.yg.dao.impl.PayDao;
import com.yg.pojo.Pay;

import java.io.UnsupportedEncodingException;
import java.security.SignatureException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/10/19.
 */
public interface IPay {
    public enum PayType{
        aliPay("支付宝支付"),
        wxPay("微信支付");
        private String name;
        public String getName() {
            return name;
        }
        PayType(String name){
            this.name=name;
        }
    }

    default Pay getPay() {
        return ((PayDao) Constants.applicationContext.getBean("payDao")).queryById(getId());
    }
    /**
     * 接口本身相关设置
     * @return
     */
//    @Cacheable(value = "backstage",key = "'pay_config'")
   default Map<String,String> getConfig(){
       Map<String, String> config = (Map<String, String>) JSON.parse(getPay().getConfig());
       return config;
   }

    /**
     * 受权信息
     * @return
     */
   default Map<String, String> getAuthInfo(Long id,String tradeType){
       Pay pay = getPay();
       Map<String, String> authInfo = new HashMap<String, String>();
           authInfo.put("businessSn", pay.getBusinessSn());
           authInfo.put("appKey",pay.getAppKey());
           authInfo.put("cert", pay.getCert());
           authInfo.put("account", pay.getAccount());
       return authInfo;
   }

    /**
     * 参数列表
     * @return
     */

    Object getBodyInfo(Map<String,String> params,IPaymentService.TradeType tradeType);

    BaseResult checkResult(Map<String,String> params,String... result);
    /**
     * 签名验证
     * @param src
     * @return
     */
    String deCode(Map<String,String> params,String... src);

    /**
     * 参数签名
     * @param src
     * @return
     */
    String enCode(Map<String,String> params,String... src);

    /**
     * @param content
     * @param charset
     * @return
     * @throws SignatureException
     * @throws UnsupportedEncodingException
     */
    default byte[] getContentBytes(String content, String charset) {
        if (charset == null || "".equals(charset)) {
            return content.getBytes();
        }
        try {
            return content.getBytes(charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("MD5签名过程中出现错误,指定的编码集不对,您目前指定的编码集是:" + charset);
        }
    }

    public Long getId();

    default Map<String, String> getApis(String tradeType) {
        return JSONArray.parseArray(getPay().getApi(),Map.class).stream().filter(map->tradeType.equals(map.get("tradeType"))).findFirst().get();
    }
}
