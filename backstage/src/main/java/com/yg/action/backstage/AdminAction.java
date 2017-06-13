package com.yg.action.backstage;

import com.yg.base.BaseAction;
import com.yg.base.BaseService;
import com.yg.pojo.Admin;
import com.yg.service.backstage.impl.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2015/9/10.
 */
@Controller
@RequestMapping("/admin")
public class AdminAction extends BaseAction {

    @Autowired
    private BaseService baseService;
    @Autowired
    private AdminService adminService;

    @RequestMapping(value = "modifyPass", method = RequestMethod.POST)
    @ResponseBody
    public Object modifyPass(HttpServletRequest request, HttpSession session, String newpass) {
        Admin admin = new Admin();
        admin.setPwd(newpass);
        admin.setId(((Admin) session.getAttribute("admin")).getId());
        return adminService.updatePass(admin).toString();
    }

}
