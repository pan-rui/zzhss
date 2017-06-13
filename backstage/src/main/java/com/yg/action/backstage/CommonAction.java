package com.yg.action.backstage;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.yg.annotaion.BeanBind;
import com.yg.base.BaseAction;
import com.yg.base.BaseResult;
import com.yg.base.BaseService;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.BaseDao;
import com.yg.pojo.Admin;
import com.yg.pojo.SmsRecord;
import com.yg.service.backstage.impl.AdminService;
import com.yg.service.impl.QueryService;
import com.yg.service.impl.SmsRecordService;
import com.yg.util.ImageCode;
import com.yg.util.Validator;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.WebAsyncTask;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/9/10.
 */
@Controller
@RequestMapping("/")
public class CommonAction extends BaseAction {

    @Autowired
    private BaseService baseService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private SmsRecordService smsRecordService;
    @Autowired
    private QueryService queryService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String toLogin(HttpServletRequest request) {
        return "login";
    }

    /**
     * 管理员登录
     *
     * @param request
     * @param adminName
     * @param pwd
     * @param verCode
     * @return
     */
    @RequestMapping(value = "loginEd", method = RequestMethod.POST)
    @ResponseBody
    public String login(HttpServletRequest request, String adminName, String pwd, String verCode) {
        try {
            List<Admin> admins = adminService.queryByPros(ParamsMap.newMap("adminName", adminName).addParams("pwd", DigestUtils.md5Hex(pwd.getBytes("utf-8"))));
            if (admins.size() == 0)
                return ReturnCode.LOGIN_PASSWORD_ERROR.toString();
            if (!String.valueOf(request.getSession().getAttribute("imageCode")).equalsIgnoreCase(verCode))
                return ReturnCode.IMAGE_CODE_ERROR.toString();
            if (((long) request.getSession().getAttribute("imgTime")) + Long.parseLong(Constants.getSystemStringValue("VerifyCode_Timeout")) < new Date().getTime())//TODO:验证码超时时间
                return ReturnCode.IMAGE_CODE_TIMEOUT.toString();
            request.getSession().setAttribute("admin", admins.get(0));
            //TODO:权限初始化
            adminService.loginInit(request);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return ReturnCode.OK.toString();
    }

    @RequestMapping("index")
    public String home(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("menus", JSON.toJSONString(adminService.queryMenuAll()));
        return "index";
    }

    @RequestMapping(value = "verifyCode", method = RequestMethod.GET)
    @ResponseBody
    public WebAsyncTask<String> verifyCode(HttpSession session, String val) {
        return new WebAsyncTask<String>(3500l, () -> {
            if (StringUtils.isEmpty(val))
                return ReturnCode.IMAGE_CODE_ISEMPTY.toString();
            if (session.getAttribute("imgTime") ==null||Long.parseLong(session.getAttribute("imgTime") + "") + Long.parseLong(Constants.getSystemStringValue("VerifyCode_Timeout")) < new Date().getTime())
                return ReturnCode.IMAGE_CODE_TIMEOUT.toString();
            if (!val.equalsIgnoreCase(session.getAttribute("imageCode") + ""))
                return ReturnCode.IMAGE_CODE_ERROR.toString();
            return ReturnCode.OK.toString();
        });
    }

    @RequestMapping(value = "imageCode", method = RequestMethod.GET)
    @ResponseBody
    public Object imageCode(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        ImageCode.generatorImg(request, response);
        return null;
    }

    /**
     * @param session
     * @param phone   发送号码
     * @param type    发送类型
     * @return
     */
    @RequestMapping(value = "sendSMS", method = RequestMethod.GET)
    @ResponseBody
    public WebAsyncTask<String> sendSMS(HttpSession session, String phone, String type) {
        return new WebAsyncTask<String>(3500l, () -> {
            if (Validator.PHONE.v(phone)) {
                long limit = Long.parseLong(Constants.getSystemStringValue("SendSms_Total_Limit"));
                SmsRecord smsRecord = smsRecordService.queryByMobile(phone);
                if (smsRecord != null && smsRecord.getCounts() > limit)
                    return ReturnCode.SEND_SMS_TOTAL_LIMIT.toString();
                String smsCode = ImageCode.getPartDigit(6);
                String smsContent = Constants.getSystemStringValue(type).replaceFirst("\\d{6}", smsCode);
                ReturnCode returnCode = ReturnCode.OK;//TODO:调用短信发送接口.......
                if (returnCode.getCode() != 0) //根据具体情况设置mobileStatus
                    return ReturnCode.SMS_RMI_ERROR.toString();
                Calendar calendar = Calendar.getInstance();
                session.setAttribute("smsCode", smsCode);
                session.setAttribute("smsTime", calendar.getTime().getTime());
                if (smsRecord != null) {
                    smsRecord.setTotalCount(smsRecord.getTotalCount() + 1);
                    smsRecord.setCounts(smsRecord.getCounts() + 1);
                    if (smsRecord.getCounts() >= limit)
                        smsRecord.setMobileStatus("1");//黑名单
                    smsRecordService.updateById(smsRecord);
                } else {
                    smsRecord = new SmsRecord();
                    smsRecord.setCounts(1);
                    smsRecord.setTotalCount(1);
                    smsRecord.setCreateTime(calendar.getTime());
                    smsRecord.setKeyVal(phone);
                    smsRecordService.save(smsRecord);
                }
                System.out.println("手机验证码为\t" + smsCode);
            } else return Validator.PHONE.toString();
            return ReturnCode.OK.toString();
        });
    }

    @RequestMapping(value = "checkSmsCode", method = RequestMethod.GET)
    @ResponseBody
    public String checkSmsCode(HttpSession session, String phone, String smsCode) {
        if (StringUtils.isEmpty(phone) || StringUtils.isEmpty(smsCode))
            return ReturnCode.PARAMS_HAS_NONE.toString();
        if (!smsCode.equals(session.getAttribute("smsCode")))
            return ReturnCode.SMS_CODE_WRONG.toString();
        if (Long.parseLong(session.getAttribute("smsTime") + "") + Long.parseLong(Constants.getSystemStringValue("SmsCode_Timeout")) < new Date().getTime())
            return ReturnCode.SMS_CODE_TIMEOUT.toString();
        SmsRecord smsRecord = smsRecordService.queryByMobile(phone);
        smsRecord.setCounts(0);
        smsRecordService.updateById(smsRecord);
        session.removeAttribute("imgTime");
        session.removeAttribute("imageCode");
        session.removeAttribute("smsCode");
        session.removeAttribute("smsTime");
        return ReturnCode.OK.toString();
    }

    @RequestMapping(value = "upload/{tableName}", method = RequestMethod.POST)
    @ResponseBody
    public String dataEdit(HttpServletRequest request, @PathVariable String tableName, String column, String key, @BeanBind("bean") Object obj, MultipartFile file) {
        BaseDao dao = (BaseDao) Constants.applicationContext.getBean(baseService.getPoName(tableName) + "Dao");
//        String path = Constants.getSystemStringValue("Upload_Root")+"/product";
        String path = request.getRealPath("/") + "image";
        Calendar calendar = Calendar.getInstance();
        File filePath = new File(path + "/" + calendar.get(Calendar.YEAR) + "/" + calendar.get(Calendar.MONTH) + "/" + calendar.get(Calendar.DAY_OF_MONTH), file.getOriginalFilename());
        if (!filePath.getParentFile().exists()) filePath.getParentFile().mkdirs();
        if (filePath.exists()) filePath.delete();
        try {
            file.transferTo(filePath);
//            Constants.ReflectUtil.setFieldValue(obj,column,setConstans(request,null).toString()+filePath.getPath().replace("\\","/"));
            String tempPath = filePath.getPath().replace("\\", "/");
            if (StringUtils.isEmpty(key))
                Constants.ReflectUtil.setFieldValue(obj, column, setConstans(request, null).toString() + tempPath.substring(tempPath.indexOf("/image")));
            else {
                Object po = dao.queryById((Long) Constants.ReflectUtil.getFieldValue(obj, "id"));
                String valStr = (String) Constants.ReflectUtil.getFieldValue(po, column);
                JSONObject jsonObject = StringUtils.isEmpty(valStr) ? new JSONObject() : JSON.parseObject(valStr);
                jsonObject.put(key, setConstans(request, null).toString() + tempPath.substring(tempPath.indexOf("/image")));
                Constants.ReflectUtil.setFieldValue(obj, column, jsonObject.toJSONString());
            }
            return dao.updateByIdForCache(obj) > 0 ? ReturnCode.OK.toString() : ReturnCode.FAIL.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ReturnCode.FAIL.toString();
    }

    /*    @RequestMapping(value = "product/upload", method = RequestMethod.POST)
        @ResponseBody
        public String uploadImg(HttpServletRequest request,String column, @BeanBind("bean") Object obj, MultipartFile file,MultipartFile big) {
            BaseDao dao = (BaseDao) Constants.applicationContext.getBean("productDao");
    //        String path = Constants.getSystemStringValue("Upload_Root")+"/product";
            String path = request.getRealPath("/") + "product";
            Calendar calendar=Calendar.getInstance();
            File filePath = new File(path + "/" + calendar.get(Calendar.YEAR) + "/" + calendar.get(Calendar.MONTH)+"/"+calendar.get(Calendar.DAY_OF_MONTH),file.getOriginalFilename());
            if(!filePath.getParentFile().exists()) filePath.getParentFile().mkdirs();
            if(filePath.exists())filePath.delete();
            try {
                file.transferTo(filePath);
    //            Constants.ReflectUtil.setFieldValue(obj,column,setConstans(request,null).toString()+filePath.getPath().replace("\\","/"));
                String tempPath=filePath.getPath().replace("\\","/");
                Constants.ReflectUtil.setFieldValue(obj,column,setConstans(request,null)+tempPath.substring(tempPath.indexOf("/product")));
                return dao.updateById(obj)>0?ReturnCode.OK.toString():ReturnCode.FAIL.toString();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return ReturnCode.FAIL.toString();
        }*/
    @RequestMapping(value = "market.xls", method = RequestMethod.GET,produces = "application/vnd.ms-excel")
    @ResponseBody
    public Object payout(HttpServletRequest request, HttpServletResponse response, long userId, Long couponDictId, Long count, ModelMap modelMap) {
        BaseResult baseResult = null;
        try {
            baseResult = queryService.generateCoupon(response.getOutputStream(), userId, couponDictId, count);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return baseResult;
    }

    @RequestMapping(value = "exit", method = RequestMethod.GET)
    public String exit(HttpServletRequest request, ModelMap modelMap) {
        request.getSession().invalidate();
        return "login";
    }

}
