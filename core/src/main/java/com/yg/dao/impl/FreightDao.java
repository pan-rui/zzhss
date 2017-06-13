
package com.yg.dao.impl;
import com.yg.pojo.Freight;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class FreightDao extends BaseDao<Freight>{
    @Autowired
    public FreightDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}