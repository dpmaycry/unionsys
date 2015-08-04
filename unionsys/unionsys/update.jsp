<%@ page language="java" import="org.dp.database.*,java.util.*,java.util.ArrayList" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ page language="java" import="org.dp.database.*,java.util.*,java.sql.Date" 
    %>
    <%
    //获得要修改活动的id
     Integer activity_id = new Integer(Integer.parseInt(new String(request.getParameter("activity_id"))));
   
    //查询要修改活动的信息 
     ArrayList list = activityDao.getUserList("select * from activity where activity_id=" + activity_id );
     Activity_Table s = (Activity_Table)list.get(0);//将列表内容转成活动类
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html meta="utf-8">
<head>

<title>修改活动信息</title>
<script>
function formcheck(){
	//var reg1=new RegExp("[\u4e00-\u9fa5]");//中文
	//var reg2=new RegExp("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");  
	var reg3=new RegExp("^[1-9]d*|0$");//非负整数
	if (document.myform.activity_name.value==""){
	    alert('活动名称不能为空！')
	    document.myform.activity_name.focus();
	    return false;
	  }
	if (document.myform.date1.value==""){
	    alert('对不起,日期不能为空！')
	    document.myform.date1.focus();
	    return false;
	  }
  if (document.myform.start_time.value==""){
	    alert('对不起,请选择开始时间！')
	    document.myform.start_time.focus();
	    return false;
	  }
  if (document.myform.stop_time.value==""){
	    alert('对不起,请选择结束时间！')
	    document.myform.stop_time.focus();
	    return false;
	  }
  if (document.myform.stop_time.value<=document.myform.start_time.value){
	    alert('结束时间应晚于于开始时间！')
	    document.myform.stop_time.focus();
	    return false;
	  }
  if (document.myform.place.value==""){
	    alert('活动地点不能为空！')
	    document.myform.place.focus();
	    return false;
	  }
  if (document.myform.content.value==""){
	    alert('活动内容不能为空！')
	    document.myform.content.focus();
	    return false;
	  }
  if (document.myform.notice.value==""){
	    alert('注意事项不能为空！')
	    document.myform.notice.focus();
	    return false;
	  }
  if (document.myform.gift.value==""){
	    alert('礼品不能为空！')
	    document.myform.gift.focus();
	    return false;
	  }
  if(document.myform.gift_real_num.value!="")
  {
 
   if (!reg3.test(document.myform.gift_real_num.value)){
	    alert('实际礼品数量输入错误！')
	    document.myform.gift_real_num.focus();
	    return false;
  }
}
 }
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
  <%@ include file="navbar.jsp" %>
  <form class="form-horizontal" name="myform" method="post" action="updateInfo.jsp" onSubmit="return formcheck()">

<h3> 修改活动信息</h3>
<div class="form-group">
    <label class="col-sm-2 control-label">活动名称：</label>
    <div class="col-sm-5">
        <input type="text" name = "activity_name" value = "<%=s.getActivity_name() %>" class="form-control">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 control-label">活动日期：</label>
    <div class="col-sm-5">
        <input type="date" name="date1" class="form-control" value = "<%=s.getDate1() %>">
    </div>
</div>

<div class="form-group">
    <label class="col-sm-2 control-label"> 活动开始时间：</label>
    <div class="col-sm-5">
        <input name="start_time" class="form-control" type="time" value = "<%=s.getStart_time() %>">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 control-label">  活动结束时间：</label>
    <div class="col-sm-5">
        <input name="stop_time" class="form-control" type="time" value = "<%=s.getStop_time() %>">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 control-label">   地点：</label>
    <div class="col-sm-5">
        <input type="text" name="place" class="form-control" value = "<%=s.getPlace() %>">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 control-label">活动内容：</label>
    <div class="col-sm-5">
        <textarea name="content" class="form-control"   style="width:500px;height:100px" ><%=s.getContent() %></textarea>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 control-label"> 注意事项：</label>
    <div class="col-sm-5">
        <textarea name="notice" class="setText"  style="width:500px;height:100px" ><%=s.getNotice() %></textarea>

    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 control-label" >   礼品名：</label>
    <div class="col-sm-5">
        <input type="text" name="gift" class="form-control" value = "<%=s.getGift() %>">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 control-label" >   预测礼品数：</label>
    <div class="col-sm-5">
        <input type="text" name="gift_pre_num" class="form-control" value = "<%=s.getGift_pre_num() %>">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 control-label">   实到人数：</label>
    <div class="col-sm-5">
        <input type="text" name="gift_real_num" class="form-control" value = "<%=s.getGift_real_num() %>">
    </div>
</div>
<div class="col-sm-5 col-md-offset-7">
  	<input type="hidden" name = "activity_id" value = "<%=activity_id%>">
    <button type="submit"  name="submit" class="btn btn-default">提交</button>
</div>
</form>


    <footer>
    
    <p>Copyright © 2015 Fnst</p>
   </footer>
</body>
</html>