
package com.yg.dao.impl;

import com.yg.pojo.Menu;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MenuDao extends BaseDao<Menu> {
    @Autowired
    public MenuDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }

    public List<Map<String,Object>> initMenus() {
        return this.sqlSessionTemplate.selectList(className + ".initMenus");
    }
}