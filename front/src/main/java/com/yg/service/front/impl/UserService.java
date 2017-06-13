package com.yg.service.front.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.yg.base.BaseResult;
import com.yg.base.BaseService;
import com.yg.base.ReturnCode;
import com.yg.codec.Base64;
import com.yg.codec.Hasher;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.BaseDao618;
import com.yg.dao.impl.CouponDao;
import com.yg.dao.impl.CouponDictDao;
import com.yg.dao.impl.DeliveryDao;
import com.yg.dao.impl.ProductDao;
import com.yg.dao.impl.RefereeRelationDao;
import com.yg.dao.impl.ShoppingCartDao;
import com.yg.dao.impl.UserDao;
import com.yg.dao.impl.UserLoginRecordDao;
import com.yg.pojo.Coupon;
import com.yg.pojo.CouponDict;
import com.yg.pojo.Delivery;
import com.yg.pojo.Product;
import com.yg.pojo.RefereeRelation;
import com.yg.pojo.ShoppingCart;
import com.yg.pojo.User;
import com.yg.pojo.UserLoginRecord;
import com.yg.service.ServiceWrap;
import com.yg.service.front.IUserService;
import com.yg.util.ImageCode;
import com.yg.vo.Products;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2015/9/9.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED)
public class UserService implements IUserService {
    @Autowired
    private BaseService baseService;
    @Autowired
    private UserDao userDao;
    @Autowired
    private CouponDictDao couponDictDao;
    @Autowired
    private RefereeRelationDao refereeRelationDao;
    @Autowired
    private BaseDao618 baseDao618;
    private Logger logger = LogManager.getLogger(UserService.class);
    public Hasher hasher = new Hasher("SHA-1");

    //    private static final String RED = "Register_Red";
//    private static final String REFERRER = "Referrer_Award";
    @Autowired
    private CouponDao couponDao;
    @Autowired
    private UserLoginRecordDao userLoginRecordDao;
    @Autowired
    private ShoppingCartDao shoppingCartDao;
    @Autowired
    private DeliveryDao deliveryDao;
    @Autowired
    private ProductDao productDao;

    @Override
    public List<User> queryUserByPO(User user) {
        return userDao.queryByPO(user);
    }

    @Override
    public User loginValidate(String nameOrPhone) {
        return userDao.loginValidate(nameOrPhone);
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.NESTED, isolation = Isolation.READ_COMMITTED)
    public void loginInit(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
//        List<Score> scores = scoreDao.queryByPros(new ParamsMap().addParams("userId", user.getId()));
//        List<ScoreDict> scoreDicts= (List<ScoreDict>) baseService.getSystemValue("ScoreDict", List.class);
/*        Stream<ScoreDict> scoreDictStream = scores.stream().map(score1 -> {
            return scoreDicts.stream().filter(scoreDict -> score1.getScoreId() == scoreDict.getId()).findFirst().get();
        });*/
        Calendar calendar = Calendar.getInstance();
      /*  List<ScoreDict> scoreDicts = scoreDictDao.queryUserScores(user.getId());
        int sumScore = scoreDicts.stream().filter(scoreDict -> {
            return scoreDict.getAwardExpirationDate().compareTo(calendar.getTime()) > 0 && scoreDict.getScoreStatus().equalsIgnoreCase("y");
        }).mapToInt(score -> score.getScore()).sum();
*//*        Integer scoreCount=scoreDictStream.reduce(0, (result, sc) -> {
            return result += sc.getScore();
        }, (result, nn) -> result + nn);*//*
//        List<ScoreDict> scoreDictList = scoreDictStream.collect(Collectors.toList());
        request.setAttribute("scores", scoreDicts);// 用户积分
        request.setAttribute("sumScore", sumScore);// 用户积分总和*/
/*        List<Account> accounts = accountDao.queryByPros(new ParamsMap().addParams("userId", user.getId()));
        Account account = null;
        if (!accounts.isEmpty())
            account = accounts.get(0); //账户信息
        else {
            account = new Account();
            account.setUserId(user.getId());
            account.setCreateTime(calendar.getTime());
            account.setFrozenAmount(BigDecimal.ZERO);
            account.setInvestAmount(BigDecimal.ZERO);
            account.setLoanAmount(BigDecimal.ZERO);
            account.setUsableAmount(BigDecimal.ZERO);
            accountDao.saveOnCache(account);
        }
        session.setAttribute("user_account", account); //账户信息*/
/*        List<BankCard> bankCards = bankCardDao.queryByPros(new ParamsMap().addParams("userId", user.getId()));
        session.setAttribute("user_card", bankCards);//银行卡信息*/
//        List<Coupon> coupons = couponDao.queryByPros(new ParamsMap().addParams("userId", user.getId()));
//        List<CouponDict> couponDicts = (List<CouponDict>) baseService.getSystemValue("CouponDict", List.class);
        List<CouponDict> couponDicts = couponDictDao.queryUserCoupons(user.getId());
/*        Stream<CouponDict> couponDictStream = coupons.stream().map(coupon -> {
            return couponDicts.stream().filter(couponDict -> couponDict.getId() == coupon.getCouponId()).findFirst().get();
        });
        List<CouponDict> couponDictList=couponDictStream.collect(Collectors.toList());*/
        long countCoupon = couponDicts.stream().filter(couponDict -> {
            return couponDict.getCouponStatus().equalsIgnoreCase("y") && couponDict.getExpirationDate().compareTo(calendar.getTime()) > 0;
        }).count();
        request.setAttribute("coupons", couponDicts);//礼券信息
        request.setAttribute("countCoupon", countCoupon);//可用礼券个数
     /* List<Person> persons = personDao.queryByPros(new ParamsMap().addParams("userId", user.getId()));
        if (!persons.isEmpty())
            session.setAttribute("user_info", persons.get(0));//实名认证
        List<ThridAccount> thridAccounts = thridAccountDao.queryByPros(new ParamsMap().addParams("userId", user.getId()));
        if (!thridAccounts.isEmpty())
            session.setAttribute("user_account3", thridAccounts);//第三方托管账户*/
        List<Map<String, Object>> imeis = baseDao618.queryByPhone(user.getCellPhone());
        session.setAttribute("imeis", imeis);
        List<ShoppingCart> shoppingCarts = shoppingCartDao.queryByPros(ParamsMap.newMap("userId", user.getId()));
        ShoppingCart shoppingCart = shoppingCarts.isEmpty() ? null : shoppingCarts.get(0);
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if(shoppingCart==null){
        if(cart!=null&&!StringUtils.isEmpty(cart.getProductItem()))
            session.setAttribute("cart", cart);
        }else{
            List<Product> productList=JSONArray.parseArray(shoppingCart.getProductItem(),Product.class);
            if(cart!=null&&!StringUtils.isEmpty(cart.getProductItem())){
                JSONArray.parseArray(cart.getProductItem(), Product.class).stream().filter(pro -> productList.stream().noneMatch(prol -> String.valueOf(pro.getId()).equals(prol.getId()+""))).forEach(proo -> productList.add(proo));
                shoppingCart.setProductItem(JSONArray.toJSONString(productList));
            }
            session.setAttribute("cart", shoppingCart);
        }

//        session.setAttribute("cart",shoppingCart.isEmpty()?null:shoppingCart.get(0));

        List<Delivery> deliverys = queryAllDeliveryByUserId(user.getId());
        session.setAttribute("deliverys", deliverys);
        UserLoginRecord userLoginRecord = new UserLoginRecord();
        userLoginRecord.setUserId(user.getId());
        userLoginRecord.setCreateTime(calendar.getTime());
        userLoginRecord.setLoginIp(baseService.getIpAddr(request));
        userLoginRecordDao.save(userLoginRecord);
    }

    @Override
    public User queryReferrer(Long id) {
        User user = userDao.queryReferrer(id);
        return user;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ReturnCode referrerAward(User user, String referrer) {//1,用户红包(是否活动);2,推荐注册奖励(是否活动)3,推荐奖励级别
        userDao.saveOnCache(user);
        if (user.getId() == null)
            return ReturnCode.FAIL;
        CouponDict red = couponDictDao.queryByRed("Register_Red");
        Coupon coupon = new Coupon();
        Calendar calendar = Calendar.getInstance();
        if (Constants.getSystemStringValue("Register_Red").trim().equals("0")) {
            coupon.setCreateTime(calendar.getTime());
            coupon.setCouponId(red.getId());
            coupon.setUserId(user.getId());
            coupon.setCouponStatus("2");//TODO:礼券未使用
            coupon.setCouponRemarks("注册红包");
            couponDao.save(coupon);
        }
        if (Constants.getSystemStringValue("Referrer_Award").trim().equals("0")) {
            //推荐奖励
            refereeAwarded(user, referrer, 1);
        }
        return ReturnCode.OK;
    }

/*    @Override
    public ReturnCode forgetPwd2(HttpServletRequest request, String snCard) {
        User user = (User) request.getSession().getAttribute("forgetPwd_User");
        if (user == null) return ReturnCode.FAIL;
        List<Person> persons = personDao.queryByPros(new ParamsMap().addParams("userId", user.getId()));
        if (persons.isEmpty()) {
            Calendar calendar = Calendar.getInstance();
            Person person = new Person();
            person.setUserId(user.getId());
            person.setCreateTime(calendar.getTime());
            person.setCardNo(snCard);
            personDao.save(person);
        } else if (!persons.get(0).getCardNo().equalsIgnoreCase(snCard))
            return ReturnCode.IDENTITY_SN_WRONG;
        return ReturnCode.OK;
    }*/

    @Override
    public ReturnCode updatePassword(HttpServletRequest request, String password) {
        User user = (User) request.getSession().getAttribute("forgetPwd_User");
        request.getSession().removeAttribute("forgetPwd_User");
        User newUser = new User();
        newUser.setId(user.getId());
        newUser.setPwd(DigestUtils.md5Hex(password));
        int cou = userDao.updateById(newUser);
//        baseDao618.updatePass()
        if (cou == 1)
            return ReturnCode.OK;
        return ReturnCode.FAIL;
    }

    @Override
    public ReturnCode registered(User user) {
        baseDao618.cloneRegister(user);
        return userDao.save(user) > 0 ? ReturnCode.OK : ReturnCode.FAIL;
    }

    @Override
    public ShoppingCart addCart(Products products, ShoppingCart cart, boolean isLogin) {
        List<Product> productList = cart!=null&&!StringUtils.isEmpty(cart.getProductItem())?JSONArray.parseArray(cart.getProductItem(),Product.class):new ArrayList<>();
        products.getProducts().stream().forEach(map -> {
            if(productList.stream().anyMatch(pro ->String.valueOf(map.get("productId")).equals(pro.getId()+""))) return;
            Product product = productDao.queryById(Long.parseLong(map.get("productId") + ""));
            product.setSellCount(Integer.parseInt(map.get("count") + ""));
            productList.add(product);
        });
        cart.setProductItem(JSONArray.toJSONString(productList));
        if(isLogin){
            List<ShoppingCart> shoppingCarts=shoppingCartDao.queryByPros(new ParamsMap<>().addParams("userId",cart.getUserId()));
            if(!shoppingCarts.isEmpty())
            shoppingCartDao.updateById(cart);
            else
                shoppingCartDao.save(cart);
        }
        return cart;
    }

    @Override
    public ShoppingCart updateCart(final List<Map<String,Object>> products, ShoppingCart cart,boolean isLogin) {
        List<Product> productList = JSONArray.parseArray(cart.getProductItem(), Product.class);
        productList.stream().forEach(product -> {
            products.stream().filter(product1 -> String.valueOf(product.getId()).equals(product1.get("productId"))).forEach(product2 -> product.setSellCount(Integer.parseInt(product2.get("count")+"")));
        });
        cart.setProductItem(JSONArray.toJSONString(productList));
        if(isLogin)
        shoppingCartDao.updateById(cart);
        return cart;
    }

    @Override
    public ShoppingCart delCart(final List<Map<String,Object>> products, ShoppingCart cart,boolean isLogin) {
        List<Product> productList = JSONArray.parseArray(cart.getProductItem(), Product.class);
       List<Product> result= productList.stream().filter(product -> {
            return products.stream().noneMatch(product1 ->String.valueOf(product.getId()).equals(product1.get("productId")+""));}).collect(Collectors.toList());
        cart.setProductItem(JSONArray.toJSONString(result));
        if(isLogin)
        shoppingCartDao.updateById(cart);
        return cart;
    }

    @Override
    public List<Delivery> queryAllDeliveryByUserId(Long id) {
        return deliveryDao.queryByPros(ParamsMap.newMap("userId", id));
    }

    @Override
    public Object grantCoupon(Long id, User user) {
//        CouponDict couponDict = couponDictDao.queryById(id);
//        if(couponDict==null) return new BaseResult<>(101, "不存在此优惠");
        List<CouponDict> couponDicts=couponDictDao.queryUserCoupons(user.getId());
        if(couponDicts.stream().anyMatch(couponDictt->String.valueOf(couponDictt.getId()).equals(id+"")))
            return new BaseResult(103, user);

        Date date = new Date();
        Coupon coupon = new Coupon();
        coupon.setCouponId(id);
        coupon.setCreateTime(date);
        coupon.setUserId(user.getId());
        coupon.setCouponStatus("2");
        coupon.setCouponRemarks(user.getCellPhone());
        String second = String.valueOf(System.currentTimeMillis());
        coupon.setId(ImageCode.getSymbol(8,ImageCode.partUpperArray)+second.substring(second.length()-8));
        couponDao.save(coupon);
        return new BaseResult<>(0,coupon);
    }

    @Override
    public User rePass(String cellPhone, String pwd) {
        List<User> users=userDao.queryByPros(ParamsMap.newMap("cellPhone", cellPhone));
        if(users==null||users.isEmpty()) return null;
        User user=users.get(0);
        User nUser = new User();
        nUser.setId(user.getId());
        nUser.setPwd(com.yg.codec.Base64.encodeToString(hasher.hash(pwd.getBytes())));
        userDao.updateById(nUser);
        baseDao618.updatePass(cellPhone, pwd);
        return user;
    }

    @Override
    public User modifyPass(String cellPhone, String oldPwd, String newPwd) {
        User user = (User)userDao.queryByPros(ParamsMap.newMap("cellPhone", cellPhone)).get(0);
        if(Base64.encodeToString(hasher.hash(oldPwd.getBytes())).equals(user.getPwd())){
            User nUser=new User();
            nUser.setId(user.getId());
            nUser.setPwd(Base64.encodeToString(hasher.hash(newPwd.getBytes())));
            userDao.updateById(nUser);
            baseDao618.updatePass(cellPhone, newPwd);
            return user;
        }else
        return null;
    }
    /**
     * 推荐奖励
     *
     * @param user     用户
     * @param referrer 用户推荐人
     * @param level    当前级别
     */
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.NESTED)
    public void refereeAwarded(User user, String referrer, final int level) {
        Calendar calendar = Calendar.getInstance();
        if (!StringUtils.isEmpty(referrer)) {
            CouponDict ref = couponDictDao.queryByReferrer("referrer_Award_" + level);//TODO:礼券Code
            User refer = userDao.queryReferrer(Long.parseLong(referrer));
            if (refer != null) {
                RefereeRelation refereeRelation = new RefereeRelation();
                if (level == 1) {
                    refereeRelation.setUserId(user.getId());
                    refereeRelation.setCreateTime(calendar.getTime());
                    refereeRelation.setRefereeId(refer.getId());
                    refereeRelationDao.save(refereeRelation);
                }
                Coupon re = new Coupon();
                re.setCouponRemarks(level + "级推荐奖励");
                re.setUserId(refer.getId());
                re.setCreateTime(calendar.getTime());
                re.setCouponStatus("2");  //TODO:奖励未使用
                re.setCouponId(ref.getId());
                int cou = couponDao.save(re); //TODO:推荐奖励
                if (level == 1 && cou > 0) {
                    refereeRelation.setCouponStatus("1");
                    refereeRelationDao.updateById(refereeRelation);//推荐关系保存
                }
            }
            if (level == 1) {
                int Level = user.getType().equals("0") ? Integer.parseInt(Constants.getSystemStringValue("User_Award_Level")) : Integer.parseInt(Constants.getSystemStringValue("Broker_Award_Level"));
                for (int le = level + 1; le <= Level; le++) {
                    List<RefereeRelation> refereeRelations = refereeRelationDao.queryByPros(new ParamsMap<>().addParams("userId", refer.getId()));
                    if (refereeRelations != null && !refereeRelations.isEmpty())
                        refereeAwarded(refer, refereeRelations.get(0).getRefereeId() + "", le);
                }
            }
        }
    }

    public BaseResult getTest() {
//        baseDao.selectList("BankCard.queryAll");
//        System.out.println(bankCardDao.abc());
//        FutureTask<ITest> iTestFutureTask=new FutureTask<ITest>()

/*        Future<ReturnCode> future = Client.getService(ServiceType.test);
        System.out.println(new Date().getTime());
        ReturnCode iTest=baseService.getService(future, 4000l);
        System.out.println(new Date().getTime());
//        iTest.getAdmin(3543534l, "来自于服务端的实例对象．．．");
        System.out.println(iTest.toString());*/
        BaseResult returnCode = ServiceWrap.getServiceResult(ServiceWrap.test_getAdmin(234534l, "panrui"));
        BaseResult returnCde = ServiceWrap.getServiceResult(ServiceWrap.test_getAdmin());
        System.out.println(JSON.toJSONString(returnCode));
        System.out.println(JSON.toJSONString(returnCde));
        return returnCode;
    }

    /*    public static void main(String[] args) {
    *//*        System.out.println(ReturnCode.OK.setData("dbd").toString());
        new Thread(){
            @Override
            public synchronized void start() {
                System.out.println(ReturnCode.OK.toString());
            }
        }.start();*//*
    }*/
    public ReturnCode addDelivery(Delivery delivery) {
        return deliveryDao.save(delivery) > 0 ? ReturnCode.OK : ReturnCode.FAIL;
}

    public Object updateDelivery(Delivery delivery) {
        return deliveryDao.updateById(delivery) > 0 ? ReturnCode.OK : ReturnCode.FAIL;
    }

    public Object delDelivery(Long id) {
        return deliveryDao.deleteById(id) > 0 ? ReturnCode.OK : ReturnCode.FAIL;
    }

    public List<Coupon> checkCoupon(Long userId) {
        return couponDao.checkCoupon(userId);
    }

    public CouponDict queryCouponDict(Long id) {
        return couponDictDao.queryById(id);
    }

    public ReturnCode updateShoppingCart(ShoppingCart cart) {
        return shoppingCartDao.updateById(cart) > 0 ? ReturnCode.OK : ReturnCode.FAIL;
    }

    public CouponDict queryCouponDictByCouponId(String couponId){
        return couponDictDao.queryCoupon(couponId);
    }

    public int updateCoupon(Coupon coupon) {
        return couponDao.updateById(coupon);
    }


}
