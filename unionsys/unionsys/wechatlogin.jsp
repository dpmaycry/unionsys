<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="org.dp.wechat.pojo.SNSUserInfo;"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="picture/sign.ico">

<title>工会系统登录</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/signin.css" rel="stylesheet">
<link href="idcode/jquery.idcode.css" rel="stylesheet" type="text/css" />

<script src="js/jquery-2.0.0.js" type="text/javascript"></script>
<script src="idcode/jquery.idcode.js" type="text/javascript"></script>
<script type="text/javascript">
        $(document).ready(function () {
             $.idcode.setCode();
			 $("form").submit(function(){
			var IsBy = $.idcode.validateCode();
			if(IsBy==false)
			{
				alert("验证码输入有误!");
				return false;
			}
			});
        });
    </script>
</head>

<body>
	<%!

	String openid="",nickname="";
	
%>
	
	<% 
		// 获取由OAuthServlet中传入的参数
		SNSUserInfo user = (SNSUserInfo)request.getAttribute("snsUserInfo"); 
		if(null != user) 
		{
			openid=user.getOpenId();
	        nickname=user.getNickname();
		}
	%>
	
	
	<%
 String name=null;
if(!session.isNew()){
  name=(String)session.getAttribute("username");
 if(name==null)name="";
}
%>

	<%
String loginfail=(String)request.getAttribute("loginfail");
if(loginfail!=null && loginfail.equals("true")){
%>


	<p style="text-align: center">
		<font size"36px" color="blue"> 	用户名或者密码有误！ </font>
	</p>


	<% } %>
	<div class="container">

		<form class="form-signin" action="wechatjudge.jsp" method="post">
			<h2 class="form-signin-heading">欢迎登录签到系统</h2>
			<label
				for="inputopenid" class="sr-only">微信号</label> <input
				type="hidden" id="inputopenid" name="openid" value=<%=openid%>
				class="form-control" placeholder="微信号">	
			<label
				for="inputnickname" class="sr-only">昵称</label> <input
				type="hidden" id="inputnickname" name="nickname" value=<%=nickname%>
				class="form-control" placeholder="昵称">	
															
			<label for="inputEmail" class="sr-only">用户名</label> <input
				type="text" id="inputUserName" name="username" class="form-control"
				placeholder="用户名" required autofocus> <label
				for="inputPassword" class="sr-only">密码</label> <input
				type="password" id="inputPassword" name="password"
				class="form-control" placeholder="密码" required> <input
				type="text" id="Txtidcode" class="txtVerification"
				placeholder="请输入验证码" /> <span id="idcode"></span>
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me">
					记住我
				</label>
			</div>
			<button class="btn btn-lg btn-primary btn-block" type="submit"
				onClick="CheckValidateCode()">登录</button>
		</form>

	</div>
</body>
</html>