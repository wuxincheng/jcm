package com.wuxincheng.manage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.wuxincheng.manage.dao.EventDao;
import com.wuxincheng.manage.model.Event;
import com.wuxincheng.manage.model.EventType;

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
			return null;
		}

		if (StringUtils.isEmpty(EventType.getValue(eventType))) {
			return null;
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
	public String save(Event event) throws Exception {
		// 检查数据项
		
		// TODO Auto-generated method stub
		
		return null;
	}

	/**
	 * 删除
	 * 
	 * @param eventid
	 */
	public void deleteById(String eventid) {
		if (StringUtils.isEmpty(eventid)) {
			return ;
		}
		eventDao.deleteById(eventid);
	}

}
