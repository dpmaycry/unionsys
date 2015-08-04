package org.dp.wechat.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dp.database.DatebaseHandler;

/**
 * Servlet implementation class AddInfo
 */
public class AddInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub.
		
		HttpSession session = request.getSession(false);
		String user="";
		if(session!=null) 
		{ 
		user = (String)session.getAttribute("username");	
		} 
		
		String ling=request.getParameter("val");
	       String id2=request.getParameter("id");
	       System.out.println(id2+ling);
	       int lingqu=Integer.parseInt(ling);
	       DatebaseHandler dh=new DatebaseHandler();
	       String ans="true";
	       dh.connSQL();
	       try{
	     //  String update = "insert into sign(member_number,gift_taken) values("+id2+",'"+lingqu+"')";
	    	   String name="";
	    	   int activityid=0;
	    	   String select1 = "select * from member where member_number='"+id2+"'";
				ResultSet resultSet1 = dh.selectSQL(select1);
				while (resultSet1.next()) {
					name = resultSet1.getString("member_name");

				}
				
				String select2 = "select * from activity order by activity_id desc limit 0,1";
				ResultSet resultSet2 = dh.selectSQL(select2);
				while (resultSet2.next()) {
					activityid = resultSet2.getInt("activity_id");
				}
	    	   
	       String insert = "insert into sign(activity_id,member_name,member_number,gift_taken,group_id) values("+activityid+",'"+name+"','"+id2+"',"+lingqu+",'"+user+"')";
	       dh.insertSQL(insert);
	       }
	       catch(Exception e)
	       {
	    	   ans="false";
	    	   
	    	   
	       }
	       finally
	       {
	    	 response.setContentType("text/xml; charset=UTF-8"); 
	  	     response.setCharacterEncoding("UTF-8");
	  	     response.setHeader("Cache-Control","no-cache"); 
	  	     StringBuffer sb = new StringBuffer();
	  	     PrintWriter out=response.getWriter();
	  	     out.print(ans);
	  	     out.close();
	    	   
	    	 dh.deconnSQL();
	       }
	       			       		
	       
		
		
	}

}
