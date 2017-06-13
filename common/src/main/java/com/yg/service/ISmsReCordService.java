package com.yg.service;

import com.yg.pojo.SmsRecord;

/**
 * Created by panrui on 2015/10/4.
 */
public interface ISmsReCordService extends IBaseService<SmsRecord>{
    public SmsRecord queryByMobile(String mobile);
}
