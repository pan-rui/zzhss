package com.yg.aspect;

import com.yg.base.Base;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2015/10/21.
 */
@Component
@Aspect
public class Baspect implements Base {
    private Logger logger = LogManager.getLogger(Baspect.class);

    @Pointcut("execution(* com.yg.service.pay.IPaymentService.*(..))")
    public void trade(){}

/*    @Around("execution(* com.yg.service.pay.IPaymentService.*(..))")
    public BaseResult saveTrade(ProceedingJoinPoint pj) throws Throwable {
        Object[] args=pj.getArgs();
//        IPay.PayType payType = (IPay.PayType) args[0];
        Map<String, Object> params = (Map<String, Object>) args[1];
     *//*   TransInfo transInfo = new TransInfo();
        transInfo.setBankUser(params.get("realName").toString());
        transInfo.setCardId(params.get("cardId").toString());
        transInfo.setContent(JSON.toJSONString(params));
        transInfo.setCtime(new Date());
        transInfo.setOrderId(params.get("orderId").toString());
        transInfo.setSocketType("0");
        transInfo.setThridId(Long.parseLong(params.get("thridId")+""));
        transInfo.setTradeType(IPay.TradeType.valueOf(pj.getSignature().getName()).getRemark());
        transInfo.setTransAmount(new BigDecimal(params.get("amount")+""));
        transInfo.setThridName(payType.getName());
        transInfoDao.save(transInfo);*//*
        BaseResult baseResult= (BaseResult) pj.proceed();
      *//*  TransInfo transInfo1= (TransInfo) transInfo.clone();
        transInfo1.setSocketType("1");
        transInfo1.setCtime(new Date());
        transInfo1.setContent(baseResult.getData()!=null?JSON.toJSONString(baseResult.getData()):baseResult.getMsg());
        transInfoDao.save(transInfo1);*//*
        return baseResult;
    }*/

}
