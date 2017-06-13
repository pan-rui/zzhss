package com.yg.service.impl;

import com.alibaba.fastjson.JSON;
import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.codec.Base64;
import com.yg.codec.Hasher;
import com.yg.dao.impl.BannerDao;
import com.yg.pojo.Admin;
import com.yg.service.ITest;
import com.yg.service.pay.wx.BaseService;
import com.yg.service.pay.wx.Configure;
import com.yg.service.pay.wx.Signature;
import com.yg.service.pay.wx.Util;
import com.yg.service.pay.wx.pay_protocol.ScanPayReqData;
import com.yg.service.pay.wx.pay_protocol.ScanPayResData;
import com.yg.tag.ToHtml;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.taglibs.standard.functions.Functions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/14.
 */
@Service
public class Test implements ITest {
    @Autowired
    private BannerDao bannerDao;

    @Override
    public BaseResult getAdmin() {
        bannerDao.queryAllForCache();
        Admin admin = new Admin();
        admin.setId(33l);
        admin.setAdminName("5453");
        admin.setPwd("fdsgretgdf");
        return new BaseResult(0, admin);
    }

    @Override
    public BaseResult getAdmin(Long id, String name) {
        bannerDao.queryAllForCache();
        Admin admin = new Admin();
        admin.setId(id);
        admin.setAdminName(name);
        admin.setPwd("fd2534354gdf");
        return new BaseResult(0, admin);
    }

    public static void main(String[] args) throws UnsupportedEncodingException {
        Logger logger = LogManager.getLogger(Test.class);
        System.out.println(System.getProperty("file.encoding"));
        System.out.println(ReturnCode.IMAGE_CODE_ERROR.toString());
        System.out.println("请选择");
//        System.getenv().forEach((key,value)->System.out.println(key.toLowerCase()+"==========>\t"+value));
        System.getProperties().forEach((key, value) -> System.out.println(key.toString() + "===========>\t" + value.toString()));
        System.out.println(DigestUtils.md5Hex("12345678"));
//        String str = "{\"1\":\"一级菜单\",\"2\":\"二级菜单\",\"3\":\"三级菜单\"}";
        String json = "fdfanfdf:{\"abc\":\"ssssss\",\"ddd\":\"25rfd\"}";
//        System.out.println(JSON.parse(json));
        String abc = "[\"id\"]";
        System.out.println(ToHtml.toHTMLString(abc));
        System.out.println(Functions.substring(json, Functions.indexOf(json, "{"), -1));
        HashMap<Object, String> ss = new HashMap<>();
        System.out.println(Map.class.isInstance(ss));
        System.out.println("/".matches("/[^/]*"));
        Hasher hasher = new Hasher("SHA-1");
        System.out.println(Base64.encodeToString(hasher.hash("891225".getBytes())));

/*
        String driverClass = "com.mysql.jdbc.Driver";
        String schema = "yanguan";
//        String jdbcUrl = "jdbc:mysql://120.25.65.82:3306/"+schema+"?useUnicode=true&characterEncoding=UTF-8";
        String jdbcUrl = "jdbc:mysql://121.201.35.183:3306/"+schema+"?useUnicode=true&characterEncoding=UTF-8&useSSL=false";
        String jdbcUrl2 = "jdbc:mysql://121.201.35.183:3306/yg?useUnicode=true&characterEncoding=UTF-8&useSSL=false";
        String userId="zhihusan";
        String password = "yg_zhs_Web~!@2013";
        try {
            Connection conn = DriverManager.getConnection(jdbcUrl, userId, password);
            Connection conn2 = DriverManager.getConnection(jdbcUrl2, userId, password);
           PreparedStatement pstmt=conn.prepareStatement("select ya.Account cellPhone,ya.Acc_Create_Time createTime,a.Token_Credential pwd FROM YG_ACCOUNT ya JOIN AUTH_TOKEN a ON ya.Acc_ID=a.Token_Principal");
            PreparedStatement pstmt2 = conn2.prepareStatement("select 1 FROM dual");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String sql="insert into t_user(userName,pwd,cellPhone,createTime,type) VALUES('"+rs.getString("cellPhone")+"','"+rs.getString("pwd")+"','"+rs.getString("cellPhone")+"','"+rs.getTimestamp("createTime")+"','0')";
                System.out.println(sql);
                pstmt2.addBatch(sql);
            }
            int[] sqlResult = pstmt2.executeBatch();
//            conn2.commit();
            System.out.println(sqlResult.length);
            pstmt2.close();
            rs.close();
            conn2.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
*/
        logger.info("test................log--info");
        System.out.println("=========================================================");
        String text = "_input_charset=utf-8&body=5446j-154.0&out_trade_no=32&partner=2088811216437780&payment_type=1&return_url=http://www.gpsssafesum.com&seller_email=18898765373@163.com&service=create_direct_pay_by_user&show_url=http://www.baidu.com&subject=5446-1453549961722&total_fee=154.0haxhlfphpheajb1hawhls88omip9uvoj";
        String tttt = "_input_charset=utf-8&body=5446j-154.0&out_trade_no=32&partner=2088811216437780&payment_type=1&return_url=http://www.gpsssafesum.com&seller_email=18898765373@163.com&service=create_direct_pay_by_user&show_url=http://www.baidu.com&subject=5446-1453566494695&total_fee=154.0haxhlfphpheajb1hawhls88omip9uvoj";
        for (int i = 0; i < text.length(); i++) {
            if (text.charAt(i) != tttt.charAt(i))
                System.out.println(text.substring(i, text.length()));
        }
        String encode = com.yg.core.Base64.encode("abdeijk".getBytes("UTF-8"));
        System.out.println(encode);
        System.out.println(new String(com.yg.core.Base64.decode(encode), "UTF-8"));
        System.out.println(((Map<String, String>) JSON.parse("{\"code\":\"sfkd\",\"name\":\"顺丰快递\",\"fee\":\"15\",\"isDefault\":true}")).get("fee"));
        System.out.println(new BigDecimal("0.01").toString());
//        String abdc = "sgetfd";
//        System.out.println(abdc.substring(0,abdc.indexOf("i")>0?abdc.indexOf("i"):abdc.length()));
        String data = "2016032321001004160271665170^0.10^SUCCESS#2016032321001004160270059799^0.10^SUCCESS";
        String[] refunds = data.split("#");
        for (String refund : refunds) {
            System.out.println("refund\t" + refund);
            String[] orderStr = refund.split("\\^");
//           for(String or:orderStr) System.out.println(or);
            if (orderStr[2].equalsIgnoreCase("success"))
                System.out.println(orderStr[0]);
//                orderService.updateByPayNum(orderStr[0], "9");
        }

        ScanPayReqData reqData = new ScanPayReqData();
        Map<String, Object> paMap = new HashMap<>();
        paMap.put("appid", Configure.getAppid());
        paMap.put("mch_id", Configure.getMchid());
        paMap.put("nonce_str", System.currentTimeMillis()+"");
        paMap.put("body", "982rfeds");
        paMap.put("attach", "5349hgr");
        paMap.put("out_trade_no", "4332");
        paMap.put("total_fee", 100);
        paMap.put("spbill_create_ip", "218.18.138.81");
        paMap.put("notify_url", "http://www.gpssafesum.com:9080");
        paMap.put("trade_type", "NATIVE");
        paMap.put("product_id", "1254");
        reqData.setAppid(Configure.getAppid());
        reqData.setMch_id(Configure.getMchid());
//            reqData.setDevice_info("jlfd");//终端设备号
        reqData.setNonce_str(System.currentTimeMillis() + "");
        reqData.setBody("jlkfds");
        reqData.setAttach("j9dsd");
        reqData.setOut_trade_no("421");
        reqData.setTotal_fee(100);
        reqData.setSpbill_create_ip(Configure.getIP());
        reqData.setNotify_url("http://www.gpssafesum.com:9080");
        reqData.setTrade_type("NATIVE");
        reqData.setProduct_id("100");
        try {
            reqData.setSign(Signature.getSign(reqData));
            paMap.put("sign", Signature.getSign(paMap));
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        String resp = null;
        try {
            resp = new BaseService("https://api.mch.weixin.qq.com/pay/unifiedorder").sendPost(reqData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(resp);
        ScanPayResData scanPayResData = (ScanPayResData) Util.getObjectFromXML(resp, ScanPayResData.class);
        System.out.println(scanPayResData.getReturn_code());
        System.out.println(scanPayResData.getResult_code());
        System.out.println(scanPayResData.getReturn_msg());
    }
}
