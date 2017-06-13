<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="include/require.jsp"%>--%>
<html>
<head>
    <meta name="keywords" content="" />
    <title>首页</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
<%@include file="../include/top.jsp"%>
    <!-- banner-->
    <div class="bg-hui padding-bottom50">
        <div class="wrapper clearfix">

            <div class="content-right">
                <div class="clearfix promoCode">
                    <div class="promoCode-left">
                        <img src="<c:url value="/images/vipMa_03.jpg"/>"/>
                        <ul class="promoCode-input">
                            <li>
                                <input type="text" maxlength="32" minlength="16" name="couponId" style="display: none;font-size: 64px;text-align:center;height:80px;" disabled="disabled">
                            </li>
                            <li>
                     <%--           <input type="text" placeholder="验证码" class="yanzhengma">
                                <a href="javascript:void(0);"><img src="images/yanzhengma_07.jpg" alt="验证码"></a>--%>
                                <input type="text" style="width: 200px;float:none;" require="true" url="${baseUrl}/verifyCode" class="yanzhengma"/>
                                <a href="javascript:void(0);"><img id="verCode2" style="float: right;position: absolute;left: 540px;top: 415px;" src="<c:url value="/imageCode?"/>"/></a>
                            </li>
                            <input type="hidden" name="couponDictId" value="${couponDict.id}"/>
                            <li>
                                <input type="button" value="领取" uid="" class="promoCodeBtn">
                            </li>
                        </ul>
                    </div>
                    <div class="promoCode-right">
                        <h3 class="promoCode-right-title">优先购买码使用规则</h3>
                        <ul class="promoCode-right-guize">
                            <li>1. 优先购买码仅可以购买指定产品，每个码限买一台，不可重复使用。</li>
                            <li>2. 本次发放的优先购买码请于活动截止（10月20日）前使用，过期失效。</li>
                            <li>3. 全额支付成功后，优先购买码立即失效。</li>
                            <li>4. 优先购买码非实名认证，请妥善保管。</li>
                            <li>5. 如遇到优先购买码无法识别的情况，请及时致电客服4008-345-866。</li>
                        </ul>
                        <h3 class="promoCode-right-title">常见问题</h3>
                        <ul>
                            <li>
                                <div class="wen">问：一个优先购买码能使用几次？</div>
                                <div class="da">答：一个优先购买码只能使用一次。</div>
                            </li>
                            <li>
                                <div class="wen">问：使用优先购买码下单后，如取消订单，优先购买码能否继续使用？</div>
                                <div class="da">答：如您已支付成功，则优先购买码不能再次使用；如果订单未支付，订单关闭后该优 先购买码可恢复使用。</div>
                            </li>
                            <li>
                                <div class="wen">问：使用优先购买码购买手机，订单是否需要一次性支付全款？</div>
                                <div class="da">答：使用优先购买码购买手机时，必须一次性支付全款。</div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%@include file="../include/loginMin.jsp" %>

    <!-- footer-->
<%@include file="../include/footer.jsp"%>
</div>
<script>
    inputBlur("input");
    $("#verCode").click(verifyCode);
    $("#verCode2").click(function() {
        var src = $(this).attr('src');
        $(this).attr('src', src.substring(0, src.indexOf('?') + 1) + Math.random());
    });
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
                $("div.login").fadeOut();
                $("input.promoCodeBtn").data('uid', 'loginEd');
                $("input.promoCodeBtn").click();
            }else{
                alert(data.msg);
                $("#login-btn").css('background','#D11721');
                $("#login-btn").val("提交");
                $("#login-btn").attr('disabled',false);
            }
        }, 'json');
        return false;
    });
    $("input.promoCodeBtn").click(function(){
        if (!validRule.validate("ul.promoCode-input")) return false;
        var uid=$("input.promoCodeBtn").data('uid');
        if($("div.header-right a:first").html().length<3&&(uid==undefined||uid=='')){
            var $win = $("div.login2");
            var height = $win.css('height'), width = $win.css('width');
            var y = (screen.height - height.substring(0, height.length - 2))/4 + 'px', x = (screen.width - width.substring(0, width.length - 2)) / 2 + 'px';
            $win.css({left: x, top: y});
            $win.fadeIn();
            return false;
        }
        $.post("${baseUrl}/user/coupon/"+$("input[name='couponDictId']").val(),{},function(data){
            if(data.code==0) {
                $("div.header-right a:first").before('<a href="'+baseUrl+'/user/home">'+data.data.couponRemarks+'</a>&nbsp;/&nbsp;<a href="'+baseUrl+'/user/exit">退出</a>');
                $("div.header-right a").slice(2,5).remove();
                $("input[name='couponId']").val(data.data.id);
                $("input[name='couponId']").show();
            }else if(data.code==103) {
                alert('您已经领取过此优惠券');
                $("div.header-right a:first").before('<a href="'+baseUrl+'/user/home">'+data.data.cellPhone+'</a>&nbsp;/&nbsp;<a href="'+baseUrl+'/user/exit">退出</a>');
                $("div.header-right a").slice(2,5).remove();
            }else alert(data.msg);
        },'json');
    })
</script>
</body>
</html>
