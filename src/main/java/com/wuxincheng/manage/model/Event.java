package com.wuxincheng.manage.model;

import java.io.Serializable;

/**
 * 活动、公告、讲道、见证等
 * 
 * @author wuxincheng
 * 
 */
public class Event implements Serializable {

	private static final long serialVersionUID = 7893687670005968056L;

	/** 主键 */
	private String eventid;

	/** 用于在列表显示的图片 */
	private String eventIndexImg;

	/** 标题 */
	private String eventTitle;

	/** 副标题 */
	private String eventSubTitle;

	/** 内容 */
	private String eventContent;

	/** 类型：1-活动、2-公告、3-讲道、4-见证 */
	private String eventType;

	/** 标签：1-活动、2-公告、3-讲道、4-见证 */
	private String eventTag;

	/** 阅读次数 */
	private Integer readSum;

	/** 赞同次数 */
	private Integer likeSum;

	/** 评论次数 */
	private Integer commentSum;

	/** 发布人 */
	private String creater;

	/** 创建时间 */
	private String createTime;

	/** 更新时间 */
	private String updateTime;

	/** 状态 */
	private String eventState;

	public String getEventid() {
		return eventid;
	}

	public void setEventid(String eventid) {
		this.eventid = eventid;
	}

	public String getEventTitle() {
		return eventTitle;
	}

	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}

	public String getEventContent() {
		return eventContent;
	}

	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}

	public String getEventType() {
		return eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getEventState() {
		return eventState;
	}

	public void setEventState(String eventState) {
		this.eventState = eventState;
	}

	public String getEventIndexImg() {
		return eventIndexImg;
	}

	public void setEventIndexImg(String eventIndexImg) {
		this.eventIndexImg = eventIndexImg;
	}

	public String getEventSubTitle() {
		return eventSubTitle;
	}

	public void setEventSubTitle(String eventSubTitle) {
		this.eventSubTitle = eventSubTitle;
	}

	public Integer getReadSum() {
		return readSum;
	}

	public void setReadSum(Integer readSum) {
		this.readSum = readSum;
	}

	public Integer getLikeSum() {
		return likeSum;
	}

	public void setLikeSum(Integer likeSum) {
		this.likeSum = likeSum;
	}

	public Integer getCommentSum() {
		return commentSum;
	}

	public void setCommentSum(Integer commentSum) {
		this.commentSum = commentSum;
	}

	public String getEventTag() {
		return eventTag;
	}

	public void setEventTag(String eventTag) {
		this.eventTag = eventTag;
	}

}
