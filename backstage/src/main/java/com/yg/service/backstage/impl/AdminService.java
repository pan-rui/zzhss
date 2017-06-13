package com.yg.service.backstage.impl;

import com.yg.base.BaseService;
import com.yg.base.ReturnCode;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.AdminDao;
import com.yg.dao.impl.MenuDao;
import com.yg.dao.impl.RoleAdminDao;
import com.yg.dao.impl.RoleDao;
import com.yg.pojo.Admin;
import com.yg.pojo.Menu;
import com.yg.pojo.RoleAdmin;
import com.yg.pojo.RoleAuth;
import com.yg.service.backstage.IAdminService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2015/9/9.
 */
@Service
public class AdminService implements IAdminService,InitializingBean {
    @Autowired
    private BaseService baseService;
    @Autowired
    private AdminDao adminDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private RoleAdminDao roleAdminDao;
    @Autowired
    private MenuDao menuDao;

    @Override
    public void loginInit(HttpServletRequest request) {
        HttpSession session=request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
//        List<Role> roles = baseService.getSystemValue("Role", List.class);
        List<RoleAdmin> roleAdmins = baseService.getSystemValue("RoleAdmin", List.class);
        List<RoleAuth> roleAuths = baseService.getSystemValue("RoleAuth", List.class);
        List<Menu> menus = baseService.getSystemValue("Menu", List.class);
       List<String> urlList=roleAdmins.stream().filter(roleAdmin -> roleAdmin.getAdminId().equals(admin.getId())).flatMapToLong(roleAdmin1 -> {
            return roleAuths.stream().filter(roleAuth -> roleAuth.getRoleId().equals(roleAdmin1.getRoleId())).mapToLong(roleAu -> roleAu.getMenuId());
        }).mapToObj(menuId-> {
           Optional<Menu> optional= menus.stream().filter(menu -> menu.getId().equals(menuId)).findFirst();
            return optional.isPresent()?optional.get().getUrl():null;
       }).collect(Collectors.toList());
        session.setAttribute("urlList",urlList);
    }

    @Override
    @Cacheable("common")
    public List<Map<String,Object>> queryMenuAll() {
        final List<Map<String, Object>> menus = menuDao.initMenus();
        List<Map<String, Object>> resultList = new LinkedList<Map<String, Object>>();
        for (Map<String, Object> menu : menus) {
            Long parentId = StringUtils.isEmpty(menu.get("parentId")) ? 0l : Long.parseLong(menu.get("parentId") + "");
            if (parentId != 0l) {
                for (Map<String, Object> menu1 : menus)
                    if (parentId.equals(menu1.get("id"))) {
                        List<Map<String, Object>> children = (List<Map<String, Object>>) menu1.get("menus");
                        if (children == null) {
                            children = new LinkedList<Map<String, Object>>();
                            menu1.put("menus", children);                //区别所在
                        }
                        children.add(menu);
                    }
            } else resultList.add(menu);
        }
        return resultList;
    }

    @Override
    public ReturnCode updatePass(Admin admin) {
        return adminDao.updateById(admin)>0?ReturnCode.OK:ReturnCode.FAIL;
    }

    @Override
    public List<Admin> queryByPros(ParamsMap<String,Object> params) {
        return adminDao.queryByPros(params);
    }


    @Override
    public void afterPropertiesSet() throws Exception {
//        Server.run();
    }
}
