package com.yg.base;

import java.io.Serializable;

/**
 * Created by Administrator on 2015/9/9.
 */
public enum ReturnCode implements Serializable {
    OK(0, "操作成功"),
    FAIL(1, "操作失败"),
    //    UPDATE_FAIL(2001, "更新失败"),
//    SAVE_FAIL(2002, "保存失败"),
//    DELETE_FAIL(2003, "删除失败"),
//    QUERY_FAIL(2004, "查询失败"),
    HAS_EXISTS(2005, "已存在"),
    NO_LOGIN(3000, "未登录"),
    REQUEST_PARAMS_VERIFY_ERROR(-1000, "请求参数验证错误"),
    CODE_INVALID(3001, "手机验证码失效"),
    COLLEC_ERROR(2006, "代收异常"),
    PAY_ERROR(2007, "代付异常"),
//    USER_HAS_EXISTS(1001, "用户名或手机号或身份证已经存在"),

    //注册时的验证
    USER_NOT_EXISTS(1002, "用户不存在"),
    NOT_EXISTS_COUPON(1031, "优惠码不正确"),
    CONPON_IS_EXPIRED(1035, "该优惠券已失效"),
    COUPON_IS_GRANTED(103, "您已经领取过此优惠券"),
    PARAMS_HAS_NONE(1003, "参数不能为空"),
    SMS_CODE_WRONG(1020, "手机验证码错误"),
    SEND_SMS_TOTAL_LIMIT(1021, "短信发送次数已达上限"),
    SMS_CODE_TIMEOUT(1022, "验证码已过期"),
    REFERRER_NOT_EXISTS(1023, "推荐码无效"),
    REFERRER_NOT_NUMBER(1024, "推荐码错误"),
    FORM_NOT_TRUE(1005, "格式不正确."),
    WRONG_PAY_PASSWORD(1061, "交易密码错误"),
    PAY_PASSWORD_IS_NONE(1060, "未设置交易密码."),
    NEED_BIND_BANK_ACCOUNT(1051, "未绑定银行卡号"),
    BANK_INFORMATION_WRONG(1050, "银行信息有误"),
    IDENTITY_SN_WRONG(1052, "身份证号不匹配"),
    Err_data_inValid(102, "参数不合法"),
    LOGIN_PASSWORD_ERROR(1011, "登录密码错误"),
    PASSWORD_NOT_MATCH(1017, "两次输入的密码不匹配"),
    MOBILE_NOT_REGISTER(1012, "该手机号码尚未注册"),
    IMAGE_CODE_ISEMPTY(1015, "验证码不能为空"),
    IMAGE_CODE_ERROR(1013, "验证码错误"),
    IMAGE_CODE_TIMEOUT(1014, "验证码已过期"),
    NO_AUTH(1016, "无此操作权限"),
    Server_Exec_Timeout(1111, "服务器端返回结果超时."),
    Server_Exec_Error(2222, "\u670D\u52A1\u5668\u7AEF\u65B9\u6CD5\u6267\u884C\u5931\u8D25"),
    Err_system_error(301, "\u51fa\u9519\u4e86!"),
    SMS_RMI_ERROR(302, "短信接口调用错误"),;
    private String msg;
    private int code;

    ReturnCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    @Override
    public String toString() {
        return "{\"code\":" + this.code + ",\"msg\":\"" + getMsg() + "\"}";
    }

}