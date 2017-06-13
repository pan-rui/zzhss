
package com.yg.dao.impl;
import com.yg.core.Base64;
import com.yg.core.DataSource;
import com.yg.core.DataSourceHolder;
import com.yg.pojo.Pay;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.io.UnsupportedEncodingException;
import java.util.List;

@Repository
public class PayDao extends BaseDao<Pay>{
    @Autowired
    public PayDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate=sqlSessionTemplate;
    }

    @Override
    @CacheEvict(key = "'Pay'")
    @DataSource(DataSourceHolder.DBType.slave1)
    public int save(Pay pay) {
        try {
            pay.setBusinessSn(Base64.encode(pay.getBusinessSn().getBytes("UTF-8")));
            pay.setAppKey(Base64.encode(pay.getAppKey().getBytes("UTF-8")));
            if(!StringUtils.isEmpty(pay.getCert()))
                pay.setCert(Base64.encode(pay.getCert().getBytes("UTF-8")));
            pay.setAccount(Base64.encode(pay.getAccount().getBytes("UTF-8")));
            pay.setHead(Base64.encode(pay.getHead().getBytes("UTF-8")));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return super.save(pay);
    }

    @Override
    @DataSource(DataSourceHolder.DBType.slave1)
    @CacheEvict(value = "backstage",key = "'pay_'+T(java.lang.String).valueOf(#id)")
    public int updateById(Pay pay) {
        try {
            pay.setBusinessSn(Base64.encode(pay.getBusinessSn().getBytes("UTF-8")));
            pay.setAppKey(Base64.encode(pay.getAppKey().getBytes("UTF-8")));
            if(!StringUtils.isEmpty(pay.getCert()))
                pay.setCert(Base64.encode(pay.getCert().getBytes("UTF-8")));
            pay.setAccount(Base64.encode(pay.getAccount().getBytes("UTF-8")));
            pay.setHead(Base64.encode(pay.getHead().getBytes("UTF-8")));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return super.updateById(pay);
    }

    @Override
    @DataSource
    @Cacheable(value = "backstage",key = "'pay_'+T(java.lang.String).valueOf(#id)")
    public Pay queryById(Long id) {
        Pay pay=super.queryById(id);
        try {
            if(!StringUtils.isEmpty(pay.getCert()))
                pay.setCert(new String(Base64.decode(pay.getCert()),"UTF-8"));
            pay.setAppKey(new String(Base64.decode(pay.getAppKey()),"UTF-8"));
            pay.setAccount(new String(Base64.decode(pay.getAccount()),"UTF-8"));
            pay.setHead(new String(Base64.decode(pay.getHead()),"UTF-8"));
            pay.setBusinessSn(new String(Base64.decode(pay.getBusinessSn()),"UTF-8"));
        } catch (UnsupportedEncodingException e) {
            System.err.println("支付参数解密,解析出错.....");
            e.printStackTrace();
        }
        return pay;
    }

    @Override
    @DataSource
    public List<Pay> queryAll() {
        List<Pay> pays= super.queryAll();
        pays.forEach(pay -> {
            try {
                if(!StringUtils.isEmpty(pay.getCert()))
                    pay.setCert(new String(Base64.decode(pay.getCert()),"UTF-8"));
            pay.setAppKey(new String(Base64.decode(pay.getAppKey()),"UTF-8"));
            pay.setAccount(new String(Base64.decode(pay.getAccount()),"UTF-8"));
            pay.setHead(new String(Base64.decode(pay.getHead()),"UTF-8"));
            pay.setBusinessSn(new String(Base64.decode(pay.getBusinessSn()),"UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        });
        return pays;
    }

}