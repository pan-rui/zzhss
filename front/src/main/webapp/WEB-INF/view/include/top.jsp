<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="require.jsp" %>
<%--<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>--%>
<header class="header">
    <div class="wrapper clearfix">
        <div class="logo">
            <div class="header-logo-1">
                <a href="<c:url value="/"/>"><img src="<c:url value="/images/logo.png"/>" alt="智护伞"/></a>
            </div>
            <div class="header-logo-1">
                <img src="<c:url value="/images/logo1.png"/>" alt="智护伞"/>
            </div>
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
            <li><a href="http://www.zhihusan.com/bbs/" target="_blank">官方论坛</a></li>
        </ul>
        <div class="header-right">
            <c:choose>
                <c:when test="${not empty user}">
                    <a href="<c:url value="/user/home"/>">${user.cellPhone}</a>&nbsp;/&nbsp;<a href="<c:url
                        value="/user/exit"/>">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${baseUrl}/user/toLogin">登录</a><a href="javascript:;">/</a><a
                        href="${baseUrl}/user/toRegister">注册</a>
                    <%--                    <script>
                                            $("#Wrap").css("width","1200px");
                                        </script>--%>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${not empty cart.productItem}">
                    <span><a href="<c:url value="/user/cart"/>">购物车（${y:toArray(cart.productItem).size()}）</a></span>
                </c:when>
                <c:otherwise>
                    <span><a href="<c:url value="/user/cart"/>">购物车（0）</a></span>
                </c:otherwise>
            </c:choose>
            <%--<a href="<c:url value="/user/coupon/1"/>" class="buy-code">优先购买码</a>--%>
        </div>
    </div>
</header>
<html>
<head>
    <link rel="stylesheet" href="<c:url value="/css/guest.css"/>"/>
</head>
<body>
<div class="main bg">
    <a id="launchBtn" class="btnText onlineBtnText btn" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=3182231864&site=qq&menu=yes">售前咨询</a>
    <a id="launchBtn2" class="btnText onlineBtnText btn" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2025825045&site=qq&menu=yes">售后服务</a>
    <a id="launchBtn3" class="btnText onlineBtnText btn" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2968012405&site=qq&menu=yes">商务合作</a>
    <a id="launchBtnOffline" class="btnText offlineBtnText btn" href="javascript:;">QQ离线</a>
    <a id="laterBtn" class="laterBtn btn"  href="javascript:;"></a>
    <a id="closeBtn" class="closeBtn btn" href="javascript:;"></a>
    <div class="content"><h2 id="subTitle" class="subTitle"></h2>
        <p id="plainText" class="plainText"></p></div>
</div>
<script>
!function linkman(){
    var $win=$('.main');
    var heigth=$win.css('height'),width=$win.css('width');
    var y=((window.innerHeight?window.innerHeight:document.documentElement.clientHeight)-parseFloat(heigth.substring(0,heigth.length-2)))/ 2+'px' ,x=(window.innerWidth?window.innerWidth:document.documentElement.clientWidth)-parseFloat(width.substring(0,width.length-2))-8+'px';
    $win.css({left: x, top: y,opcity:0.3});

}();
</script>
</body>
</html>
<div class="zhezhao" style="display:none;"></div>
<div id="device"
     style="font-size: 20px;position: absolute;padding: 10px 15px 10px 15px;width:auto;display: none;z-index: 999;height: auto;background-color:White;opcity:0.3;"></div>
<script>
    $("#find").click(function () {
        if ('${user.id}' != '') {
            fillDevice(${y:toArrayStr(imeis)});
            return false;
        }
    })
    function fillDevice(data) {
        if (data == undefined || data == null || data.length == 0) {
            alert("您没有绑定任何设备");
            return;
        }
        var $win = $("#device");
        $win.html("");
        $win.prepend('<p>想要查询您的哪台设备(IMEI)</p></br>');
        $.each(data, function (i, n) {
            $win.append('<input type="radio" name="imei" value="' + n['Device_Imei'] + '" />' + n['Device_Imei'] + '</br>')
        })
        $win.append('<a href="javascript:;" id="ok">确定</a>&nbsp;&nbsp;&nbsp;<a href="javascript:;" id="cancel">取消</a> ');
/*        var width = $win.css('height'), height = $win.css('width');
        var y = (screen.height - width.substring(0, width.length - 2)) / 2 + 'px', x = (screen.width - height.substring(0, height.length - 2)) / 2 + 'px';*/
        var heigth=$win.css('height'),width=$win.css('width');
        var y=((window.innerHeight?window.innerHeight:document.documentElement.clientHeight)-parseFloat(heigth.substring(0,heigth.length-2)))/ 2+'px' ,x=((window.innerWidth?window.innerWidth:document.documentElement.clientWidth)-parseFloat(width.substring(0,width.length-2)))/2+'px';

        $win.css({left: x, top: y, opcity: 0.3});
        $(".zhezhao").fadeIn();
        $win.fadeIn();
    }
    $("body").on("click", "#ok", function () {
        var imei = $("input[name='imei']:checked").val();
        if (imei == undefined || imei == '')
            alert("未选中设备")
        else
            window.location.href = baseUrl + "/find/car?imei=" + $.trim(imei);
    });
    $("body").on("click", "#cancel", function () {
        $("#device").fadeOut();
        $(".zhezhao").fadeOut();
        $("#login-btn").css('background', '#d11721');
        $("#login-btn").val("提交");
        $("#login-btn").attr('disabled', false);
    });
    /*    $(document).on("click","div.banner li a.link",function(event){
     $.get("${baseUrl}/user/cart/add",{products:[{productId:$(this).parent().attr('prod'),count:1}]},function(data){
     if(data.code==0){
     //去结算
     window.location.href = baseUrl + "/buy/";
     }else alert(data.msg);
     },"json");
     return false;
     })*/
</script>
<%--
<script type="text/javascript">
    $("#exit").click(function(){
        $.get("/logout.html", {}, function (data) {
            if (data.status == 0) {
                window.location.reload(true);
            }
        }, "json");
    })
    //导航动态滑动效果
    $(function () {
        var $current_nav = $("#current_nav");
        var current_nav_width = $current_nav.innerWidth();
        var current_nav_left = $current_nav.position().left;
        var $navlist_animate_block = $(".navlist-animate-block");//获取动画模块
        $navlist_animate_block.css({width: current_nav_width, left: current_nav_left});//初始化滑动模块的当前的位置
        //鼠标进入li元素触发的滑动事件
        $(".nav-list-wrap li").hover(function () {
            var index = $(this).index();
            var li_cur = $(".nav-list-wrap").find("li").eq(index);//鼠标移动到的li元素
            //利用触发，索引到li元素的位置
            var width = li_cur.innerWidth();
            var left = li_cur.position().left;
            //设置动画滑块的位置
            $navlist_animate_block.stop().animate({
                width: width, left: left
            }, 300)
        }, function () {
            //当鼠标离开li元素，滑动模块将会返回到当前模块
            $navlist_animate_block.stop().animate({width: current_nav_width, left: current_nav_left}, 300)
        });
    });
</script>--%>
