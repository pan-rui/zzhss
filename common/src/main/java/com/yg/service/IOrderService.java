package com.yg.service;

import com.yg.base.BaseResult;
import com.yg.core.ParamsMap;
import com.yg.pojo.Order;
import com.yg.pojo.OrderItem;

import java.util.List;

/**
 * Description: 订单处理相关
 *
 * @Author: panrui
 * Update: 潘锐(2016-01-23 15:22)
 */
public interface IOrderService {
    Order saveOrder(Order order);

    /**
     * 支付成功后的更新订单
     * @param params
     * @return
     */
    int updatePayOrder(ParamsMap<String,Object> params);

    int saveOrderItem(OrderItem orderItem);

    List<Order> queryOrders(Long userId);
  Order queryOrderDetail(Long userId,String couponId);

    List<Order> searchOrders(Long userId, String patten);

    Order queryById(Long id);

    int updateOrderByLogis(ParamsMap<String,Object> params);

    BaseResult refund(String payType, String detailData,String[] ids);
}
