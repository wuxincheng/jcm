package com.wuxincheng.manage.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wuxincheng.manage.model.Event;
import com.wuxincheng.manage.model.EventType;
import com.wuxincheng.manage.service.EventService;
import com.wuxincheng.util.Constants;

@Controller
@RequestMapping("/manage/event")
public class EventController extends BaseController {
	private static Logger logger = LoggerFactory.getLogger(EventController.class);

	private static final String MANAGE_NAME = Constants.MANAGE_NAME;

	private final Integer pagerSize = 10;

	@Autowired
	private EventService eventService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String eventType, String currentPager) {
		logger.info("{}查询动态列表 eventType={}", MANAGE_NAME, eventType);
		requestMessageProcess(request);
		
		if (StringUtils.isEmpty(EventType.getValue(eventType))) {
			eventType = "3"; // 默认为: 3-教会活动
		}

		Map<String, Object> pager = eventService.queryForPager(eventType, currentPager, pagerSize);

		model.addAttribute("pager", pager);
		
		model.addAttribute("eventTypeMap", EventType.getAll());
		
		model.addAttribute("eventType", eventType);
		model.addAttribute("eventTypeValue", EventType.getValue(eventType));

		return "event/list";
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String eventid) {
		logger.info("{}显示动态详细 eventid={}", MANAGE_NAME, eventid);
		requestMessageProcess(request);

		Event event = eventService.queryDetailById(eventid);

		model.addAttribute("event", event);
		model.addAttribute("eventTypeMap", EventType.getAll());

		return "event/edit";
	}

	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, Model model) {
		logger.info("{}显示编辑动态详细页面", MANAGE_NAME);
		requestMessageProcess(request);
		
		model.addAttribute("eventTypeMap", EventType.getAll());
		
		return "event/edit";
	}

	@RequestMapping(value = "/doEdit")
	public String doEdit(HttpServletRequest request, Model model, Event event) {
		logger.info("{}保存动态详细信息", MANAGE_NAME);

		String currentUser = getCurrentUser(request);
		try {
			String responseMessage = eventService.save(event, currentUser);
			if (StringUtils.isNotEmpty(responseMessage)) {
				model.addAttribute(Constants.MSG_WARN, responseMessage);
				logger.warn("保存失败：{}", responseMessage);
				model.addAttribute("eventid", event.getEventid());
				request.getSession().setAttribute("event", event);
				logger.info("eventid={}", event.getEventid());
				// StringUtils.isEmpty(event.getEventid()) ? "redirect:edit" : "redirect:detail";
				return "redirect:edit"; 
			}
		} catch (Exception e) {
			model.addAttribute(Constants.MSG_ERROR, "保存异常, 请联系管理员");
			return "event/edit";
		}

		model.addAttribute(Constants.MSG_SUCCESS, "保存成功");
		request.getSession().removeAttribute("event"); // 清缓存
		
		model.addAttribute("eventType", event.getEventType());

		return "redirect:list";
	}

	@RequestMapping(value = "/delete")
	public String delete(Model model, String eventid) {
		logger.info("{}删除动态 eventid={}", MANAGE_NAME, eventid);

		eventService.deleteById(eventid);
		model.addAttribute(Constants.MSG_SUCCESS, "删除成功");

		return "redirect:list";
	}
}
