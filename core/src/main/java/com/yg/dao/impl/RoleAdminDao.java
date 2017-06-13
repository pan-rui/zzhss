
package com.yg.dao.impl;

import com.yg.pojo.RoleAdmin;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RoleAdminDao extends BaseDao<RoleAdmin> {
    @Autowired
    public RoleAdminDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}