
package com.yg.dao.impl;

import com.yg.pojo.SmsRecord;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SmsRecordDao extends BaseDao<SmsRecord> {
    @Autowired
    public SmsRecordDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }
}