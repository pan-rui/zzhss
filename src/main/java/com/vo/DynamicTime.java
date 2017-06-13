package com.vo;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by panrui on 2016/4/24.
 */
public class DynamicTime {
    private Double timeI;
    private Long gpss;
    private Long users;

    public Double getTimeI() {
        return timeI;
    }

    public void setTimeI(Double timeI) {
        this.timeI = timeI;
    }

    public Long getGpss() {
        return gpss;
    }

    public void setGpss(Long gpss) {
        this.gpss = gpss;
    }

    public Long getUsers() {
        return users;
    }

    public void setUsers(Long users) {
        this.users = users;
    }

    public static Map<String,String> fields(){
        Map<String, String> fields = new HashMap<>();
        fields.put("timeI", "时间段");
        fields.put("gpss", "GPS点个数");
        fields.put("users", "用户数");
        return fields;
    }
}
