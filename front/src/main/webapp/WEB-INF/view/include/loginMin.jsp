<%--
  Created by IntelliJ IDEA.
  User: panrui
  Date: 2016/1/26
  Time: 18:52
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<style type="text/css">
    .erro-msg{position: inherit;top:12px;left:50px;color: #ff0000}
</style>
<div class="login2" style="position:fixed;display: none;z-index: 999;background-color: #ffffff;">
    <h3 class="login2-title">您尚未登录</h3>
    <ul>
<%--        <li class="login-tips">
            <img src="i/img/deng.png" alt="" class="login-tips-icon">
            公共场所不建议自动登录，以防账号丢失
            <img src="i/img/loginJiantou_03.png" alt="" class="loginJiantou">
        </li>--%>
        <li class="login2Border pading40 login2-email icon-email">
            <input type="text" validtype="phone" name="nameOrPhone" url="http://localhost:80/validator/user;pName=cellPhone/1" placeholder="请输入您的手机号码" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
        </li>
        <li class="login2Border pading40 login2-psw icon-psw">
            <input type="password" placeholder="密码" name="password"/>
        </li>
        <li class="yanzhengma2">
            <img alt="" id="verCode" src="/imageCode?"/>
            <input type="text" placeholder="验证码" class="login2Border" id="code" name="verCode" require="true" url="http://localhost:80/verifyCode">
        </li>
        <li>
            <input type="submit" value="立即登录" class="login2Btn" id="login-btn"/>
        </li>
        <li><a href="<c:url value="/user/rePass"/>" class="fgtPsw">忘记密码？</a><a href="${baseUrl}/user/toRegister" class="zhuce">立即注册</a></li>
    </ul>
</div>
<script>
    $(document).on('click','body',function(event){
        var login2 = $("div.login2");
        if(login2.is(":visible")){
/*            var width = login2.css('width').substring(0, login2.css('width').length - 2), height = login2.css('height').substring(0, login2.css('height').length - 2);
            var left = login2.css('left').substring(0, login2.css('left').length - 2), top = login2.css('top').substring(0, login2.css('top').length - 2);
            if(!(event.screenX > left && event.screenX < parseFloat(left) + parseFloat(width) && event.screenY > top && event.screenY < parseFloat(top)+parseFloat(height)))
                login2.fadeOut();*/
            if(login2.find(event.target).length<=0) login2.fadeOut();
        }
    })
</script>
<%--<div class="login" style="position:fixed;display: none;z-index: 999;background-color: #ffffff;border:1px #f11721 solid;">
    <h3 class="login-title">用户登录</h3>
    <form id="loginForm" method="post">
        <ul class="clearfix">
            <li>用户名:<input type="text" validtype="phone" name="nameOrPhone" url="http://localhost:80/validator/user;pName=cellPhone/1" placeholder="请输入您的手机号码" onkeyup="value=value.replace(/[^\d.]/g,'')"></li>
            <li>密码：<input type="password" name="password"></li>
            <li>
                            <span>验证码:&nbsp;&nbsp;
                            <input type="text" style="width: 100px;float:none;" id="code" name="verCode" require="true" url="http://localhost:80/verifyCode"><img id="verCode" style="float: right" src="/imageCode?"></span>
            </li>
            <li>
                <input type="submit" id="login-btn">
            </li>
        </ul>
    </form>
    <p class="forget-password"><a href="#">忘记密码？</a></p>
</div>--%>
