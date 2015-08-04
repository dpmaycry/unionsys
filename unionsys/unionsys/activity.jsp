<%@ page language="java" import="org.dp.database.*,java.util.*,java.util.ArrayList" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ page import="org.dp.database.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head meta="utf-8">

<title>活动详情</title>
 <style type="text/css">
   .setFont{
         
        }
        </style>

</head>
<body>
<%
String selectStatement = "select * from activity order by activity_id desc limit 0,1" ;
DatebaseHandler db2 = new DatebaseHandler();
db2.connSQL();
ResultSet rs2 = db2.selectSQL(selectStatement);
String activity_name = "";
String date = "";
String start_time = "";
String stop_time = "";
String place = "";
String content = "";
String notice = "";
String publisher = "";
if(rs2.next()){
	activity_name = rs2.getString("activity_name");
	date = rs2.getString("date1");
	start_time = rs2.getString("stop_time");
	stop_time = rs2.getString("stop_time");
	place = rs2.getString("place");
	content = rs2.getString("content");
	notice = rs2.getString("notice");
	publisher = rs2.getString("publisher");
}
String[] contentSplit = content.split("。");
String[] noticeSplit = notice.split("。");
db2.deconnSQL();
%>

<h1><%=activity_name %></h1>
<br>
<h3>各位公会会员：</h3>
<br>
<p>FNST公会将开展新的活动，相关信息如下：</p>
<br>
<ol class="setFont">
<li > <font size=3>活动时间</font></li>
<p ><font color="blue"><b>
时间：<%=date %> <%=start_time %> 至 <%=stop_time %></b></font></p>
<li><font size=3>活动内容说明</font></li>
<%
for(int i= 0;i<contentSplit.length;i++){
%>
    <P><%= contentSplit[i]+"。"%></P>
<%
}
%>
<li><font size=3>活动注意事项</font></li>
<font color="#FF0000"><b>
<%
for(int i= 0;i<noticeSplit.length;i++){
%>
    <P><%=noticeSplit[i]+"。"%></P>
<%
}
%>
</b>
</font>
</ol>
<p>上述活动特此通知，欢迎大家积极参与，谢谢。</p>
<p>FNST公会) <%=publisher %></p>
 <footer>
    
    <p>Copyright © 2015 FNST</p>
   </footer>
</body>
</html>