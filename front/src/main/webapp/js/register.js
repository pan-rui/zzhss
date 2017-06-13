//点击注册下一步弹出手机验证码层
$(document).ready(function () {
    $('#cance').click(function () {
        $('.phonecode-bg').fadeOut(100);
        $('#phonecode').slideUp(200);
    });
});
var timers = 59;
var tipId;
inputBlur("input");

function timer_() {
    if (timers >= 0) {
        $("#send-again").html(timers + "秒后可重新获取");
        timers--;
    } else {
        window.clearInterval(tipId);
        $("#send-again").html("重新发送验证码");
    }
}

$("#send-again").click(function(){
    sendSMS({phone: $("input[name='cellPhone']").val(),type:"SmsTemplate_Reg"});
})
$("input[name='treaty']").click(function(){
    if (!$("input[name='treaty']:checked").val())
        $("input[name='treaty']").next('.erro-msg').show().html('同意协议后才能进行下一步操作,谢谢合作');
    else
        $("input[name='treaty']").next('.erro-msg').hide(300)
})
$("#next-one").click(function () {
    if (!$("input[name='treaty']:checked").val()) {
        $("input[name='treaty']").next('.erro-msg').show().html("同意协议后才能进行下一步操作,谢谢合作");
        return;
    }

    var phone=$("input[name='cellPhone']");
    if ($(".erro-msg:visible").size()>0) return;
    $(".cellphone-num p").text($(".cellphone-num p").text().replace(/\d+/, phone.val()));
    $('.phonecode-bg').fadeIn(100);
    $('#phonecode').slideDown(100);
    /*    var test = {};
     test["paramMap.phone"] = data.phone;*/
    sendSMS({phone: phone.val(),type:"SmsTemplate_Reg"});
});

function sendSMS(obj){
            $.get(baseUrl+"/sendSMS", obj, function (data) {
                if (data.code == 0) {
                    tipId = window.setInterval(timer_, 1000);
                    alert("验证码已发送到您手机，请注意查收");
                }else
                    alert(data.msg);
                //$("input[name='smsCode']").next('.erro-msg').show().html(data.msg);
            },"json");
}

$("#confirm").click(checkSmsCode);

$("#verCode").click(function(){
    var src = $(this).attr('src');
    $(this).attr('src', src.substring(0,src.indexOf('?')+1)+Math.random());
})

//验证SmsCode
function checkSmsCode() {
    $.get(baseUrl+"/checkSmsCode",{phone:$("input[name='cellPhone']").val(),smsCode: $("input[name='smsCode']").val()},function(data){
        if(data.code==0){
            //alert("手机验证码正确");
                if (history && history.pushState)
                    history.pushState(null, "注册第二步","/register2");
            window.location.href="/register2?"+fromDataString($("form:first"));
        }else alert(data.msg);
    },"json");
}

/*
function () {
    if (validRule.validate())
        $.post("/ajaxPhoneCodeCheck.html", formData(document.forms[0]), function (data) {
            if (data.code == 1)
                window.location.href = "userCenter.html?vid=3";
            else
                alert("注册失败....")
        })
    return false;
}*/
