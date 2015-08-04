package org.dp.wechat.thread;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.dp.database.DatebaseHandler;
import org.dp.wechat.pojo.AccessToken;
import org.dp.wechat.util.MessageUtil;
import org.dp.wechat.util.CommonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 定时获取微信access_token的线程
 * 
 * @author DP
 * 
 */
public class TokenThread implements Runnable {
	private static Logger log = LoggerFactory.getLogger(TokenThread.class);
	// 第三方用户唯一凭证
	public static String appid = "";
	// 第三方用户唯一凭证密钥
	public static String appsecret = "";
	public static AccessToken accessToken = null;

	public void run() {
		while (true) {
			try {
				accessToken = CommonUtil.getAccessToken(appid, appsecret);
				if (null != accessToken) {
					
					// 数据库更新操作
					DatebaseHandler h = new DatebaseHandler();
					h.connSQL();
					try {
//						 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//
//						// 当前时间
//						 String date = df.format(new Date()) + "";

						String update ="update access_token set access_token ='"+accessToken.getToken()+"', expiresin_time ="+accessToken.getExpiresIn()+" where id=1";
						if (h.updateSQL(update) == true) {
							log.info("数据库更新token成功");

						} else {
							log.info("数据库更新token失败");
						}
					} catch (Exception e) {
						e.printStackTrace();
						log.info("数据库更新异常"+e);
					} finally {
						h.deconnSQL();
					}
					
					log.info("获取access_token成功，有效时长{}秒 token:{}", accessToken.getExpiresIn(), accessToken.getToken());
					// 休眠7000秒
					Thread.sleep((accessToken.getExpiresIn() - 200) * 1000);
				} else {
					// 如果access_token为null，60秒后再获取
					Thread.sleep(60 * 1000);
				}
			} catch (InterruptedException e) {
				try {
					Thread.sleep(60 * 1000);
				} catch (InterruptedException e1) {
					log.error("{}", e1);
				}
				log.error("{}", e);
			}
		}
	}
}