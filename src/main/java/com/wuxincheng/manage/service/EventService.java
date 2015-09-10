package com.wuxincheng.manage.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.wuxincheng.manage.dao.EventDao;
import com.wuxincheng.manage.model.Event;
import com.wuxincheng.manage.model.EventType;
import com.wuxincheng.util.DateUtil;

@Service("eventService")
public class EventService {

	@Resource
	private EventDao eventDao;

	/**
	 * 按分类分页查询活动列表
	 * 
	 * @param eventType
	 *            活动类型, 详细见EventType类
	 * @param startIndex
	 *            数据开始
	 * @param endIndex
	 *            数据结束
	 * @param currentPager
	 *            当前页码
	 * @param pagerSize
	 *            每页显示记录数
	 * @return
	 */
	public Map<String, Object> queryForPager(String eventType, String currentPager, int pagerSize) {
		if (StringUtils.isEmpty(eventType)) {
			// return null;
		}

		if (StringUtils.isEmpty(EventType.getValue(eventType))) {
			// return null;
		}

		Map<String, Object> pager = new HashMap<String, Object>();

		int startIndex = 0;
		int endIndex = 0;

		// 查询条件Map封装
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("eventType", eventType);
		queryMap.put("startIndex", startIndex);
		queryMap.put("endIndex", endIndex);
		List<Event> events = eventDao.queryPagerByMap(queryMap);

		// 查询总记录数
		int countSum = eventDao.queryCountByEventType(eventType);

		pager.put("eventType", eventType);
		pager.put("startIndex", startIndex);
		pager.put("endIndex", endIndex);
		pager.put("countSum", countSum);
		pager.put("events", events);
		pager.put("currentPager", currentPager);
		pager.put("pagerSize", pagerSize);

		return pager;
	}

	/**
	 * 根据主键查询
	 * 
	 * @param eventid
	 * @return
	 */
	public Event queryDetailById(String eventid) {
		if (StringUtils.isEmpty(eventid)) {
			return null;
		}
		return eventDao.queryDetailById(eventid);
	}

	/**
	 * 保存数据
	 * 
	 * @param event
	 * @return
	 */
	public String save(Event event, String currentUser) throws Exception {
		String responseMessage = null;
		// 检查数据项
		if (StringUtils.isEmpty(event.getEventTitle())) {
			responseMessage = "发布标题不能为空";
			return responseMessage;
		}

		if (!"2".equals(event.getEventType())) { // 发布公告不需要验证图片和简介
			if (StringUtils.isEmpty(event.getEventIndexImg())) {
				responseMessage = "首页图片链接不能为空";
				return responseMessage;
			}

			if (StringUtils.isEmpty(event.getEventSubTitle())) {
				responseMessage = "发布简介不能为空";
				return responseMessage;
			}
		}

		if (StringUtils.isEmpty(event.getEventContent())) {
			responseMessage = "发布内容不能为空";
			return responseMessage;
		}

		String currentDate = DateUtil.getCurrentDate(new Date(), "yyyy-MM-dd HH:mm:ss");
		
		if (StringUtils.isNotEmpty(event.getEventid())) { 
			// 封装一些数据
			event.setUpdateTime(currentDate);
			event.setCreater(currentUser);
			// 更新
			eventDao.update(event);
		} else {
			// 封装一些数据
			event.setReadSum(0);
			event.setLikeSum(0);
			event.setCommentSum(0);
			event.setEventTag(event.getEventType());
			event.setCreater(currentUser);
			event.setCreateTime(currentDate);
			event.setUpdateTime(currentDate);
			// 新增
			eventDao.insert(event);
		}

		return responseMessage;
	}

	/**
	 * 删除
	 * 
	 * @param eventid
	 */
	public void deleteById(String eventid) {
		if (StringUtils.isEmpty(eventid)) {
			return;
		}
		eventDao.deleteById(eventid);
	}

}
