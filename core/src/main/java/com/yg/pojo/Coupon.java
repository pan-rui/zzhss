package com.yg.pojo;

import java.io.Serializable;
import java.util.Date;

public class Coupon implements Serializable {
    private String id;

    private Long userId;

    private Long couponId;

    private Date createTime;
    private Date useTime;

    private String couponRemarks;

    private String couponStatus;
    public Coupon(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getUseTime() {
        return useTime;
    }

    public void setUseTime(Date useTime) {
        this.useTime = useTime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getCouponId() {
        return couponId;
    }

    public void setCouponId(Long couponId) {
        this.couponId = couponId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCouponRemarks() {
        return couponRemarks;
    }

    public void setCouponRemarks(String couponRemarks) {
        this.couponRemarks = couponRemarks == null ? null : couponRemarks.trim();
    }

    public String getCouponStatus() {
        return couponStatus;
    }

    public void setCouponStatus(String couponStatus) {
        this.couponStatus = couponStatus;
    }
}