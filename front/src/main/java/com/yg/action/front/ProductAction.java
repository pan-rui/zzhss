package com.yg.action.front;

import com.yg.base.BaseAction;
import com.yg.pojo.Product;
import com.yg.service.impl.QueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

/**
 * @Description: 产品相关页面跳转
 * @Created: 潘锐 (2016-01-06 19:24)
 * $Rev: 754 $
 * $Author: panrui $
 * $Date: 2016-08-07 17:00:07 +0800 (周日, 07 八月 2016) $
 */
@Controller
@RequestMapping("/product")
public class ProductAction extends BaseAction{

    @Autowired
    public QueryService queryService;

    @RequestMapping(value = "", method = RequestMethod.GET,params = "id")
    public String productInfo(HttpServletRequest request,long id, ModelMap modelMap) {
//        modelMap.put()
        Product product=queryService.queryProduct(id);
        Assert.notNull(product);
        modelMap.put("product",product);
        return "product/product";
    }

    @RequestMapping(value = "install", method = RequestMethod.GET)
    public String install(HttpServletRequest request, @RequestParam(required = true) Long id, ModelMap modelMap) {
        Product product = queryService.queryProduct(id);
        Assert.notNull(product);
        modelMap.put("product", product);
        if (product.getName().contains("T1"))
            return "product/t1_installation";
        else return "product/d6_installation";
    }

    @RequestMapping(value = "spec", method = RequestMethod.GET)
//    @ResponseBody
    public String spec(HttpServletRequest request,@RequestParam(required = true) Long id, ModelMap modelMap) {
        Product product = queryService.queryProduct(id);
        Assert.notNull(product);
        modelMap.put("product", product);
        return "/product/spec";
    }
}
