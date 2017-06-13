
package com.yg.dao.impl;

import com.yg.pojo.Banner;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository

public class BannerDao extends BaseDao<Banner> {
    @Autowired
    public BannerDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }

}