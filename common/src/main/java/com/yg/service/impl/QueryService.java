package com.yg.service.impl;

import com.alibaba.fastjson.JSON;
import com.yanguan.server.HbaseRepository;
import com.yg.base.BaseResult;
import com.yg.base.BaseService;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.core.JedisUtils;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.AdminDao;
import com.yg.dao.impl.BaseDao602;
import com.yg.dao.impl.BaseDao618;
import com.yg.dao.impl.CouponDao;
import com.yg.dao.impl.LinksDao;
import com.yg.dao.impl.ProductDao;
import com.yg.dao.impl.UserDao;
import com.yg.pojo.Coupon;
import com.yg.pojo.Links;
import com.yg.pojo.Product;
import com.yg.pojo.User;
import com.yg.service.IQueryService;
import com.yg.util.ExportExcelUtil;
import com.yg.util.GPSoffset;
import com.yg.util.ImageCode;
import com.yg.util.JuheUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import redis.clients.jedis.Jedis;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by Administrator on 2015/10/15.
 */
@Service
@Transactional(rollbackFor = Exception.class,propagation = Propagation.NESTED)
public class QueryService implements IQueryService {
    private final Logger logger = LogManager.getLogger(QueryService.class);
    @Autowired
    private BaseService baseService;
    @Autowired
    private AdminDao adminDao;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private BaseDao602 baseDao602;
    @Autowired
    private BaseDao618 baseDao618;
    @Autowired
    private LinksDao linksDao;
    @Autowired
    private UserDao userDao;
    public static final String DEV_LAST_GPS = "DEV_LAST_GPS";
    @Autowired
    private HbaseRepository hbaseRepository;
    @Autowired
    private CouponDao couponDao;
    @Autowired
    private JdkSerializationRedisSerializer jdkRedisSerializer;

    @Override
    public List<Product> queryAllProduct() {
        return productDao.queryAllForCache();
    }



    @Override
    public Map<String, String> querySelect(ParamsMap<String, Object> params) {
        List<Map<String, String>> resultList = adminDao.queryColumnInfo(params);
        return resultList.isEmpty()?null:resultList.get(0);
    }

    @Override
    public List<Map<String, Object>> findDevice(String userId) {
        return null;
    }

    @Override
    public Product queryProduct(long id) {
        return productDao.queryById(id);
    }

    @Override
    public Object track(Integer devId, Integer version, String imei, Long stTime, Long endTime) {
        List<Map<String,Object>> devGpss=null;
        if (version.equals(602)) {
            devGpss=baseDao602.track(imei, stTime, endTime);
        } else if (version.equals(618)) {
            devGpss = hbaseRepository.queryDeviceTrack(devId, stTime, endTime);
        }
        devGpss.forEach(gps->hbaseGpsOff(gps));
        return devGpss;
    }

    @Override
    public Map<String, Object> queryInstallCode(String imei) {
        return baseDao618.queryInstallCode(imei);
    }

    @Override
    public Object gpsPoint(Integer devId,Integer version,String imei) {
        Object devGps = null;
        if (version.equals(602)) {
             devGps=JedisUtils.query602Point(imei);
            if(devGps==null){
                List<Map<String, Object>> gpss=baseDao602.gpsPoint(devId, imei);
                if(gpss!=null&&!gpss.isEmpty()) devGps = gpss.get(0);
            }
        } else{
/*            Jedis jedis=baseService.getJedis();
            if (jedis.hexists(DEV_LAST_GPS.getBytes(), Constants.intToByteArray(devId))) {
                devGps = jdkRedisSerializer.deserialize(jedis.hget(DEV_LAST_GPS.getBytes(), Constants.intToByteArray(devId)));
                jedis.close();
            } else */
                devGps=hbaseRepository.queryLatestGps(devId);
        }
        hbaseGpsOff(devGps);
        return devGps;
    }

    public List<User> querySales() {
        return userDao.queryByPros(ParamsMap.newMap("type", "5").addParams("isEnable", "0"));
    }

    @Override
    public List<Links> queryAllLinks() {
        return linksDao.queryAllForCache();
    }

    public BaseResult generateCoupon(OutputStream out, long userId,final Long couponDictId,final Long count) {
        List<Coupon> lists=couponDao.queryAll();
        Set<String> imesSet = new HashSet<>();
        lists.forEach(coupon -> imesSet.add(coupon.getId()));
        ArrayList<Coupon> result = new ArrayList<Coupon>();
        for(int i=0;i<count;i++) {
            String couponId=ImageCode.getSymbol(6,ImageCode.partUpperArray)+String.format("%08d",imesSet.size()+1);
            if(!imesSet.add(couponId)) {
                i--;
                continue;
            }
            Coupon coupon = new Coupon();
            coupon.setId(couponId);
            coupon.setCouponId(couponDictId);
            coupon.setCouponStatus("2");
            coupon.setUserId(userId);
            result.add(coupon);
        }
        Map<String, String> param = ParamsMap.newMap("id", "优惠码").addParams("couponId", "优惠码字典ID").addParams("couponStatus", "状态").addParams("userId", "业务员ID");

       int size= couponDao.payout(userId, result);
           if(size>0)
               ExportExcelUtil.createExcel(result,null,out,param,"Coupon"+(userId!=0l?userId:""));
        return size>0 ? new BaseResult(ReturnCode.OK) : new BaseResult(ReturnCode.FAIL);
    }

    public Object queryLogistics(String com,String no) {
        Jedis jedis = baseService.getJedis();
        String jsonStr = jedis.get(no);
        if (!StringUtils.isEmpty(jsonStr)) {
            jedis.close();
            return JSON.parseObject(jsonStr, BaseResult.class);
        }
        Map<String, Object> param = new HashMap<>();
        param.put("com", com);
        param.put("no", no);
        BaseResult baseResult = JuheUtil.queryExp(param);
        String countStr = jedis.get(no + "-count");
        int count = StringUtils.isEmpty(countStr) ? 0 : Integer.parseInt(countStr);
        jedis.setex(no + "-count", 8 * 3600, ++count + "");
        Calendar calendar = Calendar.getInstance();
//        Date nextDay=DateUtil.getNextDay(new Date(calendar.get(Calendar.YEAR),calendar.get(Calendar.MONTH),calendar.get(Calendar.DAY_OF_MONTH)),1);
        jedis.setex(no, count < 2 ? 7200 : (int) ((new GregorianCalendar(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH) + 1).getTimeInMillis() - System.currentTimeMillis()) / 1000), JSON.toJSONString(baseResult));
        return baseResult;
    }

    public Object hbaseGpsOff(Object gps){
        if(gps==null){
            return null;
        }
        boolean isMap=gps instanceof Map;
        double agolat=0,agolng=0;
        if(isMap){
         agolat= new Double(String.valueOf(((Map)gps).get("gpsLat")));
         agolng= new Double(String.valueOf(((Map)gps).get("gpsLng")));
        }else {
            agolat = (double) Constants.ReflectUtil.getFieldValue(gps, "gpsLat");
            agolng= (double) Constants.ReflectUtil.getFieldValue(gps, "gpsLng");
        }
        if(agolat == 0 || agolng == 0){
            return null;
        }
        Double lng;
        Double lat;
        try{
            double[] latlng = new double[2];
            GPSoffset.transform(agolat, agolng,latlng);
          double[] bdgps= GPSoffset.BaiduGPSCorrect.bd_encrypt(latlng[0], latlng[1]);
            lng = bdgps[1];
            lat = bdgps[0];
        }catch(Exception e){
            logger.error(e);
            return null;
        }
        if(isMap){
            ((Map)gps).put("gpsLat",lat);
            ((Map)gps).put("gpsLng",lng);
        }else {
            Constants.ReflectUtil.setFieldValue(gps,"gpsLat",lat);
            Constants.ReflectUtil.setFieldValue(gps,"gpsLng",lng);
        }
        return gps;
    }
}
