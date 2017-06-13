
package com.yg.dao.impl;
import com.yg.pojo.OrderItem;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class OrderItemDao extends BaseDao<OrderItem>{
    @Autowired
    public OrderItemDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}