
package com.yg.dao.impl;

import com.yg.pojo.Role;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDao extends BaseDao<Role> {
    @Autowired
    public RoleDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}