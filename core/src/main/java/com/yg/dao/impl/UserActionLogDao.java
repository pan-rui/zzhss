
package com.yg.dao.impl;

import com.yg.pojo.UserActionLog;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserActionLogDao extends BaseDao<UserActionLog> {
    @Autowired
    public UserActionLogDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}