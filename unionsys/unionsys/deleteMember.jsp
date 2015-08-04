<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ page import="org.dp.excel2db.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
<%
  MemberDao.deleteMember("delete from member where member_id=" + request.getParameter("member_id"));
  response.sendRedirect("userChange.jsp");
%>
</body>
</html>