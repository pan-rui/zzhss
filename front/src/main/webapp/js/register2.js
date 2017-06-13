/**
 * Created by Administrator on 2015/9/23.
 */
inputBlur("input");
$("input[name='confirmPwd']").blur(function(){
    if($(this).val()!=$("input[name='pwd']").val())
    $(this).next(".erro-msg").show().html("两次输入的密码不一致.")
    else
        $(this).next(".erro-msg").hide(300);
});
$("#next-tow").click(function(){
    //$("input[name='referrer']").blur();
    if(!validRule.validate()) return;
    $.post(baseUrl+"/user/registerEd",fromData($("form:first")),function(data){
            $('#next-tow').val( '立即注册');
            if (data.code == 0) {
                window.location.href="/login";
            } else alert(data.msg);
    },"json");
})