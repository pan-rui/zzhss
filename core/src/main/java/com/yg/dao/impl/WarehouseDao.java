
package com.yg.dao.impl;
import com.yg.pojo.Warehouse;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class WarehouseDao extends BaseDao<Warehouse>{
    @Autowired
    public WarehouseDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}