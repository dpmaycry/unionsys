package org.dp.wechat.message.resp;

/**
 * 音乐消息
 * 
 * @author DP
 * 
 */
public class MusicMessage extends BaseMessage {
	// 音乐
	private Music Music;

	public Music getMusic() {
		return Music;
	}

	public void setMusic(Music music) {
		Music = music;
	}
}