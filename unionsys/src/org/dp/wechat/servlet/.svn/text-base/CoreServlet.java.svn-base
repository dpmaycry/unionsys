package org.dp.wechat.servlet;


import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.dp.database.DatebaseHandler;
import org.dp.wechat.pojo.AccessToken;
import org.dp.wechat.pojo.Button;
import org.dp.wechat.pojo.CommonButton;
import org.dp.wechat.pojo.ComplexButton;
import org.dp.wechat.pojo.Menu;
import org.dp.wechat.pojo.UserInfo;
import org.dp.wechat.pojo.ViewButton;
import org.dp.wechat.service.CoreService;
import org.dp.wechat.templatemessage.Data;
import org.dp.wechat.templatemessage.Data_Date;
import org.dp.wechat.templatemessage.Data_Location;
import org.dp.wechat.templatemessage.Data_Notice;
import org.dp.wechat.templatemessage.Data_Title;
import org.dp.wechat.templatemessage.Data_User;
import org.dp.wechat.templatemessage.TemplateMassage;
import org.dp.wechat.thread.TokenThread;
import org.dp.wechat.util.MessageUtil;
import org.dp.wechat.util.SignUtil;
import org.dp.wechat.util.CommonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;




/**
 * 核心请求处理类
 * 
 * @author DP
 * 
 */
public class CoreServlet extends HttpServlet {
	private static final long serialVersionUID = 4440739483644821986L;
	private static Logger log = LoggerFactory.getLogger(CommonUtil.class);

	// 开启每隔7000秒自动获取并存储一次access_token线程
	public void init() throws ServletException {
		// 获取web.xml中配置的参数
		TokenThread.appid = getInitParameter("appid");
		TokenThread.appsecret = getInitParameter("appsecret");

		// log.info("weixin api appid:{}", TokenThread.appid);
		// log.info("weixin api appsecret:{}", TokenThread.appsecret);

		// 未配置appid、appsecret时给出提示
		if ("".equals(TokenThread.appid) || "".equals(TokenThread.appsecret)) {
			log.error("appid and appsecret configuration error, please check carefully.");
		} else {
			// 启动定时获取access_token的线程
			new Thread(new TokenThread()).start();
			int result = CommonUtil.createMenu(CommonUtil.getMenu(), CommonUtil.gettoken());

			// 判断菜单创建结果
			if (0 == result)
				log.info("create menu successed！");
			else
				log.info("create menu failed:" + result);
		}
	}

	/**
	 * 确认请求来自微信服务器
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 微信加密签名
		String signature = request.getParameter("signature");
		// 时间戳
		String timestamp = request.getParameter("timestamp");
		// 随机数
		String nonce = request.getParameter("nonce");
		// 随机字符串
		String echostr = request.getParameter("echostr");

		PrintWriter out = response.getWriter();
		// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
		if (SignUtil.checkSignature(signature, timestamp, nonce)) {
			out.print(echostr);
		}
		out.close();
		out = null;
	}

	/**
	 * 处理微信服务器发来的消息
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		//
		// // 调用接口获取access_token
		// AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);



		// 调用核心业务类接收消息、处理消息
		String respMessage = CoreService.processRequest(request);

		// 响应消息
		PrintWriter out = response.getWriter();
		out.print(respMessage);

		out.close();
	}

	

}