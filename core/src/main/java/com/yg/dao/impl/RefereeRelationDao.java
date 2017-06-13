
package com.yg.dao.impl;

import com.yg.pojo.RefereeRelation;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RefereeRelationDao extends BaseDao<RefereeRelation> {
    @Autowired
    public RefereeRelationDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}