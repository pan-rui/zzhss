package com.yg.service;

import java.io.Serializable;

/**
 * Created by Administrator on 2015/9/14.
 */
public final class ServiceType implements Serializable {
    private String serverName;
    private String methodName;
    private Object[] args;

   public ServiceType(String serverName, String methodName, Object[] args) {
       this.serverName=serverName;
        this.methodName = methodName;
        this.args = args;
    }

   public ServiceType(String serverName, String methodName) {
        this(serverName,methodName, new Object[0]);
    }

    public ServiceType(String serverName) {
        this(serverName, null, new Object[0]);
    }

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    public String getMethodName() {
        return methodName;
    }

    public ServiceType setMethodName(String methodName) {
        this.methodName = methodName;
        return this;
    }

    public Object[] getArgs() {
        return args;
    }

    public ServiceType setArgs(Object[] args) {
        this.args = args;
        return this;
    }


}
