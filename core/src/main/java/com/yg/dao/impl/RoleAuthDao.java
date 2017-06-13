
package com.yg.dao.impl;

import com.yg.pojo.RoleAuth;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RoleAuthDao extends BaseDao<RoleAuth> {
    @Autowired
    public RoleAuthDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}