package org.db.db2excel;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class PoiExport extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static Connection conn=null;
	private static Statement statement = null;
	private static ResultSet rs = null;
	public  static Connection conn(){
		  
//		String username = "root";
//		String password = "admin";
//		String urle = "jdbc:mysql://localhost:3306/yxdb?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull";
		  
		//此数据库设置为SAE云数据库使用
		String urle = "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_unionsys?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull";
		String username = "4wny3w3o25";//user
		String password = "l3yzlwm4ymzx23y15h0h53l345x05w32mjwwjk1l";//password
		try { 
				
			Class.forName("com.mysql.jdbc.Driver" );//加载驱动，连接数据库
			conn = DriverManager.getConnection(urle,username, password ); 
		}
		//捕获加载驱动程序异常
		catch ( ClassNotFoundException cnfex ) {
			System.out.println(
					"装载 JDBC/ODBC 驱动程序失败。" );
				cnfex.printStackTrace(); 
			} 
			//捕获连接数据库异常
		catch ( SQLException sqlex ) {
			System.out.println( "无法连接数据库" );
			sqlex.printStackTrace();
		}
		return conn;
	}

	@Override
	public void init() throws ServletException {
		conn();
	}

	public PoiExport() {
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println(System.currentTimeMillis()); 

		String exportFileName = "信息导出_"+System.currentTimeMillis()+".xls";//导出文件名

		//创建工作薄

		Workbook  wb =  new HSSFWorkbook();

		//c创建sheet

		Sheet createSheet = wb.createSheet("first");

		//创建第一行，标题

		Row row = createSheet.createRow(0);

		String[] cellTitle = {"活动编号", "活动名称", "活动时间", "员工名","员工号","员工所在部门","员工性别","领礼品情况"};

		for (int i = 0; i < cellTitle.length; i++) {

			createSheet.setColumnWidth(i,3500);

			Cell createCell = row.createCell(i);

			createCell.setCellValue(cellTitle[i]);

		}

		//构建数据

		Emp emp = new Emp();
		List<Emp> list = new ArrayList<Emp>();

		//从数据库中查询
		String sql = "select a.activity_id,a.activity_name,a.date1,b.member_name,b.member_number,b.department,b.gender,c.gift_taken from activity a,member b,sign c where a.activity_id = c.activity_id and b.member_number = c.member_number order by c.sign_id desc;";
		
		try {
			statement = conn.createStatement();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
	
		try {
			rs = statement.executeQuery(sql);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	
		
		try {
			while(rs.next()){
				String activity_id = rs.getString("activity_id");
				String activity_name = rs.getString("activity_name");
				String date1 = rs.getString("date1");
				String member_name = rs.getString("member_name");
				String member_number = rs.getString("member_number");
				String department = rs.getString("department");
				String gender = rs.getString("gender");
				String gift_taken = rs.getString("gift_taken");
				emp.setActivity_id(activity_id);
				emp.setActivity_name(activity_name);
				emp.setDate1(date1);
				emp.setDepartment(department);
				emp.setMember_name(member_name);
				emp.setMember_number(member_number);
				emp.setGender(gender);
				emp.setGift_taken(gift_taken);
				list.add(emp);
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		for(int i=1;i<list.size();i++)

		{

			Emp e = list.get(i);

			Row dataRow = createSheet.createRow((short) i);

			for (int j = 0; j < cellTitle.length; j++) 

			{

				Cell dataCell = dataRow.createCell(j);

				switch (j) {

				case 0:

					dataCell.setCellValue(e.getActivity_id());

					break;

				case 1:

					dataCell.setCellValue(e.getActivity_name());

					break;

				case 2:

					dataCell.setCellValue(e.getDate1());

					break;

				case 3:

					dataCell.setCellValue(e.getMember_name());

					break;  
					
				case 4:

					dataCell.setCellValue(e.getMember_number());

					break; 
					
				case 5:

					dataCell.setCellValue(e.getDepartment());

					break; 
					
				case 6:

					dataCell.setCellValue(e.getGender());

					break; 
					
				case 7:

					dataCell.setCellValue(e.getGift_taken());

					break; 
				}

			}

		}


		response.setHeader("Content-Disposition", "attachment;filename=" + new String((exportFileName).getBytes(), "ISO8859-1"));//设定输出文件头

		response.setContentType("application/vnd.ms-excel;charset=UTF-8");// 定义输出类型

		OutputStream out = response.getOutputStream();

		wb.write(out);

		out.flush();

		out.close();

	}

}