<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ page import="org.dp.excel2db.*,java.util.*" %>
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
request.setCharacterEncoding("utf-8"); 
Member member = new Member();
member.setMember_number(request.getParameter("member_number"));
member.setMember_name(request.getParameter("member_name"));
member.setDepartment(request.getParameter("department"));
member.setGender(request.getParameter("gender"));
member.setNation(request.getParameter("nation"));
member.setDues(Integer.valueOf(request.getParameter("dues")));
member.setJoin_date(request.getParameter("join_date"));
member.setWeChat(request.getParameter("WeChat"));

List l = DbUtil.selectOne(Common.SELECT_MEMBER_SQL + member.getMember_number(), member);
if(l.contains(1)){
	System.out.println(l.contains(1));
%>
<script type="text/javascript" >
var member = <%=request.getParameter("member_number")%>;
alert(" 添加失败： 工号为 " + '<%=request.getParameter("member_number")%>' + " 的记录已存在！");
window.history.go(-1); 
</script>	
<%	
}else{
	MemberDao.insertMember(member);
	response.sendRedirect("userChange.jsp");
}						
%>
</body>
</html>