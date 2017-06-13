
package com.yg.dao.impl;
import com.yg.pojo.Sale;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class SaleDao extends BaseDao<Sale> {
    @Autowired
    public SaleDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}