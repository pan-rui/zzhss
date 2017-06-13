package com.yg.intercept;

import com.yg.base.ReturnCode;
import com.yg.pojo.Admin;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Administrator on 2015/9/11.
 */
public class AdminIntercept implements HandlerInterceptor {
    private String urlPattern = "";

    public void setUrlPattern(String urlPattern) {
        this.urlPattern = urlPattern;
    }

    public boolean isAllow(HttpServletRequest request, HttpServletResponse response, Admin admin) {
        List<String> urlList = (List<String>) request.getSession().getAttribute("urlList");
        String reqUri = request.getRequestURI().substring(request.getContextPath().length());
        return urlList.stream().anyMatch(str -> !StringUtils.isEmpty(str)&&reqUri.startsWith(str.indexOf("?")>0?str.substring(0,str.indexOf("?")):str));
/*        for (String url : urlList) {
            if (!StringUtils.isEmpty(url)) {
                int index = url.indexOf("?");
                String urll = index > 0 ? url.substring(0, index) : url;
                try {
                    if((StringUtils.isEmpty(request.getQueryString())?reqUri:reqUri+"?"+request.getQueryString()).startsWith(url)) return true;
                    else if (reqUri.startsWith(urll))
                        if (index > 0) {
                            request.getRequestDispatcher(request.getContextPath()+url).forward(request, response);
                            return true;
                        }  else return true;
                } catch (ServletException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
        return false;*/
        //TODO:待添加具体判断
    }

    public ReturnCode checkAuth(HttpServletRequest request, HttpServletResponse response) {
        if(request.getRequestURI().startsWith("/order/refund")) return ReturnCode.OK;
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin == null) return ReturnCode.NO_LOGIN;
        if (!isAllow(request, response, admin)) return ReturnCode.NO_AUTH;
        return ReturnCode.OK;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        if (request.getRequestURI().substring(request.getContextPath().length()).matches(urlPattern)) return true;
        ReturnCode returnCode = checkAuth(request, response);
        if (ReturnCode.OK.equals(returnCode))
            return true;
        else {
            request.getRequestDispatcher(request.getContextPath() + "/").forward(request, response);
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
