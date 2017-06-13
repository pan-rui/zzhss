package com.yg.pojo;

import java.io.Serializable;
import java.util.Date;

public class AdminActionLog implements Serializable {
    private Long id;

    private Long adminId;

    private String action;

    private String refAction;

    private String ip;

    private Date createTime;

    private String actionPara;
    private String description;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getAdminId() {
        return adminId;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action == null ? null : action.trim();
    }

    public String getRefAction() {
        return refAction;
    }

    public void setRefAction(String refAction) {
        this.refAction = refAction == null ? null : refAction.trim();
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip == null ? null : ip.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getActionPara() {
        return actionPara;
    }

    public void setActionPara(String actionPara) {
        this.actionPara = actionPara == null ? null : actionPara.trim();
    }
}