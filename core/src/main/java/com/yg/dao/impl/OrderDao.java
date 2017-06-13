
package com.yg.dao.impl;

import com.yg.core.DataSource;
import com.yg.core.DataSourceHolder;
import com.yg.core.ParamsMap;
import com.yg.pojo.Order;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class OrderDao extends BaseDao<Order>{
    @Autowired
    public OrderDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }

//    @Cacheable(value = "front",key = "'order_'+T(java.lang.String).valueOf(#userId)")
    @DataSource
    public List<Order> queryOrderInfo(Long userId) {
        return sqlSessionTemplate.selectList(className + ".queryOrderInfo", userId);
    }

/*    @Override
    @Caching(evict = {
//            @CacheEvict(value = "front",key = "'order_'+T(java.lang.String).valueOf(#t.userId)"),
            @CacheEvict(value = "front",key = "'order'")
    })
    @DataSource(DataSourceHolder.DBType.slave1)
    public int save(Order t) {
        return super.save(t);
    }*/

    @DataSource
    public List<Order> searchOrderInfo(Long userId, String patten) {
        return sqlSessionTemplate.selectList(className + ".searchOrderInfo", ParamsMap.newMap("userId", userId).addParams("patten", patten));
    }

    @DataSource(DataSourceHolder.DBType.slave1)
    public Map<String,String> cancelOrder() {
        return this.sqlSessionTemplate.selectOne(className+".cancelOrder",ParamsMap.newMap("cnt",0));
    }

    @DataSource
    public Order orderDetail(Long orderId, String couponId) {
        return this.sqlSessionTemplate.selectOne(className + ".orderDetail", ParamsMap.newMap("orderId", orderId).addParams("couponId", couponId));
    }

    @DataSource
    public int cancelOrderTime(Long userId){
        return this.sqlSessionTemplate.update(className + ".cancelOrderTime", userId);
    }

    @DataSource(DataSourceHolder.DBType.slave1)
    public int updateOrderByLogis(ParamsMap<String,Object> params) {
        return this.sqlSessionTemplate.update(className + ".updateByLogis", params);
    }

    @DataSource
//    @Cacheable(value = "backstage",key = "'order_'+T(java.lang.String).valueOf(#orderId)")
    public Order queryOrder(Long orderId) {
        return this.sqlSessionTemplate.selectOne(className + ".orderInfo", orderId);
    }

    @DataSource
    public Map<String, Object> getColumnInfo(String columnName) {
        return this.sqlSessionTemplate.selectOne(className + ".columnInfo", columnName);
    }

    @DataSource(DataSourceHolder.DBType.slave1)
    @CacheEvict(value = "front",key = "target.className+'_'+T(java.lang.String).valueOf(#params.get('id'))")
    public int updatePayOrder(ParamsMap<String,Object> params) {
        return this.sqlSessionTemplate.update(className + ".updatePayOrder", params);
    }

    @DataSource(DataSourceHolder.DBType.slave1)
    public int updateByPayNum(ParamsMap<String,Object> params) {
        return this.sqlSessionTemplate.update(className + ".updateByPayNum", params);
    }

}