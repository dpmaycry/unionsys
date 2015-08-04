package org.dp.wechat.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.dp.wechat.pojo.SNSUserInfo;
import org.dp.wechat.pojo.WeixinGroup;
import org.dp.wechat.pojo.WeixinMedia;
import org.dp.wechat.pojo.Oauth2Token;
import org.dp.wechat.pojo.QRTicket;
import org.dp.wechat.pojo.WeixinUserInfo;
import org.dp.wechat.pojo.WeixinUserList;
import org.dp.wechat.message.resp.Article;
import org.dp.wechat.message.resp.Music;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * AdvancedUtil
 * 
 * @author DP
 * @date 2013-11-9
 */
public class AdvancedUtil {
	private static Logger log = LoggerFactory.getLogger(AdvancedUtil.class);

	/**
	 * makeTextCustomMessage
	 * 
	 * @param openId 
	 * @param content 
	 * @return
	 */
	public static String makeTextCustomMessage(String openId, String content) {
		// ����Ϣ�����е�˫��Ž���ת��
		content = content.replace("\"", "\\\"");
		String jsonMsg = "{\"touser\":\"%s\",\"msgtype\":\"text\",\"text\":{\"content\":\"%s\"}}";
		return String.format(jsonMsg, openId, content);
	}

	/**
	 * ��װͼƬ�ͷ���Ϣ
	 * 
	 * @param openId ��Ϣ���Ͷ���
	 * @param mediaId ý���ļ�id
	 * @return
	 */
	public static String makeImageCustomMessage(String openId, String mediaId) {
		String jsonMsg = "{\"touser\":\"%s\",\"msgtype\":\"image\",\"image\":{\"media_id\":\"%s\"}}";
		return String.format(jsonMsg, openId, mediaId);
	}

	/**
	 * ��װ�����ͷ���Ϣ
	 * 
	 * @param openId ��Ϣ���Ͷ���
	 * @param mediaId ý���ļ�id
	 * @return
	 */
	public static String makeVoiceCustomMessage(String openId, String mediaId) {
		String jsonMsg = "{\"touser\":\"%s\",\"msgtype\":\"voice\",\"voice\":{\"media_id\":\"%s\"}}";
		return String.format(jsonMsg, openId, mediaId);
	}

	/**
	 * ��װ��Ƶ�ͷ���Ϣ
	 * 
	 * @param openId ��Ϣ���Ͷ���
	 * @param mediaId ý���ļ�id
	 * @param thumbMediaId ��Ƶ��Ϣ����ͼ��ý��id
	 * @return
	 */
	public static String makeVideoCustomMessage(String openId, String mediaId, String thumbMediaId) {
		String jsonMsg = "{\"touser\":\"%s\",\"msgtype\":\"video\",\"video\":{\"media_id\":\"%s\",\"thumb_media_id\":\"%s\"}}";
		return String.format(jsonMsg, openId, mediaId, thumbMediaId);
	}

	/**
	 * ��װ���ֿͷ���Ϣ
	 * 
	 * @param openId ��Ϣ���Ͷ���
	 * @param music ���ֶ���
	 * @return
	 */
	public static String makeMusicCustomMessage(String openId, Music music) {
		String jsonMsg = "{\"touser\":\"%s\",\"msgtype\":\"music\",\"music\":%s}";
		jsonMsg = String.format(jsonMsg, openId, JSONObject.fromObject(music).toString());
		// ��jsonMsg�е�thumbmediaid�滻Ϊthumb_media_id
		jsonMsg = jsonMsg.replace("thumbmediaid", "thumb_media_id");
		return jsonMsg;
	}

	/**
	 * ��װͼ�Ŀͷ���Ϣ
	 * 
	 * @param openId ��Ϣ���Ͷ���
	 * @param articleList ͼ����Ϣ�б�
	 * @return
	 */
	public static String makeNewsCustomMessage(String openId, List<Article> articleList) {
		String jsonMsg = "{\"touser\":\"%s\",\"msgtype\":\"news\",\"news\":{\"articles\":%s}}";
		jsonMsg = String.format(jsonMsg, openId, JSONArray.fromObject(articleList).toString().replaceAll("\"", "\\\""));
		// ��jsonMsg�е�picUrl�滻Ϊpicurl
		jsonMsg = jsonMsg.replace("picUrl", "picurl");
		return jsonMsg;
	}

	/**
	 * ���Ϳͷ���Ϣ
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param jsonMsg json��ʽ�Ŀͷ���Ϣ������touser��msgtype����Ϣ���ݣ�
	 * @return true | false
	 */
	public static boolean sendCustomMessage(String accessToken, String jsonMsg) {
		log.info("��Ϣ���ݣ�{}", jsonMsg);
		boolean result = false;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		// ���Ϳͷ���Ϣ
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "POST", jsonMsg);

		if (null != jsonObject) {
			int errorCode = jsonObject.getInt("errcode");
			String errorMsg = jsonObject.getString("errmsg");
			if (0 == errorCode) {
				result = true;
				log.info("�ͷ���Ϣ���ͳɹ� errcode:{} errmsg:{}", errorCode, errorMsg);
			} else {
				log.error("�ͷ���Ϣ����ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}

		return result;
	}

	/**
	 * ��ȡ��ҳ��Ȩƾ֤
	 * 
	 * @param appId �����˺ŵ�Ψһ��ʶ
	 * @param appSecret �����˺ŵ���Կ
	 * @param code
	 * @return WeixinAouth2Token
	 */
	public static Oauth2Token getOauth2AccessToken(String appId, String appSecret, String code) {
		Oauth2Token wat = null;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
		requestUrl = requestUrl.replace("APPID", appId);
		requestUrl = requestUrl.replace("SECRET", appSecret);
		requestUrl = requestUrl.replace("CODE", code);
		// ��ȡ��ҳ��Ȩƾ֤
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);
		if (null != jsonObject) {
			try {
				wat = new Oauth2Token();
				wat.setAccessToken(jsonObject.getString("access_token"));
				wat.setExpiresIn(jsonObject.getInt("expires_in"));
				wat.setRefreshToken(jsonObject.getString("refresh_token"));
				wat.setOpenId(jsonObject.getString("openid"));
				wat.setScope(jsonObject.getString("scope"));
			} catch (Exception e) {
				wat = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("��ȡ��ҳ��Ȩƾ֤ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return wat;
	}

	/**
	 * ˢ����ҳ��Ȩƾ֤
	 * 
	 * @param appId �����˺ŵ�Ψһ��ʶ
	 * @param refreshToken
	 * @return WeixinAouth2Token
	 */
	public static Oauth2Token refreshOauth2AccessToken(String appId, String refreshToken) {
		Oauth2Token wat = null;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=APPID&grant_type=refresh_token&refresh_token=REFRESH_TOKEN";
		requestUrl = requestUrl.replace("APPID", appId);
		requestUrl = requestUrl.replace("REFRESH_TOKEN", refreshToken);
		// ˢ����ҳ��Ȩƾ֤
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);
		if (null != jsonObject) {
			try {
				wat = new Oauth2Token();
				wat.setAccessToken(jsonObject.getString("access_token"));
				wat.setExpiresIn(jsonObject.getInt("expires_in"));
				wat.setRefreshToken(jsonObject.getString("refresh_token"));
				wat.setOpenId(jsonObject.getString("openid"));
				wat.setScope(jsonObject.getString("scope"));
			} catch (Exception e) {
				wat = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("ˢ����ҳ��Ȩƾ֤ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return wat;
	}

	/**
	 * ͨ����ҳ��Ȩ��ȡ�û���Ϣ
	 * 
	 * @param accessToken ��ҳ��Ȩ�ӿڵ���ƾ֤
	 * @param openId �û���ʶ
	 * @return SNSUserInfo
	 */
	@SuppressWarnings( { "deprecation", "unchecked" })
	public static SNSUserInfo getSNSUserInfo(String accessToken, String openId) {
		SNSUserInfo snsUserInfo = null;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
		// ͨ����ҳ��Ȩ��ȡ�û���Ϣ
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);

		if (null != jsonObject) {
			try {
				snsUserInfo = new SNSUserInfo();
				// �û��ı�ʶ
				snsUserInfo.setOpenId(jsonObject.getString("openid"));
				// �ǳ�
				snsUserInfo.setNickname(jsonObject.getString("nickname"));
				// �Ա�1�����ԣ�2��Ů�ԣ�0��δ֪��
				snsUserInfo.setSex(jsonObject.getInt("sex"));
				// �û����ڹ��
				snsUserInfo.setCountry(jsonObject.getString("country"));
				// �û�����ʡ��
				snsUserInfo.setProvince(jsonObject.getString("province"));
				// �û����ڳ���
				snsUserInfo.setCity(jsonObject.getString("city"));
				// �û�ͷ��
				snsUserInfo.setHeadImgUrl(jsonObject.getString("headimgurl"));
				// �û���Ȩ��Ϣ
				snsUserInfo.setPrivilegeList(JSONArray.toList(jsonObject.getJSONArray("privilege"), List.class));
			} catch (Exception e) {
				snsUserInfo = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("��ȡ�û���Ϣʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return snsUserInfo;
	}

	/**
	 * ������ʱ��ζ�ά��
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param expireSeconds ��ά����Чʱ�䣬��λΪ�룬��󲻳���1800
	 * @param sceneId ����ID
	 * @return WeixinQRCode
	 */
	public static QRTicket createTemporaryQRCode(String accessToken, int expireSeconds, int sceneId) {
		QRTicket weixinQRCode = null;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		// ��Ҫ�ύ��json���
		String jsonMsg = "{\"expire_seconds\": %d, \"action_name\": \"QR_SCENE\", \"action_info\": {\"scene\": {\"scene_id\": %d}}}";
		// ������ʱ��ζ�ά��
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "POST", String.format(jsonMsg, expireSeconds, sceneId));

		if (null != jsonObject) {
			try {
				weixinQRCode = new QRTicket();
				weixinQRCode.setTicket(jsonObject.getString("ticket"));
				weixinQRCode.setExpire_seconds(jsonObject.getInt("expire_seconds"));
				log.info("������ʱ��ζ�ά��ɹ� ticket:{} expire_seconds:{}", weixinQRCode.getTicket(), weixinQRCode.getExpire_seconds());
			} catch (Exception e) {
				weixinQRCode = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("������ʱ��ζ�ά��ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return weixinQRCode;
	}

	/**
	 * �������ô�ζ�ά��
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param sceneId ����ID
	 * @return ticket
	 */
	public static String createPermanentQRCode(String accessToken, int sceneId) {
		String ticket = null;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		// ��Ҫ�ύ��json���
		String jsonMsg = "{\"action_name\": \"QR_LIMIT_SCENE\", \"action_info\": {\"scene\": {\"scene_id\": %d}}}";
		// �������ô�ζ�ά��
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "POST", String.format(jsonMsg, sceneId));

		if (null != jsonObject) {
			try {
				ticket = jsonObject.getString("ticket");
				log.info("�������ô�ζ�ά��ɹ� ticket:{}", ticket);
			} catch (Exception e) {
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("�������ô�ζ�ά��ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return ticket;
	}

	/**
	 * ���ticket��ȡ��ά��
	 * 
	 * @param ticket ��ά��ticket
	 * @param savePath ����·��
	 */
	public static String getQRCode(String ticket, String savePath) {
		String filePath = null;
		// ƴ�������ַ
		String requestUrl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=TICKET";
		requestUrl = requestUrl.replace("TICKET", CommonUtil.urlEncodeUTF8(ticket));
		try {
			URL url = new URL(requestUrl);
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
			conn.setDoInput(true);
			conn.setRequestMethod("GET");

			if (!savePath.endsWith("/")) {
				savePath += "/";
			}
			// ��ticket��Ϊ�ļ���
			filePath = savePath + ticket + ".jpg";

			// ��΢�ŷ��������ص�������д���ļ�
			BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
			FileOutputStream fos = new FileOutputStream(new File(filePath));
			byte[] buf = new byte[8096];
			int size = 0;
			while ((size = bis.read(buf)) != -1)
				fos.write(buf, 0, size);
			fos.close();
			bis.close();

			conn.disconnect();
			log.info("���ticket��ȡ��ά��ɹ���filePath=" + filePath);
		} catch (Exception e) {
			filePath = null;
			log.error("���ticket��ȡ��ά��ʧ�ܣ�{}", e);
		}
		return filePath;
	}

	/**
	 * ��ȡ�û���Ϣ
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param openId �û���ʶ
	 * @return WeixinUserInfo
	 */
	public static WeixinUserInfo getUserInfo(String accessToken, String openId) {
		WeixinUserInfo weixinUserInfo = null;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
		// ��ȡ�û���Ϣ
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);

		if (null != jsonObject) {
			try {
				weixinUserInfo = new WeixinUserInfo();
				// �û��ı�ʶ
				weixinUserInfo.setOpenId(jsonObject.getString("openid"));
				// ��ע״̬��1�ǹ�ע��0��δ��ע����δ��עʱ��ȡ����������Ϣ
				weixinUserInfo.setSubscribe(jsonObject.getInt("subscribe"));
				// �û���עʱ��
				weixinUserInfo.setSubscribeTime(jsonObject.getString("subscribe_time"));
				// �ǳ�
				weixinUserInfo.setNickname(jsonObject.getString("nickname"));
				// �û����Ա�1�����ԣ�2��Ů�ԣ�0��δ֪��
				weixinUserInfo.setSex(jsonObject.getInt("sex"));
				// �û����ڹ��
				weixinUserInfo.setCountry(jsonObject.getString("country"));
				// �û�����ʡ��
				weixinUserInfo.setProvince(jsonObject.getString("province"));
				// �û����ڳ���
				weixinUserInfo.setCity(jsonObject.getString("city"));
				// �û������ԣ���������Ϊzh_CN
				weixinUserInfo.setLanguage(jsonObject.getString("language"));
				// �û�ͷ��
				weixinUserInfo.setHeadImgUrl(jsonObject.getString("headimgurl"));
			} catch (Exception e) {
				if (0 == weixinUserInfo.getSubscribe()) {
					log.error("�û�{}��ȡ���ע", weixinUserInfo.getOpenId());
				} else {
					int errorCode = jsonObject.getInt("errcode");
					String errorMsg = jsonObject.getString("errmsg");
					log.error("��ȡ�û���Ϣʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
				}
			}
		}
		return weixinUserInfo;
	}

	/**
	 * ��ȡ��ע���б�
	 * 
	 * @param accessToken ���ýӿ�ƾ֤
	 * @param nextOpenId ��һ����ȡ��openId������Ĭ�ϴ�ͷ��ʼ��ȡ
	 * @return WeixinUserList
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public static WeixinUserList getUserList(String accessToken, String nextOpenId) {
		WeixinUserList weixinUserList = null;

		if (null == nextOpenId)
			nextOpenId = "";

		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&next_openid=NEXT_OPENID";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("NEXT_OPENID", nextOpenId);
		// ��ȡ��ע���б�
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);
		// �������ɹ�
		if (null != jsonObject) {
			try {
				weixinUserList = new WeixinUserList();
				weixinUserList.setTotal(jsonObject.getInt("total"));
				weixinUserList.setCount(jsonObject.getInt("count"));
				weixinUserList.setNextOpenId(jsonObject.getString("next_openid"));
				JSONObject dataObject = (JSONObject) jsonObject.get("data");
				weixinUserList.setOpenIdList(JSONArray.toList(dataObject.getJSONArray("openid"), List.class));
			} catch (JSONException e) {
				weixinUserList = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("��ȡ��ע���б�ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return weixinUserList;
	}

	/**
	 * ��ѯ����
	 * 
	 * @param accessToken ���ýӿ�ƾ֤
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public static List<WeixinGroup> getGroups(String accessToken) {
		List<WeixinGroup> weixinGroupList = null;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/groups/get?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		// ��ѯ����
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);

		if (null != jsonObject) {
			try {
				weixinGroupList = JSONArray.toList(jsonObject.getJSONArray("groups"), WeixinGroup.class);
			} catch (JSONException e) {
				weixinGroupList = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("��ѯ����ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return weixinGroupList;
	}

	/**
	 * ��������
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param groupName �������
	 * @return
	 */
	public static WeixinGroup createGroup(String accessToken, String groupName) {
		WeixinGroup weixinGroup = null;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/groups/create?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		// ��Ҫ�ύ��json���
		String jsonData = "{\"group\" : {\"name\" : \"%s\"}}";
		// ��������
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "POST", String.format(jsonData, groupName));

		if (null != jsonObject) {
			try {
				weixinGroup = new WeixinGroup();
				weixinGroup.setId(jsonObject.getJSONObject("group").getInt("id"));
				weixinGroup.setName(jsonObject.getJSONObject("group").getString("name"));
			} catch (JSONException e) {
				weixinGroup = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("��������ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return weixinGroup;
	}

	/**
	 * �޸ķ�����
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param groupId ����id
	 * @param groupName �޸ĺ�ķ�����
	 * @return true | false
	 */
	public static boolean updateGroup(String accessToken, int groupId, String groupName) {
		boolean result = false;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/groups/update?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		// ��Ҫ�ύ��json���
		String jsonData = "{\"group\": {\"id\": %d, \"name\": \"%s\"}}";
		// �޸ķ�����
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "POST", String.format(jsonData, groupId, groupName));

		if (null != jsonObject) {
			int errorCode = jsonObject.getInt("errcode");
			String errorMsg = jsonObject.getString("errmsg");
			if (0 == errorCode) {
				result = true;
				log.info("�޸ķ�����ɹ� errcode:{} errmsg:{}", errorCode, errorMsg);
			} else {
				log.error("�޸ķ�����ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return result;
	}

	/**
	 * �ƶ��û�����
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param openId �û���ʶ
	 * @param groupId ����id
	 * @return true | false
	 */
	public static boolean updateMemberGroup(String accessToken, String openId, int groupId) {
		boolean result = false;
		// ƴ�������ַ
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/groups/members/update?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		// ��Ҫ�ύ��json���
		String jsonData = "{\"openid\":\"%s\",\"to_groupid\":%d}";
		// �ƶ��û�����
		JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "POST", String.format(jsonData, openId, groupId));

		if (null != jsonObject) {
			int errorCode = jsonObject.getInt("errcode");
			String errorMsg = jsonObject.getString("errmsg");
			if (0 == errorCode) {
				result = true;
				log.info("�ƶ��û�����ɹ� errcode:{} errmsg:{}", errorCode, errorMsg);
			} else {
				log.error("�ƶ��û�����ʧ�� errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return result;
	}

	/**
	 * �ϴ�ý���ļ�
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param type ý���ļ����ͣ�image��voice��video��thumb��
	 * @param mediaFileUrl ý���ļ���url
	 */
	public static WeixinMedia uploadMedia(String accessToken, String type, String mediaFileUrl) {
		WeixinMedia weixinMedia = null;
		// ƴװ�����ַ
		String uploadMediaUrl = "http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE";
		uploadMediaUrl = uploadMediaUrl.replace("ACCESS_TOKEN", accessToken).replace("TYPE", type);

		// ������ݷָ���
		String boundary = "------------7da2e536604c8";
		try {
			URL uploadUrl = new URL(uploadMediaUrl);
			HttpURLConnection uploadConn = (HttpURLConnection) uploadUrl.openConnection();
			uploadConn.setDoOutput(true);
			uploadConn.setDoInput(true);
			uploadConn.setRequestMethod("POST");
			// ��������ͷContent-Type
			uploadConn.setRequestProperty("Content-Type", "multipart/form-data;boundary=" + boundary);
			// ��ȡý���ļ��ϴ������������΢�ŷ�����д��ݣ�
			OutputStream outputStream = uploadConn.getOutputStream();

			URL mediaUrl = new URL(mediaFileUrl);
			HttpURLConnection meidaConn = (HttpURLConnection) mediaUrl.openConnection();
			meidaConn.setDoOutput(true);
			meidaConn.setRequestMethod("GET");

			// ������ͷ�л�ȡ��������
			String contentType = meidaConn.getHeaderField("Content-Type");
			// ������������ж��ļ���չ��
			String fileExt = CommonUtil.getFileExt(contentType);
			// �����忪ʼ
			outputStream.write(("--" + boundary + "\r\n").getBytes());
			outputStream.write(String.format("Content-Disposition: form-data; name=\"media\"; filename=\"file1%s\"\r\n", fileExt).getBytes());
			outputStream.write(String.format("Content-Type: %s\r\n\r\n", contentType).getBytes());

			// ��ȡý���ļ�������������ȡ�ļ���
			BufferedInputStream bis = new BufferedInputStream(meidaConn.getInputStream());
			byte[] buf = new byte[8096];
			int size = 0;
			while ((size = bis.read(buf)) != -1) {
				// ��ý���ļ�д�����������΢�ŷ�����д��ݣ�
				outputStream.write(buf, 0, size);
			}
			// ���������
			outputStream.write(("\r\n--" + boundary + "--\r\n").getBytes());
			outputStream.close();
			bis.close();
			meidaConn.disconnect();

			// ��ȡý���ļ��ϴ�������������΢�ŷ���������ݣ�
			InputStream inputStream = uploadConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			StringBuffer buffer = new StringBuffer();
			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// �ͷ���Դ
			inputStream.close();
			inputStream = null;
			uploadConn.disconnect();

			// ʹ��JSON-lib�������ؽ��
			JSONObject jsonObject = JSONObject.fromObject(buffer.toString());
			weixinMedia = new WeixinMedia();
			weixinMedia.setType(jsonObject.getString("type"));
			// type����thumbʱ�ķ��ؽ����������Ͳ�һ��
			if ("thumb".equals(type))
				weixinMedia.setMediaId(jsonObject.getString("thumb_media_id"));
			else
				weixinMedia.setMediaId(jsonObject.getString("media_id"));
			weixinMedia.setCreatedAt(jsonObject.getInt("created_at"));
		} catch (Exception e) {
			weixinMedia = null;
			log.error("�ϴ�ý���ļ�ʧ�ܣ�{}", e);
		}
		return weixinMedia;
	}

	/**
	 * ����ý���ļ�
	 * 
	 * @param accessToken �ӿڷ���ƾ֤
	 * @param mediaId ý���ļ���ʶ
	 * @param savePath �ļ��ڷ������ϵĴ洢·��
	 * @return
	 */
	public static String getMedia(String accessToken, String mediaId, String savePath) {
		String filePath = null;
		// ƴ�������ַ
		String requestUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("MEDIA_ID", mediaId);
		System.out.println(requestUrl);
		try {
			URL url = new URL(requestUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoInput(true);
			conn.setRequestMethod("GET");

			if (!savePath.endsWith("/")) {
				savePath += "/";
			}
			// ����������ͻ�ȡ��չ��
			String fileExt = CommonUtil.getFileExt(conn.getHeaderField("Content-Type"));
			// ��mediaId��Ϊ�ļ���
			filePath = savePath + mediaId + fileExt;

			BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
			FileOutputStream fos = new FileOutputStream(new File(filePath));
			byte[] buf = new byte[8096];
			int size = 0;
			while ((size = bis.read(buf)) != -1)
				fos.write(buf, 0, size);
			fos.close();
			bis.close();

			conn.disconnect();
			log.info("����ý���ļ��ɹ���filePath=" + filePath);
		} catch (Exception e) {
			filePath = null;
			log.error("����ý���ļ�ʧ�ܣ�{}", e);
		}
		return filePath;
	}

	public static void main(String args[]) {
		// ��ȡ�ӿڷ���ƾ֤
		String accessToken = CommonUtil.gettoken();

		/**
		 * ���Ϳͷ���Ϣ���ı���Ϣ��
		 */
		// ��װ�ı��ͷ���Ϣ
		String jsonTextMsg = makeTextCustomMessage("oEdzejiHCDqafJbz4WNJtWTMbDcE", "����鿴<a href=\"http://blog.csdn.net/lyq8479\">���Ĳ���</a>");
		// ���Ϳͷ���Ϣ
		sendCustomMessage(accessToken, jsonTextMsg);

		/**
		 * ���Ϳͷ���Ϣ��ͼ����Ϣ��
		 */
		Article article1 = new Article();
		article1.setTitle("΢����Ҳ�ܶ�����");
		article1.setDescription("");
		article1.setPicUrl("http://www.egouji.com/xiaoq/game/doudizhu_big.png");
		article1.setUrl("http://resource.duopao.com/duopao/games/small_games/weixingame/Doudizhu/doudizhu.htm");
		Article article2 = new Article();
		article2.setTitle("������ӥ\n80�󲻵ò���ľ�����Ϸ");
		article2.setDescription("");
		article2.setPicUrl("http://www.egouji.com/xiaoq/game/aoqixiongying.png");
		article2.setUrl("http://resource.duopao.com/duopao/games/small_games/weixingame/Plane/aoqixiongying.html");
		List<Article> list = new ArrayList<Article>();
		list.add(article1);
		list.add(article2);
		// ��װͼ�Ŀͷ���Ϣ
		String jsonNewsMsg = makeNewsCustomMessage("oEdzejiHCDqafJbz4WNJtWTMbDcE", list);
		// ���Ϳͷ���Ϣ
		sendCustomMessage(accessToken, jsonNewsMsg);

		/**
		 * ������ʱ��ά��
		 */
		QRTicket weixinQRCode = createTemporaryQRCode(accessToken, 900, 111111);
		// ��ʱ��ά���ticket
		System.out.println(weixinQRCode.getTicket());
		// ��ʱ��ά�����Чʱ��
		System.out.println(weixinQRCode.getExpire_seconds());

		/**
		 * ���ticket��ȡ��ά��
		 */
		String ticket = "gQEg7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2lIVVJ3VmJsTzFsQ0ZuQ0Y1bG5WAAIEW35+UgMEAAAAAA==";
		String savePath = "G:/download";
		// ���ticket��ȡ��ά��
		getQRCode(ticket, savePath);

		/**
		 * ��ȡ�û���Ϣ
		 */
		WeixinUserInfo user = getUserInfo(accessToken, "oEdzejiHCDqafJbz4WNJtWTMbDcE");
		System.out.println("OpenID��" + user.getOpenId());
		System.out.println("��ע״̬��" + user.getSubscribe());
		System.out.println("��עʱ�䣺" + user.getSubscribeTime());
		System.out.println("�ǳƣ�" + user.getNickname());
		System.out.println("�Ա�" + user.getSex());
		System.out.println("��ң�" + user.getCountry());
		System.out.println("ʡ�ݣ�" + user.getProvince());
		System.out.println("���У�" + user.getCity());
		System.out.println("���ԣ�" + user.getLanguage());
		System.out.println("ͷ��" + user.getHeadImgUrl());

		/**
		 * ��ȡ��ע���б�
		 */
		WeixinUserList weixinUserList = getUserList(accessToken, "");
		System.out.println("�ܹ�ע�û���" + weixinUserList.getTotal());
		System.out.println("���λ�ȡ�û���" + weixinUserList.getCount());
		System.out.println("OpenID�б?" + weixinUserList.getOpenIdList().toString());
		System.out.println("next_openid��" + weixinUserList.getNextOpenId());

		/**
		 * ��ѯ����
		 */
		List<WeixinGroup> groupList = getGroups(accessToken);
		// ѭ�������������Ϣ
		for (WeixinGroup group : groupList) {
			System.out.println(String.format("ID��%d ��ƣ�%s �û���%d", group.getId(), group.getName(), group.getCount()));
		}

		/**
		 * ��������
		 */
		WeixinGroup group = createGroup(accessToken, "��˾Ա��");
		System.out.println(String.format("�ɹ��������飺%s id��%d", group.getName(), group.getId()));

		/**
		 * �޸ķ�����
		 */
		updateGroup(accessToken, 100, "ͬ��");

		/**
		 * �ƶ��û�����
		 */
		updateMemberGroup(accessToken, "oEdzejiHCDqafJbz4WNJtWTMbDcE", 100);

		/**
		 * �ϴ���ý���ļ�
		 */
		WeixinMedia weixinMedia = uploadMedia(accessToken, "voice", "http://localhost:8080/weixinmpapi/test.mp3");
		System.out.println(weixinMedia.getMediaId());
		System.out.println(weixinMedia.getType());
		System.out.println(weixinMedia.getCreatedAt());

		/**
		 * ���ض�ý���ļ�
		 */
		getMedia(accessToken, "N7xWhOGYSLWUMPzVcGnxKFbhXeD_lLT5sXxyxDGEsCzWIB2CcUijSeQOYjWLMpcn", "G:/download");
	}
}
