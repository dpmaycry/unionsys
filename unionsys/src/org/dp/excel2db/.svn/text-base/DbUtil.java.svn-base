package org.dp.excel2db;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;

import org.dp.database.*;

public class DbUtil {

	public static void insert(String sql, Member member) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			DatebaseHandler db = new DatebaseHandler();
			conn = db.connSQL();
			ps = conn.prepareStatement(sql);
			ps.setString(1, member.getMember_number());
			ps.setString(2, member.getMember_name());
			ps.setString(3, member.getDepartment());
			ps.setString(4, member.getGender());
			ps.setString(5, member.getNation());
			ps.setString(6, String.valueOf(member.getDues()));
			ps.setString(7, member.getJoin_date());
			ps.setString(8, member.getWeChat());
			boolean flag = ps.execute();
			//if(!flag){
			//	System.out.println("Save data : member_number = " + member.getMember_number() + " , member_name = " +  member.getMember_name() + " succeed!");
			//}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List selectOne(String sql, Member member) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List list = new ArrayList();
		try {
			DatebaseHandler db = new DatebaseHandler();
			conn = db.connSQL();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				list.add(1);
			}else{
				list.add(0);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return list;
	}
	
	
	public static ResultSet selectAll(String sql) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			DatebaseHandler db = new DatebaseHandler();
			conn = db.connSQL();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return rs;
	}

}
