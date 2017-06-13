
package com.yg.dao.impl;
import com.yg.pojo.ShoppingCart;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class ShoppingCartDao extends BaseDao<ShoppingCart>{
    @Autowired
    public ShoppingCartDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}