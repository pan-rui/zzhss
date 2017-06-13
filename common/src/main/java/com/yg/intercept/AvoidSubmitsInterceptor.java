package com.yg.intercept;

import com.alibaba.fastjson.JSON;
import com.yg.annotaion.AvoidSubmits;
import com.yg.annotaion.impl.TokenProcessor;
import com.yg.core.Constants;
import com.yg.service.impl.QueryService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * Created by hynpublic on 2015/1/5.
 */
public class AvoidSubmitsInterceptor extends HandlerInterceptorAdapter implements InitializingBean {
    private QueryService queryService;
    public AvoidSubmitsInterceptor(){}

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if(handler instanceof HandlerMethod) {
            AvoidSubmits avoidSubmits = ((HandlerMethod) handler).getMethod().getAnnotation(AvoidSubmits.class);
            TokenProcessor tokenProcessor=TokenProcessor.getInstance();
            if(avoidSubmits!=null&&avoidSubmits.saveToken())
                tokenProcessor.saveToken(request);
            if(avoidSubmits!=null&&avoidSubmits.removeToken()){
                boolean flag=tokenProcessor.isTokenValid(request);
                if(!flag){
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter pw=response.getWriter();
                    pw.write("<script>alert('提交失败,请重新操作');window.history.go(-2)</script>");
                    pw.close();
                }
                return flag;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        request.setAttribute("productss",queryService.queryAllProduct());
        request.setAttribute("sends", JSON.parseArray(Constants.getSystemStringValue("DeliveryType")));
        request.setAttribute("linkss",queryService.queryAllLinks());
        super.postHandle(request, response, handler, modelAndView);
    }


    @Override
    public void afterPropertiesSet() throws Exception {
        queryService = (QueryService) Constants.applicationContext.getBean("queryService");
    }
}
