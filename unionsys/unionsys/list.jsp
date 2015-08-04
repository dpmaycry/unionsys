<%@ page language="java" import="org.dp.database.*,java.util.*,java.util.ArrayList" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
    <% 
  
  String sql = "select * from activity";
  ArrayList list = activityDao.getUserList(sql); 
  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>活动信息</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- linl href="css/user-defined.css" rel="stylesheet"-->
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.js"></script>
	<script src="js/jquery-1.11.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
	  <!--  
	<script src="js/Highcharts-4.1.3/highcharts.js"></script>
	<script src="js/Highcharts-4.1.3/highcharts-more.js"></script>
	-->  
	<script type="text/javascript">
	$(function() {

        $("#nav_li_list").addClass("active");});


	 </script>
    <style type="text/css">
 footer {
            padding: 40px 0;
            color: #999;
            text-align: center;
            background-color: #f9f9f9;
            border-top: 1px solid #e5e5e5;
            margin-top:60px;
          
        }
        </style>


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
<div class="container">
 <input type="button" name="bottom" value="活动发布" class=" btn btn-primary"
         onclick="javascript:window.location.href='add.jsp'">
  <br>
  <br>
  <div class="table-responsive">
  <table id="table_id" class="display">
  <thead>
    <tr>
        <td>编号</td>
        <td>活动名称</td>
        <td>活动日期</td>
        <td>活动开始时间</td>
        <td>活动结束时间</td>
        <td>活动地点</td>
        <td>礼品</td>
        <td>预测礼品数</td>
        <td>实到人数</td>
        <td>参与率</td>
        <td>操作</td>
     </tr>
     </thead>
     <tbody>
     <%
     {
    	 int count = 1;
       for (Iterator it = list.iterator(); it.hasNext();){
        Activity_Table s = (Activity_Table) it.next();
      %>
      <tr>
        <td><%=count++%></td>
        <td><%=s.getActivity_name() %></td>
        <td><%=s.getDate1() %></td>
        <td><%=s.getStart_time()%></td>
        <td><%=s.getStop_time() %></td>
        <td><%=s.getPlace() %></td> 
        <td><%=s.getGift() %></td>
        <td><%=s.getGift_pre_num() %></td>
        <td><%=s.getGift_real_num() %></td>
        <td><%=s.getParticipation_rate() %></td>
        <td>
          <a href="update.jsp?activity_id=<%=s.getActivity_id()%>">修改</a>
          <a href="delete.jsp?activity_id=<%=s.getActivity_id()%>"
             onclick="return confirm('确定删除？');">删除</a>
        </td>
       </tr>
       <%   }
           }
       %>
       </tbody>
       </table>
       </div>
       </div>
  
    <footer>
    <p>Copyright © 2015 FNST</p>
   </footer>
         <script>
    $(document).ready( function () {
    $('#table_id').DataTable({
    	columnDefs:[{
     	   orderable:false,
            targets:[8]
        }],
        "aLengthMenu":[5,10,15,20],
        "oLanguage": {
            "sProcessing": "正在加载中......",
            "sLengthMenu": "每页显示 _MENU_ 条记录",
            "sZeroRecords": "对不起，查询不到相关数据！",
            "sEmptyTable": "表中无数据存在！",
            "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
            "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
            "sSearch": "搜索",
            "oPaginate": {
                "sFirst": "首页",
                "sPrevious": "上一页",
                "sNext": "下一页",
                "sLast": "末页"
            }  
        } //多语言配置
    });
    } );
   
    </Script>
 
    
</body>
</html>
