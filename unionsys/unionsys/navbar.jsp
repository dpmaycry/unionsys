<%@ page language="java" import="org.dp.database.*,java.util.*,java.util.ArrayList" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title></title>
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
<table >
  <tr>
    <td width="300" height="30">&nbsp;</td>
    <td width="1000" align="right"><b>Hello</b>, <%=session.getAttribute("username") %> <a href="logout.jsp">注销</a></td>
  </tr>
  
  </table>
<div class="container">
<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="home_page.jsp">首页</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
	        <li id="nav_li_list"><a href="list.jsp">活动信息</a></li>
	  		<li id="nav_li_userChange"><a href="userChange.jsp" target="">会员信息</a></li>
	  		<li id="nav_li_showInfo"><a href="showInfo.jsp" target="">签到页面</a></li>
	  		<li id="nav_li_output"><a href="output.jsp" target="">数据分析及导出</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>


</body>
</html>