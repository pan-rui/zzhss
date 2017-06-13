<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@include file="include/require.jsp"%>
<html>
<head>
	<meta charset="utf-8" />
	<title></title>
	<%--<link rel="stylesheet" href="../css/bootstrap.css" />--%>
</head>
<style>
	.login{width:500px;margin: 100px auto;}
	h1{margin-bottom: 30px;}
	body{ background: #2AABD2;color:#fff;}
	#swicthcode{padding: 0;}
	#swicthcode img{width:75px;height:34px;}
</style>

<body style="min-width: 1290px;">
	<div class="login">
		<h1 class="text-center">后台管理系统</h1>
			<form class="form-horizontal" id="form">
		  		<div class="form-group">
		    		<label for="name" class="col-sm-2 control-label">用户名</label>
		    		<div class="col-sm-10">
		      			<input type="text" class="form-control" id="name" name="adminName" placeholder="点击输入用户名">
		    		</div>
		  		</div>
		  		<div class="form-group">
		    		<label for="pwd" class="col-sm-2 control-label">密码</label>
		    		<div class="col-sm-10">
		      			<input type="password" class="form-control" id="pwd" name="pwd" placeholder="password">
		    		</div>
		  		</div>
		  		<div class="form-group">
		    		<label for="code" class="col-sm-2 control-label">验证码</label>
		    		<div class="col-sm-8">
						<input type="text" id="code" name="verCode" require="true" url="${baseUrl}/verifyCode"/>
					</div>
		    		<div class="col-sm-2" id="swicthcode">
						<img  id="verCode" src="<c:url value="${baseUrl}/imageCode?"/>"/>
		    		</div>
		  		</div>
				<div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <div class="checkbox">
				        <label>
				          <input type="checkbox"> 记住我
				        </label>
				      </div>
				    </div>
				</div>
				<div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <button type="submit" class="btn btn-default" id="submit">进入后台</button>
				    </div>
				</div>
			</form>
		</div>
	</div>
<script type="text/javascript">
	checkCookie($("input[name='adminName']"));
	checkCookie($("input[name='pwd']"));
	$("#verCode").click(function(){
		var src = $(this).attr('src');
		$(this).attr('src', src.substring(0,src.indexOf('?')+1)+Math.random());
	});
	$("#remember").click(function(){
		if($(this).attr("checked")!=undefined){
			setCookie("adminName",$("input[name='adminName']").val(),30);
			setCookie("pwd",$("input[name='pwd']").val(),30)
		}else{
			deleteCookie("adminName");
			deleteCookie("pwd");
		}
	});
	$("#form").submit(function () {
		login();
		return false;
	})
	function login(){
		$(this).attr('disabled',true);
		$('#submit').val('登录中...');

		var param = {adminName:$("input[name='adminName']").val(),pwd:$("#pwd").val(),verCode:$("input[name='verCode']").val()};
		$.post(baseUrl+"/loginEd",param,function(data){
			$('#submit').val('马上登录');
			if(data.code == 0){
				window.location.href=baseUrl+"/index";
			}else
				$.messager.alert("失败",data.msg,"warning");
			$('#submit').val('登录');
		},"json");
	}
</script>
</body>
</html>
