
package com.yg.dao.impl;

import com.yg.core.DataSource;
import com.yg.core.DataSourceHolder;
import com.yg.pojo.Admin;
import org.apache.commons.codec.digest.DigestUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.io.UnsupportedEncodingException;

@Repository
public class AdminDao extends BaseDao<Admin> {
    @Autowired
    public AdminDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }

    @Override
    @DataSource(DataSourceHolder.DBType.slave1)
    public int save(Admin admin) {
        try {
            admin.setPwd(DigestUtils.md5Hex(admin.getPwd().getBytes("utf-8")));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return super.save(admin);
    }

    @Override
    @DataSource(DataSourceHolder.DBType.slave1)
    public int updateById(Admin admin) {
        if (!StringUtils.isEmpty(admin.getPwd()))
            try {
                admin.setPwd(DigestUtils.md5Hex(admin.getPwd().getBytes("utf-8")));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        return super.updateById(admin);
    }

}