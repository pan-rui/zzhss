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
            <h3 class="register-title">修改密码</h3>

            <form method="post" id="userForm">
                <ul>
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-phone"></i>
                            <input type="text" value="" id="cellPhone" name="cellPhone" validType="phone"
                                   url="${baseUrl}/validator/user;pName=cellPhone/1" placeholder="账号/手机号"
                                   onkeyup="value=value.replace(/[^\d.]/g,'')"
                                   maxlength="11">
                        </p>
                    </li>
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-psw"></i>
                            <input type="password" validType="password" name="oldPwd" id="opwd" placeholder="请输入旧密码">
                        </p>
                    </li>
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-psw"></i>
                            <input type="password" validType="password" name="newPwd" id="pwd" placeholder="请输入新密码">
                        </p>
                    </li>
                    <li class="clearfix">
                        <p class="register-border">
                            <i class="icon icon-psw"></i>
                            <input type="password" id="confirmPwd" placeholder="请再次输入新密码">
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
    var err = $("<h4 class='erro-msg'></h4>");
    inputBlur("input[name]");
    $("body").on('focus',"input[name],#confirmPwd",function(){
        $(this).next('.erro-msg:visible').hide();
    })

/*    $("#confirmPwd").on("change", function () {
        var erro = $(this).next(".erro-msg") || err;
        erro.hide(100);
    });*/
    $("#confirmPwd").blur(function(){
        if ($("#confirmPwd").val() != $("#pwd").val()) {
                err.show().text("两次输入的密码不一致.")
                $("#confirmPwd").after(err);
        }
    })
    $("#userForm").submit(function () {
        if (!validRule.validate("#userForm")) return false;
        var from = fromData("input[name]")
        $.post(baseUrl + "/user/modifyPassEd", from, function (data) {
            if (data.code == 0)
                alert("密码修改成功!")
            else alert(data.msg);
        }, "json");
        return false;
    });
</script>
</body>
</html>
