
package com.yg.dao.impl;
import com.yg.pojo.Statistics;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class StatisticsDao extends BaseDao<Statistics>{
    @Autowired
    public StatisticsDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}