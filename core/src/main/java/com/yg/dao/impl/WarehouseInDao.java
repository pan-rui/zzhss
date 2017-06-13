
package com.yg.dao.impl;
import com.yg.pojo.WarehouseIn;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class WarehouseInDao extends BaseDao<WarehouseIn>{
    @Autowired
    public WarehouseInDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}