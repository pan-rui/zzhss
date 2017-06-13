package com.yg.action.front;

import com.yg.base.BaseAction;
import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.codec.Base64;
import com.yg.codec.Blowfish;
import com.yg.codec.Hasher;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.CouponDao;
import com.yg.dao.impl.SaleDao;
import com.yg.pojo.Coupon;
import com.yg.pojo.Delivery;
import com.yg.pojo.Order;
import com.yg.pojo.Sale;
import com.yg.pojo.ShoppingCart;
import com.yg.pojo.User;
import com.yg.service.front.impl.UserService;
import com.yg.service.impl.OrderService;
import com.yg.service.impl.QueryService;
import com.yg.util.Validator;
import com.yg.vo.Products;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

/**
 * 结合现有前台更改...
 * Created by Administrator on 2015/9/9.
 */
@Controller
@RequestMapping("/user")
public class UserAction extends BaseAction {
    @Autowired
    private UserService userService;
    @Autowired
    private CommonAction commonAction;
    private Blowfish encryptor = new Blowfish(Constants.publicKey);
    @Autowired
    private QueryService queryService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private CouponDao couponDao;
    @Autowired
    private SaleDao saleDao;
    private Hasher hasher = new Hasher("SHA-1");

    /**
     * 登录
     *
     * @param request
     * @param nameOrPhone
     * @param password
     * @param verCode
     * @return
     */
    @RequestMapping(value = "loginEd", method = RequestMethod.POST)
    @ResponseBody
    public Object login(HttpServletRequest request, String nameOrPhone, String verCode, String password) {
        if (Validator.PHONE.v(nameOrPhone) || Validator.NAME.v(nameOrPhone)) {
            User user = userService.loginValidate(nameOrPhone);
            if (user == null)
                return ReturnCode.USER_NOT_EXISTS.toString();
            if (!Base64.encodeToString(hasher.hash(password.getBytes())).equals(user.getPwd()))
                return ReturnCode.LOGIN_PASSWORD_ERROR.toString();
//                String veriftCode = String.valueOf(request.getSession().getAttribute("smsCode"));
//                request.getSession().removeAttribute("smsCode");
//                if (DigestUtils.md5Hex((code + mobile).getBytes("utf-8")).equals(veriftCode)) {
//                if (verCode.equals(request.getSession().getAttribute("imageCode"))) {
            request.getSession().setAttribute("user", user);
            //TODO:登录及相关信息保存至session
            userService.loginInit(request);
//                return new BaseResult(0,Constants.getSystemStringValue("loginEd_ToUrl"));
            String referer = request.getHeader("Referer");
            if (referer.matches("http://[\\w.:]+/\\w+/(cart|coupon|order)[\\w/?.=]*"))
                return new BaseResult<>(7777, referer);
            else if (referer.contains("/find")) {
                List<Map<String, Object>> imeis = (List<Map<String, Object>>) request.getSession().getAttribute("imeis");
                if (imeis.size() > 0){
                    if(imeis.size()>1)
                    return new BaseResult(0, imeis);
                else return new BaseResult(8888, imeis.get(0));
                } else return new BaseResult(0, "用户未绑定任何设备!");
            } else return new BaseResult(6666, user);
        }
        return new BaseResult(Validator.PHONE.getCode(), "用户名或手机号码错误.");
    }

    @RequestMapping(value = "toLogin", method = RequestMethod.GET)
    public String toLogin(HttpServletRequest request, ModelMap modelMap) {
        return "user/login";
    }

    @RequestMapping(value = "toRegister", method = RequestMethod.GET)
    public String toRegister(HttpServletRequest request, ModelMap modelMap) {

        return "user/register";
    }

/*    @RequestMapping(value = "test", method = RequestMethod.GET)
    @ResponseBody
    public Object testReturnCode(HttpServletRequest request, String message) {
        BaseResult result = userService.getTest();

        return result;
    }

    //ajax异步请求,调用服务器
    @RequestMapping(value = "test2", method = RequestMethod.GET)
    @ResponseBody
    public WebAsyncTask<BaseResult> testResult(HttpServletRequest request, String message) {
        WebAsyncTask<BaseResult> webAsyncTask = new WebAsyncTask<BaseResult>(2000l, new Client.GetServer(ServiceWrap.test_getAdmin()));
        webAsyncTask.onTimeout(new Callable<BaseResult>() {
            @Override
            public BaseResult call() throws Exception {
                return null;
            }
        });
        return webAsyncTask;
    }

    //ajax异步请求,本地调用
    @RequestMapping(value = "test3", method = RequestMethod.GET)
    @ResponseBody
    public Callable<BaseResult> testResult2(HttpServletRequest request, String message) {
        return () -> {
            return new BaseResult(0, "test3");
        };
    }

    @RequestMapping(value = "testBean", method = RequestMethod.POST)
    @ResponseBody
    public Object testBean(@Valid Admin admin, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
        if (result.hasErrors()) {
            System.out.println(result.getFieldError("pwd").getDefaultMessage());
        }
        System.out.println(result.getFieldErrorCount());
        return ReturnCode.FAIL.toString();

    }*/

    @RequestMapping(value = "registerEd", method = RequestMethod.POST)
    @ResponseBody
    public Object registerEd(HttpServletRequest request, HttpServletResponse response, User user) {
//        if (errors.hasErrors())
//            return getFormatError(errors);
        Calendar calendar = Calendar.getInstance();
        user.setCreateTime(calendar.getTime());
//        String password=encryptor.decrypt(user.getPwd());
        user.setPwd(Base64.encodeToString(hasher.hash(user.getPwd().getBytes())));
        user.setRegIp(getIpAddr(request));
        user.setUserName(user.getCellPhone());
        user.setIsEnable("0");
        ReturnCode returnCode = userService.registered(user);
//        ReturnCode returnCode = userService.referrerAward(user, null);
//        userService.save(user);
//        if(!StringUtils.isEmpty(referrer)){
//            //写入推荐关系表
//            //派发奖励
//        }

        return returnCode.toString();
    }

/*    @RequestMapping(value = "updatePassword", method = RequestMethod.POST)
    @ResponseBody
    public String updatePassword(HttpServletRequest request, String password, String confirmPassword) {
        if (!StringUtils.isEmpty(confirmPassword) && confirmPassword.equals(password)) {
            return userService.updatePassword(request, password).toString();
        } else return ReturnCode.PASSWORD_NOT_MATCH.toString();
    }*/

    @RequestMapping(value = "rePass", method = RequestMethod.GET)
    public Object rePass(HttpServletRequest request, String cellPhone, String pwd, ModelMap modelMap) {
        return "user/rePass";
    }

    @RequestMapping(value = "modifyPass", method = RequestMethod.GET)
    public Object modifyPass(HttpServletRequest request, ModelMap modelMap) {
        return "user/modifyPass";
    }

    @RequestMapping(value = "modifyPassEd", method = RequestMethod.POST)
    @ResponseBody
    public Object modifyPassEd(HttpServletRequest request, String cellPhone, String oldPwd, String newPwd, ModelMap modelMap) {
        if (StringUtils.isEmpty(cellPhone) || StringUtils.isEmpty(oldPwd) || StringUtils.isEmpty(newPwd))
            return new BaseResult<>(1, "参数不能为空");
        User user = userService.modifyPass(cellPhone, oldPwd, newPwd);
        return user == null ? ReturnCode.LOGIN_PASSWORD_ERROR.toString() : ReturnCode.OK.toString();
    }

    @RequestMapping(value = "rePassEd", method = RequestMethod.POST)
    @ResponseBody
    public Object rePassEd(HttpServletRequest request, @NotNull  String cellPhone, String pwd, ModelMap modelMap) {
        User user = userService.rePass(cellPhone, pwd);
        return new BaseResult(0, user);
    }

    @RequestMapping(value = "exit", method = RequestMethod.GET)
    public String exit(HttpServletRequest request, ModelMap modelMap) {
        request.getSession().invalidate();
        return "index";
    }

    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String home(HttpServletRequest request, ModelMap modelMap) {
        return "forward:/user/order";
    }

    @RequestMapping(value = "cart", method = RequestMethod.GET)
    public String cart(HttpServletRequest request, ModelMap modelMap) {
        return "/buy/cart";
    }

    @RequestMapping(value = "/cart/{operate}", method = RequestMethod.GET)
//    @ResponseBody
    public String updateCart(HttpServletRequest request, HttpServletResponse response, @PathVariable String operate, Long productId, Products products) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        ShoppingCart cart = null;
        Date date = new Date();
//            Jedis jedis = baseService.getJedis();
//            cart = (ShoppingCart) baseService.jdkRedisSerializer.deserialize(jedis.get(baseService.jdkRedisSerializer.serialize(request.getRequestedSessionId() + "_cart")));
        cart = (ShoppingCart) request.getSession().getAttribute("cart");
        boolean isLogin = user != null, isSite = productId != null && !StringUtils.isEmpty(productId + "");
        if (cart == null) {
            cart = new ShoppingCart();
            cart.setCtime(date);
            cart.setLoginIp(getIpAddr(request));
        }
        if (isLogin)
            cart.setUserId(user.getId());
        if (isSite) {
            products = new Products();
            Map<String, Object> maps = new HashMap<String, Object>();
            maps.put("productId", productId);
            maps.put("count", 1);
            products.setProducts(Arrays.asList(maps));
        }
        switch (operate) {
            case "add":
                userService.addCart(products, cart, isLogin);
                request.getSession().setAttribute("cart", cart);
                break;
            case "update":
                userService.updateCart(products.getProducts(), cart, isLogin);
                request.getSession().setAttribute("cart", cart);
                break;
            case "delete":
                userService.delCart(products.getProducts(), cart, isLogin);
                request.getSession().setAttribute("cart", cart);
                break;
        }
        if (isSite)
            return "buy/cart";
        else {
            PrintWriter pw = null;
            pw = response.getWriter();
            pw.write(ReturnCode.OK.toString());
            pw.close();
            return null;
        }
    }

    @RequestMapping(value = "delivery/{operate}", method = RequestMethod.POST)
    @ResponseBody
    public Object addDelivery(HttpServletRequest request, @Valid Delivery delivery, BindingResult errors, @PathVariable String operate, ModelMap modelMap) {
        if ("add".equalsIgnoreCase(operate)) {
            if (errors.hasErrors())
                return getFormatError(errors);
            List<Delivery> deliveries = (List<Delivery>) request.getSession().getAttribute("deliverys");
            deliveries = deliveries == null ? new ArrayList<Delivery>() : deliveries;
            deliveries.add(delivery);
            request.getSession().setAttribute("deliverys", deliveries);
            User user = (User) request.getSession().getAttribute("user");
            if (user != null)
                return userService.addDelivery(delivery).getCode() == 0 ? new BaseResult(0, delivery) : ReturnCode.FAIL.toString();
            return new BaseResult(0, delivery);
        } else if ("update".equalsIgnoreCase(operate)) {
            return userService.updateDelivery(delivery).toString();
        } else if ("delete".equalsIgnoreCase(operate))
            return userService.delDelivery(delivery.getId()).toString();
        return ReturnCode.PARAMS_HAS_NONE.toString();
    }

    @RequestMapping("checkCoupon/{userId}")
    @ResponseBody
    public Object checkCoupon(HttpServletRequest request, ModelMap modelMap, @PathVariable Long userId, String userCouponId) {
        List<Coupon> coupons = userService.checkCoupon(userId);
        Optional<Coupon> optional = coupons.stream().filter(coupon -> coupon.getId().substring(0, 6).equalsIgnoreCase(userCouponId)).findFirst();
//                ?ReturnCode.OK.toString():ReturnCode.NOT_EXISTS_COUPON.toString();
        if (optional.isPresent()) {
//            if(Integer.parseInt(optional.get().getCouponStatus())>2) return ReturnCode.CONPON_IS_EXPIRED.toString();
            return new BaseResult<>(0, userService.queryCouponDict(optional.get().getCouponId()));
        } else return ReturnCode.NOT_EXISTS_COUPON.toString();
    }

    @RequestMapping(value = "coupon/{couponDictId}", method = RequestMethod.GET)
    public String getCoupon(HttpServletRequest request, @PathVariable Long couponDictId, ModelMap modelMap) {
        modelMap.put("couponDict", userService.queryCouponDict(couponDictId));
        return "user/coupon";
    }

    @RequestMapping(value = "coupon/{couponDictId}", method = RequestMethod.POST)
    @ResponseBody
    public Object grantCoupon(HttpServletRequest request, @PathVariable Long couponDictId, ModelMap modelMap) {
        User user = (User) request.getSession().getAttribute("user");
        return userService.grantCoupon(couponDictId, user);
    }

    @RequestMapping(value = "order")
    public String order(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        User user = (User) request.getSession().getAttribute("user");
        if (Objects.isNull(user)) return "user/login";
        //取消一定时间内未支付的订单
        orderService.cancelOrderTime(user.getId());
        //更新一定时间内的物流状态
        orderService.updateLogistics(user.getId());
        List<Order> orders = orderService.queryOrders(user.getId());
        modelMap.put("orders", orders);
        modelMap.put("salePhone", Constants.getSystemStringValue("salePhone"));
        modelMap.put("stateEnum", baseService.queryColumnInfo(ParamsMap.newMap("tableName", "t_order").addParams("columnName", "state")));
        return "user/userOrder";
    }

    @RequestMapping(value = "searchOrder", method = RequestMethod.POST)
    public String searchOrder(HttpServletRequest request, String patten, ModelMap modelMap) {
        User user = (User) request.getSession().getAttribute("user");
        List<Order> orders = orderService.searchOrders(user.getId(), patten);
        modelMap.put("orders", orders);
        modelMap.put("stateEnum", baseService.queryColumnInfo(ParamsMap.newMap("tableName", "t_order").addParams("columnName", "state")));
        return "include/orderChild";
    }

    @RequestMapping(value = "coupons", method = RequestMethod.GET)
    public String coupons(HttpServletRequest request, ModelMap modelMap) {
        User user = (User) request.getSession().getAttribute("user");
        if (Objects.isNull(user)) return "user/login";
        //更新过期状态
        couponDao.updateState(user.getId());
        modelMap.put("coupons", couponDao.queryCoupons(user.getId()));
        return "user/coupons";
    }

    @RequestMapping(value = "sale", method = RequestMethod.POST)
    public String sale(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap, MultipartFile pic, Sale sale) {
        String path = request.getRealPath("/") + "upload";
        Calendar calendar = Calendar.getInstance();
        int result = 0;
        try {
            if (pic != null && !StringUtils.isEmpty(pic.getOriginalFilename())) {
                File filePath = new File(path + "/" + calendar.get(Calendar.YEAR) + "/" + calendar.get(Calendar.MONTH) + "/" + calendar.get(Calendar.DAY_OF_MONTH), pic.getOriginalFilename());
                if (!filePath.getParentFile().exists()) filePath.getParentFile().mkdirs();
                if (filePath.exists()) filePath.delete();
                pic.transferTo(filePath);
                String tempPath = filePath.getPath().replace("\\", "/");
                sale.setPicture(setConstans(request, modelMap) + tempPath.substring(tempPath.indexOf("/upload")));
            }
            sale.setCtime(new Date());
            result = saleDao.save(sale);
            Order order = new Order();
            order.setId(sale.getOrderId());
            order.setState("3");//状态更新为申请退款中
            orderService.updateOrder(order);
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=utf-8");
            PrintWriter pw = response.getWriter();
            if (result <= 0) {
                pw.write("<script>alert('提交失败!');window.history.back();</script>");
            } else
                pw.write("<script>alert('提交成功,售后处理将尽快给您处理!');window.location.href ='" + setConstans(request, modelMap) + "/';</script>");
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "forward:/user/order";
    }
}
