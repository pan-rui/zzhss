package com.yg.intercept;

import com.yg.base.ReturnCode;
import com.yg.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2015/7/29.
 */
public class CheckLoginIntercept implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        ReturnCode returnCode = checkLogin(request);
        if (ReturnCode.OK.equals(returnCode))
            return true;
        else {
            request.getRequestDispatcher("/user/toLogin").forward(request, response);
            return false;
        }
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

    public boolean isAllow(HttpServletRequest request,User user) {
        return true;    //TODO:待添加具体判断
    }

    public ReturnCode checkLogin(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) return ReturnCode.NO_LOGIN;
        if (!isAllow(request,user)) return ReturnCode.NO_AUTH;
        return ReturnCode.OK;
    }

}
