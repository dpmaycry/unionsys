package org.dp.excel2db;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.SQLException;
import java.util.List;

/**
 * Servlet implementation class Excel2DB
 */
public class Excel2DBServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Excel2DBServlet() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=gb2312");  
		PrintWriter out = response.getWriter();
		Common.EXCEL_PATH = (String)request.getAttribute("excelFile");
		try {
			ReadExcel xlsMain = new ReadExcel();
			Member member = null;
			List<Member> list = xlsMain.readXls();

			for (int i = 0; i < list.size(); i++) {
				member = list.get(i);
				DbUtil.insert(Common.INSERT_MEMBER_SQL, member);
			}
			File file = new File(Common.EXCEL_PATH); 
			file.delete();
			List<String> errorList = xlsMain.geterrprList();
			if(errorList.isEmpty()){
				response.sendRedirect("userChange.jsp");
			}else{
				request.setAttribute("errorList", errorList);
		        RequestDispatcher dispatcher = request.getRequestDispatcher("errorList.jsp");
		        dispatcher.forward(request,response);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

}
