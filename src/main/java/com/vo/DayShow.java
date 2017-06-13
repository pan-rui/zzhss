package com.vo;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by panrui on 2016/4/24.
 */
public class DayShow {
    private String date;
    private Integer validUser;
    private Long ridingTime;
    private Double mileage;
    private Integer activeUser;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Integer getValidUser() {
        return validUser;
    }

    public void setValidUser(Integer validUser) {
        this.validUser = validUser;
    }

    public Long getRidingTime() {
        return ridingTime;
    }

    public void setRidingTime(Long ridingTime) {
        this.ridingTime = ridingTime;
    }

    public Double getMileage() {
        return mileage;
    }

    public void setMileage(Double mileage) {
        this.mileage = mileage;
    }

    public Integer getActiveUser() {
        return activeUser;
    }

    public void setActiveUser(Integer activeUser) {
        this.activeUser = activeUser;
    }

    public static Map<String, String> fields() {
        Map<String, String> fields = new HashMap();
        fields.put("date", "日期");
        fields.put("validUser", "有效用户数");
        fields.put("ridingTime", "骑行时间(单位:秒)");
        fields.put("mileage", "骑行里程(单位:米)");
        fields.put("activeUser", "上线天数/用户数");
        return fields;
    }
}
