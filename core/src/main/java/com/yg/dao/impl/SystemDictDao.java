
package com.yg.dao.impl;

import com.yg.pojo.SystemDict;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SystemDictDao extends BaseDao<SystemDict> {
    @Autowired
    public SystemDictDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}