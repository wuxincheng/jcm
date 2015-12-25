package com.wuxincheng.manage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manage/support")
public class SupportController {
	private static Logger logger = LoggerFactory.getLogger(SupportController.class);

	@RequestMapping(value = "/")
	public String support(Model model) {
		logger.info("后台技术支持");
		return "support";
	}
	
}
