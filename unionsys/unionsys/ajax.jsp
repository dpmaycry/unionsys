<%@ page contentType="text/html; charset=UTF-8" %>  
<%@ page import="org.dp.database.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>   
    <%  
    //设置输出信息的格式及字符集  
    response.setContentType("text/xml; charset=UTF-8");  
    response.setHeader("Cache-Control","no-  cache");  
    out.println("<response>");  
      
   int sign_id=0,activity_id=0;
    DatebaseHandler db = new DatebaseHandler();
	db.connSQL();
	try {
		String select = "select * from sign where gift_taken=3";
		ResultSet resultSet = db.selectSQL(select);
		while (resultSet.next()) {
			sign_id = resultSet.getInt("sign_id");
			activity_id = resultSet.getInt("activity_id");
		}
		
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("查询异常+e");
	} finally {
		db.deconnSQL();
	}
    out.println("<name>"+sign_id+  
       "号传感器</name>");  
    out.println("<count>" +activity_id+ "</count>");    
    out.println("</response>");  
    out.close();  
    %>