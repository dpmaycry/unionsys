package org.dp.wechat.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dp.database.DatebaseHandler;
import org.dp.wechat.pojo.ActionInfo;
import org.dp.wechat.pojo.CreateQRTicket;
import org.dp.wechat.pojo.Scene;
import org.dp.wechat.pojo.QRTicket;
import org.dp.wechat.util.MessageUtil;
import org.dp.wechat.util.CommonUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

/**
 * loginservlet
 * 
 * @author DP
 * 
 */
public class OutputServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// super.doGet(req, resp);
		System.out.println("=========doGet========");
		this.doPost(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// super.doPost(req, resp);

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		PrintWriter pw = resp.getWriter();
		System.out.println("=========doPost========");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		int deviceno = Integer.parseInt(req.getParameter("deviceno"));

		if ("admin".equals(username) && "123".equals(password)) {

			QRTicket ticket = CommonUtil.getTicket(
					getticket("QR_SCENE",300, 1),
					CommonUtil.gettoken());
			String tk = ticket.getTicket();
			int es = ticket.getExpire_seconds();
			String url = ticket.getUrl();
			String stUrl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="
					+ java.net.URLEncoder.encode(tk);
			
			pw.println(stUrl);
			// String title = req.getParameter("title");
				// int colorTheme =
				// Integer.parseInt(req.getParameter("colorTheme"));
				// int goalDays =
				// Integer.parseInt(req.getParameter("goalDays"));
				// int finishedDays =
				// Integer.parseInt(req.getParameter("finishedDays"));
				// String startDay = req.getParameter("startDay");
				// int remind = Integer.parseInt(req.getParameter("remind"));
				// String remindTime = req.getParameter("remindTime");
			
//				System.out.println(Query(username));
//				pw.println(Query(username));

			}
			System.out.println("=========username========" + username);
			System.out.println("=========password========" + password);
			System.out.println("=========deviceno========" + deviceno);

	}
	
	// 获取二维码凭证消息
	private static CreateQRTicket getticket(String action_name,
			int expire_seconds, int scene_id) {
		CreateQRTicket ct = new CreateQRTicket();
		ActionInfo ai = new ActionInfo();
		Scene sc = new Scene();
		sc.setScene_id(scene_id);
		ai.setScene(sc);
		ct.setAction_info(ai);
		ct.setAction_name(action_name);
		ct.setExpire_seconds(expire_seconds);
		return ct;
	}


//	public boolean IsUserRight(String user, String pw) {
//
//		DBC h = new DBC();
//		h.connSQL();
//		String s = "select *  from user where username='" + user + "'";
//		String p = "";
//		ResultSet rs = h.selectSQL(s);
//		// h.layoutStyle2(resultSet);
//		try {
//			while (rs.next()) {
//				p = rs.getString("password");
//
//			}
//		} catch (SQLException e) {
//			System.out.println("显示时数据库出错。");
//			e.printStackTrace();
//			return true;
//
//		} catch (Exception e) {
//
//			System.out.println("显示出错。");
//			e.printStackTrace();
//			return true;
//		}
//		h.deconnSQL();
//
//		if (p.equals(pw)) {
//			return true;
//		} else {
//			return false;
//
//		}
//	}

//	public JSONObject Query(String user) {
//
//		List<UserInfo> list1 = new ArrayList<UserInfo>();
//		List<Habit> list2 = new ArrayList<Habit>();
//		List<Record> list3 = new ArrayList<Record>();
//
//		JSONObject json = new JSONObject();
//
//		Database h = new Database();
//		h.connSQL();
//
//		String q1 = "select * from user where username='" + user + "'";
//
//		ResultSet rq1 = h.selectSQL(q1);
//		try {
//			while (rq1.next()) {
//				String q2 = "select * from habit where user_id ='"
//						+ rq1.getString("id") + "'";
//				UserInfo userinfo = new UserInfo();
//				userinfo.setUsername(rq1.getString("username"));
//				userinfo.setNickname(rq1.getString("nickname"));
//				userinfo.setSign(rq1.getString("sign"));
//
//				ResultSet rq2 = h.selectSQL(q2);
//
//				while (rq2.next()) {
//
//					Habit habit = new Habit();
//					habit.setTitle(rq2.getString("title"));
//					habit.setColorTheme(rq2.getInt("colorTheme"));
//					habit.setGoalDays(rq2.getInt("goalDays"));
//					habit.setFinishedDays(rq2.getInt("finishedDays"));
//					habit.setStartDay(rq2.getString("startDay"));
//					habit.setRemind(rq2.getInt("remind"));
//					habit.setRemindTime(rq2.getString("remindTime"));
//
//					String q3 = "select * from record where habit_id ='"
//							+ rq2.getString("id") + "'";
//					ResultSet rq3 = h.selectSQL(q3);
//
//					while (rq3.next()) {
//
//						Record record = new Record();
//						record.setDay(rq3.getString("day"));
//						record.setFinished(rq3.getInt("finished"));
//						
//						list3.add(record);
//
//					}
//					habit.setRecord(list3);
//
//					list2.add(habit);
//
//				}
//				
//				userinfo.setHabit(list2);
//				json=JSONObject.fromObject(userinfo);
//				json.element("user", userinfo);
//			}
//			
//			
//
//		} catch (SQLException e) {
//			System.out.println("显示时数据库出错。");
//			e.printStackTrace();
//
//		} catch (Exception e) {
//
//			System.out.println("显示出错。");
//			e.printStackTrace();
//		}
//		h.deconnSQL();
//		return json;
//	}

}
