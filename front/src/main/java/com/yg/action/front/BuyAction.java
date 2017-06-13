package com.yg.action.front;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.yg.annotaion.AvoidSubmits;
import com.yg.base.BaseAction;
import com.yg.base.BaseResult;
import com.yg.base.BaseService;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.pojo.Coupon;
import com.yg.pojo.Delivery;
import com.yg.pojo.Order;
import com.yg.pojo.OrderItem;
import com.yg.pojo.Pay;
import com.yg.pojo.Product;
import com.yg.pojo.ShoppingCart;
import com.yg.pojo.User;
import com.yg.service.front.impl.UserService;
import com.yg.service.impl.OrderService;
import com.yg.service.pay.impl.PaymentService;
import com.yg.service.pay.wx.Util;
import com.yg.service.pay.wx.pay_protocol.ScanPayNotifyData;
import com.yg.service.pay.wx.pay_protocol.ScanPayResData;
import com.yg.util.DateUtil;
import com.yg.util.ImageCode;
import com.yg.util.JuheUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Description: 购买相关请求
 * @Created: 潘锐 (2016-01-07 10:21)
 * $Rev: 759 $
 * $Author: panrui $
 * $Date: 2016-08-15 12:27:43 +0800 (周一, 15 八月 2016) $
 */
@Controller
@RequestMapping("/buy")
public class BuyAction extends BaseAction {
    private Logger logger = LogManager.getLogger(BuyAction.class);
    @Autowired
    private UserService userService;
    @Autowired
    private BaseService baseService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private CommonAction commonAction;
    private final static String RETURN_SUCCESS = "<xml>" +
            "  <return_code><![CDATA[SUCCESS]]></return_code>" +
            "  <return_msg><![CDATA[OK]]></return_msg>" +
            "</xml>";
    private static final String SUCCESS = "SUCCESS";

    @RequestMapping(value = "", method = RequestMethod.GET)
    @AvoidSubmits(saveToken = true)
    public String cart(HttpServletRequest request, HttpServletResponse response, String products, ModelMap modelMap) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) return "/user/login";
        if (StringUtils.isEmpty(products)) {
            try {
                response.setCharacterEncoding("UTF-8");
                response.setContentType("text/html; charset=utf-8");
                PrintWriter pw = response.getWriter();
                pw.write("<script>alert('没有发现需要购买的商品');window.history.back();</script>");
                pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("cart");
        if (cart == null) return "index";
        if (user != null) {
            List<Delivery> deliveries = userService.queryAllDeliveryByUserId(user.getId());
            request.getSession().setAttribute("deliverys", deliveries);
        }
        List<String> pros = Arrays.asList(products.split(","));
        List<Product> productItem = JSONArray.parseArray(cart.getProductItem(), Product.class).stream().filter(product -> pros.stream().anyMatch(pro -> String.valueOf(product.getId()).equals(pro))).collect(Collectors.<Product>toList());
        int[] count = new int[1];
        productItem.forEach(pro -> count[0] += pro.getSellCount());
        request.getSession().setAttribute("productItem", productItem);
        request.getSession().setAttribute("productCount", count[0]);
        request.setAttribute("pays", baseService.getSystemValue("pay", List.class));
/*        modelMap.put("pays", baseService.getSystemValue("pay", List.class));
        modelMap.put("sends", JSON.parseArray(Constants.getSystemStringValue("DeliveryType")));*/
        return "buy/orderConfirmation";
    }

    @RequestMapping(value = "order", method = RequestMethod.POST)
    @AvoidSubmits(removeToken = true)
    public String order(HttpServletRequest request, HttpServletResponse response, Order order, ModelMap modelMap) {
        //1.分店ID 计算 2.优惠券 处理 3.发票 4.购物车清空
        ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("cart");
        List<Product> productItem = (List<Product>) request.getSession().getAttribute("productItem");
        Calendar calendar = Calendar.getInstance();
        order.setCtime(calendar.getTime());
        String sn = order.getUserId() + "" + System.currentTimeMillis();
        order.setOrderSn(sn);
        //消费金额,优惠金额
        final double[] prices = {0d}, priceYs = {0d};
        productItem.forEach(product -> {
            prices[0] += product.getPrice() == null ? 0 : product.getPrice() * product.getSellCount();
            priceYs[0] += product.getPriceY() == null ? 0 : product.getPriceY() * product.getSellCount();
        });
        order.setMoney(new BigDecimal(priceYs[0]).setScale(2, RoundingMode.HALF_UP).doubleValue());
        order.setPreferential(new BigDecimal(prices[0] - priceYs[0]).setScale(2, RoundingMode.HALF_DOWN).doubleValue());
        //优惠券优惠金额
        if (!StringUtils.isEmpty(order.getCouponId())) {
            double couponAmount = userService.queryCouponDictByCouponId(order.getCouponId()).getCouponAmount().doubleValue();
            order.setCouponPrice(couponAmount >= 1d ? couponAmount : new BigDecimal((1 - couponAmount) * order.getMoney()).setScale(2, RoundingMode.HALF_DOWN).doubleValue());
        }
        //运费
        Map<String, String> logistics = (Map<String, String>) JSONArray.parseArray(Constants.getSystemStringValue("DeliveryType")).stream().filter(map -> ((Map<String, String>) map).get("code").equals(order.getLogistics())).findFirst().get();
        order.setOrderMoney(new BigDecimal(order.getMoney() - (order.getCouponPrice() == null ? 0 : order.getCouponPrice()) + Double.parseDouble(logistics.get("fee"))).setScale(2, RoundingMode.HALF_UP).doubleValue());
        order.setRemark(logistics.get("name"));
        order.setState("0");//下单待付款
        order.setReqIp(getIpAddr(request));
        orderService.saveOrder(order);
        response.setCharacterEncoding("UTF-8");
        if (order.getId() == null) {
            try {
                response.setContentType("text/html; charset=utf-8");
                PrintWriter pw = response.getWriter();
                pw.write("<script>alert('订单提交失败!');window.history.go(-2)</script>");
                pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return "index";
        }
        productItem.forEach(product -> {
            OrderItem orderItem = new OrderItem();
            orderItem.setCount(product.getSellCount());
            orderItem.setCtime(calendar.getTime());
            orderItem.setOrderId(order.getId());
            orderItem.setPrice(product.getPrice() * product.getSellCount());
            orderItem.setPriceY(product.getPriceY());
            orderItem.setProdId(product.getId());
            orderItem.setProdName(product.getName());
            if (orderService.saveOrderItem(orderItem) < 1) return;
        });
        if (!StringUtils.isEmpty(order.getCouponId())) {
            Coupon coupon = new Coupon();
            coupon.setId(order.getCouponId());
            coupon.setCouponStatus("3");
            userService.updateCoupon(coupon);

        }
        //整理购物车
        request.getSession().removeAttribute("productItem");
        List<Product> remainProduct = JSONArray.parseArray(cart.getProductItem(), Product.class).stream().filter(product -> productItem.stream().noneMatch(pro -> String.valueOf(product.getId()).equals(String.valueOf(pro.getId())))).collect(Collectors.<Product>toList());
        cart.setProductItem(JSONArray.toJSONString(remainProduct));
        userService.updateShoppingCart(cart);
        request.getSession().setAttribute("cart", cart);
        //公共参数.....
        Map<String, String> commonMap = new HashMap<>();
        commonMap.put("orderName", productItem.get(0).getName());
        commonMap.put("description", productItem.get(0).getDescription());
        commonMap.put("orderId", order.getId() + "");
        commonMap.put("returnUrl", "http://www.gpssafesum.com:9080/buy/pay2");
        //orderMoney
        commonMap.put("showUrl", "http://www.gpssafesum.com:9080/user/home");
        commonMap.put("operateType", "NATIVE");
        commonMap.put("reqIp", Constants.getSystemStringValue("webServerIp"));
//        commonMap.put("reqIp", "218.18.138.81");
        commonMap.put("payType", order.getPayType());
        Map<String, String> orderMap = Constants.poToMapString(order);
        orderMap.putAll(commonMap);
        if ("aliPay".equalsIgnoreCase(order.getPayType())) {
            orderMap.put("notifyUrl", Constants.getSystemStringValue("Notify_Url") + "/buy/call");
        } else {
            orderMap.put("notifyUrl", Constants.getSystemStringValue("Notify_Url") + "/buy/wxCall");
            orderMap.put("orderMoney", (int) (order.getOrderMoney() * 100) + "");
            orderMap.put("randomStr", ImageCode.getPartSymbol(32));
        }
        BaseResult baseResult = paymentService.recharge(orderMap);
        if (baseResult.getCode() == 0) {
            try {
//                if (!StringUtils.isEmpty(baseResult.getMsg())) {
                if ("aliPay".equalsIgnoreCase(order.getPayType())) {
                    response.setContentType("text/html; charset=utf-8");
                    PrintWriter pw = response.getWriter();
                    pw.write(baseResult.getMsg());
                    pw.close();
                } else if ("wxPay".equalsIgnoreCase(order.getPayType())) {
                    System.out.println(baseResult.getMsg());
                    ScanPayResData scanPayResData = (ScanPayResData) Util.getObjectFromXML(baseResult.getMsg(), ScanPayResData.class);
                    if (scanPayResData.getReturn_code().equalsIgnoreCase(SUCCESS) && scanPayResData.getResult_code().equalsIgnoreCase(SUCCESS)) {
                        request.getSession().setAttribute("wxPayCode", scanPayResData.getCode_url());
                        modelMap.put("orderMoney", order.getOrderMoney());
                        modelMap.put("orderId", order.getId());
                        modelMap.put("tTime", DateUtil.convertDateToString(calendar.getTime(), "yyyy-MM-dd HH:mm"));
                        modelMap.put("salePhone", Constants.getSystemStringValue("salePhone"));
                        modelMap.put("product", productItem.get(0).getName());
                        modelMap.put("productDesc", productItem.get(0).getDescription());
                        return "buy/wxQrCode";
                    } else {
                        response.setContentType("text/html; charset=utf-8");
                        PrintWriter pw = response.getWriter();
                        pw.write("<script>alert('调用支付失败!');window.location.href ='/user/order';</script>");
                        pw.close();
                        logger.info(scanPayResData.getReturn_msg() + "\t" + scanPayResData.getErr_code_des());
                    }
                }
//                }
            } catch (IOException e) {
                logger.error("调用支付接口异常..订单号为:" + order.getId());
                e.printStackTrace();
            }
            //TODO:POST结果处理
//            return "user/login";
        } else {
            logger.error(baseResult.getMsg());
        }
        return "index";
    }

    @RequestMapping(value = "call", method = RequestMethod.POST)
    @ResponseBody
    public String pay(HttpServletRequest request, ModelMap modelMap) throws UnsupportedEncodingException {
        Map<String, String> params = new HashMap<String, String>();
        Map requestParams = request.getParameterMap();
        for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext(); ) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
            //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
            params.put(name, valueStr);
        }
        //商户订单号
        String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");
        //支付宝交易号
        String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");
        //交易状态
        String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"), "UTF-8");
        params.put("payType", "aliPay");
        BaseResult baseResult = paymentService.checkResult(params);
        if (baseResult.getCode() == 0) {
            if (trade_status.equals("TRADE_FINISHED")) {
                logger.info("交易完结........订单号为:" + out_trade_no);
            } else if (trade_status.equals("TRADE_SUCCESS")) {
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
                //如果有做过处理，不执行商户的业务程序
//                orderService
                //注意：
                //付款完成后，支付宝系统发送该交易状态通知
/*                Order order = new Order();
                order.setId(Long.parseLong(out_trade_no));
                order.setPayNum(trade_no);
                order.setPayInfo(JSON.toJSONString(params));
                order.setPayMoney(Double.parseDouble(params.get("total_fee")));
                order.setState("1");
                order.setUtime(new Date());*/
                orderService.updatePayOrder(ParamsMap.newMap("id", Long.parseLong(out_trade_no)).addParams("payNum", trade_no).addParams("payInfo", JSON.toJSONString(params)).addParams("payMoney", Double.parseDouble(params.get("total_fee"))).addParams("state", "1"));
                logger.info("支付成功........订单号为:" + out_trade_no);
                payedNotify(Constants.getSystemStringValue("Pay_Notify_Phone"),"支付宝",Double.parseDouble(params.get("total_fee")),out_trade_no);
            }
            return "success";
        } else logger.error("订单支付结果异常...........");
        return "fail";
    }

    @RequestMapping(value = "wxCall", method = RequestMethod.POST)
    @ResponseBody
    public String wxCall(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws UnsupportedEncodingException {
        StringBuffer sb = new StringBuffer();
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
            String line = null;
            while ((line = br.readLine()) != null)
                sb.append(line);
        } catch (IOException e) {
            e.printStackTrace();
        }
        ScanPayNotifyData scanPayNotifyData = (ScanPayNotifyData) Util.getObjectFromXML(sb.toString(), ScanPayNotifyData.class);
        if (scanPayNotifyData.getReturn_code().equalsIgnoreCase(SUCCESS) && scanPayNotifyData.getResult_code().equalsIgnoreCase(SUCCESS)) {
            orderService.updatePayOrder(ParamsMap.newMap("id", Long.parseLong(scanPayNotifyData.getOut_trade_no())).addParams("payNum", scanPayNotifyData.getTransaction_id()).addParams("payInfo", JSON.toJSONString(scanPayNotifyData)).addParams("payMoney", scanPayNotifyData.getTotal_fee() / 100d).addParams("state", "1"));
            logger.info("支付成功........订单号为:" + scanPayNotifyData.getOut_trade_no());
            payedNotify(Constants.getSystemStringValue("Pay_Notify_Phone"),"微信",scanPayNotifyData.getTotal_fee()/100,scanPayNotifyData.getOut_trade_no());
            return RETURN_SUCCESS;
        } else {
            logger.error(sb.toString());
            return "<xml>" +
                    "  <return_code><![CDATA[FAIL]]></return_code>" +
                    "  <return_msg><![CDATA[校验错误]]></return_msg>" +
                    "</xml>";
        }
    }

    /**
     * 支付返回的结果页面......略
     *
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "pay2", method = RequestMethod.GET)
    public String pay2(HttpServletRequest request, ModelMap modelMap) {
        logger.info("==========================returnUrl---------GET");
//        request.getParameterMap().forEach((k,v)-> logger.info(k+"\t"+v.toString()));
        return "index";
    }

    @RequestMapping(value = "directBuy", method = RequestMethod.GET, params = "orderId")
//    @AvoidSubmits(removeToken = true)
    public String directBuy(HttpServletRequest request, HttpServletResponse response, Long orderId, ModelMap modelMap) {
        Order order = orderService.queryById(orderId);
        List<Product> products = orderService.queryProductByOrderId(orderId);
        //公共参数.....
        Map<String, String> commonMap = new HashMap<>();
        commonMap.put("orderName", products.get(0).getName());
        commonMap.put("description", products.get(0).getDescription());
        commonMap.put("orderId", order.getId() + "");
        commonMap.put("returnUrl", "http://www.gpssafesum.com:9080/buy/pay2");
        //orderMoney
        commonMap.put("showUrl", "http://www.gpssafesum.com:9080/user/home");
        commonMap.put("operateType", "NATIVE");
        commonMap.put("reqIp", Constants.getSystemStringValue("webServerIp"));
//        commonMap.put("reqIp", "218.18.138.81");
        commonMap.put("payType", order.getPayType());
        Map<String, String> orderMap = Constants.poToMapString(order);
        orderMap.putAll(commonMap);
        if ("aliPay".equalsIgnoreCase(order.getPayType())) {
            orderMap.put("notifyUrl", Constants.getSystemStringValue("Notify_Url") + "/buy/call");
        } else {
            orderMap.put("notifyUrl", Constants.getSystemStringValue("Notify_Url") + "/buy/wxCall");
            orderMap.put("orderMoney", (int) (order.getOrderMoney() * 100) + "");
            orderMap.put("randomStr", ImageCode.getPartSymbol(32));
        }
        BaseResult baseResult = paymentService.recharge(orderMap);
        if (baseResult.getCode() == 0) {
            try {
//                if (!StringUtils.isEmpty(baseResult.getMsg())) {
                if ("aliPay".equalsIgnoreCase(order.getPayType())) {
                    response.setCharacterEncoding("UTF-8");
                    response.setContentType("text/html; charset=utf-8");
                    PrintWriter pw = response.getWriter();
                    pw.write(baseResult.getMsg());
                    pw.close();
                } else if ("wxPay".equalsIgnoreCase(order.getPayType())) {
                    System.out.println(baseResult.getMsg());
                    ScanPayResData scanPayResData = (ScanPayResData) Util.getObjectFromXML(baseResult.getMsg(), ScanPayResData.class);
                    if (scanPayResData.getReturn_code().equalsIgnoreCase(SUCCESS) && scanPayResData.getResult_code().equalsIgnoreCase(SUCCESS)) {
                        request.getSession().setAttribute("wxPayCode", scanPayResData.getCode_url());
                        modelMap.put("orderMoney", order.getOrderMoney());
                        modelMap.put("orderId", order.getId());
                        modelMap.put("tTime", DateUtil.convertDateToString(new Date(), "yyyy-MM-dd HH:mm"));
                        modelMap.put("salePhone", Constants.getSystemStringValue("salePhone"));
                        modelMap.put("product", products.get(0).getName());
                        modelMap.put("productDesc", products.get(0).getDescription());
                        return "buy/wxQrCode";
                    } else {
                        response.setContentType("text/html; charset=utf-8");
                        PrintWriter pw = response.getWriter();
                        pw.write("<script>alert('调用支付失败!');window.location.href ='/user/order';</script>");
                        pw.close();
                        logger.info(scanPayResData.getReturn_msg() + "\t" + scanPayResData.getErr_code_des());
                    }
                }
//                }
            } catch (IOException e) {
                logger.error("调用支付接口异常..订单号为:" + order.getId());
                e.printStackTrace();
            }
            //TODO:POST结果处理
//            return "user/login";
        } else {
            logger.error(baseResult.getMsg());
        }
        return "index";
    }

    @RequestMapping(value = "cancelOrder", method = RequestMethod.POST)
    @ResponseBody
    public Object cancelOrder(HttpServletRequest request, HttpServletResponse response, Long id, ModelMap modelMap) {
        Order order = new Order();
        order.setId(id);
        order.setState("8");//交易结束
        return orderService.updateOrder(order) > 0 ? ReturnCode.OK.toString() : ReturnCode.FAIL.toString();
    }

    @RequestMapping(value = "orderDetail", method = RequestMethod.GET)
    public String orderDetail(HttpServletRequest request, Long orderId, String couponId, ModelMap modelMap) {
        User user = (User) request.getSession().getAttribute("user");
        Order orderDetail = orderService.queryOrderDetail(orderId, couponId);
        List<Pay> pays = baseService.getSystemValue("Pay", List.class);
        modelMap.put("payType", pays.stream().filter(pay -> pay.getName().equals(orderDetail.getPayType())).findFirst().get().getRemark());
        //订单状态判断,物流信息查询
        if (!StringUtils.isEmpty(orderDetail.getLogisticsId())) {
            Map<String, Object> param = new HashMap<>();
            param.put("com", orderDetail.getLogistics());
            param.put("no", orderDetail.getLogisticsId());
            BaseResult baseResult = (BaseResult) commonAction.queryLogistics(request, String.valueOf(orderDetail.getLogistics()), String.valueOf(orderDetail.getLogisticsId()));
            if (baseResult.getCode() == 0)
                modelMap.put("logistics", baseResult.getData());
        }
        if (!StringUtils.isEmpty(orderDetail.getCouponId())) {
            modelMap.put("couponDict", userService.queryCouponDictByCouponId(couponId));
        }
        modelMap.put("order", orderDetail);
        modelMap.put("salePhone", Constants.getSystemStringValue("salePhone"));
        modelMap.put("stateEnum", baseService.queryColumnInfo(ParamsMap.newMap("tableName", "t_order").addParams("columnName", "state")));
        return "buy/orderDetails";
    }

    @RequestMapping(value = "sale", method = RequestMethod.GET)
    public String sale(HttpServletRequest request, Long orderId, ModelMap modelMap) {
        modelMap.put("orderInfo", orderService.queryOrderDetail(orderId, ""));
        modelMap.put("Sale_Name", Constants.getSystemStringValue("Sale_Name"));
        modelMap.put("Sale_Phone", Constants.getSystemStringValue("Sale_Phone"));
        modelMap.put("Sale_Address", Constants.getSystemStringValue("Sale_Address"));
        return "user/userSale";
    }

    @RequestMapping(value = "loopState", method = RequestMethod.POST)
    @ResponseBody
    public Object loopState(HttpServletRequest request, Long orderId, ModelMap modelMap) {
        Order order = orderService.queryById(orderId);
        if (order.getState().equals("1") && !StringUtils.isEmpty(order.getPayNum())) {
            return new BaseResult(0, 0);
        } else return new BaseResult(0, 1);
    }

    public synchronized void payedNotify(String phones,String payType,double amount,String orderId) {
        if (!StringUtils.isEmpty(phones)) {
            Map<String, Object> param = new HashMap<>();
            param.put("tpl_id", 19468);
            param.put("tpl_value", "#payType#="+payType+"&#amount#="+amount+"&#orderId#=" + orderId);
            for (String phone : phones.split(",")) {
                param.put("mobile", phone);
                BaseResult result = JuheUtil.sendSms(param);
                if(result.getCode()!=0) logger.error("付款短信通知失败...原因:"+result.getData());
            }
        }
    }
}
