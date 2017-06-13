package com.yg.action.backstage;

import com.yg.base.BaseAction;
import com.yg.service.impl.OrderService;
import com.yg.service.impl.QueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/10/26.
 */
@Controller
@RequestMapping("/market")
public class MarketAction extends BaseAction {
    @Autowired
    private OrderService orderService;
    @Autowired
    private QueryService queryService;

    /**
     * 查询所有业务员
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "sales", method = RequestMethod.POST)
    @ResponseBody
    public Object sales(HttpServletRequest request, ModelMap modelMap) {
        return queryService.querySales();
    }

}
