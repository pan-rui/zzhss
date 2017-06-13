<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="../include/require.jsp"%>--%>
<!DOCTYPE html>
<html>
<head>
  <title>产品中心</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="../include/top.jsp"%>
    <!-- banner-->
    <!-- banner-->
    <div class="banner1" style="height:508px;">
        <div style="background: #ca1947 url(${product.img}) no-repeat 50% 100%; height:508px;">
            <div class="wrapper">
                <div class="bannerWenzi">
<%--                    <h3><i>智护伞D6</i></h3>
                    <p class="bannerWenziDetal">新一代GPS云防盗智能终端<br>精.准.智.连，树立行业新标杆</p>--%>
                    <p class="bannerWenziPrice">￥${product.price}</p>
                    <a href="<c:url value="/user/cart/add?productId=${product.id}"/>" class="link">立即购买</a>
                </div>
            </div>
        </div>
    </div>
<%--    <div class="banner">
        <div class="slider slider1">
            <ul class="play">
                <li style="background: #ca1947 url(<c:url value="/images/banner1.jpg"/>) no-repeat 50% 100%;" prod="${product.id}"><a href="<c:url value="/user/cart/add?productId=${product.id}"/>" class="link"></a></li>
                &lt;%&ndash;<li style="background: #7fbe52 url(<c:url value="/images/banner1.jpg"/>) no-repeat 50% 100%;"><a href="#" class="link"></a></li>&ndash;%&gt;
                &lt;%&ndash;<li style="background: #7fbe52 url(<c:url value="/images/banner1.jpg"/>) no-repeat 50% 100%;"><a href="#" class="link"></a></li>&ndash;%&gt;
            </ul>
        </div>
    </div>--%>
    <!-- showImg-->
    <div class="bg-hui product">
        <div class="wrapper product-title">
            <span>${product.content}</span>
        </div>
        <ul class="product-list">
            <li class="jing" style="background:url(${y:toMap(product.imgs).detail1}) no-repeat center center;"></li>
            <li class="zhun" style="background: url(${y:toMap(product.imgs).detail2}) no-repeat center center;"></li>
            <li class="zhi" style="background:url(${y:toMap(product.imgs).detail3}) no-repeat center center;"></li>
            <li class="lian" style="background: url(${y:toMap(product.imgs).detail4}) no-repeat center center;"></li>
        </ul>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp"%>
    <!-- floatmenu -->
    <div class="float-menu">
        <h3 class="menu-title"><span>${product.name}</span></h3>
        <%@include file="../include/leftMenu.jsp"%>
    </div>
<%--<div class="zhezh" style="position: fixed;width:100%;left:0;top:0;height:100%;background:rgba(243,243,243,1);z-index:2;display: none"></div>--%>
<div style="position:fixed;width: 1024px;height:auto;display:none;z-index: 99;text-align:center;vertical-align:middle;padding:80px 0px 0px 143px;" id="vDiv">
    <img src="<c:url value="/images/close.jpg"/>" alt="关闭" style="position: relative;top: -580px;left: 525px;;z-index: 100;"/>

</div>
</div>
<script>
    $("ul.menu li a[link]").on("click",function(){
        $.get(baseUrl+"/link",{content:$(this).attr("link")},function(data){
            if(data.code==0){
                $("#Wrap > div").not(".header,.footer,.float-menu").remove();
                $(".header").after(data.msg);
            }else alert(data.msg);
        },'json')
    })
    $("h3.menu-title").click(function(){
        $(this).next("ul.menu").toggle(100,'linear');
    });
</script>
</body>
</html>
