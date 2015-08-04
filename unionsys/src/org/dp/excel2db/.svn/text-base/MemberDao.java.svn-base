package org.dp.excel2db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.dp.database.*;

public class MemberDao {
	
	
	public static ArrayList<Member> getMemberList(String sql){
		ArrayList<Member> list=new ArrayList<Member>();
		try{
			Connection conn = null;
			DatebaseHandler db = new DatebaseHandler();
			conn = db.connSQL();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				Member member = new Member();
				Integer member_id = rs.getInt("member_id");
				member.setMember_id(member_id);
				String member_name = rs.getString("member_name");
				member.setMember_name(member_name);
				String member_number = rs.getString("member_number");
				member.setMember_number(member_number);				
				Integer dues = rs.getInt("dues");
				member.setDues(dues);				
				String department = rs.getString("department");
				member.setDepartment(department);				
				String gender = rs.getString("gender");
				member.setGender(gender);				
				String nation = rs.getString("nation");
				member.setNation(nation);				
				String join_date = rs.getString("join_date");
				member.setJoin_date(join_date);				
				String WeChat = rs.getString("WeChat");
				member.setWeChat(WeChat);
				list.add(member);
			}
			rs.close();
			stmt.close();
			db.deconnSQL();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	 public static void insertMember(Member member){
		   String member_number = member.getMember_number();
		   String member_name = member.getMember_name();
		   String department = member.getDepartment();
		   String gender = member.getGender();
		   String nation = member.getNation();
		   Integer dues = member.getDues();
		   String join_date = member.getJoin_date();
		   String WeChat = member.getWeChat();
		  try {
			  Connection conn = null;
			  DatebaseHandler db = new DatebaseHandler();
			  conn = db.connSQL();
			  Statement stmt=conn.createStatement();
			  String sql="insert into member(member_number,member_name,department,gender,nation,dues,join_date,WeChat) values('"+member_number+"','"+member_name+"','"+department+"','"+gender+"','"+nation+"','"+dues+"','"+join_date+"','"+WeChat+"')";
			  stmt.executeUpdate(sql);			  
			  stmt.close();
			  db.deconnSQL();
		  } catch (SQLException e) {
		   e.printStackTrace();
		  }
	 }
	 
	 public static void updateMember(Member member){
		 Integer member_id = member.getMember_id();
		 String member_number = member.getMember_number();
		 String member_name = member.getMember_name();
		 String department = member.getDepartment();
		 String gender = member.getGender();
		 String nation = member.getNation();
		 Integer dues = member.getDues();
		 String join_date = member.getJoin_date();
		 String WeChat = member.getWeChat();
		try {
			Connection conn = null;
			DatebaseHandler db = new DatebaseHandler();
			conn = db.connSQL();
			Statement stmt=conn.createStatement();
			String sql="update member set member_number='"+member_number+"', member_name='"+member_name+"', department='"+department+"', gender='"+gender+"', nation='"+nation+"',dues='"+dues+"', join_date='"+join_date+"', WeChat='"+WeChat+"' where member_id='"+member_id+"'";
			stmt.executeUpdate(sql);
			stmt.close();
			db.deconnSQL();
		} catch (SQLException e) {
		 e.printStackTrace();
		}
	}
	 
	 public static void deleteMember(String sql){
		  try {
			  Connection conn = null;
			  DatebaseHandler db = new DatebaseHandler();
			  conn = db.connSQL();
			  Statement stmt=conn.createStatement();
			  stmt.executeUpdate(sql);
			  stmt.close();
			  db.deconnSQL();
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
	}
	
}
