<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<head>  
    <META http-equiv=Content-Type content="text/html; charset="UTF-8">  
  </head> 
    <mce:style type="text/css"><!--
/* CSS Document */
body {
 font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
 background: #E6EAE9;
}
a {
 color: #c75f3e;
}
#mytable {
 width: 700px;
 padding: 0;
 margin: 0;
}
caption {
 padding: 0 0 5px 0;
 width: 700px; 
 font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 text-align: right;
}
th {
 font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 letter-spacing: 2px;
 text-transform: uppercase;
 text-align: left;
 padding: 6px 6px 6px 12px;
 background: #CAE8EA url(images/bg_header.jpg) no-repeat;
}
th.nobg {
 border-top: 0;
 border-left: 0;
 border-right: 1px solid #C1DAD7;
 background: none;
}
td {
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 background: #fff;
 font-size:11px;
 padding: 6px 6px 6px 12px;
 color: #4f6b72;
}

td.alt {
 background: #F5FAFA;
 color: #797268;
}
th.spec {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 background: #fff url(images/bullet1.gif) no-repeat;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
}
th.specalt {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 background: #f5fafa url(images/bullet2.gif) no-repeat;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #797268;
}
/*---------for IE 5.x bug*/
html>body td{ font-size:11px;}
--></mce:style><style type="text/css" mce_bogus="1">/* CSS Document */
body {
 font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
 background: #E6EAE9;
}
a {
 color: #c75f3e;
}
#mytable {
 width: 700px;
 padding: 0;
 margin: 0;
}
caption {
 padding: 0 0 5px 0;
 width: 700px; 
 font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 text-align: right;
}
th {
 font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 letter-spacing: 2px;
 text-transform: uppercase;
 text-align: left;
 padding: 6px 6px 6px 12px;
 background: #CAE8EA url(images/bg_header.jpg) no-repeat;
}
th.nobg {
 border-top: 0;
 border-left: 0;
 border-right: 1px solid #C1DAD7;
 background: none;
}
td {

 background: #fff;
 font-size:11px;
 padding: 6px 6px 6px 12px;
 color: #4f6b72;
}

td.alt {
 background: #F5FAFA;
 color: #797268;
}
th.spec {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 background: #fff url(images/bullet1.gif) no-repeat;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
}
th.specalt {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 background: #f5fafa url(images/bullet2.gif) no-repeat;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #797268;
}
/*---------for IE 5.x bug*/
/*---------for IE 5.x bug*/  
html>body td{ font-size:11px;}</style> 
<script language="javascript">  
      
    var XMLHttpReq;  
        //创建XMLHttpRequest对象         
        function createXMLHttpRequest() {  
            if(window.XMLHttpRequest) { //Mozilla 浏览器  
                XMLHttpReq = new XMLHttpRequest();  
            }  
            else if (window.ActiveXObject) { // IE浏览器  
                try {  
                    XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");  
                } catch (e) {  
                    try {  
                        XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");  
                    } catch (e) {}  
                }  
            }  
        }  
        //发送请求函数  
      
        function send1() {  
        	
            createXMLHttpRequest(); 
       
            var url = "CurrentInfo";  
           
            XMLHttpReq.open("GET", url, true);  
            XMLHttpReq.onreadystatechange = processResponse1;//指定响应函数  
            XMLHttpReq.send(null);  // 发送请求  
        }  
        
        
      function send2() {  
        	
            createXMLHttpRequest(); 
            
            var url = "Erweima";
           
            XMLHttpReq.open("GET", url, true);  
            XMLHttpReq.onreadystatechange = processResponse;//指定响应函数  
            XMLHttpReq.send(null);  // 发送请求  
        }  
        
        
        // 处理返回信息函数  
        function processResponse() {  
        	
            if (XMLHttpReq.readyState == 4) { // 判断对象状态  
                if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
                	
                    DisplayHot();  
                   
                } else { //页面不正常  
                   
                }  
            }  
        }  
        
        function processResponse1() {  
        
            if (XMLHttpReq.readyState == 4) { // 判断对象状态  
                if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
                	
                    DisplayHot1();  
                    setTimeout("send1()", 2000);  
                } else { //页面不正常  
                   
                }  
            }  
        }  
        
        function DisplayHot() {  
                var tab = XMLHttpReq.responseText;
            
            document.getElementById("ewm").innerHTML=tab;  
            
        }  
        function DisplayHot1() {  
         
            var tab = XMLHttpReq.responseText;
          
             
            document.getElementById("old").innerHTML=tab;     
              
            
        }  
        function send3(id) {    
        	
        	var name=document.getElementById("adname").value  
        	if(name==""){ 
        		alert("员工号不能为空")   
        		}else{    
        			createXMLHttpRequest(); 
                   
                     var url = "AddInfo?id="+name+"+&val="+id; 
                   
                    XMLHttpReq.open("GET", url, true);  
                    XMLHttpReq.onreadystatechange = processResponse3;//指定响应函数  
                    XMLHttpReq.send(null);  // 发送请求  
        			 
        			document.getElementById("adname").value=""
        	}  
       }                    
        function processResponse3() {  
            
            if (XMLHttpReq.readyState == 4) { // 判断对象状态  
                if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
                	
                	var tab = XMLHttpReq.responseText;
                   if(tab=="true")
                	   {
                	     alert("插入成功")
                	     
                	   }
                   else
                   {
                	    alert("插入失败")
                	   
                   }
                    
                    
                	
                	
                	
                    
                } else { //页面不正常  
                      alert("插入失败")
                }  
            }  
        }  
        
    
       function gradeChange(id){
    	
    	var s=id.split("|");
       
        createXMLHttpRequest(); 
        
            var url = "HistoryInfo?id="+s[0]+"+&val="+s[1];  
           
            XMLHttpReq.open("GET", url, true); 
        
            XMLHttpReq.onreadystatechange = processResponse1;//指定响应函数  
            XMLHttpReq.send(null);  // 发送
        

       }
     
</script>

 <body  onload =send1()>  
  <%@ include file="navbar.jsp" %>
 <h2 id="lingCount"><h2>
  <center>
  <frameset rows="30%,50%,20%">
<frame  frameborder="1" >
 
    <button class="btn btn-primary" onclick=send2() >刷新二维码</button>
    <div id="ewm" > </div>
 
 </frame>
<HR style="FILTER: alpha(opacity=100,finishopacity=0,style=3)" width="80%" color=#987cb9 SIZE=3>
<frame  frameborder="1" >
<h1>正在签到的员工</h1>
<div id="old">
</div>
</frame>
<HR style="FILTER: alpha(opacity=100,finishopacity=0,style=3)" width="80%" color=#987cb9 SIZE=3>
<frame  frameborder="1" >
<h1>添加员工</h1> <div id="old"> 
<table border="1">   
<tr>  <th>员工号</th>    
 <th>领取礼物</th>   </tr>  
  <tr>  <td><input type="text" id=adname /></td>     <td> <button  id=1 onclick=send3(this.id)>领取</button>     <button  id=0 onclick=send3(this.id) >不领取</button> </tr>
  </table>
</frame>


</frameset>
   
     
 </center>
 
 <footer>
    
    <p>Copyright © 2015 FNST</p>
   </footer>
 <script >
     $(function() {

		$("#nav_li_showInfo").addClass("active")
		});
		</script>
    </body>
    </html>