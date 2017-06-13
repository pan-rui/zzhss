
package com.yg.dao.impl;

import com.yg.core.DataSource;
import com.yg.pojo.User;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao extends BaseDao<User> {
    @Autowired
    public UserDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    @DataSource
    public User queryReferrer(Long id) {
        return sqlSessionTemplate.selectOne(className + ".queryReferrer", id);
    }

    @DataSource
    public User loginValidate(String nameOrPhone) {
        return sqlSessionTemplate.selectOne(className + ".loginValidate", nameOrPhone);
    }
}