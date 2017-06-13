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
                        <%--<li><a href="<c:url value="/user/coupons"/> ">优惠券</a></li>--%>
                        <li><a href="<c:url value="/user/modifyPass"/>">修改密码</a></li>
                        <li><a href="<c:url value="/user/exit"/>">退出登录</a></li>
                    </ul>
                </div>
                <div class="order-left">|<a href="<c:url value="/user/order"/>">我的订单</a></div>
            </div>
                </c:when>
                <c:otherwise>
                    <div class="header-right">
                    <a href="${baseUrl}/user/toLogin">登录</a><a href="javascript:;">/</a><a href="${baseUrl}/user/toRegister">注册</a>
                    </div>
                </c:otherwise>
            </c:choose>
            <%--<div class="order-user">
                <a href="javascript:;" class="icon-xiala">${user.cellPhone}</a>|
                <a href="<c:url value="/user/order"/>">我的订单</a>
            </div>--%>
        </div>
    </header>
    <div class="zhezhao" style="display:none;"></div>
    <div id="device" style="font-size: 20px;position: absolute;padding: 10px 15px 10px 15px;width:auto;display: none;z-index: 999;height: auto;background-color:White;opcity:0.3;"></div>
    <script>
        $("#find").click(function(){
            if('${user.id}'!=''){
                fillDevice(${y:toArrayStr(imeis)});
                return false;
            }
        })
        function fillDevice(data) {
            if(data==undefined||data==null||data.length==0){
                alert("您没有绑定任何设备!");
                location.href = baseUrl + "/";
                return ;
            }
            var $win = $("#device");
            $win.html("");
            $win.prepend('<p>想要查询您的哪台设备(IMEI)</p></br>');
            $.each(data,function(i,n){
                $win.append('<input type="radio" name="imei" value="'+n['Device_Imei']+'" />'+n['Device_Imei']+'</br>')
            })
            $win.append('<a href="javascript:;" id="ok">确定</a>&nbsp;&nbsp;&nbsp;<a href="javascript:;" id="cancel">取消</a> ');
            var width=$win.css('height'),height=$win.css('width');
            var y=(screen.height-width.substring(0,width.length-2))/ 2 +'px',x=(screen.width-height.substring(0,height.length-2))/2+'px';
            $win.css({left: x, top: y,opcity:0.3});
            $(".zhezhao").fadeIn();
            $win.fadeIn();
        }
        $("body").on("click","#ok",function(){
            var imei=$("input[name='imei']:checked").val();
            if(imei==undefined||imei=='')
                alert("未选中设备")
            else
                window.location.href = baseUrl + "/find/car?imei=" + $.trim(imei);
        });
        $("body").on("click","#cancel", function () {
            $("#device").fadeOut();
            $(".zhezhao").fadeOut();
            $("#login-btn").css('background','#d11721');
            $("#login-btn").val("提交");
            $("#login-btn").attr('disabled',false);
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
    <%@include file="../include/loginMin.jsp" %>
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
    <!-- showImg-->
    <div class="bg-hui shopping-padding">
        <div class="wrapper">
            <table class="shopping" width="100%">
                <tr>
                    <th>
                        <input type="checkbox" id="checkAll">全选
                    </th>
                    <th>商品名称</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>操作</th>
                </tr>
                <tbody>
                <c:set var="amount"/>
                <c:forEach items="${y:toArray(cart.productItem)}" var="product">
                    <tr prod="${product.id}" priY="${product.priceY}">
                        <td>
                            <input type="checkbox" value="${product.id}" />
                            <a href="<c:url value="/product?id=${product.id}"/>"><img
                                    src="<c:url value="${y:toMap(product.imgs).small}"/>" alt=""></a>
                        </td>
                        <td>
                            <h3><a href="<c:url value="/product?id=${product.id}"/>">${product.name}</a></h3>

                            <p>${product.description}</p>
                        </td>
                        <td><em class="single-price"></em>${product.price}元</td>
                        <td>
                            <p class="td-center">
                                <a href="javascript:void(0)" class="shopping-reduction" op="subtract">-</a>
                                <input type="text" value="${product.sellCount}" class="single-num" name="sellCount"
                                       onkeyup="value=value.replace(/[^\d]/g,'')">
                                <a href="javascript:void(0)" class="shopping-add" op="add">+</a>
                            </p>
                        </td>
                        <td>
                            <i class="single-sum"><%--${product.priceY * product.sellCount}元--%></i>
                        </td>
                        <td>
                            <span class="single-delete" operate="delete">×</span>
                        </td>
                    </tr>
                    <c:set var="amount" value="${amount+product.priceY*product.sellCount}"/>
                </c:forEach>
                </tbody>
                <%--<tbody>
                    <tr>
                        <td>
                            <input type="checkbox">
                            <a href="#"><img src="images/shoppingImg_03.jpg" alt=""></a>
                        </td>
                        <td>
                            <h3><a href="#">电动车摩托车GPS防盗追踪器</a></h3>
                            <p>电摩通用 精准定位 远程熄火 防水防盗</p>
                        </td>
                        <td><em class="single-price"></em>150元</td>
                        <td>
                            <p class="td-center">
                                <a href="javascript:void(0)" class="shopping-reduction">-</a>
                                <input type="text" value="1" class="single-num">
                                <a href="javascript:void(0)" class="shopping-add">+</a>
                            </p>
                        </td>
                        <td>
                            <i class="single-sum">150元</i>
                        </td>
                        <td>
                            <span class="single-delete">×</span>
                        </td>
                    </tr>
                </tbody>--%>
            </table>
            <div class="clearfix price-sum" style="padding-left: 100px;">
                <p class="settlement">
                    合计（不含运费）<span class="sum">${amount}</span>元
                    <a href="<c:url value="/buy/"/>" class="sum-btn">去结算</a>
                </p>
                <a href="<c:url value="/"/>" class="going-shopping" style="color:#FF0000;">继续购物</a>共<span class="letter"></span>件商品 已选择<span
                    class="choose-letter"></span>件
            </div>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp" %>
</div>
<script>
    function sum() {
        var sum = 0;
        $("tr[prod] input:checked").each(function(i,domE){
            var tr = $(this).closest("tr");
            sum += Math.round(parseFloat(tr.attr('priY')) * tr.find("input[name='sellCount']").val()*100)/100;
        })
        $("div.price-sum span.sum").html(sum);
    }
    $("tr[prod] input:checkbox").click(function(){
        sum();
        $("span.choose-letter").html($("tr[prod] input:checked").length);
    });
    $("#checkAll").click(function(){
        if($(this).is(":checked"))
            $("tr[prod] input").not(":checked").each(function(){$(this).click();})
        else
            $("tr[prod] input:checked").each(function(){$(this).click()});
    });

    inputBlur("input");
    $(function () {
        $("tr[prod] input[type='checkbox']").each(function(i,domE){
            var tr = $(this).closest("tr");
            tr.find("i.single-sum").html(Math.round(parseFloat(tr.attr('priY')) * tr.find("input[name='sellCount']").val()*100)/100+'元');
        })
        $("#checkAll").click();
        $("span.choose-letter").html($("tr[prod] input:checked").length)
//        sum();
        $("table.shopping").on("change", "input[name='sellCount']", function () {
            var td = $(this).closest("td"), tr = $(this).closest("tr");
//    var price=td.prev().text().substring(0,td.prev().text().length-1)
            var cur_i = td.next().find(".single-sum");
            cur_i.html(Math.round(parseFloat(tr.attr('priY')) * $(this).val()*100)/100 + '元');
            sum();
            $.get(baseUrl + "/user/cart/update", {
                products: [{
                    productId: tr.attr("prod"),
                    count: $(this).val()
                }]
            }, function (data) {
                if (data.code != 0)
                    alert("数量更改失败,请联系客服.")
            }, "json");
        })
        $("table.shopping").on("click", "p.td-center a[op='add']", function () {
            var inp = $(this).prev("input");
            inp.val(parseInt(inp.val()) + 1);
            inp.change();
        });
        $("table.shopping").on("click", "p.td-center a[op='subtract']", function () {
            var inp = $(this).next("input");
            if (parseInt(inp.val()) > 1){
                inp.val(parseInt(inp.val()) - 1);
                inp.change();
            }
        })
        //去结算
        $("a.sum-btn").click(function(){
            if($("table.shopping tr[prod]").length==0){
                alert("购物车内至少有一件商品时才能提交.")
                return false;
            }
            if($("tr[prod] input:checked").length==0) {
                alert("请您选择需要结算的商品.")
                return false;
            }
            var productI=[];
            $("tr[prod] input:checked").each(function(i,domE){
                productI[i]=$(domE).closest("tr").attr("prod");
            })
            var old = $(this).attr("href");
            $(this).attr("href", old + '?products=' + productI.join());
            if('${user.id}'==''){
                var $win = $("div.login2");
                var height = $win.css('height'), width = $win.css('width');
                var y = (screen.height - height.substring(0, height.length - 2))/4 + 'px', x = (screen.width - width.substring(0, width.length - 2)) / 2 + 'px';
                $win.css({left: x, top: y});
                $win.fadeIn();
                return false;
            }
        })

        $(document).on('click',"#ball",function(){
            $("#device").hide();
            window.location.href = $("a.sum-btn").attr('href');
        })
        //删除商品
        $("span.single-delete").click(function(){
            var tr=$(this).closest('tr');
            $.get(baseUrl + "/user/cart/delete", {products: [{productId: tr.attr("prod")}]}, function (data) {
                if (data.code == 0) {
                    tr.remove();
                    sum();
                    $("span.choose-letter").html($("tr[prod] input:checked").length);
                } else alert("删除失败")
            }, 'json');
        });

        $("#verCode").click(verifyCode);
        $("#login-btn").click(function(){
            $("#login-btn").attr('disabled',true);
            $("#login-btn").css('background','#A9A9A9');
            $("#login-btn").val("正在登录...");
            if (!validRule.validate("#loginForm")){
                $("#login-btn").css('background','#D11721');
                $("#login-btn").val("提交");
                $("#login-btn").attr('disabled',false);
                return false;
            }
            $.post("${baseUrl}/user/loginEd", fromData("input[name]"), function (data) {
                if (data.code == 7777) {
                    window.location.href=$("a.sum-btn").attr('href');
                }else{
                    alert(data.msg);
                    $("#login-btn").css('background','#D11721');
                    $("#login-btn").val("提交");
                    $("#login-btn").attr('disabled',false);
                }
            }, 'json');
            return false;
        });
    })
</script>
</body>
</html>
