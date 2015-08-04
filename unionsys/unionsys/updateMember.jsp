<%@ page language="java" import="org.dp.database.*,java.util.*,java.util.ArrayList" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ page import="org.dp.excel2db.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html meta="utf-8">
<head>
<script src="js/memberCheck.js" type="text/javascript" ></script>
<title>修改会员信息</title>
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
String member_id = request.getParameter("member_id");
ArrayList<Member> list = MemberDao.getMemberList("select * from member where member_id=" + member_id );
Member member = (Member)list.get(0);
%>
<%@ include file="navbar.jsp" %>
<form class="form-horizontal"  name="myform" action="updateMemberInfo.jsp" method="post" onsubmit="return member_check()">

    <h3>   修改会员信息：</h3>
    <div class="form-group">
        <label class="col-sm-2 control-label"> 工号：</label>
        <div class="col-sm-5">
            <input type="text" id="member_number" name="member_number" class="form-control" value = "<%=member.getMember_number() %>">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">姓名：</label>
        <div class="col-sm-5">
            <input type="text" id="member_name" name="member_name" class="form-control" value = "<%=member.getMember_name() %>" >
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">性　別</label>
        <div class="col-sm-5">
            <select class="form-control" id="gender" name="gender" value = "<%=member.getGender() %>">
                <option value="男" selected="selected">男</option>
                <option value="女">女</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 control-label">  部门：</label>
        <div class="col-sm-5">
            <input type="text" id="department" name="department" class="form-control" value = "<%=member.getDepartment() %>" >
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label"> 民族：</label>
        <div class="col-sm-5">
            <input type="text" id="nation" name="nation"class="form-control" value = "<%=member.getNation() %>">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">    会费：</label>
        <div class="col-sm-5">
            <input type="text" id="dues" name="dues" class="form-control" value = "<%=member.getDues() %>">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">  入会日期：</label>
        <div class="col-sm-5">
            <input type="date" id="join_date" name="join_date" class="form-control" value = "<%=member.getJoin_date() %>">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">  微信：</label>
        <div class="col-sm-5">
            <input type="text" id="WeChat" name="WeChat" class="form-control" value = "<%=member.getWeChat() %>">
        </div>
    </div>

    <div class="col-sm-5 col-md-offset-7">
        <input type="hidden"id="member_id" name="member_id" value = "<%=member.getMember_id() %>"/>
        <input type="hidden"id="member_number_old" name="member_number_old" value = "<%=member.getMember_number() %>"/>
        <button type="submit"  name="submit" class="btn btn-default">提交</button>
    </div>

</form>
</body>
<footer>
  
    <p>Copyright © 2015</p>
   </footer>
</html>