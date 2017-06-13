package com.yg.pojo;

import java.io.Serializable;
import java.util.Date;

public class ShoppingCart implements Serializable{
    private Long id;

    private Date ctime;

    private Date utime;

    private Long userId;

    private String loginIp;

    private String productItem;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCtime() {
        return ctime;
    }

    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }

    public Date getUtime() {
        return utime;
    }

    public void setUtime(Date utime) {
        this.utime = utime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getLoginIp() {
        return loginIp;
    }

    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp == null ? null : loginIp.trim();
    }

    public String getProductItem() {
        return productItem;
    }

    public void setProductItem(String productItem) {
        this.productItem = productItem;
    }
}