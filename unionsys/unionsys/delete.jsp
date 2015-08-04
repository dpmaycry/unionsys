<%@ page language="java" import="org.dp.database.*,java.util.*,java.sql.Date" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%
if((String)session.getAttribute("username")==null){
		  request.setAttribute("loginfail","true");
%>
	<jsp:forward page="login.jsp" />
<%	
}
%>
<%
 //获得要删除活动的id并删除
  Integer activity_id=new Integer(Integer.parseInt(new String(request.getParameter("activity_id"))));
  activityDao.delete(activity_id);
   
  response.sendRedirect("list.jsp");//转到list.jsp页面
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>delete.jsp start page</title>
</head>
<body>
 this is my jsp page！
<br>
</body>
</html>