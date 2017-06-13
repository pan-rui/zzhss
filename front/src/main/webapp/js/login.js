/**
 * Created by Administrator on 2015/9/23.
 */
inputBlur("input");
checkCookie($("input[name='nameOrPhone']"));
checkCookie($("input[name='password']"));
$("#verCode").click(function(){
    var src=$(this).attr('src');
    $(this).attr('src', src.substring(0,src.indexOf('?')+1)+Math.random());
});
$("#remember").click(function(){
    if($(this).attr("checked")!=undefined){
        setCookie("nameOrPhone",$("input[name='nameOrPhone']").val(),30);
        setCookie("password",$("input[name='password']").val(),30)
    }else{
        deleteCookie("nameOrPhone");
        deleteCookie("password");
    }
});
$("#form").submit(function () {
    login();
    return false;
})
function login(){
    $(this).attr('disabled',true);
    $('#submit').val('登录中...');

    var param = {nameOrPhone:$("input[name='nameOrPhone']").val(),password:$("#password").val(),verCode:$("input[name='verCode']").val()};
    $.post(baseUrl+"/user/loginEd",param,function(data){
        $('#submit').val('马上登录');
        if(data.code == 0){
            //var salu = data.afterLoginUrl;
            //if(salu && typeof salu == 'string' ) {
            //   	window.location.href =  salu;
            //  	return;
            //}
            window.location.href=data.msg;
        }else
            alert(data.msg);
        $('#submit').val('登录');
    },"json");
}