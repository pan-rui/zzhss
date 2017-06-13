<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="../include/require.jsp" %>--%>
<!DOCTYPE html>
<html>
<head>
    <title>重设密码</title>
    <style>
        .register li {
            position: relative;
        }

        .register .erro-msg {
            position: absolute;
            left: 345px;
            top: 5px;
            width: 190px;
            color: #d11721;
        }
    </style>
</head>
<body>
<div id="Wrap">
    <!-- header-->
    <%@include file="../include/top.jsp" %>
    <!-- showImg-->
    <div class="register-content">
        <div class="register">
            <h3 class="register-title">账号重设密码</h3>

            <form method="post" id="userForm" action="/user/registerEd">
                <ul>
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-phone"></i>
                            <input type="text" value="" id="cellPhone" name="cellPhone" validType="phone"
                                   url="${baseUrl}/validator/user;pName=cellPhone/0" placeholder="账号/手机号"
                                   onkeyup="value=value.replace(/[^\d.]/g,'')"
                                   maxlength="11">
                        </p>
                    </li>
                    <li class="clearfix">
                        <p class="register-border" style="float:left;width:188px;">
                            <i class="icon icon-psw"></i>
                            <input type="text" class="auth-code" id="smsCode" placeholder="短信验证码" maxlength="6">
                            <%--<h4 class="erro-msg" style="display: none"></h4>--%>
                        </p>
                        <a href="javascript:;" id="sendSms" class="send-again">获取短信验证码</a>
                    </li>
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-psw"></i>
                            <input type="password" validType="password" name="pwd" id="pwd" placeholder="请输入密码">
                        </p>
                    </li>
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-psw"></i>
                            <input type="password" id="confirmPwd" placeholder="请再次输入密码">
                            <%--<h4 class="erro-msg" style="display: none"></h4>--%>
                        </p>
                    </li>

                    <li>
                        <input type="submit" value="确定" class="register-btn"/>
                    </li>
                </ul>
            </form>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp" %>
</div>
<script>
    var timers = -1;
    var tipId;
    var err = $("<h4 class='erro-msg'></h4>");
    inputBlur("input[name]");
    function timer_() {
        if (timers >= 0) {
            $("#sendSms").html(timers + "秒后可重新获取");
            timers--;
        } else {
            window.clearInterval(tipId);
            timers=-1;
            $("#sendSms").html("重新发送验证码");
        }
    }

    $("#sendSms").click(function () {
        if(timers>=0) return false;
        var phone = $("#cellPhone").val();
        if (phone == undefined || phone == '') {
            validRule.exec("#cellPhone", null);
            return false;
        }
        timers=59;
        sendSMS({phone: phone, type: "Sms_Register_Template"});
        return false;
    })

    function sendSMS(obj) {
        $.get(baseUrl + "/sendSMS", obj, function (data) {
            if (data.code == 0) {
                tipId = window.setInterval(timer_, 1000);
                alert("验证码已发送到您手机，请注意查收");
            } else
                alert(data.msg);
            //$("input[name='smsCode']").next('.erro-msg').show().html(data.msg);
        }, "json");
    }
    $("#smsCode,#confirmPwd,#email").on("change", function () {
        var erro = $(this).next(".erro-msg") || err;
        erro.hide(100);
    });
    $("#userForm").submit(function () {
        var smsCode = $("#smsCode").val();
        if (smsCode == undefined || smsCode == '') {
            err.show().html("短信验证码不能为空.")
            $("#smsCode").after(err);
            return false;
        }
        var flag = false;
        $.ajax({
            url: baseUrl + "/checkSmsCode",
            data: {phone: $("#cellPhone").val(), smsCode: $("#smsCode").val()},
            success: function (data) {
                if (data.code != 0) {
                    err.show().html(data.msg);
                    $("#smsCode").after(err);
                } else {
                    $("smdCode").next(".erro-msg").hide(300);
                    flag = true;
                }
            },
            async:false,
            dataType: "json"
        });
        if (!flag) return false;
        if ($("#confirmPwd").val() != $("#pwd").val()) {
            err.show().text("两次输入的密码不一致.")
            $("#confirmPwd").after(err);
            return false;
        }
        if (!validRule.validate("#userForm")) return false;
        var from = fromData("input[name]")
        $.post(baseUrl + "/user/rePassEd", from, function (data) {
            if (data.code == 0)
                alert("密码修改成功!")
            else alert(data.msg);
        }, "json");
        return false;
    });
</script>
</body>
</html>
