package com.wuxincheng.manage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.wuxincheng.manage.model.Event;

@Repository("eventDao")
public class EventDao extends BaseDao {

	@SuppressWarnings("unchecked")
	public List<Event> queryPagerByMap(Map<String, Object> queryMap) {
		return this.getSqlMapClientTemplate().queryForList("Event.queryPagerByMap", queryMap);
	}

	public int queryCountByEventType(String eventType) {
		return (Integer) this.getSqlMapClientTemplate().queryForObject(
				"Event.queryCountByEventType", eventType);
	}

	public Event queryDetailById(String eventid) {
		return (Event) this.getSqlMapClientTemplate().queryForObject("Event.queryDetailById",
				eventid);
	}

	public void deleteById(String eventid) {
		this.getSqlMapClientTemplate().delete("Event.deleteById", eventid);
	}

	public void update(Event event) {
		this.getSqlMapClientTemplate().update("Event.update", event);
	}

	public void insert(Event event) {
		this.getSqlMapClientTemplate().insert("Event.insert", event);
	}

}
