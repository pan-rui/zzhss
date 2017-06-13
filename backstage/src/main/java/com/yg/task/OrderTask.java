package com.yg.task;

import com.yg.base.BaseService;
import com.yg.service.impl.OrderService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by panrui on 2016/2/26.
 */
@Component
public class OrderTask {

    private Logger logger = LogManager.getLogger(OrderTask.class);
    @Autowired
    private OrderService orderService;
    @Autowired
    private BaseService baseService;

    public void cancelOrder() {
        int count=Integer.parseInt(orderService.cancelOrder().get("cnt"));
        logger.info("自动取消的订单数量为:"+count);
    }

}
