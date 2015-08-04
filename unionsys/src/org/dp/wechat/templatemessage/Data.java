package org.dp.wechat.templatemessage;
/**
 * 新推送通知-模板消息详细内容实体类
 * @author DP
 *
 */
public class Data {
    private Data_Title title;//标题
    
    private Data_Date date; //日期
    
    private Data_Location location; //地点
   
    private Data_Notice notice; //注意事项
    
    private Data_User user; //发布者姓名

	public Data_Title getTitle() {
		return title;
	}

	public void setTitle(Data_Title title) {
		this.title = title;
	}

	public Data_Date getDate() {
		return date;
	}

	public void setDate(Data_Date date) {
		this.date = date;
	}

	public Data_Location getLocation() {
		return location;
	}

	public void setLocation(Data_Location location) {
		this.location = location;
	}

	public Data_Notice getNotice() {
		return notice;
	}

	public void setNotice(Data_Notice notice) {
		this.notice = notice;
	}

	public Data_User getUser() {
		return user;
	}

	public void setUser(Data_User user) {
		this.user = user;
	}


}
