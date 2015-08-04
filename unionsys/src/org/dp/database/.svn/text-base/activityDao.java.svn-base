package org.dp.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class activityDao {
	private static Connection conn=null;
	private static Statement statement = null;
	public  static Connection conn(){

//		  String username = "root";
//		  String password = "admin";
//		  String urle = "jdbc:mysql://127.0.0.1:3306/new_schema?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull";
		  
			//此数据库设置为SAE云数据库使用
			String urle = "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_unionsys?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull";//port：3307 database:app_hellochat123
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
	
	public static ArrayList getUserList(String sql){
		
		  ArrayList list=new ArrayList();
		  try {
		   Connection conn= conn();
		   Statement stmt=conn.createStatement();
		 
		   ResultSet rs=stmt.executeQuery(sql);
		   while(rs.next()){
		    Activity_Table pro=new Activity_Table();
		    Integer activity_id=rs.getInt("activity_id");
		    pro.setActivity_id(activity_id);
		    String activity_name=rs.getString("activity_name");
		    pro.setActivity_name(activity_name);
		    String date1=rs.getString("date1");
		    pro.setDate1(date1);
		    String start_time=rs.getString("start_time");
		    pro.setStart_time(start_time);
		    String stop_time=rs.getString("stop_time");
		    pro.setStop_time(stop_time);
		    String place=rs.getString("place");
		    pro.setPlace(place);
		    String content=rs.getString("content");
		    pro.setContent(content);
		    String notice=rs.getString("notice");
		    pro.setNotice(notice);
		    String gift=rs.getString("gift");
		    pro.setGift(gift);
		    Double participation_rate=rs.getDouble("participation_rate");
		    pro.setParticipation_rate(participation_rate);
		    Integer gift_pre_num = rs.getInt("gift_pre_num");
		    pro.setGift_pre_num(gift_pre_num);
		    Integer gift_real_num=rs.getInt("gift_real_num");
		    pro.setGift_real_num(gift_real_num);
		    String publisher=rs.getString("publisher");
		    pro.setPublisher(publisher);
		    list.add(pro);
		   }
		   rs.close();
		   stmt.close();
		   conn.close();
		  } catch (SQLException e) {
		   
		   e.printStackTrace();
		  }
		  return list;
		 }
		
		 public static void delete(Integer activity_id){
		  String sql ="delete from activity where activity_id = '"+activity_id+"'";
		  Connection conn=conn();
		  try {
		   Statement stmt=conn.createStatement();
		   stmt.executeUpdate(sql);
		    stmt.close();
		    conn.close();
		  } catch (SQLException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		  }
		  
		 }
		 public static void insert(String sql){
			 Connection conn=conn();
			  try {
			   Statement stmt=conn.createStatement();
			 
			   stmt.executeUpdate(sql);
			   stmt.close();
			   conn.close();
			 } catch (SQLException e) {
			   // TODO Auto-generated catch block
			   e.printStackTrace();
			  }
		  
		 }
		 public static void update(String sql){
			
		  Connection conn=conn();
		  try {
		   Statement stmt=conn.createStatement();
		 
		   stmt.executeUpdate(sql);
		   stmt.close();
		   conn.close();
		 } catch (SQLException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		  }
		 }
		 
		 public static ArrayList<String> select(String sql){
			 ArrayList<String> list=new ArrayList<String>();
			  Connection conn=conn();
			  try {
			   Statement stmt=conn.createStatement();
			   ResultSet rs= stmt.executeQuery(sql);
			   while(rs.next()){
				   String openid = rs.getString("openid");
				  
				   list.add(openid);
			   }
			   rs.close();
			   stmt.close();
			   conn.close();
			 } catch (SQLException e) {
			   // TODO Auto-generated catch block
			   e.printStackTrace();
			  }
			  return list;
			 }
		 
		 public static int total_num(String sql){
				
			   Connection conn= conn();
			   int num = 0;
			  try {
				  Statement stmt=conn.createStatement();
				  ResultSet rs=stmt.executeQuery(sql);
				  
			  if(rs.next()){
				 num =rs.getInt("num");
				   }
			   stmt.close();
			   conn.close();
			 } catch (SQLException e) {
			   // TODO Auto-generated catch block
			   e.printStackTrace();
			  }
			  return num;
			}
		 
		 public static Double avg_par(String sql){
				
			   Connection conn= conn();
			   Double rate_avg = 0.0;
			  try {
				  Statement stmt=conn.createStatement();
				  ResultSet rs=stmt.executeQuery(sql);
				  
			  if(rs.next()){
				 rate_avg =rs.getDouble("rate_avg");
				   }
			   stmt.close();
			   conn.close();
			 } catch (SQLException e) {
			   // TODO Auto-generated catch block
			   e.printStackTrace();
			  }
			  return rate_avg;
			}
		 
		  public static void close(Connection conn){
		  try {
		   conn.close();
		  } catch (SQLException e) {
		  
		   e.printStackTrace();
		  }
		 }
		 
		}