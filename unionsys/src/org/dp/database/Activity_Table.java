package org.dp.database;


public class Activity_Table {
	private Integer activity_id;
	private String activity_name;
	private String date1;
	private String start_time;
	private String stop_time;
	private String place;
	private String content;
	private String notice;
	private String gift;
	private Integer gift_pre_num;
	private Integer gift_real_num;
	private Double participation_rate;
	private String publisher;
	

	public void setActivity_id(Integer activity_id) {
		this.activity_id = activity_id;
	}

	public Integer getActivity_id() {
		return activity_id;
	}

	public void setActivity_name(String activity_name) {
		this.activity_name = activity_name;
	}

	public String getActivity_name() {
		return activity_name;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getPlace() {
		return place;
	}

	public void setGift(String gift) {
		this.gift = gift;
	}

	public String getGift() {
		return gift;
	}

	public void setGift_pre_num(Integer gift_pre_num) {
		this.gift_pre_num = gift_pre_num;
	}

	public Integer getGift_pre_num() {
		return gift_pre_num;
	}

	public void setGift_real_num(Integer gift_real_num) {
		this.gift_real_num = gift_real_num;
	}

	public Integer getGift_real_num() {
		return gift_real_num;
	}
    
	public Double getParticipation_rate() {
		return participation_rate;
	}

	public void setParticipation_rate(Double participation_rate) {
		this.participation_rate = participation_rate;
	}
  public static void main(String[] args){
		
	}

public String getContent() {
	return content;
}

public void setContent(String content) {
	this.content = content;
}

public String getNotice() {
	return notice;
}

public void setNotice(String notice) {
	this.notice = notice;
}

public String getDate1() {
	return date1;
}

public void setDate1(String date1) {
	this.date1 = date1;
}

public String getStart_time() {
	return start_time;
}

public void setStart_time(String start_time) {
	this.start_time = start_time;
}

public String getStop_time() {
	return stop_time;
}

public void setStop_time(String stop_time) {
	this.stop_time = stop_time;
}

public String getPublisher() {
	return publisher;
}

public void setPublisher(String publisher) {
	this.publisher = publisher;
}
	
}
