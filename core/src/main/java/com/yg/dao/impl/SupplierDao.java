
package com.yg.dao.impl;
import com.yg.pojo.Supplier;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class SupplierDao extends BaseDao<Supplier>{
    @Autowired
    public SupplierDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}