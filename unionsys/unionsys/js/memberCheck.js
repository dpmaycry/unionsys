function member_check(){
	var member_number = document.getElementById("member_number").value;
	var member_name = document.getElementById("member_name").value;
	var department = document.getElementById("department").value;
	var gender = document.getElementById("gender").value;
	var nation = document.getElementById("nation").value;
	var dues = document.getElementById("dues").value;
	var join_date = document.getElementById("join_date").value;
	var WeChat = document.getElementById("WeChat").value;
	var insertFlag = true;
	var errorFields = "";
	if(!/^[0-9]+$/.test(member_number)){		
		 errorFields += " 工号 ";
		 insertFlag = false;	
	 }	
	 if(!/^[\u4e00-\u9fa5]+$/.test(member_name)){
		 errorFields += " 姓名 ";
		 insertFlag = false;
	 }		
	 if(!/^[0-9]+-[0-9]+$/.test(department)){
		 errorFields += " 部门 ";
		 insertFlag = false;
	 }		 
	 if(!/[男]|[女]/.test(gender)){
		 errorFields += " 性别 ";
		 insertFlag = false;
	 }		 
	 if(!/^[\u4e00-\u9fa5]+$/.test(nation)){
		 errorFields += " 民族 ";
		 insertFlag = false;
	 }		 
	 if(!/^[0-9]+$/.test(dues)){
		 errorFields += " 会费 ";
		 insertFlag = false;
	 }						
	 if(!/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/.test(join_date)){
		 errorFields += " 入会时间 ";
		 insertFlag = false;
	 }
	 if(!/[\da-zA-Z]*/.test(WeChat)){
		 errorFields += " 微信 ";
		 insertFlag = false;
	 }
	 if(!insertFlag){
		 alert(" 插入失败： " + errorFields + "错误！");
		 return false;
	 }
}