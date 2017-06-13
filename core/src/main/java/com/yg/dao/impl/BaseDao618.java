package com.yg.dao.impl;

import com.yg.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @Description: 602数据库查询
 * @Created: 潘锐 (2016-01-11 12:57)
 * $Rev: 759 $
 * $Author: panrui $
 * $Date: 2016-08-15 12:27:43 +0800 (周一, 15 八月 2016) $
 */
@CacheConfig(cacheNames = "front", cacheResolver = "baseService")
@Repository
public class BaseDao618 {
    @Autowired
    private JdbcTemplate jdbcTemplate618;

    @Cacheable(key = "'devices'+T(java.lang.String).valueOf(#cellPhone)",value = "front")
    public List<Map<String, Object>> queryByPhone(String  cellPhone) {
        String sql = "SELECT ydi.* FROM YG_DEVICE_INFO ydi JOIN ACCOUNT_has_DEVICE ahd ON ydi.Device_ID=ahd.Device_ID JOIN YG_ACCOUNT ya ON ahd.Acc_ID=ya.Acc_ID WHERE ya.Account='"+cellPhone+"'";
        return jdbcTemplate618.queryForList(sql);
    }

    public void cloneRegister(User user) {
       jdbcTemplate618.execute("insert IGNORE YG_ACCOUNT(Account) VALUES ('" + user.getCellPhone() + "')");
       Map<String,Object> resultMap=jdbcTemplate618.queryForMap("select Acc_ID from YG_ACCOUNT WHERE Account='" + user.getCellPhone() + "'");
        jdbcTemplate618.execute("insert IGNORE AUTH_TOKEN(Token_Principal,Token_Credential) values(" + resultMap.get("Acc_ID") + ",'" + user.getPwd() + "')");
    }

    @Cacheable(key="'installCode'",value = "backstage")
    public Map<String,Object> queryInstallCode(String imei) {
        String sql = "select Install_Code FROM YG_DEVICE_INFO WHERE Device_Imei='"+imei+"'";
        return  jdbcTemplate618.queryForMap(sql);
    }

    public int updatePass(String phone, String newPass) {
        String sql = "UPDATE AUTH_TOKEN at,YG_ACCOUNT ya SET at.Token_Credential='" + newPass + "' WHERE at.Token_Principal=ya.Acc_ID AND ya.Account='" + phone + "'";
       return jdbcTemplate618.update(sql);
    }

}
