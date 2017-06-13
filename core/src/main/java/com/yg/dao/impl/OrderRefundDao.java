
package com.yg.dao.impl;
import com.yg.pojo.OrderRefund;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class OrderRefundDao extends BaseDao<OrderRefund>{
    @Autowired
    public OrderRefundDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }

}