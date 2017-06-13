
package com.yg.dao.impl;

import com.yg.core.DataSource;
import com.yg.core.ParamsMap;
import com.yg.pojo.CouponDict;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CouponDictDao extends BaseDao<CouponDict> {
    @Autowired
    public CouponDictDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    @DataSource
    public List<CouponDict> queryUserCoupons(Long userId) {
        return sqlSessionTemplate.selectList(className + ".queryUserCoupons", userId);
    }

    @Cacheable(value = "backstage", key = "target.className+#redCode")
    @DataSource
    public CouponDict queryByRed(String redCode) {
        List<CouponDict> couponDicts = queryByPros(new ParamsMap<>().addParams("couponRemarks", redCode));
        if (couponDicts.isEmpty())
            return null;
        return couponDicts.get(0);
    }

    @Cacheable(value = "backstage", key = "target.className+#code")
    @DataSource
    public CouponDict queryByReferrer(String code) {
        List<CouponDict> couponDicts = queryByPros(new ParamsMap<>().addParams("couponRemarks", code));
        if (couponDicts.isEmpty())
            return null;
        return couponDicts.get(0);
    }

    @DataSource
    public CouponDict queryCoupon(String couponId){
        return sqlSessionTemplate.selectOne(className + ".queryCoupon", couponId);
    }
}