package com.yg.dao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Description: 602数据库查询
 * @Created: 潘锐 (2016-01-11 12:57)
 * $Rev: 759 $
 * $Author: panrui $
 * $Date: 2016-08-15 12:27:43 +0800 (周一, 15 八月 2016) $
 */
@CacheConfig(cacheNames = "front", cacheResolver = "baseService")
@Repository
public class BaseDao602 {
    @Autowired
    private JdbcTemplate jdbcTemplate602;
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    private String imeiMatch="^(81211|31888|32888|82211)\\d+";
    private List<String> imeiList = Arrays.asList("812110000000103", "812110000000115", "812110000000120", "812110000000123", "812110000000144", "812110000000150", "812110000000159", "812110000000179", "812110000000185", "812110000000195");

    @Cacheable(key = "'gps602_'+T(java.lang.String).valueOf(#imei)",value = "front")
    public List<Map<String, Object>> queryById(Long imei) {
        String tableName = "tb_aut_gps_" + sdf.format(new Date());
        String sql = "SELECT * FROM " + tableName + " where DEV_IMEI='" + imei + "'";
        return jdbcTemplate602.queryForList(sql);
    }

    public List<Map<String, Object>> gpsPoint(Integer devId, String imei) {
        Calendar calendar = Calendar.getInstance();
//        StringBuffer sb = new StringBuffer("select gp.* from (");
        String sql = "";
        List<Map<String,Object>> result=null;
        for(int index=0;index<7;index++){
            if(index>0) calendar.add(Calendar.DAY_OF_MONTH,-1);
            sql="SELECT DEV_AUT_LNG gpsLng,DEV_AUT_LAT gpsLat,DATE_FORMAT(DEV_AUT_TIME,'%Y-%m-%e %k:%i:%s') gpsTime,DEV_AUT_SPEED speed,DEV_AUT_DIRECTION azimuth FROM tb_aut_gps_" +
                    sdf.format(calendar.getTime()) + " where DEV_IMEI='" + imei + "' ORDER BY gpsTime DESC  LIMIT 1";
//            sb.append("SELECT DEV_AUT_LNG gpsLng,DEV_AUT_LAT gpsLat,DATE_FORMAT(DEV_AUT_TIME,'%Y-%m-%e %k:%i:%s') gpsTime,DEV_AUT_SPEED speed,DEV_AUT_DIRECTION azimuth,DEV_IMEI FROM ")
//                    .append("tb_aut_gps_").append(sdf.format(calendar.getTime()));
//            if(index<6) sb.append(" union ");
        result=jdbcTemplate602.queryForList(sql);
        if(result!=null&&!result.isEmpty()) break;
        }
//        sb.append(") gp where gp.DEV_IMEI='").append(imei).append("' order by gp.gpsTime desc limit 1");
/*        String sql = "SELECT DEV_AUT_LNG gpsLng,DEV_AUT_LAT gpsLat,DATE_FORMAT(DEV_AUT_TIME,'%Y-%m-%e %k:%i:%s') gpsTime,DEV_AUT_SPEED speed,DEV_AUT_DIRECTION azimuth FROM " +
                getTableName(imei) + " where DEV_IMEI='" + imei + "' ORDER BY gpsTime DESC  LIMIT 1";*/
                return result;
    }

    public List<Map<String, Object>> track(String imei, Long stTime, Long endTime) {
        String sql = "SELECT DEV_AUT_LNG gpsLng,DEV_AUT_LAT gpsLat,DATE_FORMAT(DEV_AUT_TIME,'%Y-%m-%e %k:%i:%s') gpsTime,DEV_AUT_SPEED speed,DEV_AUT_DIRECTION azimuth FROM " +
                getTableName(imei,new Date(stTime*1000)) + " where DEV_IMEI='" + imei + "' and UNIX_TIMESTAMP(DEV_AUT_TIME) >="+stTime+" AND UNIX_TIMESTAMP(DEV_AUT_TIME) <="+endTime+" ORDER BY gpsTime DESC";
        return jdbcTemplate602.queryForList(sql);
    }

    public String getTableName(String imei) {
       return getTableName(imei, new Date());
    }

    public String getTableName(String imei, Date date) {
        if(imei.matches(imeiMatch) && !imeiList.contains(imei))
            return "tb_aut_gps_recent_old_devs";
        else return "tb_aut_gps_" + sdf.format(date);
    }

}
