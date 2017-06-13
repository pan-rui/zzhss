package com.yg.service;

import com.alibaba.fastjson.JSON;
import com.yg.base.BaseResult;
import com.yg.base.Client;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

/**
 * Created by Administrator on 2015/9/14.
 */
public class ServiceWrap {
//    public static final ServiceType Test_getAdmin = new ServiceType("test", "getAdmin");

    public static ServiceType test_getAdmin(Object... objs) {
        return new ServiceType("test", "getAdmin", objs);
    }

    public static ServiceType borrowS_apply(String method,Object... objs) {
        return new ServiceType("borrowService", method, objs);
    }

    public static BaseResult getServiceResult(final ServiceType serviceType) {
        Future<BaseResult> future= Client.getService(serviceType);
        String taskName = future.getClass().getName();
        BaseResult v = null;
        try {
            v = future.get(3500l, TimeUnit.MILLISECONDS);
        } catch (InterruptedException e) {
            System.out.println("连接被中断....任务名为：" + JSON.toJSONString(serviceType));
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        } catch (TimeoutException e) {
/*            if (Server.respGroup.activeCount() < 1)
                System.out.println("服务端未启动．．．．");*/
            System.out.println("获取服务超时....任务名为："+taskName);
            e.printStackTrace();
        }
        return v;
    }
}
