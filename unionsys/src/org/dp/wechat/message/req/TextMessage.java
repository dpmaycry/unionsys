package org.dp.wechat.message.req;

/**
 * 文本消息
 * 
 * @author DP
 *
 */
public class TextMessage extends BaseMessage {
	// 消息内容
	private String Content;

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}
}