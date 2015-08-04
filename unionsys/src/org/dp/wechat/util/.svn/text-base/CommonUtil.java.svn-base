package org.dp.wechat.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.dp.database.DatebaseHandler;
import org.dp.wechat.pojo.AccessToken;
import org.dp.wechat.pojo.Button;
import org.dp.wechat.pojo.CommonButton;
import org.dp.wechat.pojo.ComplexButton;
import org.dp.wechat.pojo.CreateQRTicket;
import org.dp.wechat.pojo.Menu;
import org.dp.wechat.pojo.QRTicket;
import org.dp.wechat.pojo.UserInfo;
import org.dp.wechat.pojo.ViewButton;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 公众平台通用接口工具类
 * 
 * @author DP
 * 
 */
public class CommonUtil {
	private static Logger log = LoggerFactory.getLogger(CommonUtil.class);

	// 获取access_token的接口地址（GET） 限200（次/天）
	public final static String access_token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";

	// 菜单创建（POST） 限100（次/天）
	public static String menu_create_url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";

	// 获取用户基本信息（GET）
	public final static String user_info_url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
	
	// 获取二维码凭证（POST）
	public final static String ticket_url = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=TOKEN";
	/**
	 * 获取access_token
	 * 
	 * @param appid
	 *            凭证
	 * @param appsecret
	 *            密钥
	 * @return
	 */
	public static AccessToken getAccessToken(String appid, String appsecret) {
		AccessToken accessToken = null;

		String requestUrl = access_token_url.replace("APPID", appid).replace(
				"APPSECRET", appsecret);
		JSONObject jsonObject = httpsRequest(requestUrl, "GET", null);
		// 如果请求成功
		if (null != jsonObject) {
			try {
				accessToken = new AccessToken();
				accessToken.setToken(jsonObject.getString("access_token"));
				accessToken.setExpiresIn(jsonObject.getInt("expires_in"));
			} catch (JSONException e) {
				accessToken = null;
				// 获取token失败
				log.error("获取token失败 errcode:{} errmsg:{}",
						jsonObject.getInt("errcode"),
						jsonObject.getString("errmsg"));
			}
		}
		return accessToken;
	}
	/**
	 * 查询access_token
	 * 
	 * @return
	 */
	public static String gettoken() {
		String a = null;
//		int b = 0;
		// 数据库查询操作
		DatebaseHandler db = new DatebaseHandler();
		db.connSQL();
		try {

			String select = "select * from access_token where id=1";
			ResultSet resultSet = db.selectSQL(select);
			while (resultSet.next()) {
				a = resultSet.getString("access_token");
//				b = resultSet.getInt("expiresin_time");
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.printf("查询异常!" + e);
		} finally {
			db.deconnSQL();
		}
		return a;

	}

	/**
	 * 获取user_info
	 * 
	 * @param accessToken
	 *            凭证
	 * @param openid
	 *            用户openid对当前公众号唯一
	 * @return
	 */
	public static UserInfo getUserInfo(String accessToken, String openid) {
		UserInfo userInfo = null;

		String requestUrl = user_info_url.replace("ACCESS_TOKEN", accessToken)
				.replace("OPENID", openid);
		JSONObject jsonObject = httpsRequest(requestUrl, "GET", null);
		// 如果请求成功
		if (null != jsonObject) {
			try {
				userInfo = new UserInfo();
				userInfo.setSubscribe(jsonObject.getInt("subscribe"));
				userInfo.setNickname(jsonObject.getString("nickname"));
				userInfo.setOpenid(jsonObject.getString("openid"));
				userInfo.setSex(jsonObject.getInt("sex"));
				userInfo.setCity(jsonObject.getString("city"));
				userInfo.setCountry(jsonObject.getString("country"));
				userInfo.setProvince(jsonObject.getString("province"));
				userInfo.setLanguage(jsonObject.getString("language"));
				userInfo.setHeadimgurl(jsonObject.getString("headimgurl"));
				userInfo.setSubscribe_time(jsonObject.getInt("subscribe_time"));
				// userInfo.setUnionid(jsonObject.getString("unionid"));

			} catch (JSONException e) {
				accessToken = null;
				// 获取userinfo失败
				log.error("获取userinfo失败 errcode:{} errmsg:{}",
						jsonObject.getInt("errcode"),
						jsonObject.getString("errmsg"));
			}
		}
		return userInfo;
	}

	// 菜单创建（POST） 限100（次/天）

	/**
	 * 创建菜单
	 * 
	 * @param menu
	 *            菜单实例
	 * @param accessToken
	 *            有效的access_token
	 * @return 0表示成功，其他值表示失败
	 */
	public static int createMenu(Menu menu, String accessToken) {
		int result = 0;

		// 拼装创建菜单的url
		String url = menu_create_url.replace("ACCESS_TOKEN", accessToken);
		// 将菜单对象转换成json字符串
		String jsonMenu = JSONObject.fromObject(menu).toString();
		// 调用接口创建菜单
		JSONObject jsonObject = httpsRequest(url, "POST", jsonMenu);

		if (null != jsonObject) {
			if (0 != jsonObject.getInt("errcode")) {
				result = jsonObject.getInt("errcode");
				log.error("创建菜单失败 errcode:{} errmsg:{}",
						jsonObject.getInt("errcode"),
						jsonObject.getString("errmsg"));
			}
		}

		return result;
	}
	/**
	 * 组装菜单数据
	 * 
	 * @return
	 */
	public static Menu getMenu() {
		CommonButton btn11 = new CommonButton();
		btn11.setName("开始签到");
		btn11.setType("click");
		btn11.setKey("11");

		CommonButton btn12 = new CommonButton();
		btn12.setName("参加记录");
		btn12.setType("click");
		btn12.setKey("12");
		
		CommonButton btn13 = new CommonButton();
		btn13.setName("会员信息");
		btn13.setType("click");
		btn13.setKey("13");
		
		ViewButton btn21 = new ViewButton();
		btn21.setName("活动详情");
		btn21.setType("view");
		btn21.setUrl("http://1.unionsys.sinaapp.com/activity.jsp");

		CommonButton btn31 = new CommonButton();
		btn31.setName("帮助手册");
		btn31.setType("click");
		btn31.setKey("31");

		CommonButton btn32 = new CommonButton();
		btn32.setName("反馈建议");
		btn32.setType("click");
		btn32.setKey("32");

		ComplexButton mainBtn1 = new ComplexButton();
		mainBtn1.setName("我");
		mainBtn1.setSub_button(new Button[] { btn11,btn12,btn13});

		ComplexButton mainBtn2 = new ComplexButton();
		mainBtn2.setName("关于");
		mainBtn2.setSub_button(new Button[] { btn31, btn32});

		/**
		 * 这是公众号unionsys目前的菜单结构，每个一级菜单都有二级菜单项<br>
		 * 
		 * 在某个一级菜单下没有二级菜单的情况，menu该如何定义呢？<br>
		 * 比如，第三个一级菜单项不是“关于”，而直接是“网址”，那么menu应该这样定义：<br>
		 * menu.setButton(new Button[] { mainBtn1, mainBtn2, btn33 });
		 */
		Menu menu = new Menu();
		menu.setButton(new Button[] { mainBtn1,btn21,mainBtn2});

		return menu;
	}
	/**
	 * 获取ticket
	 * 
	 * @param accessToken
	 *            凭证
	 * @return
	 */
	public static QRTicket getTicket(CreateQRTicket cticket,String accessToken) {
		QRTicket ticket = null;

		String Url = ticket_url.replace("TOKEN", accessToken);		
		String jsonTicket = JSONObject.fromObject(cticket).toString();
		JSONObject jsonObject = httpsRequest(Url, "POST", jsonTicket);
		// 如果请求成功
		if (null != jsonObject) {
			try {
				ticket = new QRTicket();
				ticket.setTicket(jsonObject.getString("ticket"));
				ticket.setExpire_seconds(jsonObject.getInt("expire_seconds"));
				ticket.setUrl(jsonObject.getString("url"));
			} catch (JSONException e) {
				ticket = null;
				// 获取ticket失败
				log.error("获取ticket失败 errcode:{} errmsg:{}",
						jsonObject.getInt("errcode"),
						jsonObject.getString("errmsg"));
			}
		}
		return ticket;
	}

	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpsRequest(String requestUrl,
			String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection httpsUrlConn = (HttpsURLConnection) url
					.openConnection();
			httpsUrlConn.setSSLSocketFactory(ssf);

			httpsUrlConn.setDoOutput(true);
			httpsUrlConn.setDoInput(true);
			httpsUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpsUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod))
				httpsUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpsUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpsUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(
					inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(
					inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpsUrlConn.disconnect();
			jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			log.error("Weixin server connection timed out.");
		} catch (Exception e) {
			log.error("https request error:{}", e);
		}
		return jsonObject;
	}
	
    
    /**
     * URL编码（utf-8）
     * 
     * @param source
     * @return
     */
    public static String urlEncodeUTF8(String source) {
        String result = source;
        try {
            result = java.net.URLEncoder.encode(source, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return result;
    }
	
    /**
     * 根据内容类型判断文件扩展名
     * 
     * @param contentType 内容类型
     * @return
     */
    public static String getFileExt(String contentType) {
        String fileExt = "";
        if ("image/jpeg".equals(contentType))
            fileExt = ".jpg";
        else if ("audio/mpeg".equals(contentType))
            fileExt = ".mp3";
        else if ("audio/amr".equals(contentType))
            fileExt = ".amr";
        else if ("video/mp4".equals(contentType))
            fileExt = ".mp4";
        else if ("video/mpeg4".equals(contentType))
            fileExt = ".mp4";
        return fileExt;
    }

}