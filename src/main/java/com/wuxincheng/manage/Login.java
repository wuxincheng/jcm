package com.wuxincheng.manage;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.wuxincheng.manage.controller.BaseController;
import com.wuxincheng.manage.model.Admins;
import com.wuxincheng.manage.service.AdminsService;
import com.wuxincheng.util.Constants;
import com.wuxincheng.util.MD5;
import com.wuxincheng.util.Validation;

@Controller
@RequestMapping("/admins")
public class Login extends BaseController {

	private static Logger logger = LoggerFactory.getLogger(Login.class);

	private static final String MANAGE_NAME = Constants.MANAGE_NAME;

	@Autowired
	private AdminsService adminsService;

	@RequestMapping(value = "/login")
	public String login(HttpServletRequest request, Model model) {
		logger.info(MANAGE_NAME + "显示后台管理登录页面");
		requestMessageProcess(request);

		return "login";
	}

	@RequestMapping(value = "/doLogin")
	public String doLogin(HttpServletRequest request, Model model,
			@RequestParam String adminsLogin, @RequestParam String adminsPwd) {
		logger.info(MANAGE_NAME + "登录到系统");

		if (Validation.isBlank(adminsLogin) || Validation.isBlank(adminsPwd)) {
			model.addAttribute(Constants.MSG_TYPE_WARNING, "用户名和密码都不能为空");
			return "login";
		}

		// Admins admins = adminsService.login(adminsLogin, adminsPwd);
		Admins admins = adminsService.query(adminsLogin);

		if (null == admins) {
			model.addAttribute(Constants.MSG_TYPE_WARNING, "用户不存在，请检查您的账号");
			return "login";
		}

		String pwd = admins.getAdminsPwd(); // 数据库中的密码

		// 登录密码加密
		String adminsPwdMD5Str = MD5.encryptMD5Pwd(adminsPwd);

		if (!Validation.isBlank(pwd) && pwd.equals(adminsPwdMD5Str)) {
			request.getSession().setAttribute("admins", admins);
		} else {
			model.addAttribute(Constants.MSG_TYPE_WARNING, "用户密码不正确");
			return "login";
		}

		return "redirect:main";
	}

	@RequestMapping(value = "/main")
	public String main() {
		return "main";
	}

}
