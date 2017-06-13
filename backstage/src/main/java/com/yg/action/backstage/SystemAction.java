package com.yg.action.backstage;

import com.yg.annotaion.BeanBind;
import com.yg.annotaion.MapBind;
import com.yg.base.BaseAction;
import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.core.Page;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.AdminDao;
import com.yg.dao.impl.BaseDao;
import com.yg.dao.impl.MenuDao;
import com.yg.pojo.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by panrui on 2015/10/4.
 */
@Controller
@RequestMapping("/system")
public class SystemAction extends BaseAction {

    @Autowired
    private AdminDao adminDao;
    @Autowired
    private MenuDao menuDao;
    /**
     * 刷新系统数据,后台//TODO:后台操作
     * @param request
     * @return
     */
    @RequestMapping("/refreshData")
    @ResponseBody
    public String refreshData(HttpServletRequest request) {
        baseService.clearAllCache();
        baseService.initSystemData();
        return ReturnCode.OK.toString();
    }

    @RequestMapping(value = "list/{tableName}", method = RequestMethod.GET)
    public String datagrid(HttpServletRequest request, @ModelAttribute @PathVariable String tableName,String key,String val, @MapBind Page page, ModelMap modelMap) {
        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(baseService.getPoName(tableName) + "Dao");
        if(!StringUtils.isEmpty(key)&&!StringUtils.isEmpty(val)){
            Map<String, Object> params = page.getParams();
            if(!params.containsKey(key))
            params.put(key, val);
            modelMap.put("key", key);
            modelMap.put("val", val);
            page.setParams(params);
            if(Objects.isNull(page.getOrderMap())||page.getOrderMap().isEmpty()){
            Map<String, String> orderMap = new HashMap<>();
            orderMap.put(key, "asc");
            page.setOrderMap(orderMap);
            }
        }
        List results = dao.queryForPage(page);
        page.setResults(results);
        modelMap.put("page", page);
        modelMap.put("columnsInfo", dao.queryColumnInfo(ParamsMap.newMap("tableName", tableName)));
        List<Menu> menus=menuDao.queryByPros(ParamsMap.newMap("url", request.getRequestURI()));
        modelMap.put("menuInfo", menus.isEmpty()?null:menus.get(0));
        modelMap.put("listUrl", StringUtils.isEmpty(request.getQueryString())?request.getRequestURI():request.getRequestURI()+"?"+request.getQueryString());
        String referer=request.getHeader("referer");
        if (referer.substring(referer.indexOf("/", 10)).startsWith(request.getRequestURI())) {
            return "jsonList";
        } else return "datagrid";
    }

    @RequestMapping(value = "list/{tableName}", method = RequestMethod.POST)
    @ResponseBody
    public Object subgrid(HttpServletRequest request,@PathVariable String tableName, @MapBind(value = "param",clazz = Map.class) Object obj) {
        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(baseService.getPoName(tableName) + "Dao");
        List result=dao.queryByPros((ParamsMap)obj);
        Map<String,Object> map=ParamsMap.newMap("rows",result);
        map.put("total",result.size());
        return map;
    }

    @RequestMapping(value = "save/{tableName}",method = RequestMethod.POST)
    @ResponseBody
    public Object dataSave(HttpServletRequest request,@ModelAttribute@PathVariable String tableName, String operate, @BeanBind("bean") Object bean) {
        BaseResult valid = validAndReturn(bean);
        if (valid.getCode() != 0) return valid;
        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(baseService.getPoName(tableName) + "Dao");
        int i = 0;
        if (operate.equals("add"))
            i = dao.saveOnCache(bean)!=null?1:0;
        else i = dao.updateByIdForCache(bean);
        return i > 0 ? ReturnCode.OK.toString() : ReturnCode.FAIL.toString();
    }

    @RequestMapping(value = "del/{tableName}",method = RequestMethod.POST)
    @ResponseBody
    public Object dataDel(HttpServletRequest request, @PathVariable String tableName, String ids) {
        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(baseService.getPoName(tableName) + "Dao");
        String[] idArray = ids.split(",");
        int count = idArray.length;
        for (String id : idArray)
            count -= dao.deleteById(Long.parseLong(id));
        return count < idArray.length ? ReturnCode.OK.toString(): ReturnCode.FAIL.toString();
    }

    @RequestMapping(value = "addOpt/{tableName}",method = RequestMethod.GET)
    public String addOperate(HttpServletRequest request, @ModelAttribute @PathVariable String tableName, ModelMap modelMap) {
        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(baseService.getPoName(tableName) + "Dao");
        modelMap.put("bean", menuDao.queryByPros(ParamsMap.newMap("url", "/system/list/"+tableName)).get(0));
        return "setControler";
    }
    @RequestMapping(value = "addOpt/{tableName}",method = RequestMethod.POST)
    @ResponseBody
    public String addOperateEd(HttpServletRequest request, @ModelAttribute @PathVariable String tableName,@BeanBind("menu") Menu menu, ModelMap modelMap) {
        return menuDao.updateByIdForCache(menu) > 0 ? ReturnCode.OK.toString() : ReturnCode.FAIL.toString();
    }
    @RequestMapping(value = "setColumn/{tableName}",method = RequestMethod.GET)
    public String setColumn(HttpServletRequest request, @ModelAttribute @PathVariable String tableName, ModelMap modelMap) {
//        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(baseService.getPoName(tableName) + "Dao");
        modelMap.put("columnsInfo", adminDao.queryColumnInfo(ParamsMap.newMap("tableName", tableName)));
        modelMap.put("bean",menuDao.queryByPros(ParamsMap.newMap("url", "/system/list/" + tableName)).get(0));
        return "setColumn";
    }

    @RequestMapping(value = "setColumn/{tableName}",method = RequestMethod.POST)
    @ResponseBody
    public String setColumnEd(HttpServletRequest request, @ModelAttribute @PathVariable String tableName, @BeanBind("menu") Menu menu, ModelMap modelMap) {
        return menuDao.updateByIdForCache(menu) > 0 ? ReturnCode.OK.toString() : ReturnCode.FAIL.toString();
    }

    @RequestMapping(value = "{tableName}/{operate}", params = "id")
    public String dataInfo(HttpServletRequest request, @ModelAttribute @PathVariable String tableName, @ModelAttribute @PathVariable String operate, String id, ModelMap modelMap) {
        String beanName = baseService.getPoName(tableName);
        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(beanName + "Dao");
        modelMap.put("columnsInfo", dao.queryColumnInfo(ParamsMap.newMap("tableName", tableName)));
        if (!operate.equals("add"))
            modelMap.put("bean", dao.queryById(Long.parseLong(id)));
        return "dataInfo";
    }

    /**
     * 操作项里的字段更改处理
     * @param request
     * @param tableName
     * @param obj
     * @return
     */
    @RequestMapping(value = "edit/{tableName}", method = RequestMethod.POST)
    @ResponseBody
    public String dataEdit(HttpServletRequest request,@PathVariable String tableName, @BeanBind("bean") Object obj) {
        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(baseService.getPoName(tableName) + "Dao");
        return dao.updateByIdForCache(obj)>0?ReturnCode.OK.toString():ReturnCode.FAIL.toString();
    }

    @RequestMapping(value = "list/{tableName}/columns", method = RequestMethod.GET)
    @ResponseBody
    public Object getColumns(HttpServletRequest request,@PathVariable String tableName) {
        return adminDao.queryColumnInfo(ParamsMap.newMap("tableName", tableName));
    }
}
