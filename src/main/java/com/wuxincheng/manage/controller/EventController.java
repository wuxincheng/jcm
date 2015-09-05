package com.wuxincheng.manage.controller;

import java.util.Map;

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
public class EventController {
	private static Logger logger = LoggerFactory.getLogger(EventController.class);

	private static final String MANAGE_NAME = Constants.MANAGE_NAME;

	private final Integer pagerSize = 10;

	@Autowired
	private EventService eventService;

	@RequestMapping(value = "/list")
	public String list(Model model, String eventType, String currentPager) {
		logger.info("{}查询动态列表 eventType={}", MANAGE_NAME, eventType);

		Map<String, Object> pager = eventService.queryForPager(eventType, currentPager, pagerSize);

		model.addAttribute("pager", pager);

		return "event/list";
	}

	@RequestMapping(value = "/detail")
	public String detail(Model model, String eventid) {
		logger.info("{}显示动态详细 eventid={}", MANAGE_NAME, eventid);

		Event event = eventService.queryDetailById(eventid);

		model.addAttribute("event", event);

		return "event/edit";
	}

	@RequestMapping(value = "/edit")
	public String edit(Model model) {
		logger.info("{}显示编辑动态详细页面", MANAGE_NAME);
		
		model.addAttribute("eventTypeMap", EventType.getAll());
		
		return "event/edit";
	}

	@RequestMapping(value = "/doEdit")
	public String doEdit(Model model, Event event) {
		logger.info("{}保存动态详细信息", MANAGE_NAME);

		try {
			String responseMessage = eventService.save(event);
			if (StringUtils.isNotEmpty(responseMessage)) {
				model.addAttribute(Constants.MSG_WARN, responseMessage);
				logger.warn(responseMessage);
				model.addAttribute("eventid", event.getEventid());
				logger.info("eventid={}", event.getEventid());
				return event.getEventid() == null ? "event/edit" : "redirect:detail";
			}
		} catch (Exception e) {
			model.addAttribute(Constants.MSG_ERROR, "保存异常, 请联系管理员");
			return "event/edit";
		}

		model.addAttribute(Constants.MSG_SUCCESS, "保存成功");

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
