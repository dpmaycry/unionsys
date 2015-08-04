<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.dp.excel2db.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
    <title>会员信息</title>
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
    
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script type="text/javascript">
	$(function() {

        $("#nav_li_userChange").addClass("active");});


	 </script>
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
  <script type="text/javascript">  
  function check_fileType()
  {
	  var typeArr = new Array("xls","xlsx");
	  var fileObj = document.getElementById('file1');
      if (fileObj.value != "") {
          var type_count = 0;
          var pos = fileObj.value.lastIndexOf(".");
          var lastname = fileObj.value.substring(pos+1, fileObj.value.length);
          for (var i = 0; i < typeArr.length; i++) {
              if (lastname.toLowerCase() == typeArr[i])
              {
                  type_count++;
              }
          }
          if(type_count == 0){
        	  alert("请上传 " + typeArr.join(" 或 ") + "类型的文件!");
        	  fileObj.focus();
        	  return false;
          }
      } else {
          alert("请选择文件！");
          fileObj.focus();
          return false;
      }
  }
  function progress()
  {
	  document.getElementById("process").innerHTML="正在处理，请稍候...";
  }
  </script>
  <%
  String username = request.getParameter("username");
  String sql = "select * from member";
  ArrayList list = MemberDao.getMemberList(sql); 
%> 
<%@ include file="navbar.jsp" %>
  <form class="form-horizontal" name="upform" action="UploadServlet" method="post" enctype="multipart/form-data" onsubmit="return check_fileType()">
    <div class="form-group">
			<label class="col-sm-2 control-label">批量导入：</label>
			<div class="col-sm-5">
				<input class="form-control" type ="file" name="file1" id="file1" accept=".csv,.xls,.xlsx" onchange="check_fileType()" />
			</div>
			<button type="submit" class="btn btn-default" onclick="progress()">提交</button>
			<button type="reset" class="btn btn-default" >重置 </button>
			</div>
	<div class="form-group">	
   <div class="col-sm-5 col-sm-offset-1 control-label">
			<input   type="button" name="bottom" value="添加会员信息" class="col-sm-5 btn btn-primary"
         onclick="javascript:window.location.href='addMember.jsp'"><br>
       
       </div>  
       <div><p><b id="process"></b></p></div>
	</div>

  
  </form>
  
  
  <div class="table-responsive">
  <table id="table_id" class="display">
  <br>
   <thead>
    <tr>
        <th>编号</th>
        <th>工号</th>
        <th>姓名</th>
        <th>部门</th>
        <th>性别</th>
        <th>民族</th>
        <th>会费</th>
        <th>入会时间</th>
        <th>微信</th>
        <th>操作</th>
     </tr>
     </thead>
     <tbody>
     <%
     {
       int count = 1;
       for (Iterator it = list.iterator(); it.hasNext();){
        Member member = (Member)it.next();
      %>
      
      <tr>
      	<td><%=count++ %></td>
        <td><%=member.getMember_number() %></td>
        <td><%=member.getMember_name() %></td>
        <td><%=member.getDepartment() %></td>
        <td><%=member.getGender() %></td> 
        <td><%=member.getNation() %></td>
        <td><%=member.getDues() %></td>
        <td><%=member.getJoin_date() %></td>
        <td><%=member.getWeChat() %></td>
        <td>
          <a href="updateMember.jsp?member_id=<%=member.getMember_id() %>">修改</a>
          <a href="deleteMember.jsp?member_id=<%=member.getMember_id() %>"
             onclick="return confirm('确定删除？');">删除</a>
        </td>
       </tr>
       
       <%   }
           }
       %>
      </tbody>
       </table>
       </div>
         <footer>
  
    <p>Copyright © 2015</p>
   </footer>
  
         <script>
    $(document).ready( function () {
    $('#table_id').DataTable({
    	columnDefs:[{
     	   orderable:false,
            targets:[9]
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
    $(function() {

		$("#nav_li_userChange.jsp").addClass("active")
		});
    </Script>
   </body>
</html>
