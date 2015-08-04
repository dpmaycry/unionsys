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
import javax.servlet.http.HttpSession;

import org.dp.database.DatebaseHandler;
import org.dp.wechat.pojo.ActionInfo;
import org.dp.wechat.pojo.CreateQRTicket;
import org.dp.wechat.pojo.Scene;
import org.dp.wechat.pojo.QRTicket;
import org.dp.wechat.util.MessageUtil;
import org.dp.wechat.util.CommonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

/**
 * loginservlet
 * 
 * @author DP
 * 
 */
public class Erweima extends HttpServlet {
	private static Logger log = LoggerFactory.getLogger(CommonUtil.class);
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// super.doGet(req, resp);
		System.out.println("=========doGet========");
		this.doPost(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession(false);
		String user="";
		if(session!=null) 
		{ 
		user = (String)session.getAttribute("username");	
		} 
       
		int id=Integer.parseInt(user);
         
            QRTicket ticket = CommonUtil.getTicket(
                    getticket("QR_SCENE",3000, id),
                    CommonUtil.gettoken());
            String tk = ticket.getTicket();
            int es = ticket.getExpire_seconds();
            String url = ticket.getUrl();
            String stUrl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="
                    + java.net.URLEncoder.encode(tk);
    //          String stUrl="https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFK8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3kweXE0T3JscWY3UTltc3ZPMklvAAIEG9jUUgMECAcAAA%3d%3d";
             
            response.setContentType("text/xml; charset=UTF-8");
             response.setCharacterEncoding("UTF-8");
             response.setHeader("Cache-Control","no-cache");
             StringBuffer sb = new StringBuffer();
             PrintWriter out=response.getWriter();
              sb.append("<img src=");
             sb.append(stUrl);
             sb.append("  height=200 width=200>");
             out.println(sb.toString());
             System.out.println(sb.toString());
             out.close();
		     
		
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




}
