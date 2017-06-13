package com.yg.action.backstage;

import com.yg.base.BaseAction;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.BaseDao;
import com.yg.service.backstage.impl.AdminService;
import com.yg.service.pay.impl.AliPay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.MatrixVariable;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.WebAsyncTask;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/10/26.
 */
@Controller
@RequestMapping("/ui")
public class UIAction extends BaseAction {
    @Autowired
    private AdminService adminService;
    @Autowired
    private AliPay aliPay;

    /**
     * 后台左侧菜单
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping("menus")
    @ResponseBody
    public List<Map<String, Object>> initMenus(HttpServletRequest request, ModelMap modelMap) {
        return adminService.queryMenuAll();
    }

    @RequestMapping(value = "validator/{bean}/{status}", method = RequestMethod.GET)
    @ResponseBody
    public WebAsyncTask<String> validator(HttpServletRequest request, @PathVariable String bean, @MatrixVariable(required = false) String pName, @PathVariable int status, String val) {
        return new WebAsyncTask<String>(3500l, () -> {
            BaseDao dao = (BaseDao) Constants.applicationContext.getBean(bean + "Dao");
            ParamsMap<String, Object> params = new ParamsMap();
            if (StringUtils.isEmpty(val))
                return "{\"code\":1,\"msg\":\"" + pName + "不能为空\"}";
            if (StringUtils.isEmpty(pName))
                params.addParams("id", val);
            else params.addParams(pName, val);
            List<Object> list = dao.queryByPros(params);
            if (status >= 1) {
                if (list == null || list.isEmpty())
                    return "{\"code\":1,\"msg\":\"不存在该" + pName + "记录\"}";
            } else {
                if (list != null && !list.isEmpty())
                    return "{\"code\":1,\"msg\":\"已存在该" + pName + "记录\"}";
            }
            return ReturnCode.OK.toString();
        });
    }

    @RequestMapping("testPay")
    @ResponseBody
    public Object testPay(HttpServletRequest request, ModelMap map) {
        Map<String, String> params = new HashMap<>();
        Map<Object,Object> mm=request.getParameterMap();
       mm.forEach((k,v)->{
             if(!k.equals("sign")&&!k.equals("sign_type"))
                 params.put(String.valueOf(k), ((String[])v)[0]);
        });

        String sign = aliPay.enCode(params, aliPay.getPay().getAppKey(), aliPay.getConfig().get("charset"));
        System.out.println(sign.equals(((String[])mm.get("sign"))[0]));
        return sign;
    }
}
