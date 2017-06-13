package com.yg.pojo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class CouponDict implements Serializable {
    private Long id;

    private String couponName;

    private BigDecimal couponAmount;

    private Date createTime;

    private String couponRemarks;

    private String couponStatus;

    private String couponType;

    private Date expirationDate;
    private String isWithdraw;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName == null ? null : couponName.trim();
    }

    public BigDecimal getCouponAmount() {
        return couponAmount;
    }

    public void setCouponAmount(BigDecimal couponAmount) {
        this.couponAmount = couponAmount;
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
        this.couponStatus = couponStatus == null ? null : couponStatus.trim();
    }

    public String getCouponType() {
        return couponType;
    }

    public void setCouponType(String couponType) {
        this.couponType = couponType;
    }

    public String getIsWithdraw() {
        return isWithdraw;
    }

    public void setIsWithdraw(String isWithdraw) {
        this.isWithdraw = isWithdraw;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }
}