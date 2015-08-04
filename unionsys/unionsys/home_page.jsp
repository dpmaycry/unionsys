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
if((String)session.getAttribute("username")==null){
	String openid = request.getParameter("openid");
	String nickname = request.getParameter("nickname");
	String username = request.getParameter("username");
	session.setAttribute("username",username);
	String password = request.getParameter("password");
	String selectStatement = "select * from admin where admin_name=" + "\"" + username +"\"" + "and password=" + "\"" + password +"\"" ;
	DatebaseHandler db = new DatebaseHandler();
	db.connSQL();
	ResultSet rs = db.selectSQL(selectStatement);
	if(!rs.next()){
		  request.setAttribute("loginfail","true");
	%>
	<jsp:forward page="login.jsp" />
	<%
	}
}

%>  <%@ include file="navbar.jsp" %>
    <%@ include file="activity.jsp" %>
</body>
</html>
