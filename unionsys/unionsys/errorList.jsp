<%@ page language="java" import="org.dp.database.*,java.util.*,java.util.ArrayList" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html meta="utf-8">
<head>
<title>信息导入错误页面</title>
</head>
<body>
<%
if((String)session.getAttribute("username")==null){
		  request.setAttribute("loginfail","true");
%>
	<jsp:forward page="login.jsp" />
<%	
}
%>
<%@ include file="navbar.jsp" %>
<%

List<String> errorList = (List<String>)request.getAttribute("errorList");
for(Iterator<String> i = errorList.iterator();i.hasNext(); ){
	String str = (String) i.next();
	out.print(str);
	out.println("<br>");
}
%>
<br>
<br>
<br>
  <footer>
    
    <p>Copyright © 2015 FNST</p>
   </footer>
</body>
</html>