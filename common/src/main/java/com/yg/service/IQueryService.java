package com.yg.service;

import com.yg.base.Base;
import com.yg.core.ParamsMap;
import com.yg.pojo.Links;
import com.yg.pojo.Product;
import com.yg.pojo.User;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/10/15.
 */
public interface IQueryService extends Base,Serializable {

    public List<Product> queryAllProduct();
    public Map<String, String> querySelect(ParamsMap<String, Object> params);
    public List<Map<String,Object>> findDevice(String userId);

    public Product queryProduct(long id);

    public Object gpsPoint(Integer devId,Integer version,String imei);
    public Object track(Integer devId,Integer version,String imei,Long stTime,Long endTime);

    public Map<String, Object> queryInstallCode(String imei);

    public List<User> querySales();

    public List<Links> queryAllLinks();

}
