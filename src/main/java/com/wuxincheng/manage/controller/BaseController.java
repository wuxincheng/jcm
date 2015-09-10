package com.wuxincheng.manage.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wuxincheng.manage.model.Admins;
import com.wuxincheng.util.Constants;

/**
 * 基Controller
 * 
 * @author wuxincheng
 *
 */
@Controller
@RequestMapping("/base")
public class BaseController {
	
	public String getCurrentUser (HttpServletRequest request) {
		Admins admins = (Admins)request.getSession().getAttribute("admins");
		if (admins != null) {
			return admins.getAdminsLogin();
		}
		return null;
	}
	
	/**
	 * 处理信息提示
	 */
	protected void requestMessageProcess(HttpServletRequest request) {

		String msgError = request.getParameter(Constants.MSG_ERROR);
		String msgWarn = request.getParameter(Constants.MSG_WARN);
		String msgInfo = request.getParameter(Constants.MSG_INFO);
		String msgSuccess = request.getParameter(Constants.MSG_SUCCESS);

		request.setAttribute(Constants.MSG_ERROR, encode(msgError));
		request.setAttribute(Constants.MSG_WARN, encode(msgWarn));
		request.setAttribute(Constants.MSG_INFO, encode(msgInfo));
		request.setAttribute(Constants.MSG_SUCCESS, encode(msgSuccess));
	}
	
	/**
	 * GET请求乱码处理
	 */
	private String encode(String param) {
		return param;
	}
	
}
