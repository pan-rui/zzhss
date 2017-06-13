/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.yanguan.server.model;

import java.io.Serializable;

/**
 * 设备轨迹GPS信息
 *
 * @author [*田园间*]   liaoxuqian@hotmail.com
 * @since version 1.0
 * @datetime 2015-7-31  15:39:41
 */
public class DevGpsVo implements Serializable {

    /***********************************************
    |             C O N S T A N T S             |
    ***********************************************/
    private static final long serialVersionUID = -1L;

    /***********************************************
    |    I N S T A N C E   V A R I A B L E S    |
    ***********************************************/
    /**
     * gps经度
     */
    private double gpsLng;
    /**
     * gps纬度
     */
    private double gpsLat;
    /**
     * gps时间
     */
    private long gpsTime;
    /**
     * 设备速度，单位：km/h
     */
    private float speed;
    /**
     * 设备方位角
     */
    private float azimuth;

    /***********************************************
    |         C O N S T R U C T O R S           |
     ***********************************************/
    /***********************************************
    |  A C C E S S O R S / M O D I F I E R S    |
     ***********************************************/
    public double getGpsLng() {
        return gpsLng;
    }

    public void setGpsLng(double gpsLng) {
        this.gpsLng = gpsLng;
    }

    public double getGpsLat() {
        return gpsLat;
    }

    public void setGpsLat(double gpsLat) {
        this.gpsLat = gpsLat;
    }

    public long getGpsTime() {
        return gpsTime;
    }

    public void setGpsTime(long gpsTime) {
        this.gpsTime = gpsTime;
    }

    public float getSpeed() {
        return speed;
    }

    public void setSpeed(float speed) {
        this.speed = speed;
    }

    public float getAzimuth() {
        return azimuth;
    }

    public void setAzimuth(float azimuth) {
        this.azimuth = azimuth;
    }

    /***********************************************
    |               M E T H O D S               |
     ***********************************************/
    @Override
    public String toString() {
        return "DevGpsVo{" + "gpsLng=" + gpsLng + ", gpsLat=" + gpsLat + ", gpsTime=" + gpsTime + ", speed=" + speed + ", azimuth=" + azimuth + '}';
    }
}