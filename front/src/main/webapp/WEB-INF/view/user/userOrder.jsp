<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="../include/require.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的订单</title>
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
            <%--<div class="order-user">
                <a href="javascript:location.reload(true);" class="icon-xiala">${user.cellPhone}</a>|
                <a href="javascript:location.reload(true);">我的订单</a>
            </div>--%>
            <c:choose>
                <c:when test="${not empty user}">
                    <div class="order-user">
                        <div class="order-hover">
                            <a href="javascript:;" class="icon-xiala">${user.cellPhone}</a>
                            <ul class="user-xiala">
                                <%--<li><a href="<c:url value="/user/coupons"/> ">优惠券</a></li>--%>
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
        </div>
    </header>
    <!-- showImg-->
    <div class="bg-hui padding-bottom50">
        <div class="wrapper clearfix">
            <div class="user-order-bg">
                <div class="user-order-header clearfix">
                    <ul class="user-order-tab">
                        <li class="user-order-tab-focus" id="all">
                            <a href="<c:url value="/user/order"/>" >所有订单</a>
                        </li>
                        <li  id="wait0">
                            <a href="javascript:;">待付款</a>
                            <span class="icon icon-sum" id="waits"></span>
                        </li>
                        <li id="wait2">
                            <a href="javascript:;" >待收货</a>
                            <span class="icon icon-sum" id="wait2s"></span>
                        </li>
                        <li id="wait7">
                            <a href="javascript:;">已完成</a>
                            <span class="icon icon-sum" id="wait3s"></span>
                        </li>
                    </ul>
<%--                    <ul class="user-order-tab-hot">
                        <li><a href="#">我的常购商品</a><img src="images/new.png" class="newgoodsIcon"></li>
                        <li><a href="#">特价.清仓</a></li>
                    </ul>
                    <a href="#" class="user-order-recycle">订单回收站</a>--%>
                    <div class="user-order-search">
                        <input type="text" placeholder="商品名称/订单号" name="patten"/>
                        <input type="button" value="" id="search"/>
                        <%--<span class="senior">高级</span>--%>
                    </div>

                </div>
                <div class="user-order-tab-content">
                    <table class="user-order-table">
                        <colgroup>
                            <col style="width:15%;">
                            <col style="width:20%;">
                            <col style="width:15%;">
                            <col style="width:8%;">
                            <col style="width:12%;">
                            <col style="width:10%;">
                        </colgroup>
                        <tr>
                            <th>订单</th>
                            <th>订单详情</th>
                            <th>收货人</th>
                            <th>数量</th>
                            <th>全部状态</th>
                            <th>操作</th>
                        </tr>
                    </table>
<%@include file="../include/orderChild.jsp"%>
<%--<c:forEach items="${orders}" var="orderInfo" varStatus="s">
<table class="user-order-table user-order-table-list" statu="${orderInfo.state}">
                        <colgroup>
                            <col style="width:15%;">
                            <col style="width:20%;">
                            <col style="width:15%;">
                            <col style="width:8%;">
                            <col style="width:12%;">
                            <col style="width:10%;">
                        </colgroup>
                        <tr class="bg-hui">
                            <td colspan="2">
                                <span class="order-time">${orderInfo.ctime}</span>
                                <span class="order-id">订单号：${orderInfo.id}</span>
                            </td>
                            &lt;%&ndash;<td>Voollcci</td>&ndash;%&gt;
                            <td colspan="2">${salePhone}</td>
                            <td>&nbsp;</td>
                        </tr>
    <c:forEach items="${orderInfo.orderItems}" var="orderItem" varStatus="ss">
                        <tr>
                            <td>
                                <a href="<c:url value="/product?id=${orderItem.prodId}"/>"><img src="${y:toMap(orderItem.product.imgs).minBig}" alt=""></a>
                            </td>
                            <td>
                                <h3 class="order-center-title">
                                    <a href="#">${orderItem.product.name}</a>
                                </h3>
                                <p class="order-center-title-hui">${orderItem.product.desc}</p>
                            </td>
                            <td><p class="order-user-img">${orderInfo.delivery.name}</p></td>
                            <td>x${orderItem.count}</td>
                            <td>
                                <p class="order-single-sum">总额￥${orderInfo.money}</p>
                                <p class="order-pay">应付￥${orderInfo.orderMoney}</p>
                                <p>${orderInfo.logistics}</p>
                            </td>
                            <td>
                                <p class="wait-delivery">${orderInfo.state}</p>
                                <p class="tracking"><a href="javascript:;" id="logistics">跟踪</a></p>
                                <p><a href="<c:url value=""/>" id="detail">订单详情</a></p>
                            </td>
                        </tr>
    </c:forEach>
                    </table>
    </c:forEach>--%>
                </div>
            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp"%>
    <div id="device" style="font-size: 15px;position: absolute;padding: 10px 15px 10px 15px;width:auto;display: none;z-index: 999;height: auto;background-color:White;opcity:0.3;"></div>
</div>
<script>
    $(function() {
        var listtable=$("div.user-order-tab-content table.user-order-table-list");
        $("#waits").html(listtable.filter("table[statu='0']").length);
        $("#wait2s").html(listtable.filter("table[statu='2']").length);
        $("#wait3s").html(listtable.filter("table[statu='7']").length);
    })
    function tabClick(){
            var listtable=$("div.user-order-tab-content table.user-order-table-list");
            $(this).addClass("user-order-tab-focus").siblings().removeClass("user-order-tab-focus");
        var idV = $(this).attr('id'), va = idV.substr(idV.length - 1, 1);
        if(isNaN(va))
                listtable.show();
        else{
            listtable.hide();
            listtable.filter("table[statu='"+va+"']").show();
        }
        return false;
    }
    $("ul.user-order-tab").on('click', 'li', tabClick);
/*$("#all").click()
    $("#wait").click(function(){
        var listtable=$("div.user-order-tab-content table.user-order-table-list");
        $(this).addClass("user-order-tab-focus").siblings().removeClass("user-order-tab-focus");
        listtable.hide();
        listtable.filter("table[statu='0']").show();
        return false;
    })
    $("#wait2").click(function(){
        var listtable=$("div.user-order-tab-content table.user-order-table-list");
        $(this).addClass("user-order-tab-focus").siblings().removeClass("user-order-tab-focus");
        listtable.hide();
        listtable.filter("table[statu='1']").show();
        return false;
    });*/
    $("#search").click(function(){
       var patten=$("input[name='patten']").val();
        $.post("${baseUrl}/user/searchOrder",{patten:patten},function(data){
            if($(data).find("script").length>0)
                alert("查找出错.请稍后重试.")
            else {
                $("div.user-order-tab-content").children("table[statu]").remove();
                $("div.user-order-tab-content").append($(data));
            }
        },'html');
    })
</script>
</body>
</html>
