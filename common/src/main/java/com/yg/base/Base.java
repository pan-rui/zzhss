package com.yg.base;

import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import javax.servlet.http.HttpServletRequest;
import java.text.MessageFormat;
import java.util.List;

/**
 * Created by lenovo on 2014/12/8.
 */
public interface Base {
//    @Resource
//    protected JedisPool jedisPool;
//    protected Logger logger = Logger.getLogger(this.getClass());
//    public static ApplicationContext applicationContext;
//    public static String webPath;
//    public static ApplicationContext otherApplicationContext;
//    public static String jsp_classpath;
//    public static ApplicationContext getApplicationContext(HttpServletRequest request) {
////        return applicationContext==null?applicationContext=WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext()):applicationContext;
//        return Base.applicationContext;
//    }

    default BaseResult getFormatError(BindingResult result) {
        List<FieldError> fields = result.getFieldErrors();
        StringBuffer errors = new StringBuffer();
        for (FieldError fieldError : fields) {
            if (!StringUtils.isEmpty(fieldError.getDefaultMessage()))
                errors.append(MessageFormat.format(fieldError.getDefaultMessage(), fieldError.getField(), fieldError.getRejectedValue()));
        }
        return new BaseResult(1,errors.toString());
    }
    //日期格式化为常用格式
/*    static String formatDate(Date date) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(date);
    }

    static String formatDateTime(Date date) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return df.format(date);
    }*/
    /**
     * 获取访问用户的客户端IP（适用于公网与局域网）.
     */
    default String getIpAddr(final HttpServletRequest request) {
        Assert.notNull(request, "getIpAddr method HttpServletRequest Object is null");
        String ipString = request.getHeader("x-forwarded-for");
        if (StringUtils.isEmpty(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getHeader("Proxy-Client-IP");
        }
        if (StringUtils.isEmpty(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getHeader("WL-Proxy-Client-IP");
        }
        if (StringUtils.isEmpty(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getRemoteAddr();
        }

        // 多个路由时，取第一个非unknown的ip
        final String[] arr = ipString.split(",");
        for (final String str : arr) {
            if (!"unknown".equalsIgnoreCase(str)) {
                ipString = str;
                break;
            }
        }
        return ipString;
    }

}
