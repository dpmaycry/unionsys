package org.dp.wechat.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.dp.database.DatebaseHandler;
import org.dp.wechat.pojo.AccessToken;
import org.dp.wechat.pojo.ActionInfo;
import org.dp.wechat.pojo.CreateQRTicket;
import org.dp.wechat.pojo.Menu;
import org.dp.wechat.pojo.Scene;
import org.dp.wechat.pojo.QRTicket;
import org.dp.wechat.pojo.UserInfo;
import org.dp.wechat.templatemessage.Data;
import org.dp.wechat.templatemessage.Data_Date;
import org.dp.wechat.templatemessage.Data_Location;
import org.dp.wechat.templatemessage.Data_Notice;
import org.dp.wechat.templatemessage.Data_Title;
import org.dp.wechat.templatemessage.Data_User;
import org.dp.wechat.templatemessage.TemplateMassage;
import org.dp.wechat.util.MessageUtil;
import org.dp.wechat.util.CommonUtil;
import org.dp.wechat.message.resp.Article;
import org.dp.wechat.message.resp.NewsMessage;
import org.dp.wechat.message.resp.TextMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 核心服务类
 * 
 * @author DP
 *
 */
public class CoreService {
	// String appid="wxf68de07d90a0837a";
	// String appsecret="23cc74b30d85d7a2d2fd2210d109ca18";
	private static Logger log = LoggerFactory.getLogger(CoreService.class);
    private static String clickmsg="您尚未绑定账号，请点击<a href=\"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf68de07d90a0837a&redirect_uri=http%3A%2F%2F1.unionsys.sinaapp.com%2FOAuthServlet&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect\">这里绑定账号</a>";
	
	/**
	 * 处理微信发来的请求
	 * 
	 * @param request
	 * @return
	 */
	public static String processRequest(HttpServletRequest request) {
		String respMessage = null;
		try {

			// 默认返回的文本消息内容
			String respContent = "请求处理异常，请稍候尝试！";

			// xml请求解析
			Map<String, String> requestMap = MessageUtil.parseXml(request);

			// 发送方帐号（open_id）
			String fromUserName = requestMap.get("FromUserName");
			// 公众帐号
			String toUserName = requestMap.get("ToUserName");
			// 消息类型
			String msgType = requestMap.get("MsgType");

			// 默认回复此文本消息
			TextMessage textMessage = new TextMessage();
			textMessage.setToUserName(fromUserName);
			textMessage.setFromUserName(toUserName);
			textMessage.setCreateTime(new Date().getTime());
			textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
			// textMessage.setFuncFlag(0);

			// 文本消息
			if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_TEXT)) {
				// 接收用户发送的文本消息内容
				String content = requestMap.get("Content");

				if ("1".equals(content)) {
//					// 创建图文消息
//					NewsMessage mainMessage = new NewsMessage();
//					mainMessage.setToUserName(fromUserName);
//					mainMessage.setFromUserName(toUserName);
//					mainMessage.setCreateTime(new Date().getTime());
//					mainMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
//					// mainMessage.setFuncFlag(0);
//					List<Article> mainList = new ArrayList<Article>();
//
//					Article mainarticle = new Article();
//					mainarticle.setTitle("工会活动公告 ");
//					// 图文消息中可以使用QQ表情、符号表情
//					mainarticle.setDescription("活动");
//					// 将图片置为空
//					mainarticle.setPicUrl("");
//					mainarticle.setUrl("");
//
//					mainList.add(mainarticle);
//					mainMessage.setArticleCount(mainList.size());
//					mainMessage.setArticles(mainList);
//					respMessage = MessageUtil.newsMessageToXml(mainMessage);
					respContent ="请在工会活动指定时间内到达指定地点->打开手机定位及网络->使用微信扫描活动现场的二维码->签到成功并领取礼物！";
					textMessage.setContent(respContent);
					respMessage = MessageUtil.textMessageToXml(textMessage);

				}

				else if ("2".equals(content)) {
					respContent ="如果您是FNST工会会员，请点击“会员信息”，在弹出的回复中点击“这里”跳转链接，输入您的工号和工会密码登录即可。";
					textMessage.setContent(respContent);
					respMessage = MessageUtil.textMessageToXml(textMessage);
				} else if ("3".equals(content)) {
					respContent = "注意！！！\n本公众号仅为FNST员工中的工会会员服务；\n如果您是FNST员工但还不是工会会员，请在公司OA申请加入会员即可；\n如果您不是FNST员工，请先申请加入富士通南大软件公司，请关注“富士通南大招贤纳士”公众号了解详情\n Copyleft 2015";
					textMessage.setContent(respContent);
					respMessage = MessageUtil.textMessageToXml(textMessage);
				} else if (content.contains("反馈：") || content.contains("反馈:")
						|| content.contains("反馈")) {
					String openid = fromUserName;
					String nickname = "";

					DatebaseHandler db1 = new DatebaseHandler();
					db1.connSQL();
					try {

						String select1 = "select * from user_table where openid='"
								+ fromUserName + "'";

						ResultSet resultSet1 = db1.selectSQL(select1);
						while (resultSet1.next()) {
							nickname = resultSet1.getString("nickname");
						}

					} catch (SQLException e) {
						e.printStackTrace();
						System.out
								.println("Error occured while querying in Socket");
					} finally {
						db1.deconnSQL();
					}

					// SimpleDateFormat df = new SimpleDateFormat(
					// "yyyy-MM-dd HH:mm:ss");// 设置日期格式
					// String date = df.format(new Date());
					DatebaseHandler db = new DatebaseHandler();
					db.connSQL();

					String insert = "insert into feedback_table(openid,nickname,content) values('"
							+ openid
							+ "','"
							+ nickname
							+ "','"
							+ content
							+ "')";

					if (db.insertSQL(insert) == true) {
						System.out.println("insert Record successfully");
					}

					db.deconnSQL();

					respContent = "" + emoji(0x1F44C)
							+ ",已收到您的反馈，我们会继续努力完善，并且感谢您对我们一如既往的支持。";
					textMessage.setContent(respContent);
					respMessage = MessageUtil.textMessageToXml(textMessage);

				} else {
					
					StringBuffer contentMsg = new StringBuffer();
					contentMsg.append(
							"您好" + emoji(0x1F603)
									+ "，我是会员帮助指南，请回复相应数字选择帮助内容：")
							.append("\n\n");
					contentMsg.append("1 关于活动签到").append("\n");
					contentMsg.append("2 关于账号绑定").append("\n");
					contentMsg.append("3 免责声明").append("\n\n");
					contentMsg.append("如有其它疑问请直接点击“反馈建议”").append("\n");
					textMessage.setContent(contentMsg.toString());
					// 将文本消息对象转换成xml字符串
					respMessage = MessageUtil.textMessageToXml(textMessage);
					
					// 创建图文消息
//					NewsMessage mainMessage = new NewsMessage();
//					mainMessage.setToUserName(fromUserName);
//					mainMessage.setFromUserName(toUserName);
//					mainMessage.setCreateTime(new Date().getTime());
//					mainMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
//					// mainMessage.setFuncFlag(0);
//					List<Article> mainList = new ArrayList<Article>();
//
//					Article mainarticle = new Article();
//					mainarticle.setTitle("工会活动公告 ");
//					// 图文消息中可以使用QQ表情、符号表情
//					mainarticle.setDescription("工会活动公告");
//					// 将图片置为空
//					mainarticle.setPicUrl("");
//					mainarticle.setUrl("");
//
//					mainList.add(mainarticle);
//					mainMessage.setArticleCount(mainList.size());
//					mainMessage.setArticles(mainList);
//					respMessage = MessageUtil.newsMessageToXml(mainMessage);

				}

			}
			// 事件推送
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {

				// 事件类型
				String eventType = requestMap.get("Event");
				// 订阅
				if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {
					int scanid = 0;
					String s ="0";
					if (requestMap.get("EventKey").contains("qrscene_")) {

						scanid = Integer.parseInt(requestMap.get("EventKey")
								.replace("qrscene_", ""));
						s="0"+scanid;
					}

					
					UserInfo userInfo = CommonUtil.getUserInfo(CommonUtil.gettoken(),
							fromUserName);
					int subscribe = userInfo.getSubscribe();
					String openid = userInfo.getOpenid();
					String nickname = userInfo.getNickname();
					int sex = userInfo.getSex();
					String city = userInfo.getCity();
					String country = userInfo.getCountry();
					String province = userInfo.getProvince();
					String language = userInfo.getLanguage();
					String headimgurl = userInfo.getHeadimgurl();
					int subscribe_time = userInfo.getSubscribe_time();
					

					if (IsUserExist(fromUserName)) { 
						// 数据库更新操作
						DatebaseHandler db = new DatebaseHandler();
						db.connSQL();
						try {

							String update = "update user_table set subscribe='" + subscribe+ "', nickname ='"+ nickname + "', headimgurl ='"+ headimgurl + "' where openid='" + fromUserName + "'";
							if (db.updateSQL(update) == true) {
								
								
								if (scanid == 0) {
									respContent = "工会活动公众号感谢您再次关注！";
									textMessage.setContent(respContent);
									respMessage = MessageUtil
											.textMessageToXml(textMessage);
								} else if (IsGroupExist(s))
								{
									int unionno = 0;
									// 数据库查询操作
									DatebaseHandler db0 = new DatebaseHandler();
									db0.connSQL();
									try {

										String select0 = "select * from user_table where openid='"
												+ fromUserName + "'";
										ResultSet resultSet0 = db0.selectSQL(select0);
										while (resultSet0.next()) {
											
											unionno = resultSet0.getInt("unionno");
										}

									} catch (SQLException e) {
										e.printStackTrace();
										respContent = "查询异常!";
										textMessage.setContent(respContent);
										respMessage = MessageUtil
												.textMessageToXml(textMessage);
									} finally {
										db0.deconnSQL();
									}

									if (unionno == 0) {
										// 由于href属性值必须用双引号引起，这与字符串本身的双引号冲突，所以要转义
										respContent =clickmsg;
									    textMessage.setContent(respContent);
										respMessage = MessageUtil
												.textMessageToXml(textMessage);
									}else {

										Double Latitude=0.0,Longitude=0.0,Precision=0.0;
										Double Latitudeadmin=1.1,Longitudeadmin=1.1,Precisionadmin=1.1;
										
										// 数据库查询操作
										DatebaseHandler dbx = new DatebaseHandler();
										dbx.connSQL();
										try {
											String select = "select * from user_table where openid='"
													+ fromUserName + "'";
											String selectadmin = "select * from temp_table where id=1";
											ResultSet resultSet = dbx.selectSQL(select);
											ResultSet resultSetadmin = dbx.selectSQL(selectadmin);
											while (resultSet.next()) {
												Latitude = resultSet.getDouble("latitude");
												Longitude = resultSet.getDouble("longitude");
												Precision = resultSet.getDouble("lprecision");
											}
											while (resultSetadmin.next()) {
												Latitudeadmin = resultSetadmin.getDouble("latitude");
												Longitudeadmin = resultSetadmin.getDouble("longitude");
												Precisionadmin = resultSetadmin.getDouble("lprecision");

											}
											
										} catch (SQLException e) {
											e.printStackTrace();
											respContent = "地理位置查询异常!"+e;
											textMessage.setContent(respContent);
											respMessage = MessageUtil
													.textMessageToXml(textMessage);
										} finally {
											dbx.deconnSQL();
										}
//										respContent = "laadmin="+Latitudeadmin+"loa="+Longitudeadmin+"LaE"+Math.abs(Latitude-Latitudeadmin)+"LoE"+Math.abs(Longitude-Longitudeadmin);
//									    textMessage.setContent(respContent);
//									    respMessage = MessageUtil.textMessageToXml(textMessage);	
										if(Math.abs(Latitude-Latitudeadmin)<0.001 && Math.abs(Longitude-Longitudeadmin)<0.001)
										{
											String member_name=null,member_number=null;
											int activityid=0;
											// 数据库查询操作
											DatebaseHandler db1 = new DatebaseHandler();
											db1.connSQL();
											try {
												String select = "select * from user_table where openid='"
														+ fromUserName + "'";
												
												ResultSet resultSet = db1.selectSQL(select);
												
												while (resultSet.next()) {
													member_number = resultSet.getString("unionno");
												}

												String select1 = "select * from member where member_number='"+member_number+"'";
												ResultSet resultSet1 = db1.selectSQL(select1);
												while (resultSet1.next()) {
													member_name = resultSet1.getString("member_name");

												}
												
												String select2 = "select * from activity order by activity_id desc limit 0,1";
												ResultSet resultSet2 = db1.selectSQL(select2);
												while (resultSet2.next()) {
													activityid = resultSet2.getInt("activity_id");
												}
												
											} catch (SQLException e) {
												e.printStackTrace();
												respContent = "查询异常!"+e;
												textMessage.setContent(respContent);
												respMessage = MessageUtil
														.textMessageToXml(textMessage);
											} finally {
												db1.deconnSQL();
											}

											// 数据库插入
											DatebaseHandler db2 = new DatebaseHandler();
											db2.connSQL();
											try {
												String insert = "insert into sign(activity_id,member_name,member_number,gift_taken,group_id) values("+activityid+",'"+member_name+ "','"+member_number+ "', 3,'"+s+"')";
					                            
												if (db2.insertSQL(insert) == true) {						

												     respContent = "签到成功!";
												     textMessage.setContent(respContent);
												     respMessage = MessageUtil.textMessageToXml(textMessage);
												} else {

													respContent = "关注用户信息注册失败！"+activityid+member_name+member_number;
													textMessage.setContent(respContent);
													respMessage = MessageUtil
															.textMessageToXml(textMessage);
												}
											} catch (Exception e) {
												e.printStackTrace();
												respContent = "数据库插入异常!"+e;
												textMessage.setContent(respContent);
												respMessage = MessageUtil
														.textMessageToXml(textMessage);
											} finally {
												db2.deconnSQL();
											}
											
						
										}else{
											
								//	    respContent = "请出席活动后再签到!：LaE"+Math.abs(Latitude-Latitudeadmin)+"LoE"+Math.abs(Longitude-Longitudeadmin);
									    respContent = "请出席活动后再签到；如果您已在活动现场签到，请向现场工会工作人员寻求帮助。";
									    textMessage.setContent(respContent);
									    respMessage = MessageUtil.textMessageToXml(textMessage);	
										}
										
									}
									
								}

								
							} else {
								respContent = "用户信息更新失败！";
								textMessage.setContent(respContent);
								respMessage = MessageUtil
										.textMessageToXml(textMessage);
							}
						} catch (Exception e) {
							e.printStackTrace();
							respContent = "数据库更新异常:" + e;
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} finally {
							db.deconnSQL();
						}

					} else {
						// 数据库插入
						DatebaseHandler db = new DatebaseHandler();
						db.connSQL();
						try {

							String insert = "insert into user_table(unionno,subscribe,openid,nickname,sex,city,country,province,language,headimgurl,subscribe_time) values('"
									+ 0
									+ "','"
									+ subscribe
									+ "','"
									+ openid
									+ "','"
									+ nickname
									+ "','"
									+ sex
									+ "','"
									+ city
									+ "','"
									+ country
									+ "','"
									+ province
									+ "','"								
									+ language
									+ "','"
									+ headimgurl
									+ "','"
									+ subscribe_time
									+ "')";

							if (db.insertSQL(insert) == true) {
								if (scanid == 0) {
									respContent = "工会活动公众号感谢您的关注！！";
									textMessage.setContent(respContent);
									respMessage = MessageUtil
											.textMessageToXml(textMessage);
								} else if(IsGroupExist(s)) {
									respContent = clickmsg;
									textMessage.setContent(respContent);
									respMessage = MessageUtil
											.textMessageToXml(textMessage);
								}

							} else {

								respContent = "用户信息注册失败！";
								textMessage.setContent(respContent);
								respMessage = MessageUtil
										.textMessageToXml(textMessage);
							}
						} catch (Exception e) {
							e.printStackTrace();
							respContent = "数据库插入异常!";
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} finally {
							db.deconnSQL();
						}
					}

					
					
				}
				// 取消订阅
				else if (eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) {
					// TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息
					DatebaseHandler db = new DatebaseHandler();
					db.connSQL();
					try {

						String update = "update user_table set subscribe=0 where openid='"
								+ fromUserName + "'";
						if (db.updateSQL(update) == true) {
							// TODO
						}
					} catch (Exception e) {
						e.printStackTrace();
						// respContent = "数据库更新异常:"+e;
						// textMessage.setContent(respContent);
						// respMessage =
						// MessageUtil.textMessageToXml(textMessage);
					} finally {
						db.deconnSQL();
					}

				}
				// 二维码扫描事件
				else if (eventType.equals(MessageUtil.EVENT_TYPE_SCAN)) {
					// TODO
					int scanid = Integer.parseInt(requestMap.get("EventKey"));
					String s="0"+scanid;
					String nickname=null;
					int unionno = 0;
					// 数据库查询操作
					DatebaseHandler db0 = new DatebaseHandler();
					db0.connSQL();
					try {

						String select0 = "select * from user_table where openid='"
								+ fromUserName + "'";
						ResultSet resultSet0 = db0.selectSQL(select0);
						while (resultSet0.next()) {
							nickname = resultSet0.getString("nickname");
							unionno = resultSet0.getInt("unionno");
						}

					} catch (SQLException e) {
						e.printStackTrace();
						respContent = "查询异常!";
						textMessage.setContent(respContent);
						respMessage = MessageUtil
								.textMessageToXml(textMessage);
					} finally {
						db0.deconnSQL();
					}

					if (unionno == 0) {
						// 由于href属性值必须用双引号引起，这与字符串本身的双引号冲突，所以要转义
						respContent =clickmsg;
					    textMessage.setContent(respContent);
						respMessage = MessageUtil
								.textMessageToXml(textMessage);
					}else
					{		
					if (IsGroupExist(s)){
					Double Latitude=0.0,Longitude=0.0,Precision=0.0;
					Double Latitudeadmin=1.1,Longitudeadmin=1.1,Precisionadmin=1.1;
					
					// 数据库查询操作
					DatebaseHandler db = new DatebaseHandler();
					db.connSQL();
					try {
						String select = "select * from user_table where openid='"
								+ fromUserName + "'";
						String selectadmin = "select * from temp_table where id=1";
						ResultSet resultSet = db.selectSQL(select);
						ResultSet resultSetadmin = db.selectSQL(selectadmin);
						while (resultSet.next()) {
							Latitude = resultSet.getDouble("latitude");
							Longitude = resultSet.getDouble("longitude");
							Precision = resultSet.getDouble("lprecision");
						}
						while (resultSetadmin.next()) {
							Latitudeadmin = resultSetadmin.getDouble("latitude");
							Longitudeadmin = resultSetadmin.getDouble("longitude");
							Precisionadmin = resultSetadmin.getDouble("lprecision");

						}
						
					} catch (SQLException e) {
						e.printStackTrace();
						respContent = "地理位置查询异常!"+e;
						textMessage.setContent(respContent);
						respMessage = MessageUtil
								.textMessageToXml(textMessage);
					} finally {
						db.deconnSQL();
					}
//					respContent = "laadmin="+Latitudeadmin+"loa="+Longitudeadmin+"LaE"+Math.abs(Latitude-Latitudeadmin)+"LoE"+Math.abs(Longitude-Longitudeadmin);
//				    textMessage.setContent(respContent);
//				    respMessage = MessageUtil.textMessageToXml(textMessage);	
					if(Math.abs(Latitude-Latitudeadmin)<0.001 && Math.abs(Longitude-Longitudeadmin)<0.001)
					{
						String member_name=null,member_number=null;
						int activityid=0;
						// 数据库查询操作
						DatebaseHandler db1 = new DatebaseHandler();
						db1.connSQL();
						try {
							String select = "select * from user_table where openid='"
									+ fromUserName + "'";
							
							ResultSet resultSet = db1.selectSQL(select);
							
							while (resultSet.next()) {
								member_number = resultSet.getString("unionno");
							}

							String select1 = "select * from member where member_number='"+member_number+"'";
							ResultSet resultSet1 = db1.selectSQL(select1);
							while (resultSet1.next()) {
								member_name = resultSet1.getString("member_name");

							}
							
							String select2 = "select * from activity order by activity_id desc limit 0,1";
							ResultSet resultSet2 = db1.selectSQL(select2);
							while (resultSet2.next()) {
								activityid = resultSet2.getInt("activity_id");
							}
							
						} catch (SQLException e) {
							e.printStackTrace();
							respContent = "查询异常!"+e;
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} finally {
							db1.deconnSQL();
						}

						// 数据库插入
						DatebaseHandler db2 = new DatebaseHandler();
						db2.connSQL();
						try {
							String insert = "insert into sign(activity_id,member_name,member_number,gift_taken,group_id) values("+activityid+",'"+member_name+ "','"+member_number+ "', 3,'"+s+"')";
							String insert1 = "insert into record_table(openid,activity_id) values('"+fromUserName+"',"+activityid+")";
                            
							if (db2.insertSQL(insert) == true) {						

							if(	db2.insertSQL(insert1) == true)
							{
							     respContent = "签到成功!";
							     textMessage.setContent(respContent);
							     respMessage = MessageUtil.textMessageToXml(textMessage);
							}
							} else {

								respContent = "二维码用户信息注册失败！";
								textMessage.setContent(respContent);
								respMessage = MessageUtil
										.textMessageToXml(textMessage);
							}
						} catch (Exception e) {
							e.printStackTrace();
							respContent = "数据库插入异常!"+e;
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} finally {
							db2.deconnSQL();
						}
						
	
					}else{
						
			//	    respContent = "请出席活动后再签到!：LaE"+Math.abs(Latitude-Latitudeadmin)+"LoE"+Math.abs(Longitude-Longitudeadmin);
				    respContent = "请出席活动后再签到；如果您已在活动现场签到，请向现场工会工作人员寻求帮助。";
				    textMessage.setContent(respContent);
				    respMessage = MessageUtil.textMessageToXml(textMessage);	
					}
					}
					}
				}					
				//地理位置事件
				else if (eventType.equals(MessageUtil.REQ_MESSAGE_TYPE_LOCATION)) {
					String Latitude = requestMap.get("Latitude");
					String Longitude = requestMap.get("Longitude");
					String Precision = requestMap.get("Precision");

					// 数据库更新操作
					DatebaseHandler db = new DatebaseHandler();
					db.connSQL();
					try {

						String update = "update user_table set latitude='" + Latitude+ "', longitude ='"+ Longitude + "', lprecision ='"+ Precision + "' where openid='" + fromUserName + "'";
						if (db.updateSQL(update) == true) {
							
//							respContent = "定位成功！\n经度:" + Latitude + "。\n维度:" + Longitude + "。\n精度:"
//									+ Precision + "。";
//							textMessage.setContent(respContent);
//							respMessage = MessageUtil
//									.textMessageToXml(textMessage);

							
						} else {
							respContent = "用户定位信息获取失败！";
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						}
					} catch (Exception e) {
						e.printStackTrace();
						respContent = "数据库更新异常:" + e;
						textMessage.setContent(respContent);
						respMessage = MessageUtil
								.textMessageToXml(textMessage);
					} finally {
						db.deconnSQL();
					}

				}
				// 自定义菜单点击事件
				else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {
					// 事件KEY值，与创建自定义菜单时指定的KEY值对应
					String eventKey = requestMap.get("EventKey");
					// 创建图文消息
					NewsMessage newsMessage = new NewsMessage();
					newsMessage.setToUserName(fromUserName);
					newsMessage.setFromUserName(toUserName);
					newsMessage.setCreateTime(new Date().getTime());
					newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
					// newsMessage.setFuncFlag(0);
					List<Article> articleList = new ArrayList<Article>();
					
					if (eventKey.equals("11")) { 	
						if (IsAdminExist(fromUserName))
						{   int unionno = 0;
							Double Latitude = null,Longitude = null,Precision = null;
							// 数据库查询操作
							DatebaseHandler db1 = new DatebaseHandler();
							db1.connSQL();
							try {
								String select = "select * from user_table where openid='"+ fromUserName + "'";
								
								ResultSet resultSet = db1.selectSQL(select);

								while (resultSet.next()) {
									unionno = resultSet.getInt("unionno");
									Latitude = resultSet.getDouble("latitude");
									Longitude = resultSet.getDouble("longitude");
									Precision = resultSet.getDouble("lprecision");
								}
									String update = "update temp_table set unionno='" + unionno+ "', openid ='"+ fromUserName + "', latitude ='"+ Latitude + "', longitude ='"+ Longitude + "', lprecision ='"+ Precision + "' where id=1";
									if (db1.updateSQL(update) == true) {
										
											respContent = "已使用您的位置作为本次活动签到的基准位置！";
											textMessage.setContent(respContent);
											respMessage = MessageUtil
													.textMessageToXml(textMessage);

									}
								
							} catch (SQLException e) {
								e.printStackTrace();
								respContent = "查询异常!";
								textMessage.setContent(respContent);
								respMessage = MessageUtil
										.textMessageToXml(textMessage);
							} finally {
								db1.deconnSQL();
							}
							
							
						}else {						
						int unionno =0;
						// 数据库查询操作
						DatebaseHandler db = new DatebaseHandler();
						db.connSQL();
						try {

							String select = "select * from user_table where openid='"
									+ fromUserName + "'";
							ResultSet resultSet = db.selectSQL(select);
							while (resultSet.next()) {
								unionno = resultSet.getInt("unionno");
							}

						} catch (SQLException e) {
							e.printStackTrace();
							respContent = "查询异常!";
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} finally {
							db.deconnSQL();
						}

						if (unionno==0) {
							respContent = clickmsg;
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} else{
							
							QRTicket ticket = CommonUtil.getTicket(
									getticket("QR_SCENE",300, 17099),
									CommonUtil.gettoken());
							String tk = ticket.getTicket();
							int es = ticket.getExpire_seconds();
							String url = ticket.getUrl();
							String qrUrl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="
									+ java.net.URLEncoder.encode(tk);
						respContent = "请在工会活动指定时间内到达指定地点->打开手机定位及网络->使用微信扫描活动现场的<a href=\""+qrUrl+"\">二维码</a>->签到成功并领取礼物！";						
						textMessage.setContent(respContent);
						respMessage = MessageUtil.textMessageToXml(textMessage);
						}
						}
					}else if (eventKey.equals("12")) {

						String nickname = null;
						int unionno = 0;
						// 数据库查询操作
						DatebaseHandler db = new DatebaseHandler();
						db.connSQL();
						try {

							String select = "select * from user_table where openid='"
									+ fromUserName + "'";
							ResultSet resultSet = db.selectSQL(select);
							while (resultSet.next()) {
								nickname = resultSet.getString("nickname");
								unionno = resultSet.getInt("unionno");
							}

						} catch (SQLException e) {
							e.printStackTrace();
							respContent = "查询异常!";
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} finally {
							db.deconnSQL();
						}

						if (unionno == 0) {
							// 由于href属性值必须用双引号引起，这与字符串本身的双引号冲突，所以要转义
							respContent =clickmsg;
						    textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} else {

							Vector list = new Vector();
							list.addElement("参加记录(默认最多显示前20条)");
							// List list = new ArrayList();
							int i = 0;
							// 数据库查询操作
							DatebaseHandler db1 = new DatebaseHandler();
							db1.connSQL();
							try {

								String select = "select * from record_table where openid='"
										+ fromUserName + "' order by id desc";
								ResultSet resultSet = db1.selectSQL(select);
								while (resultSet.next()) {
									String	activity_name="";
									String activity_id = resultSet.getString("activity_id");
									String time = resultSet.getString("update_time");
									
									String selectact = "select * from activity where activity_id='"
											+ activity_id + "'";
									ResultSet resultSetact = db1.selectSQL(selectact);
									while (resultSetact.next()) {
									activity_name = resultSetact.getString("activity_name");
									}
									
									
									
									i++;
									list.addElement("\n" + i + "、活动名称： "+ activity_name +"，签到时间：" + time);
									if (i > 20)
										break;
								}

							} catch (SQLException e) {
								e.printStackTrace();
								respContent = "查询访客记录异常!";
								textMessage.setContent(respContent);
								respMessage = MessageUtil
										.textMessageToXml(textMessage);
							} finally {
								db1.deconnSQL();
							}

							if (i == 0) {
								respContent = "无参加记录";
								textMessage.setContent(respContent);
								respMessage = MessageUtil
										.textMessageToXml(textMessage);
							} else {
								respContent = "" + list;
								textMessage.setContent(respContent);
								respMessage = MessageUtil
										.textMessageToXml(textMessage);
							}
						}
					} else if (eventKey.equals("13")) {
						String nickname = null;
						int unionno = 0;
						// 数据库查询操作
						DatebaseHandler db = new DatebaseHandler();
						db.connSQL();
						try {

							String select = "select * from user_table where openid='"
									+ fromUserName + "'";
							ResultSet resultSet = db.selectSQL(select);
							while (resultSet.next()) {
								nickname = resultSet.getString("nickname");
								unionno = resultSet.getInt("unionno");
							}

						} catch (SQLException e) {
							e.printStackTrace();
							respContent = "查询异常!";
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} finally {
							db.deconnSQL();
						}

						if (unionno==0) {
							respContent = clickmsg;
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						} else {
							respContent = "您的微信号为：" + nickname + "\n您的工号为：0"+unionno+"\n您的微信号已经与FNST工会会员绑定!";
							textMessage.setContent(respContent);
							respMessage = MessageUtil
									.textMessageToXml(textMessage);
						}
					} else if (eventKey.equals("31")) {

						StringBuffer contentMsg = new StringBuffer();
						contentMsg.append(
								"您好" + emoji(0x1F603)
										+ "，我是会员帮助指南，请回复相应数字选择帮助内容：")
								.append("\n\n");
						contentMsg.append("1 关于活动签到").append("\n");
						contentMsg.append("2 关于账号绑定").append("\n");
						contentMsg.append("3 免责声明").append("\n\n");
						contentMsg.append("如有其它疑问请直接点击“反馈建议”").append("\n");
						textMessage.setContent(contentMsg.toString());
						// 将文本消息对象转换成xml字符串
						respMessage = MessageUtil.textMessageToXml(textMessage);

					} else if (eventKey.equals("32")) {
						respContent = "欢迎反馈建议！\n反馈时请您以“反馈：”开头，再输入您要反馈的内容。您的每一个意见都是我们宝贵的财富。";
						textMessage.setContent(respContent);
						respMessage = MessageUtil.textMessageToXml(textMessage);

					}
				}

			} else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_VOICE)) { // 语音识别结果
				String recognition = requestMap.get("Recognition");
				respContent = "语音识别结果为:" + recognition;
				textMessage.setContent(respContent);
				respMessage = MessageUtil.textMessageToXml(textMessage);
			} 

			else {
				StringBuffer contentMsg = new StringBuffer();
				contentMsg.append(
						"您好" + emoji(0x1F603)
								+ "，我是会员帮助指南，请回复相应数字选择帮助内容：")
						.append("\n\n");
				contentMsg.append("1 关于活动签到").append("\n");
				contentMsg.append("2 关于账号绑定").append("\n");
				contentMsg.append("3 免责声明").append("\n\n");
				contentMsg.append("如有其它疑问请直接点击“反馈建议”").append("\n");
				textMessage.setContent(contentMsg.toString());
				// 将文本消息对象转换成xml字符串
				respMessage = MessageUtil.textMessageToXml(textMessage);
//				// 创建图文消息
//				NewsMessage mainMessage = new NewsMessage();
//				mainMessage.setToUserName(fromUserName);
//				mainMessage.setFromUserName(toUserName);
//				mainMessage.setCreateTime(new Date().getTime());
//				mainMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
//				// mainMessage.setFuncFlag(0);
//				List<Article> mainList = new ArrayList<Article>();
//
//				Article mainarticle = new Article();
//				mainarticle.setTitle("工会活动公告");
//				// 图文消息中可以使用QQ表情、符号表情
//				mainarticle.setDescription("工会活动公告");
//				// 将图片置为空
//				mainarticle.setPicUrl("");
//				mainarticle.setUrl("");
//
//				mainList.add(mainarticle);
//				mainMessage.setArticleCount(mainList.size());
//				mainMessage.setArticles(mainList);
//				respMessage = MessageUtil.newsMessageToXml(mainMessage);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return respMessage;
	}

	private static boolean empty(String recognition) {
		// TODO Auto-generated method stub
		return false;
	}

	public void massmsg(){
		
		
		
	}
	
	// 发送模板消息
	public static void send_template_message(String openId, String TITLE,
			String DATE, String LOCATION, String NOTICE,String USER) {
		String access_token = CommonUtil.gettoken();
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="
				+ access_token;

		TemplateMassage temp = new TemplateMassage();
		Data data = new Data();
		Data_Title title = new Data_Title();
		Data_Date date = new Data_Date();
		Data_Location location = new Data_Location();
		Data_Notice notice = new Data_Notice();
		Data_User user = new Data_User();
		
		// SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//
		// 当前时间
		// String date = df.format(new Date()) + "";

		title.setValue(TITLE);
		title.setColor("#FF0000");
		date.setValue(DATE);
		date.setColor("#173177");
		location.setValue(LOCATION);
		location.setColor("#000000");
		notice.setValue(NOTICE);
		notice.setColor("#000000");
		user.setValue(USER);
		user.setColor("#000000");


		data.setTitle(title);
		data.setDate(date);
		data.setLocation(location);
		data.setNotice(notice);
		data.setUser(user);
		temp.setTouser(openId);// 用户的OPEN ID
		temp.setTemplate_id("Yu4BfAaEK7W3zgqhPEQH0DYOQdIGOV1XnzsXrE-_74Q");
		temp.setUrl("http://1.unionsys.sinaapp.com/activity.jsp");
		temp.setTopcolor("#FF0000");
		temp.setData(data);

		String jsonString = JSONObject.fromObject(temp).toString()
				.replace("day", "Day");
		JSONObject jsonObject = CommonUtil.httpsRequest(url, "POST", jsonString);
		System.out.println("TemplateMessage" + jsonObject);
		int result = 0;
		if (null != jsonObject) {
			if (0 != jsonObject.getInt("errcode")) {
				result = jsonObject.getInt("errcode");
				log.error("错误 errcode:{} errmsg:{}",
						jsonObject.getInt("errcode"),
						jsonObject.getString("errmsg"));
			}
		}
		log.info("模板消息发送结果：" + result);
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

	/**
	 * emoji表情转换(hex -> utf-16)
	 * 
	 * @param hexEmoji
	 * @return
	 */
	public static String emoji(int hexEmoji) {
		return String.valueOf(Character.toChars(hexEmoji));
	}

	public static boolean IsUserExist(String openid) {
		int i = 0;
		// 数据库查询操作
		DatebaseHandler db = new DatebaseHandler();
		db.connSQL();
		try {

			String select = "select * from user_table where openid='" + openid
					+ "'";
			ResultSet resultSet = db.selectSQL(select);
			while (resultSet.next()) {
				// a = resultSet.getString("access_token");
				// b = resultSet.getInt("expiresin_time");
				i++;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.printf("查询异常!" + e);
		} finally {
			db.deconnSQL();
		}
		if (i == 0)
			return false;
		else
			return true;

	}
	public static boolean IsAdminExist(String openid) {
		int i = 0;
		// 数据库查询操作
		DatebaseHandler db = new DatebaseHandler();
		db.connSQL();
		try {

			String select = "select * from admin where wechatid='" + openid
					+ "'";
			ResultSet resultSet = db.selectSQL(select);
			while (resultSet.next()) {
				// a = resultSet.getString("access_token");
				// b = resultSet.getInt("expiresin_time");
				i++;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.printf("查询异常!" + e);
		} finally {
			db.deconnSQL();
		}
		if (i == 0)
			return false;
		else
			return true;

	}
	public static boolean IsGroupExist(String scanid) {
		int i = 0;
		// 数据库查询操作
		DatebaseHandler db = new DatebaseHandler();
		db.connSQL();
		try {

			String select = "select * from admin where admin_name='" + scanid
					+ "'";
			ResultSet resultSet = db.selectSQL(select);
			while (resultSet.next()) {
				// a = resultSet.getString("access_token");
				// b = resultSet.getInt("expiresin_time");
				i++;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.printf("查询异常!" + e);
		} finally {
			db.deconnSQL();
		}
		if (i == 0)
			return false;
		else
			return true;

	}

}
