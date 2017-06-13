package com.yg.service.backstage;

import com.yg.base.ReturnCode;
import com.yg.core.ParamsMap;
import com.yg.pojo.Admin;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/9.
 */
public interface IAdminService {

    public void loginInit(HttpServletRequest request);

    public List<Map<String,Object>> queryMenuAll();

    public ReturnCode updatePass(Admin admin);

    public List<Admin> queryByPros(ParamsMap<String,Object> params);
}
