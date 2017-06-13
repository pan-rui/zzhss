package com.yg.action.front;

import com.yg.base.BaseAction;
import com.yg.core.Constants;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * @Description: App相关链接跳转
 * @Created: 潘锐 (2016-01-06 20:39)
 * $Rev: 566 $
 * $Author: panrui $
 * $Date: 2016-03-31 21:32:06 +0800 (周四, 31 三月 2016) $
 */
@Controller
@RequestMapping(value = "/app", method = RequestMethod.GET)
public class AppAction extends BaseAction {

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String center(HttpServletRequest request, ModelMap modelMap) {
        return "app/downApp";
    }

    @RequestMapping(value = "/use", method = RequestMethod.GET)
    public String appUse(HttpServletRequest request, String client, String pName, ModelMap modelMap) {
        modelMap.put("client", client);
        modelMap.put("appVideo", Constants.getSystemStringValue("App_Use_Video"));
        if(StringUtils.isEmpty(pName)) return "app/d6_app";
        if (pName.contains("T1"))
            return "app/t1_app";
        else return "app/d6_app";
    }
}
