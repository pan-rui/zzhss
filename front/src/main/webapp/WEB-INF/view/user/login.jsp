<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="../include/require.jsp" %>--%>
<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="../include/top.jsp" %>
    <!-- showImg-->
    <div class="login-content" style="background:url(<c:url value="/images/loginShowImg_02.jpg"/>);">
        <div class="wrapper">
            <div class="login">
                <h3 class="login-title">用户登录</h3>

                <form id="loginForm" method="post">
                    <ul class="clearfix">
                        <li>用户名:<input type="text" validType="phone" name="nameOrPhone" url="${baseUrl}/validator/user;pName=cellPhone/1" placeholder="请输入您的手机号码" onkeyup="value=value.replace(/[^\d.]/g,'')"></li>
                        <li>密码：<input type="password" name="password"></li>
                        <li>
                            <span>验证码:&nbsp;&nbsp;
                            <input type="text" style="width: 100px;float:none;" id="code" name="verCode" require="true" url="${baseUrl}/verifyCode"/><img id="verCode" style="float: right"
                                                                                                    src="<c:url value="/imageCode?"/>"/></span>
                        </li>
                            <li>
                            <input type="submit" id="login-btn">
                        </li>
                    </ul>
                </form>
                <p class="forget-password"><a href="<c:url value="/user/rePass"/>">忘记密码？</a></p>
            </div>
        </div>
    </div>
    <div class="bg-hui">
        <ul class="wrapper clearfix work-tenet">
            <li>
                <div class="work-tenet-bg">
                    <img src="<c:url value="/images/workTenetIcon_03.png"/>" alt="在线客服" height="66">
                </div>
                <h3>在线客服</h3>
                <p>周一至周五 9:00-18:30</p>
            </li>
            <li>
                <div class="work-tenet-bg">
                    <img src="<c:url value="/images/workTenetIcon_05.png"/>" alt="7天无理由退货" height="66">
                </div>
                <h3>7天无理由退货</h3>
                <p>7天无理由退货，请放心购买</p>
            </li>
            <li>
                <div class="work-tenet-bg">
                    <img src="<c:url value="/images/workTenetIcon_07.png"/>" alt="15天免费换货" height="66">
                </div>
                <h3>15天免费换货</h3>
                <p>15天内如遇质量问题 免费换货</p>
            </li>
            <li>
                <div class="work-tenet-bg">
                    <img src="<c:url value="/images/workTenetIcon_09.png"/>" alt="365天无忧保修" height="66">
                </div>
                <h3>365天无忧保修</h3>
                <p>365天内产品自身质量问题保修</p>
            </li>
        </ul>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp" %>
</div>
<script>
    inputBlur("input");
    $("input").focus(function(){
        $(this).next('.erro-msg').remove();
    })
    $("#verCode").click(verifyCode);
    $("#loginForm").submit(function(){
        $("#login-btn").attr('disabled',true);
        $("#login-btn").css('background','#A9A9A9');
        $("#login-btn").val("正在登录...");
//        $("input").blur();
        if (!validRule.validate("#loginForm")){
            $("#login-btn").css('background','#D11721');
            $("#login-btn").val("提交");
            $("#login-btn").attr('disabled',false);
            return false;
        }
        /*        $.get("${baseUrl}/user/loginEd", fromData("input[name]"), function (data) {
         if (data.code == 0)
         window.location.href = baseUrl + data.msg;
         else alert(data.msg);
         }, 'json');*/
        var $win = $("#device");
        if($win.is(":visible")){
            alert("请选择一个设备的IMEI")
            return false;
        }
        $.post("${baseUrl}/user/loginEd", fromData("input[name]"), function (data) {
            if (data.code == 0) {
                fillDevice(data.data);
            } else if(data.code==8888){
                window.location.href = baseUrl + "/find/car?imei="+data.data['Device_Imei'];
            }else if(data.code==6666) {
                window.location.href = baseUrl + "/";
            }else if(data.code==7777){
                window.location.href=data.msg;
            }else{
                alert(data.msg);
                $("#login-btn").css('background','#D11721');
                $("#login-btn").val("提交");
                $("#login-btn").attr('disabled',false);
            }
        }, 'json');
        return false;
    });

</script>
</body>
</html>
