
package com.yg.dao.impl;

import com.yg.pojo.HelpType;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HelpTypeDao extends BaseDao<HelpType> {
    @Autowired
    public HelpTypeDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}