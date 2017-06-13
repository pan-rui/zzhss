
package com.yg.dao.impl;

import com.yg.pojo.AdminActionLog;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminActionLogDao extends BaseDao<AdminActionLog> {
    @Autowired
    public AdminActionLogDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}