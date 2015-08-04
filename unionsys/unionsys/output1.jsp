<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
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
    
<script type="text/javascript">
$(function() {

    $("#nav_li_output").addClass("active");});


	function giftOnchange() {	
		var selectText = $("#gift_given").val();
		if (selectText == "all") {
			$("td[class='0']").parent().show();
			$("td[class='1']").parent().show();
		} else if (selectText == 1) {
			$("td[class='0']").parent().hide();
			$("td[class='1']").parent().show();
		} else {
			$("td[class='1']").parent().hide();
			$("td[class='0']").parent().show();
		}
	}
	function saveCode(obj) {
		var winname = window.open('', '_blank', 'top=10000');
		var strHTML = document.all.tableExcel.innerHTML;
		winname.document.open('text/html', 'replace');
		winname.document.writeln(strHTML);
		winname.document.execCommand('saveas', '', 'excel.xls');
		winname.close();
	}
	function actOnchange(){
		var selectItem=$("#actnum option:selected").val();
		$("tr[actid='"+selectItem+"']").show();
		$("tr[actid!='"+selectItem+"']").not(":first").hide();
		var ling=$("td[class='1']:visible").length;
		var weiLing=$("td[class='0']:visible").length;
		var yi_yi = $("td[dep='1-1']:visible").length;
		var yi_er = $("td[dep='1-2']:visible").length;
		var yi_san = $("td[dep='1-3']:visible").length;
		var yi_si = $("td[dep='1-4']:visible").length;
		var er_yi = $("td[dep='2-1']:visible").length;
		var er_er = $("td[dep='2-2']:visible").length;
		var er_san = $("td[dep='2-3']:visible").length;
		var er_si = $("td[dep='2-4']:visible").length;
		var san_yi = $("td[dep='3-1']:visible").length;
		var san_er = $("td[dep='3-2']:visible").length;
		var san_san = $("td[dep='3-3']:visible").length;
		var san_si = $("td[dep='3-4']:visible").length;		
	}
</script>
<title></title>
</head>
<body>
<%@ include file="navbar.jsp" %>

	<div>
		<select id="gift_given" onchange="giftOnchange()">
			<option value="all">全部</option>
			<option value="1">领过奖品</option>
			<option value="0">未领过奖品</option>
		</select>
		 
		
		<input type="button" value="导出 Excel" onclick="saveCode(tableExcel)">
		
		<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
			url="jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_unionsys?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull" user="4wny3w3o25"
			password="l3yzlwm4ymzx23y15h0h53l345x05w32mjwwjk1l" />

		<sql:query var="result" sql="select distinct activity_id from sign;" dataSource="${ds}">
		
		</sql:query>
		<select id="actnum" onchange="actOnchange()">
			<c:forEach var="row" items="${result.rows}">
				<option value="${row.activity_id}">${row.activity_id}</option>			
			</c:forEach>
		</select>
			
		<sql:query var="rs" sql="select * from sign;" dataSource="${ds}">
		
		</sql:query>
	  </div> <br>
		 <div class="table-responsive" id="tableExcel" >
  <table id="table_id" class="display">
		<thead>
			<tr >
				<th>活动编号</th>
				<th>用户名</th>
				<th>编号</th>
				<th>部门</th>
				<th>领奖情况</th>
				<th>性别</th>
				<th>名族</th>
				<th>所交会费</th>
				<th>加入公司时间</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="row" items="${rs.rows}">
				<tr actid="${row.activity_id}">
					<td>${row.activity_id}</td>
					<td>${row.member_name}</td>
					<td>${row.member_number}</td>
					<td>${row.department}</td>
					<td class="${row.gift_taken}"><c:choose>
							<c:when test="${row.gift_taken=='0'}">
 							未领
 						</c:when>
							<c:otherwise>已领</c:otherwise>
						</c:choose></td>
					<td>${row.gender}</td>
					<td>${row.nation}</td>
					<td>${row.dues}</td>
					<td>${row.join_date}</td>	
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
	</div>
	      <footer>
   
    <p>Copyright © 2015 FNST</p>
   </footer>
	
	 <script>
    $(document).ready( function () {
    $('#table_id').DataTable({
    	columnDefs:[{
     	   orderable:true,
          
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
</script>
</body>
</html>