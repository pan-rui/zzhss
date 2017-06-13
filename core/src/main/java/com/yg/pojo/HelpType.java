package com.yg.pojo;

import java.io.Serializable;
import java.util.Date;

public class HelpType implements Serializable {
    private Long id;

    private String helpTypeName;

    private Date createTime;

    private Integer orderNo;

    private Integer helpTypeId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getHelpTypeName() {
        return helpTypeName;
    }

    public void setHelpTypeName(String helpTypeName) {
        this.helpTypeName = helpTypeName == null ? null : helpTypeName.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public Integer getHelpTypeId() {
        return helpTypeId;
    }

    public void setHelpTypeId(Integer helpTypeId) {
        this.helpTypeId = helpTypeId;
    }
}