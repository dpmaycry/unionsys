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
	function saveCode() {
		//alert("${pageContext.request.contextPath}");
		//window.location.href="${pageContext.request.contextPath}"+"/PoiExport"
		window.location.href="PoiExport";
	}
	function actOnactnum(){
		var selectItem=$("#actnum option:selected").val();
		if(selectItem=="all"){
			$("tr").show();
			return;
		}
		$("tr[actid='"+selectItem+"']").show();
		$("tr[actid!='"+selectItem+"']").not(":first").hide();	
//		var ling=$("td[class='1']:visible").length;
//		var weiLing=$("td[class='0']:visible").length;
//		var yi_yi = $("td[dep='1-1']:visible").length;
//		var yi_er = $("td[dep='1-2']:visible").length;
//		var yi_san = $("td[dep='1-3']:visible").length;
//		var yi_si = $("td[dep='1-4']:visible").length;
//		var er_yi = $("td[dep='2-1']:visible").length;
//		var er_er = $("td[dep='2-2']:visible").length;
//		var er_san = $("td[dep='2-3']:visible").length;
//		var er_si = $("td[dep='2-4']:visible").length;
//		var san_yi = $("td[dep='3-1']:visible").length;
//		var san_er = $("td[dep='3-2']:visible").length;
//		var san_san = $("td[dep='3-3']:visible").length;
//		var san_si = $("td[dep='3-4']:visible").length;	
	}
	function actOnactname(){
		var selectItem=$("#actname option:selected").val();
		if(selectItem=="all"){
			$("tr").show();
			return;
		}
		$("tr[actname='"+selectItem+"']").show();
		$("tr[actname!='"+selectItem+"']").not(":first").hide();
	}
	function actOnactdate(){
		var selectItem=$("#actdate option:selected").val();
		if(selectItem=="all"){
			$("tr").show();
			return;
		}
		$("tr[actdate='"+selectItem+"']").show();
		$("tr[actdate!='"+selectItem+"']").not(":first").hide();	
	}
</script>
<title></title>
</head>
<body>
<%@ include file="navbar.jsp" %>

	<div>
	
		
			

	
		根据领礼物情况选择：
		<select id="gift_given" onchange="giftOnchange()">
			<option value="all">全部</option>
			<option value="1">领过礼物</option>
			<option value="0">未领过礼物</option>
		</select>		
  		<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
			url="jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_unionsys?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull" user="4wny3w3o25"
			password="l3yzlwm4ymzx23y15h0h53l345x05w32mjwwjk1l" />
			
		根据活动id选择：	
		<sql:query var="result1" sql="select distinct activity_id from sign;" dataSource="${ds}">		
		</sql:query>		
		<select id="actnum" onchange="actOnactnum()">
			<option value="all">全部</option>
			<c:forEach var="row" items="${result1.rows}">
				<option value="${row.activity_id}">${row.activity_id}</option>			
			</c:forEach>
		</select>
		
		根据活动名称选择：
		<sql:query var="result2" sql="select distinct activity_name from activity;" dataSource="${ds}">		
		</sql:query>
		<select id="actname" onchange="actOnactname()">
			<option value="all">全部</option>
			<c:forEach var="row" items="${result2.rows}">
				<option value="${row.activity_name}">${row.activity_name}</option>			
			</c:forEach>
		</select>
		
		根据活动时间选择：
		<sql:query var="result3" sql="select date1 from activity;" dataSource="${ds}">		
		</sql:query>
		<select id="actdate" onchange="actOnactdate()">
			<option value="all">全部</option>
			<c:forEach var="row" items="${result3.rows}">
				<option value="${row.date1}">${row.date1}</option>			
			</c:forEach>
		</select>	
			
		<input type="button" value="导出 Excel" onclick="saveCode()">	
		
	
		<sql:query var="rs" sql="select a.activity_id,a.activity_name,a.date1,b.member_name,b.member_number,b.department,b.gender,c.gift_taken from activity a,member b,sign c where a.activity_id = c.activity_id and b.member_number = c.member_number order by c.sign_id desc;" dataSource="${ds}">
		
		</sql:query>
	  </div> <br>
		 <div class="table-responsive" id="tableExcel" >
  <table id="table_id" class="display">
		<thead>
			<tr >
				<th>活动编号</th>
				<th>活动名称</th>
				<th>活动时间</th>
				<th>员工名</th>
				<th>员工号</th>			
				<th>员工所在部门</th>
				<th>员工性别</th>
				<th>领礼品情况</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="row" items="${rs.rows}">
				<tr actid="${row.activity_id}" actname="${row.activity_name}" actdate="${row.date1}">
					<td>${row.activity_id}</td>
					<td>${row.activity_name}</td>
					<td>${row.date1}</td>
					<td>${row.member_name}</td>
					<td>${row.member_number}</td>
					<td dep="${row.department}">${row.department}</td>
					<td>${row.gender}</td>
					<td class="${row.gift_taken}"><c:choose>
							<c:when test="${row.gift_taken=='0'}">
 							未领
 						</c:when>
							<c:otherwise>已领</c:otherwise>
						</c:choose></td>				
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