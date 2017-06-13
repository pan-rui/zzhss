package com.yg.action.front;

import com.google.zxing.WriterException;
import com.yg.base.BaseAction;
import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.BaseDao;
import com.yg.pojo.SmsRecord;
import com.yg.pojo.User;
import com.yg.service.front.impl.UserService;
import com.yg.service.impl.QueryService;
import com.yg.service.impl.SmsRecordService;
import com.yg.util.ImageCode;
import com.yg.util.JuheUtil;
import com.yg.util.Validator;
import com.yg.util.ZXingUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.MatrixVariable;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.WebAsyncTask;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by panrui on 2015/10/3.
 */
@Controller
@RequestMapping("/")
public class CommonAction extends BaseAction {
    private Logger logger = LogManager.getLogger(CommonAction.class);
    @Autowired
    private UserService userService;
    @Autowired
    private SmsRecordService smsRecordService;
    @Autowired
    private QueryService queryService;

    /**
     * 首页
     *
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index(HttpServletRequest request, ModelMap modelMap) {
//        modelMap.put("products", queryService.queryAllProduct());
        modelMap.put("publicVideo", Constants.getSystemStringValue("Publicity_Video"));
        modelMap.put("useVideo", Constants.getSystemStringValue("Use_Video"));
        modelMap.put("installVideo", Constants.getSystemStringValue("Install_Video"));
        modelMap.put("businessVideo", Constants.getSystemStringValue("Business_Video"));
        //TODO:初始化............
        return "index";
    }

/*    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String toLogin(HttpServletRequest request, ModelMap modelMap) {
        return "user/login";
    }*/

    //
    @RequestMapping(value = "testS", method = RequestMethod.GET)
    @ResponseBody
    public Object testReturnCode(HttpServletRequest request, String message) {
        BaseResult result = userService.getTest();

        return result;
    }

    @RequestMapping(value = "validator/{bean}/{status}", method = RequestMethod.GET)
    @ResponseBody
    public WebAsyncTask<String> validator(HttpServletRequest request, @PathVariable String bean, @MatrixVariable(required = false) String pName, @PathVariable int status, String val) {
        return new WebAsyncTask<String>(3500l, () -> {
            BaseDao dao = (BaseDao) Constants.applicationContext.getBean(bean + "Dao");
            ParamsMap<String, Object> params = new ParamsMap();
            if (StringUtils.isEmpty(val))
                return "{\"code\":1,\"msg\":\"" + pName + "不能为空\"}";
            if (StringUtils.isEmpty(pName))
                params.addParams("id", val);
            else params.addParams(pName, val);
            List<Object> list = dao.queryByPros(params);
            if (status >= 1) {
                if (list == null || list.isEmpty())
                    return "{\"code\":1,\"msg\":\"不存在该记录\"}";
            } else {
                if (list != null && !list.isEmpty()){
                    if("user".equalsIgnoreCase(bean))
                        return "{\"code\":1,\"msg\":\"此号码可能已经在App上注册,请直接登录!\"}";
                    else  return "{\"code\":1,\"msg\":\"已存在该记录\"}";
                }
            }
//            if(bean.equalsIgnoreCase("user"))

            return ReturnCode.OK.toString();
        });
    }

/*    @RequestMapping(value = "register", method = RequestMethod.GET)
    public String register() {
        return "user/register";
    }*/

    @RequestMapping(value = "verifyCode", method = RequestMethod.GET)
    @ResponseBody
    public WebAsyncTask<String> verifyCode(HttpSession session, String val) {
        return new WebAsyncTask<String>(3500l, () -> {
            String verifyCode_Timeout = Constants.getSystemStringValue("VerifyCode_Timeout");
            if (StringUtils.isEmpty(val))
                return ReturnCode.IMAGE_CODE_ISEMPTY.toString();
            if (session.getAttribute("imgTime")==null||Long.parseLong(session.getAttribute("imgTime") + "") + Long.parseLong(verifyCode_Timeout==null?"180000":verifyCode_Timeout) < new Date().getTime())
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
//                String smsCode = "888888";
                String smsCode = ImageCode.getPartDigit(6);
//                String smsContent = Constants.getSystemStringValue(type).replaceFirst("\\d{6}", smsCode);
                Map<String, Object> param = new HashMap<>();
                param.put("mobile", phone);
                param.put("tpl_id", 10298);
                param.put("tpl_value", "#app#=智护伞&#code#="+smsCode+"&#expire#="+Long.parseLong(Constants.getSystemStringValue("SmsCode_Timeout"))/1000);
                BaseResult result = JuheUtil.sendSms(param);//TODO:调用短信发送接口.......
                if (result.getCode() != 0) //根据具体情况设置mobileStatus
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

/*    @RequestMapping(value = "register2", method = RequestMethod.GET)
    public String register2(HttpServletRequest request) {
        request.getSession().setAttribute("step1Map", new HashMap<String, String[]>(request.getParameterMap()));
        return "register2";
    }*/

    @RequestMapping(value = "validator/userReferrer", method = RequestMethod.GET)
    @ResponseBody
    public String userReferrer(HttpServletRequest request, HttpServletResponse response, String val) throws UnsupportedEncodingException {
        if (StringUtils.isEmpty(val))
            return ReturnCode.PARAMS_HAS_NONE.toString();
        if (!org.apache.commons.lang.StringUtils.isNumeric(val))
            return ReturnCode.REFERRER_NOT_NUMBER.toString();
        User user = userService.queryReferrer(Long.parseLong(val));
        if (user == null)
            return ReturnCode.REFERRER_NOT_EXISTS.toString();
        return ReturnCode.OK.toString();
    }

    @RequestMapping(value = "link", method = RequestMethod.GET)
    @ResponseBody
    public Object link(HttpServletRequest request, String content, ModelMap modelMap) {
        if (!StringUtils.isEmpty(content)) {
            return new BaseResult(0, Constants.getSystemStringValue(content));
        } else
            return ReturnCode.PARAMS_HAS_NONE;
    }

    @RequestMapping("refreshData")
    @ResponseBody
    public String refreshData(HttpServletRequest request) {
        baseService.clearAllCache();
        baseService.initSystemData();
        return ReturnCode.OK.toString();
    }

    /**
     * Ajax 跨域访问
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "testA", method = RequestMethod.GET)
    @ResponseBody
    public String testA(HttpServletRequest request, HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");//跨域访问,允许所有
        System.out.println();
        return request.getParameter("callback") + "(" + ReturnCode.OK.toString() + ")";
    }

    @RequestMapping("service")
    public String serviceCenter(HttpServletRequest request, ModelMap map) {
        return "serviceCenter";
    }

    @RequestMapping(value = "logistics",method = RequestMethod.POST,params = "no")
    @ResponseBody
    public Object queryLogistics(HttpServletRequest request, String com, String no) {
        return queryService.queryLogistics(com, no);
    }

    @RequestMapping(value = "agreement", method = RequestMethod.GET)
    public String agreement(HttpServletRequest request, ModelMap modelMap) {
        return "user/agreement";
    }
    @RequestMapping(value = "map", method = RequestMethod.GET)
    public String map(HttpServletRequest request, ModelMap modelMap) {
        return "include/map";
    }

    @RequestMapping(value = "wxQRCode",method = RequestMethod.GET)
    @ResponseBody
    public String generateQRCode(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) {
        response.setContentType("image/jpeg; charset=UTF-8");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        try {
           BufferedImage image= ZXingUtil.convert2Image(String.valueOf(request.getSession().getAttribute("wxPayCode")), 301, 301);
            ImageIO.write(image, "JPEG", response.getOutputStream());
        } catch (WriterException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
