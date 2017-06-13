<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%--<%@include file="../include/require.jsp" %>--%>
<!DOCTYPE html>
<html>
<head>
    <title>注册</title>
    <style>
        .register li {
            position: relative;
        }

        .register .erro-msg {
            position: absolute;
            left: 340px;
            top: 1px;
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
            <h3 class="register-title">注册智护伞账户</h3>

            <form method="post" id="userForm" action="/user/registerEd">
                <ul>
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-phone"></i>
                            <input type="text" value="" id="cellPhone" name="cellPhone" validType="phone"
                                   url="${baseUrl}/validator/user;pName=cellPhone/0" placeholder="输入手机号码"
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
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-psw"></i>
                            <input type="text" name="email" id="email" placeholder="请输入电子邮箱（选填）">
                        </p>
                    </li>
                    <li class="clearfix" style="margin-top:8px;">
                        <a href="<c:url value="/agreement"/>" class="xieyi-link" target="_blank">用户协议</a>
                        <input type="checkbox" class="xieyi" checked="checked" id="treaty"/>已阅读并同意注册用户协议
                        <p class="erro-msg" style="display:none"></p>
                    </li>
                    <li>
                        <input type="submit" value="立即注册" class="register-btn"/>
                    </li>
                </ul>
            </form>
        </div>
    </div>
    <!-- footer-->
    <%@include file="../include/footer.jsp" %>
</div>
<div id="ball" style="position: absolute;width:700px;display: none;z-index: 999;height: 600px;background-color:White;opcity:0.3;"></div>
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
    })

    $("#treaty").click(function () {
        if (!$("#treaty:checked").val())
            $("#treaty").next('.erro-msg').show().html('同意协议后才能进行下一步操作,谢谢合作');
        else
            $("#treaty").next('.erro-msg').hide(300)
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
        var email = $("#email").val();
        if (email != '') {
            if (!new RegExp(validRule.email.regexp, 'g').test(email)) {
                err.show().html("email格式不正确");
                $("#email").after(err);
                return false;
            }
        }
        if (!validRule.validate("#userForm")) return false;
        var from = fromData("input[name]")
        $.post(baseUrl + "/user/registerEd", from, function (data) {
            if (data.code == 0)
                window.location.href = baseUrl + '/user/toLogin';
            else alert(data.msg);
        }, "json");
        return false;
    });
    $("#ball").click(function () {
        if ($(this).is(":visible"))
            $(this).hide(400, 'linear');
    })
    $("form li a[link]").on("click", function () {
        $.get(baseUrl + "/link", {content: $(this).attr("link")}, function (data) {
            if (data.code == 0) {
                var $win = $("#ball");
                $win.html(data.msg);
                var height = $win.css('height'), width = $win.css('width');
                var y = (screen.height - height.substring(0, height.length - 2)) / 2 + 'px', x = (screen.width - width.substring(0, width.length - 2)) / 2 + 'px';
                $win.css({left: x, top: y, opcity: 0.3});
                $win.show();
            } else alert(data.msg);
        }, 'json');
    })
</script>
</body>
</html>
