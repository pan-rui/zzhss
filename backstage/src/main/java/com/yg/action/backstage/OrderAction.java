package com.yg.action.backstage;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yg.base.BaseAction;
import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.pojo.Order;
import com.yg.pojo.OrderItem;
import com.yg.service.impl.OrderService;
import com.yg.service.impl.QueryService;
import com.yg.service.pay.impl.AliPay;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import redis.clients.jedis.Jedis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/26.
 */
@Controller
@RequestMapping("/order")
public class OrderAction extends BaseAction {
    private Logger logger = LogManager.getLogger(OrderAction.class);
    @Autowired
    private OrderService orderService;
    @Autowired
    private AliPay aliPay;
    @Autowired
    private QueryService queryService;

    @RequestMapping(value = "shipments", method = RequestMethod.POST)
    @ResponseBody
    public Object shipments(HttpServletRequest request, Order order, ModelMap modelMap) {
        if (!StringUtils.isEmpty(order.getLogisticsId())) {
            order.setStartDeliveryTime(new Date());
            int i = orderService.updateOrder(order);
            if (i > 0) {
                JSONObject jsonObject = JSON.parseObject(order.getShipments());
                for (String itId : jsonObject.keySet()) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setId(Long.parseLong(itId));
                    orderItem.setImei(JSONArray.toJSONString(jsonObject.get(itId)));
                    orderService.upItem(orderItem);
                }
            }
            return ReturnCode.OK.toString();
        }
        return ReturnCode.FAIL.toString();
    }

    @RequestMapping(value = "orderInfo", method = RequestMethod.POST)
    @ResponseBody
    public Object orderInfo(HttpServletRequest request, Long orderId, ModelMap modelMap) {
        Order result = orderService.queryOrder(orderId);
        return result == null || result.getOrderItems().isEmpty() ? ReturnCode.FAIL.toString() : new BaseResult(0, result);
    }

    @RequestMapping(value = "print/{orderId}", method = RequestMethod.GET)
//    @CacheEvict(value = "backstage",key="'order_'+T(java.lang.String).valueOf(#orderId)")
    public Object shipments(HttpServletRequest request, ModelMap modelMap, @PathVariable Long orderId) {
        modelMap.put("orderInfo", orderService.queryOrder(orderId));
        return "printOrder";
    }

    @RequestMapping(value = "refund", method = RequestMethod.POST)
    @ResponseBody
    public String processRefund(HttpServletRequest request, ModelMap modelMap) {
        boolean flag = false;
        try {
            String result_details = new String(request.getParameter("result_details").getBytes("ISO-8859-1"), "UTF-8");
            String batch_no = new String(request.getParameter("batch_no").getBytes("ISO-8859-1"), "UTF-8");
            String success_num = new String(request.getParameter("success_num").getBytes("ISO-8859-1"), "UTF-8");
            logger.info("退款批次号为:" + batch_no + "\t成功的订单数量为:" + success_num);
            logger.info(result_details);
            String[] refunds = result_details.split("#");
            int count=0;
            for (String refund : refunds) {
                String[] orderStr = refund.split("\\^");
//                logger.info(orderStr[0]+"\t"+orderStr[1]+"\t"+orderStr[2]+"@");
                if (orderStr[2].equalsIgnoreCase("SUCCESS"))
                    count+=orderService.updateByPayNum(orderStr[0], "9");
            }
            flag = count == Integer.parseInt(success_num);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return flag ? "success" : "fail";
    }

    @RequestMapping(value = "subRefund", method = RequestMethod.POST)
    @ResponseBody
    public Object refund(HttpServletRequest request, String payType, String detailData, String ids, ModelMap modelMap) {
        BaseResult baseResult = orderService.refund(payType, detailData,ids.split(","));
        if (baseResult.getCode() == 0) {
            Jedis jedis = baseService.getJedis();
            if(!StringUtils.isEmpty(baseResult.getMsg()))
            jedis.setex("batchRefund", 15, baseResult.getMsg());
            jedis.close();
        }
/*        String[] idArr=ids.split(",");
        int i=0;
        if(baseResult.getCode()==0)
            for (String id : idArr) {
                Order order = new Order();
                order.setState("9");
                order.setId(Long.parseLong(id));
                orderService.updateOrder(order);
                i++;
            }
        return i == idArr.length ? ReturnCode.OK.toString() : ReturnCode.FAIL.toString();*/
        return baseResult;
    }

    @RequestMapping(value = "toRefund", method = RequestMethod.GET)
    public String processRefund(HttpServletRequest request, HttpServletResponse response) {
        Jedis jedis = baseService.getJedis();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter pw = null;
        try {
            pw = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        if(jedis.exists("batchRefund"))
            pw.write(jedis.get("batchRefund"));
        else
        pw.write("<script>alert('退款失败,操作超时');window.history.back();</script>");
        pw.close();
        return "";
    }
}

