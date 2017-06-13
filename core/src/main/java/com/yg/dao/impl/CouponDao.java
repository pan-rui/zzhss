
package com.yg.dao.impl;

import com.yg.core.DataSource;
import com.yg.core.DataSourceHolder;
import com.yg.core.ParamsMap;
import com.yg.pojo.Coupon;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class CouponDao extends BaseDao<Coupon> {
    @Autowired
    public CouponDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }

    @DataSource(DataSourceHolder.DBType.slave1)
    public int updateState(Long userId){
        return sqlSessionTemplate.update(className + ".updateState", userId);
    }

    @DataSource
    public List<Map<String,Object>> queryCoupons(Long userId){
        return sqlSessionTemplate.selectList(className + ".queryCoupons", userId);
    }

    @DataSource
    public List<Coupon> checkCoupon(Long userId) {
        return sqlSessionTemplate.selectList(className + ".checkCoupon", userId);
    }

    @DataSource(DataSourceHolder.DBType.slave1)
    public int payout(Long userId, ArrayList<Coupon> lists) {
        return sqlSessionTemplate.insert(className + ".payout", ParamsMap.newMap("userId", userId).addParams("lists", lists));
    }
}