package com.yg.base;

import java.io.Serializable;

/**
 * Created by Administrator on 2015/9/14.
 */
public class BaseResult<T> implements Serializable {
    private String msg;
    private int code;
    private T data;

    public BaseResult() {
    }

    public BaseResult(ReturnCode returnCode) {
        this.code = returnCode.getCode();
        this.msg = returnCode.getMsg();
    }

    public BaseResult(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public BaseResult(int code, T data) {
        this.code = code;
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
