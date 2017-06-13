
package com.yg.dao.impl;
import com.yg.pojo.ProductStock;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class ProductStockDao extends BaseDao<ProductStock>{
    @Autowired
    public ProductStockDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}