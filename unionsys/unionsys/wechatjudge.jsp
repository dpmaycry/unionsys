<%@ page import="org.dp.database.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
  <title>主页</title>
</head>
</head>
<body>
<%
String openid = request.getParameter("openid");
String nickname = request.getParameter("nickname");
String username = request.getParameter("username");
session.setAttribute("username",username);
String password = request.getParameter("password");
String selectStatement = "select * from member where member_number=" + "\"" + username +"\"" ;
DatebaseHandler db = new DatebaseHandler();
db.connSQL();
ResultSet rs = db.selectSQL(selectStatement);
if(!rs.next()&&password!="fnst1234"){
	  request.setAttribute("loginfail","true");
%>
<jsp:forward page="wechatlogin.jsp" />
<%
}else{
	
	if(openid!=null)
	{
		// 数据库更新操作
		DatebaseHandler db1 = new DatebaseHandler();
		db1.connSQL();
		try {
            String select= "select * from user_table where unionno='"+username+"'";
			String update = "update user_table set unionno='" + username+ "' where openid='" + openid + "'";
			
			ResultSet rs1 = db.selectSQL(select);
			if(!rs1.next()){

			if (db1.updateSQL(update) == true) {
				
				out.print("<h1>您的微信号"+nickname+"已经成功绑定工号"+username+"<h1>");
				
			}
			}else{
			out.print("<h1>改账号已被绑定，请联系工会管理员或重新绑定！<h1>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.println(e);
		} finally {
			db1.deconnSQL();
		}	
	
	}
	
	
}
%>
</body>
</html>
