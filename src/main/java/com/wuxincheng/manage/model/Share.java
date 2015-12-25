package com.wuxincheng.manage.model;

import java.io.Serializable;

/**
 * 内容分享
 * 
 * @author wuxincheng
 * 
 */
public class Share implements Serializable {

	private static final long serialVersionUID = 1L;

	private String shareid;

	/** P:图片, A:文字 */
	private String shareType;

	/** 分享内容 */
	private String shareContent;

	/** 分享图片 */
	private String shareImage;

	/** 所属标签 */
	private String shareTag;

	/** 分享时间 */
	private String shareTime;

	/** 分享状态 */
	private String shareState;

	public String getShareid() {
		return shareid;
	}

	public void setShareid(String shareid) {
		this.shareid = shareid;
	}

	public String getShareType() {
		return shareType;
	}

	public void setShareType(String shareType) {
		this.shareType = shareType;
	}

	public String getShareContent() {
		return shareContent;
	}

	public String getShareTag() {
		return shareTag;
	}

	public void setShareTag(String shareTag) {
		this.shareTag = shareTag;
	}

	public void setShareContent(String shareContent) {
		this.shareContent = shareContent;
	}

	public String getShareImage() {
		return shareImage;
	}

	public void setShareImage(String shareImage) {
		this.shareImage = shareImage;
	}

	public String getShareTime() {
		return shareTime;
	}

	public void setShareTime(String shareTime) {
		this.shareTime = shareTime;
	}

	public String getShareState() {
		return shareState;
	}

	public void setShareState(String shareState) {
		this.shareState = shareState;
	}

}
