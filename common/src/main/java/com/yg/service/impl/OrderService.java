package com.yg.service.impl;

import com.alibaba.fastjson.JSON;
import com.yg.base.BaseResult;
import com.yg.base.BaseService;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.OrderDao;
import com.yg.dao.impl.OrderItemDao;
import com.yg.dao.impl.ProductDao;
import com.yg.dao.impl.SaleDao;
import com.yg.pojo.Order;
import com.yg.pojo.OrderItem;
import com.yg.pojo.Product;
import com.yg.pojo.Sale;
import com.yg.service.IOrderService;
import com.yg.service.pay.IPay;
import com.yg.service.pay.impl.PaymentService;
import com.yg.service.pay.wx.Util;
import com.yg.service.pay.wx.pay_protocol.RefundResData;
import com.yg.util.DateUtil;
import com.yg.util.ImageCode;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @Description: 订单处理
 * @Created: 潘锐 (2016-01-23 15:22)
 * $Rev: 759 $
 * $Author: panrui $
 * $Date: 2016-08-15 12:27:43 +0800 (周一, 15 八月 2016) $
 */
@Service
@Transactional(rollbackFor = Exception.class, propagation = Propagation.NESTED)
public class OrderService implements IOrderService {
    private final Logger logger = LogManager.getLogger(OrderService.class);
    @Autowired
    private BaseService baseService;
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private OrderItemDao orderItemDao;
    @Autowired
    private QueryService queryService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private SaleDao saleDao;

    @Override
    public Order saveOrder(Order order) {
        orderDao.save(order);
        return order;
    }

    @Override
    public int updatePayOrder(ParamsMap<String, Object> params) {
        return orderDao.updatePayOrder(params);
    }

    public int updateOrder(Order order) {
        return orderDao.updateById(order);
    }

    @Override
    public int saveOrderItem(OrderItem orderItem) {
        return orderItemDao.save(orderItem);
    }

    @Override
    public List<Order> queryOrders(Long userId) {
        return orderDao.queryOrderInfo(userId);
    }

    @Override
    public Order queryOrderDetail(Long orderId, String couponId) {
        return orderDao.orderDetail(orderId, couponId);
    }

    @Override
    public List<Order> searchOrders(Long userId, String patten) {
        return orderDao.searchOrderInfo(userId, patten);
    }

    @Override
    public Order queryById(Long id) {
        return orderDao.queryById(id);
    }

    @Override
    public int updateOrderByLogis(ParamsMap<String, Object> params) {
        return orderDao.updateOrderByLogis(params);
    }

    @Override
    public BaseResult refund(String payType, String detailData, String[] ids) {
        IPay.PayType payT = StringUtils.isEmpty(payType) ? IPay.PayType.aliPay : IPay.PayType.valueOf(payType);
        BaseResult baseResult = null;
        Map<String, String> params = new HashMap<>();
        int count=0;
        switch (payT) {
            case aliPay:
                Calendar calendar = Calendar.getInstance();
                params.put("batchNo", DateUtil.convertDateToString(calendar.getTime(), "yyyyMMdd") + System.currentTimeMillis());
                params.put("notifyUrl", Constants.getSystemStringValue("Refund_Notify_Url"));
                params.put("batchNum", detailData.split("#").length + "");
                params.put("refundDate", DateUtil.convertDateTimeToString(calendar.getTime(), "yyyy-MM-dd HH:mm:ss"));
                params.put("payType", payType);
                params.put("detailData", detailData);
                baseResult = paymentService.refund(params);
                break;
            case wxPay:
                params.put("payType", payType);
                for (String sId : ids) {
                    Order order = orderDao.queryById(Long.parseLong(sId));
                    if (Objects.isNull(order)) continue;
                    params.put("randomStr", ImageCode.getPartSymbol(32));
                    params.put("orderMoney", (int)(order.getOrderMoney() * 100) + "");
                    params.put("orderId", order.getId() + "");
                    params.put("refundMoney", (int)(order.getOrderMoney() * 100) + "");
                    List<Sale> sales = saleDao.queryByPros(ParamsMap.newMap("orderId", order.getId()));
                    if (sales == null || sales.isEmpty()) continue;
                    params.put("refundId", sales.get(0).getId() + "");
                    baseResult = paymentService.refund(params);
                    if (baseResult.getCode() == 0) {
                        RefundResData refundResData = (RefundResData) Util.getObjectFromXML(baseResult.getMsg(), RefundResData.class);
                        if (refundResData.getReturn_code().equalsIgnoreCase("SUCCESS") && refundResData.getResult_code().equalsIgnoreCase("SUCCESS")) {
                            Order order1=new Order();
                            order1.setId(Long.parseLong(refundResData.getOut_trade_no()));
                            order1.setState("9");
                            order1.setRefundInfo(JSON.toJSONString(refundResData));
                            count+=updateOrder(order1);
                            logger.info("退款成功...订单号为:"+order1.getId());
                        } else return new BaseResult(Integer.parseInt(refundResData.getErr_code()),refundResData.getErr_code_des());
                    } else return new BaseResult(ReturnCode.FAIL);
                }
                logger.info("微信退款订单数量为:"+count);
                baseResult.setData(count);
                break;
        }
        return baseResult;
    }

    public Map<String, String> cancelOrder() {
        return orderDao.cancelOrder();
    }

    public int cancelOrderTime(Long userId) {
        int size = orderDao.cancelOrderTime(userId);
        logger.info("取消订单\t用户:" + userId + "数量为:" + size);
        return size;
    }

    public List<Order> queryByPros(ParamsMap<String, Object> params) {
        return orderDao.queryByPros(params);
    }

    public Order queryOrder(Long orderId) {
        return orderDao.queryOrder(orderId);
    }

    public int upItem(OrderItem orderItem) {
        return orderItemDao.updateById(orderItem);
    }

    public int updateLogistics(Long userId) {
        List<Order> orders = orderDao.queryByPros(ParamsMap.newMap("userId", userId).addParams("state", "2"));
        orders.forEach(order -> queryService.queryLogistics(order.getLogistics(), order.getLogisticsId()));
        return orders.size();
    }

    public Map<String, Object> getColumnInfo(String columnName) {
        return orderDao.getColumnInfo(columnName);
    }

    public List<OrderItem> queryItByOrderId(Long orderId) {
        return orderItemDao.queryByPros(ParamsMap.newMap("orderId", orderId));
    }

    public List<Product> queryProductByOrderId(Long orderId) {
        return productDao.queryByOrderId(orderId);
    }

    public int updateByPayNum(String payNum, String state) {
        return orderDao.updateByPayNum(ParamsMap.newMap("payNum", payNum).addParams("state", state));
    }

}
