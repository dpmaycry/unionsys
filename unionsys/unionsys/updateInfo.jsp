<%@ page language="java" import="org.dp.database.*,java.util.*,java.sql.Date,java.math.*,org.dp.wechat.service.*" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); 
String publisher = (String)session.getAttribute("username");
Integer activity_id=new Integer(Integer.parseInt(new String(request.getParameter("activity_id"))));//接收信息

//String sql1="select avg(participation_rate) as rate_avg from activity where activity_id < '"+activity_id+"'";
//Double rate_avg=activityDao.avg_par(sql1);
String sql2 = "select count(*) as num from member";
Integer num = activityDao.total_num(sql2);
Integer gift_pre_num = Integer.parseInt(request.getParameter("gift_pre_num")); 
String activity_name = new String(request.getParameter("activity_name"));
String date1 = request.getParameter("date1");
String start_time = request.getParameter("start_time");
String stop_time = request.getParameter("stop_time");
String place=new String(request.getParameter("place"));
String content=new String(request.getParameter("content"));
String notice=new String(request.getParameter("notice"));
String gift=new String(request.getParameter("gift"));

 if (Integer.parseInt(request.getParameter("gift_real_num"))!=0){
	 //完善信息
	  Integer gift_real_num=new Integer(Integer.parseInt(new String(request.getParameter("gift_real_num"))));
	  double value=(double)gift_real_num/(double)num ;
	  java.math.BigDecimal bigdecimal = new BigDecimal(value);
	  double noTaxPrice = bigdecimal.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	  double participation_rate=noTaxPrice;
	  String sql = "update activity set activity_name='"+activity_name+"', date1='"+date1+"',start_time='"+start_time+"',stop_time='"+stop_time+"', place='"+place+"', content='"+content+"',notice='"+notice+"',gift='"+gift+"',  gift_pre_num='"+gift_pre_num+"', gift_real_num='"+gift_real_num+"', participation_rate='"+participation_rate+"' where activity_id='"+activity_id+"'";
	  activityDao.update(sql);//执行修改
	  
	 }
  else{
	  //修改已发布信息
	  activityDao.update("update activity set activity_name='"+activity_name+"', date1='"+date1+"',start_time='"+start_time+"',stop_time='"+stop_time+"', place='"+place+"',content='"+content+"',notice='"+notice+"', gift='"+gift+"',  gift_pre_num='"+gift_pre_num+"',  publisher='"+publisher+"' where activity_id='"+activity_id+"'"); 
	  String sql3 = "select * from user_table where unionno != 0";
	  ArrayList<String> list= activityDao.select(sql3);
	  	  
	   {
	 	 for (Iterator<String> it = list.iterator(); it.hasNext();){
	 		
	 	 	CoreService.send_template_message(it.next().toString(),activity_name, date1, place, notice, publisher);
	 	 }
	   }
  }
response.sendRedirect("list.jsp");//转到list.jsp
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>updateInfo start page</title>
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
 this is jsp page.
 <br>
</body>
</html>