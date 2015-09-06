package com.wuxincheng.util;

import org.springframework.util.StringUtils;

import com.wuxincheng.manage.model.EventType;

public class NktTagUtil {

	public static String eventType(String eventType){
		if (StringUtils.isEmpty(eventType)) {
			return null;
		}
		return EventType.getValue(eventType);
	}
	
	public static String eventState(String eventState){
		if (StringUtils.isEmpty(eventState)) {
			return null;
		}
		if ("0".equals(eventState)) {
			return "未发布";
		}
		if ("1".equals(eventState)) {
			return "已发布";
		}
		return null;
	}
	
}
