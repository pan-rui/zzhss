
package com.yg.dao.impl;

import com.yg.pojo.UserLoginRecord;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserLoginRecordDao extends BaseDao<UserLoginRecord> {
    @Autowired
    public UserLoginRecordDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}