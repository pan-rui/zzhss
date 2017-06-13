package com.yg.service.front;

import com.yg.base.ReturnCode;
import com.yg.pojo.Delivery;
import com.yg.pojo.ShoppingCart;
import com.yg.pojo.User;
import com.yg.vo.Products;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/9.
 */
public interface IUserService{
    /**
     * 查询指定条件用户
     * @param user
     * @return
     */
    public List<User> queryUserByPO(User user);

    /**
     * 用户登录验证用户名
     * @param nameOrPhone
     * @return
     */
    public User loginValidate(String nameOrPhone);

    /**
     * 用户登录成功初始化
     * @param request
     */
    public void loginInit(HttpServletRequest request);

    /**
     * 查询推荐注册人
     * @param id
     * @return
     */
    public User queryReferrer(Long id);

    /**
     * 推荐奖励
     * @param user
     * @param referrer
     * @return
     */
    public ReturnCode referrerAward(User user, String referrer);

    /**
     * 用户修改密码
     * @param request
     * @param password
     * @return
     */
    public ReturnCode updatePassword(HttpServletRequest request,String password);

    /**
     * 用户注册
     * @param user
     * @return
     */
    public ReturnCode registered(User user);

    /**
     * 添加商品到购物车
     * @param products
     * @param cart
     * @param isLogin
     * @return
     */
    public ShoppingCart addCart(Products products, ShoppingCart cart, boolean isLogin);

    /**
     * 购物车修改
     * @param products
     * @param cart
     * @param isLogin
     * @return
     */
    public ShoppingCart updateCart(List<Map<String,Object>> products,ShoppingCart cart,boolean isLogin);

    /**
     * 购物车删除
     * @param products
     * @param cart
     * @param isLogin
     * @return
     */
    public ShoppingCart delCart(List<Map<String,Object>> products,ShoppingCart cart,boolean isLogin);

    public List<Delivery> queryAllDeliveryByUserId(Long id);

    public Object grantCoupon(Long id, User user);

    public User rePass(String cellPhone, String pwd);

    public User modifyPass(String cellPhone, String oldPwd, String newPwd);
}
