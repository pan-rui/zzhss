package com.yg.service.impl;

import com.yg.core.ParamsMap;
import com.yg.dao.impl.SmsRecordDao;
import com.yg.pojo.SmsRecord;
import com.yg.service.ISmsReCordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by panrui on 2015/10/4.
 */
@Service
public class SmsRecordService implements ISmsReCordService {
    @Autowired
    private SmsRecordDao smsRecordDao;


    @Override
    public SmsRecord queryById(long id) {
        return smsRecordDao.queryById(id);
    }

    @Override
    public int deleteById(long id) {
        return smsRecordDao.deleteById(id);
    }

    @Override
    public List<SmsRecord> queryAll() {
        return smsRecordDao.queryAll();
    }

    @Override
    public int save(SmsRecord smsRecord) {
        return smsRecordDao.save(smsRecord);
    }

    @Override
    public int updateById(SmsRecord smsRecord) {
        return smsRecordDao.updateById(smsRecord);
    }

    public SmsRecord queryByMobile(String mobile) {
        List<SmsRecord> smsRecords=smsRecordDao.queryByPros(new ParamsMap<String, String>().addParams("keyVal", mobile));
        if(smsRecords==null||smsRecords.isEmpty())
            return null;
        return smsRecords.get(0);
    }
}
