package com.yg.base;

import com.yg.service.impl.QueryService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.validator.HibernateValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Locale;
import java.util.Set;

/**
 * Created by lenovo on 2014/12/6.
 */
@ControllerAdvice
public class BaseAction implements Base,ServletContextAware {
    /*    public  @Value("#{config['hhn.login']}") String hhn_login;
        public @Value("#{config['hhn.admin.login']}") String hhn_admin_login;*/
//    @Autowired
//    protected javax.validation.Validator validator;
    protected javax.validation.Validator validator = Validation.byProvider(HibernateValidator.class).configure().buildValidatorFactory().getValidator();
    private Logger logger = LogManager.getLogger(BaseAction.class);
    protected ServletContext servletContext;
    protected String webPath;
    @Autowired
    protected BaseService baseService;
    @Autowired
    private QueryService queryService;

    public String getMessage(HttpServletRequest request, String key, Object... objs) {
        Locale locale = RequestContextUtils.getLocale(request);
        return baseService.applicationContext.getMessage(key, objs, locale);
    }


    @ExceptionHandler
    @ResponseBody
    public BaseResult exp(HttpServletRequest request,HttpServletResponse response, Exception ex) {
//        BaseReturn baseReturn=new BaseReturn();
        ex.printStackTrace();
        if (ex instanceof HttpMessageNotReadableException){
        logger.error(ex.getMessage());
/*            baseReturn.setReturnCode(BaseReturn.Err_data_inValid);
            baseReturn.setMessageInfo(getMessage(request,"data.inValid",null));*/
            return new BaseResult(1,ex.getMessage());
        }else if(ex instanceof ServletRequestBindingException || ex instanceof IllegalArgumentException){
            try {
                response.setCharacterEncoding("UTF-8");
                response.setContentType("text/html; charset=utf-8");
                PrintWriter pw = response.getWriter();
                pw.write("<script>alert('参数有误,请重试');window.history.back();</script>");
                pw.close();
            } catch (IOException e) {
                logger.error(e.getMessage());
                e.printStackTrace();
            }
            return null;
        }else
            return new BaseResult(ReturnCode.Err_system_error);
/*            baseReturn.setReturnCode(BaseReturn.Err_system_error);
            baseReturn.setMessageInfo(ex.getMessage());*/
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext=servletContext;
        this.webPath = servletContext.getRealPath("/");
    }
    public <E> BaseResult validAndReturn(E t) {
        Set<ConstraintViolation<E>> errs = validator.validate(t);
        if (errs.size() > 0) {
            StringBuffer sb = new StringBuffer();
            for (ConstraintViolation<E> cons : errs)
                sb.append(cons.getPropertyPath() + ":" + cons.getInvalidValue() + "===>" + cons.getMessage() + "\r\n");
            return new BaseResult(1,sb.toString());
        } else return new BaseResult(ReturnCode.OK);
    }

    public String getCookie(String key, HttpServletRequest request) {
        Cookie mycookies[] = request.getCookies();
        if (mycookies != null) {
            for (int i = 0; i < mycookies.length; i++) {
                if (key.equalsIgnoreCase(mycookies[i].getName())) {
                    try {
                        return URLDecoder.decode(mycookies[i].getValue(), "utf-8");
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return "";
    }


/*    @RequestMapping("/imageCode")
    @ResponseBody
    public void test(HttpServletRequest request,HttpServletResponse response) {
        try {
            ImageCode.generatorImg(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        }
    }*/

    @ModelAttribute("baseUrl")
    public String setConstans(HttpServletRequest request,ModelMap model){

        return request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
    }
}
