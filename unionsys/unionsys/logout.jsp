<%@ page contentType="text/html; charset=UTF-8" %>
<html><head><title>logout</title></head>
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
session.invalidate(); 
response.sendRedirect("login.jsp");
%>

</body></html>
