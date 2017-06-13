package com.yg.aspect;

import com.alibaba.fastjson.JSONArray;
import com.yg.annotaion.OperationLog;
import com.yg.annotaion.TradeLog;
import com.yg.base.Base;
import com.yg.core.Constants;
import com.yg.core.DataSource;
import com.yg.core.DataSourceHolder;
import com.yg.dao.impl.AdminActionLogDao;
import com.yg.dao.impl.UserActionLogDao;
import com.yg.pojo.AdminActionLog;
import com.yg.pojo.UserActionLog;
import com.yg.task.RecoverDBType;
import com.yg.util.DateUtil;
import com.yg.util.SendMail;
import com.yg.util.TriggerUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.MessageFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

/**
 * Created by lenovo on 2014/12/18.
 * 用户操作记录和管理员操作记录
 */
@Component
@Aspect
public class LogAspect implements Base {

    @Autowired
    private AdminActionLogDao adminActionLogDao;
    @Autowired
    private UserActionLogDao userActionLogDaoImpl;
    private Logger logger = LogManager.getLogger(LogAspect.class);
    @Autowired
    private SendMail sendMail;
    @Value("#{config[adminEmail]}")
    private String adminEmail;

    private ThreadLocal<String> method = new ThreadLocal<>();

    @Pointcut("@annotation(com.yg.annotaion.TradeLog)")
    public void TradeLog() {
    }

    @Pointcut("@annotation(com.yg.annotaion.OperationLog))")
    public void operationLog() {
    }

    @Pointcut("execution(* com.yg.dao.impl.*Dao*.*(..)) && @annotation(com.yg.core.DataSource)")
    public void dataSource() {
    }

    @Before("TradeLog()")
    public void doBefore(JoinPoint joinPoint) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Object user = request.getSession().getAttribute("user");
        Integer userId = null;
        if (user == null) {
            Object[] obj = joinPoint.getArgs();
            if (obj.length != 1 || !(obj[0] instanceof Map)) return;
            Map params = (Map) obj[0];
            userId = Integer.parseInt(String.valueOf(params.get("userId") == null ? params.get("user_id") : params.get("userId")));//获取当前用户ID
        }
//        else userId= Integer.parseInt(String.valueOf(((AccountUserDo) user).getId()));
        String ip = getIpAddr(request);
/*       根据访问路径确定是用户操作记录还是管理员操作记录
            SystemLog log = new SystemLog();
            log.setDescription(getMethodDescription(joinPoint,0));
            log.setMethod(joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()");
            log.setLog_type(Byte.valueOf("0"));
            log.setRequest_ip(ip);
            log.setException_code(null);
            log.setException_detail(null);
            log.setUser_id(userId);
            log.setParams(JSON.toJSONString(joinPoint.getArgs()));
            log.setCtime(Calendar.getInstance().getTime());
            systemLogDao.save(log);*/
    }

    @AfterThrowing(pointcut = "TradeLog()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Object user = request.getSession().getAttribute("user");
        Integer userId = null;
        if (user == null) {
            Object[] obj = joinPoint.getArgs();
            if (obj.length != 1 || !(obj[0] instanceof Map)) return;
            Map params = (Map) obj[0];
            userId = Integer.parseInt(String.valueOf(params.get("userId") == null ? params.get("user_id") : params.get("userId")));//获取当前用户ID
        }
//        else userId= Integer.parseInt(String.valueOf(((AccountUserDo) user).getId()));
        String ip = getIpAddr(request);
        String params = JSONArray.toJSONString(joinPoint.getArgs());
/*            SystemLog log = new SystemLog();
            log.setDescription(getMethodDescription(joinPoint,1));
            log.setMethod(joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()");
            log.setLog_type(Byte.valueOf("1"));
            log.setRequest_ip(ip);
            log.setException_code(e.getClass().getName());
            log.setException_detail(e.getMessage());
            log.setUser_id(userId);
            log.setParams(JSON.toJSONString(joinPoint.getArgs()));
            log.setCtime(Calendar.getInstance().getTime());
            systemLogDao.save(log);*/
        logger.error(MessageFormat.format("异常方法:{}异常代码:{}异常信息:{}参数:{}", joinPoint.getTarget().getClass().getName() + joinPoint.getSignature().getName(), e.getClass().getName(), e.getMessage(), params));
    }

    @AfterReturning(pointcut = "operationLog()", returning = "returnObj")
    public void doAfterReturn(JoinPoint joinPoint, Object returnObj) {
        Object[] args = joinPoint.getArgs();
        HttpServletRequest request = (HttpServletRequest) args[0];
        String url = request.getRequestURL() + "?" + request.getQueryString();
        boolean isAdmin = url.contains("/system/");
        Object user = isAdmin ? request.getSession().getAttribute("admin") : request.getSession().getAttribute("user");
        Long userId = null;
        if (user == null)
            return;
        else
            userId = (Long) Constants.ReflectUtil.getFieldValue(user, "id");//获取当前用户ID
//            if (obj.length != 1 || !(obj[0] instanceof Map)) return;
//            Map params = (Map) obj[0];
        String params = joinPoint.getTarget().getClass() + "." + joinPoint.getSignature().getName() + "()==>" + JSONArray.toJSONString(Arrays.copyOfRange(args, 1, args.length));
        String fromUrl = request.getHeader("Referer");
        String ip = getIpAddr(request);
        if (isAdmin) {
            AdminActionLog adminActionLog = new AdminActionLog();
            adminActionLog.setAction(url);
            adminActionLog.setActionPara(params);
            adminActionLog.setAdminId(userId);
            adminActionLog.setCreateTime(new Date());
            adminActionLog.setRefAction(fromUrl);
            adminActionLog.setIp(ip);
            adminActionLog.setDescription(getMethodValue(joinPoint, 2));
            adminActionLogDao.save(adminActionLog);
        } else {
            UserActionLog userActionLog = new UserActionLog();
            userActionLog.setAction(url);
            userActionLog.setActionPara(params);
            userActionLog.setUserId(userId);
            userActionLog.setCreateTime(new Date());
            userActionLog.setRefAction(fromUrl);
            userActionLog.setIp(ip);
            userActionLog.setDescription(getMethodValue(joinPoint, 2));
            userActionLogDaoImpl.save(userActionLog);
        }
    }

    public String getMethodValue(JoinPoint joinPoint, int type) {
        Object[] objs = joinPoint.getArgs();
        Class[] clazzs = new Class[objs.length];
        for (int i = 0; i < clazzs.length; i++) {
                if (objs[i].getClass().getName().startsWith("com.yg.pojo"))
                clazzs[i]=Object.class;
//                    clazzs[i] = Class.forName(objs[i].getClass().getName());        //TODO:待观察
                else
                    clazzs[i] = objs[i].getClass();
        }
        Method method = null;
        try {
            method = joinPoint.getTarget().getClass().getMethod(joinPoint.getSignature().getName(), clazzs);
        } catch (NoSuchMethodException e) {
            logger.error("获取方法注解值异常......\n"+e.getMessage());
            e.printStackTrace();
            return "";
        }
        switch (type) {
            case 1:
                return method.getAnnotation(TradeLog.class).value();
            case 2:
                return method.getAnnotation(OperationLog.class).value();
            case 3:
                return method.getAnnotation(DataSource.class).value().name();
            default:
                return "";
        }
    }

    public Method getMethod(JoinPoint joinPoint) {
        Object[] objs = joinPoint.getArgs();
        Class[] clazzs = new Class[objs.length];
        for (int i = 0; i < clazzs.length; i++)
            clazzs[i] = objs[i].getClass();
        Method method = null;
        try {
            method = joinPoint.getTarget().getClass().getMethod(joinPoint.getSignature().getName(), clazzs);
        } catch (NoSuchMethodException e) {
            logger.error("获取方法注解值异常......");
            logger.error(MessageFormat.format("异常信息:{}", e.getMessage().toString()));
            e.printStackTrace();
            return method;
        }
        return method;
    }

    @Before("dataSource()")
    public void sqlBefore(JoinPoint joinPoint) {
        DataSourceHolder.DBType dbType = DataSourceHolder.DBType.valueOf(getMethodValue(joinPoint, 3));
        DataSourceHolder.setLocalDataSource(dbType);
    }

    @AfterThrowing(pointcut = "dataSource()", throwing = "e")
    public void connectException(JoinPoint joinPoint, MyBatisSystemException e) throws DataAccessException {
        String dbType = getMethodValue(joinPoint, 3);
        String methodInfo = joinPoint.getSignature().toString();
        if (methodInfo.equals(method.get())) throw e;
        method.set(methodInfo);
        DataSourceHolder.status = DataSourceHolder.DBType.valueOf(dbType).next();
        Object target = joinPoint.getTarget();
        try {
            getMethod(joinPoint).invoke(target, joinPoint.getArgs());
        } catch (IllegalAccessException e1) {
            e1.printStackTrace();
        } catch (InvocationTargetException e1) {
            e1.printStackTrace();
        }
        sendMail.sendEmail(adminEmail, "数据库服务器(" + dbType + ")异常", "异常发生时间:" + DateUtil.convertDateTimeToString(new Date(), null) + "\r\n异常方法:\t" + methodInfo + "\r\n" + e.getMessage());//TODO:可变为短信通知..
        //定时任务
        TriggerUtil.simpleTask(null, RecoverDBType.class, DateUtil.dateAddDay(new Date(), 1));
    }
}
