<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="../include/require.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>购物车</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <header class="header">
        <div class="wrapper clearfix">
            <div class="logo">
                <a href="<c:url value="/"/>"><img src="<c:url value="/images/logo.png"/>" alt="智护伞"></a>
                <img src="<c:url value="/images/logo1.png"/>" alt="智护伞"/>
            </div>
            <ul class="nav">
                <li class="nav-focus"><a href="<c:url value="/"/>">首页</a></li>
                <li>
                    <a href="javascript:;" onclick="return false;">产品中心</a>
                    <div class="sub-nav">
                        <c:forEach items="${productss}" var="product">
                            <a href="${baseUrl}/product?id=${product.id}">${product.name}</a>
                        </c:forEach>
                    </div>
                </li>
                <li><a href="<c:url value="/app/"/>">APP下载</a></li>
                <li><a href="<c:url value="/find/"/>" id="find">智护伞查车</a></li>
                <li><a href="<c:url value="/service"/>">服务中心</a></li>
                <li><a href="http://75549.vhost1.cloudvhost.cn/bbs" target="_blank">官方论坛</a></li>
            </ul>
            <%--            <div class="shopping-header">
                            <h3><span>我的购物车</span><a href="#">问题反馈 ></a></h3>
                        </div>--%>
            <c:choose>
                <c:when test="${not empty user}">
                    <div class="order-user">
                        <div class="order-hover">
                            <a href="javascript:;" class="icon-xiala">${user.cellPhone}</a>
                            <ul class="user-xiala">
                                <li><a href="<c:url value="/user/coupons"/> ">优惠券</a></li>
                                <li><a href="<c:url value="/user/modifyPass"/>">修改密码</a></li>
                                <li><a href="<c:url value="/user/exit"/>">退出登录</a></li>
                            </ul>
                        </div>
                        <div class="order-left">|<a href="<c:url value="/user/order"/>">我的订单</a></div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${baseUrl}/user/toLogin">登录</a><a href="javascript:;">/</a><a href="${baseUrl}/user/toRegister">注册</a>
                </c:otherwise>
            </c:choose>
            <%--<div class="order-user">
                <a href="javascript:;" class="icon-xiala">${user.cellPhone}</a>|
                <a href="<c:url value="/user/order"/>">我的订单</a>
            </div>--%>
        </div>
    </header>
    <!-- showImg-->
    <div class="bg-hui padding-bottom50">
        <div class="wrapper clearfix">
            <div class="bgfff">
                <div class="user-coupons-tab clearfix">
                    <ul class="user-coupons-tab-l">
                        <li class="user-coupons-tab-focus">
                            <a href="javascript:;">我的优惠券</a>
                        </li>
<%--                        <li>
                            <a href="#">领取优惠券</a>
                        </li>--%>
                    </ul>
<%--                    <div class="user-coupons-tab-r">
                        <a href="#">优惠券规则说明</a>
                    </div>--%>
                </div>
                <ul class="user-coupons-toolbar clearfix">
                    <li class="width120">
                        <dl class="coupons-xiala">
                            <dt><a href="javascript:;" state="0">全部</a><i class="cJiantou"></i></dt>
                            <dd>
                                <a href="javascript:;" state="2">未使用</a>
                                <a href="javascript:;" state="3">已使用</a>
                                <a href="javascript:;" state="5">已过期</a>
                                <%--<a href="javascript:;">回收站</a>--%>
                            </dd>
                        </dl>
                    </li>
                    <li class="width120">
                        <a href="javascript:;">优惠券类型</a>
                    <%--                        <dl class="coupons-xiala">
                            <dt>
                                <a href="#">优惠券类型</a>
                                <i class="cJiantou"></i>
                            </dt>
                            <dd>
                                <a href="#">全部</a>
                                <a href="#">优先购买券</a>
                                <a href="#">安装费券</a>
                            </dd>
                        </dl>--%>
                    </li>
                    <li>
                        <a href="javascript:;">过期时间</a>
                    </li>
                    <li>
                        <a href="javascript:;">使用时间</a>
                    </li>
                    <li>
                        <a href="javascript:;">优惠金额</a>
                    </li>
                </ul>
                <table class="coupons-table">
                    <colgroup>
                        <col width="182">
                        <col width="182">
                        <col width="116">
                        <col width="116">
                        <col width="116">
                        <col width="">
                    </colgroup>
                    <tbody>
<%--                    <tr>
                        <td>哈哈</td>
                        <td>ceshi</td>
                        <td>sad</td>
                        <td>asd</td>
                        <td>asd</td>
                        <td>&nbsp;</td>
                    </tr>--%>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp" %>

</div>
</body>
</html>
