package org.dp.wechat.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dp.database.DatebaseHandler;




/**
 * Servlet implementation class HistoryInfo
 */
@WebServlet("/HistoryInfo")
public class HistoryInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HistoryInfo() {
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
       dh.connSQL();
       String update = "update sign set gift_taken="+lingqu+" where member_number='"+id2+"'";
       System.out.println(update);
       dh.updateSQL(update);
       ResultSet  rst=dh.selectSQL("select member_name,member_number from sign where gift_taken=3 and group_id="+user);
		 
	     response.setContentType("text/xml; charset=UTF-8"); 
	     response.setCharacterEncoding("UTF-8");
	     response.setHeader("Cache-Control","no-cache"); 
	     StringBuffer sb = new StringBuffer();
	     PrintWriter out=response.getWriter();
	  
	     sb.append("<table id=mytable cellspacing=0>");
	     sb.append("<caption>&nbsp;</caption>");
	   
	     sb.append("<tr><th scope=col >姓名</th><th scope=col abbr=Dual 1.8>工号</th><th scope=col abbr=Dual 2>领取礼物</th></tr>");
	     
	     int i=1;
	    try {
			while(rst.next())
			{
				sb.append("<tr>");
				 try {
					sb.append("<td id=mn"+i+">"+rst.getString("member_name")+"</td>");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				 String mem_num=null;
				 try {
					  mem_num=rst.getString("member_number");
					sb.append("<td id=mnu"+i+">"+mem_num+"</td>");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				 
				 sb.append("<td>"+"<button id="+mem_num+"|0"+" "+"onclick=gradeChange(this.id)>"+  "不领</button>");
				 sb.append("<button id="+mem_num+"|1"+" "+"onclick=gradeChange(this.id)>"+  "领取</button>"+"</td>");
				 
       
				 
				sb.append("</tr>");
				
				i++;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	       
	     sb.append("</table>");
	     
	     out.println(sb.toString());
	     System.out.println(sb.toString());
	     out.close();
		dh.deconnSQL();
	}
}
