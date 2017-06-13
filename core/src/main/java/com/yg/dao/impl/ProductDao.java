
package com.yg.dao.impl;
import com.yg.core.DataSource;
import com.yg.pojo.Product;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDao extends BaseDao<Product>{
    @Autowired
    public ProductDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }

    @DataSource
    public List<Product> queryByOrderId(Long orderId) {
        return this.sqlSessionTemplate.selectList(className+".queryByOrderId",orderId);
    }
}