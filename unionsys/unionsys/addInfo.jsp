<%@ page language="java" import="org.dp.database.*,java.util.*,java.sql.Date,java.math.*,org.dp.wechat.service.* " contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%
if((String)session.getAttribute("username")==null){
		  request.setAttribute("loginfail","true");
%>
	<jsp:forward page="login.jsp" />
<%	
}
%>
<%request.setCharacterEncoding("utf-8"); 
  String publisher = (String)session.getAttribute("username");
  
//获取活动信息  
  String activity_name = new String(request.getParameter("activity_name"));
  String date1 = request.getParameter("date1");
  String start_time = request.getParameter("start_time");
  String stop_time = request.getParameter("stop_time");
  String place=new String(request.getParameter("place"));
  String content=new String(request.getParameter("content"));
  String notice=new String(request.getParameter("notice"));
  
  String gift=new String(request.getParameter("gift"));
  Integer gift_pre_num =Integer.parseInt(request.getParameter("gift_pre_num"));
    
  activityDao.insert("insert into activity (activity_name,date1,start_time,stop_time,place,content,notice,gift,gift_pre_num,publisher) values ('"+activity_name+"','"+date1+"','"+start_time+"','"+stop_time+"','"+place+"','"+content+"','"+notice+"','"+gift+"','"+gift_pre_num+"','"+publisher+"')"); 
  
  
  String sql2 = "select * from user_table where unionno != 0";
  ArrayList<String> list= activityDao.select(sql2);
  
   {
 	 for (Iterator<String> it = list.iterator(); it.hasNext();){
 		
 	 	CoreService.send_template_message(it.next().toString(),activity_name, date1, place, notice, publisher);
 	 }
   }
  response.sendRedirect("list.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>addInfo.jsp start page</title>
</head>
<body>
 添加成功！
<br>
</body>
</html>