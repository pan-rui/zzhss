package com.yg.action.front;

import com.yg.base.BaseAction;
import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.pojo.User;
import com.yg.service.impl.QueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * @Description: 查车
 * @Created: 潘锐 (2016-01-07 09:43)
 * $Rev: 759 $
 * $Author: panrui $
 * $Date: 2016-08-15 12:27:43 +0800 (周一, 15 八月 2016) $
 */
@Controller
@RequestMapping("/find")
public class FindCarAction extends BaseAction {

    @Autowired
    private QueryService queryService;

    @RequestMapping("")
    public String find(HttpServletRequest request, ModelMap modelMap, RedirectAttributesModelMap map) {
        User user = (User) request.getSession().getAttribute("user");
//        return "redirect:http://www.zhihusan.com";
        if(user!=null){
            return "index";
        }else return "user/login";
    }
@RequestMapping(value = "car",method = RequestMethod.GET)
    public String findCar(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap, String imei) {
    if(request.getSession().getAttribute("user")!=null){
        List<Map<String,Object>> imeis= (List<Map<String, Object>>) request.getSession().getAttribute("imeis");
        Optional<Map<String,Object>> optional=imeis.stream().filter(map->{return imei.equals(map.get("Device_Imei"));}).findFirst();
        if(optional.isPresent()){
        Map<String,Object> device=optional.get();
        modelMap.put("device", device);
        return "findCar/car-track";
        }else{
            try {
                response.setCharacterEncoding("UTF-8");
                PrintWriter pw = response.getWriter();
                pw.write("<script>alert('您指定的IMEI号有误!'); window.history.back();</script>");
                pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
                return null;
        }
    }else
        return "index";
    }

    @RequestMapping(value = "{devId}/{imei}", method = RequestMethod.GET)
    @ResponseBody
    public Object gpsPoint(HttpServletRequest request,@PathVariable Integer devId, @PathVariable String imei,Integer version) {
        Object data=queryService.gpsPoint(devId,version,imei);
        return data == null ? new BaseResult(ReturnCode.FAIL):new BaseResult(0,data);
    }

    @RequestMapping(value = "{devId}/{imei}", method = RequestMethod.POST)
    @ResponseBody
    public Object track(HttpServletRequest request,@PathVariable Integer devId, @PathVariable String imei,Integer version,Long stTime,Long endTime) {
        return new BaseResult(0,queryService.track(devId,version,imei,stTime,endTime));
    }
}
