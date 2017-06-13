
package com.yg.dao.impl;
import com.yg.pojo.Delivery;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class DeliveryDao extends BaseDao<Delivery>{
    @Autowired
    public DeliveryDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}