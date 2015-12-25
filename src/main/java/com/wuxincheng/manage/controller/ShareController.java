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
import org.springframework.web.bind.annotation.ResponseBody;

import com.wuxincheng.manage.Result;
import com.wuxincheng.manage.model.Share;
import com.wuxincheng.manage.service.ShareService;
import com.wuxincheng.util.Constants;

/**
 * 分享管理
 * 
 * @author wuxc01
 * 
 */
@Controller
@RequestMapping("/manage/share")
public class ShareController extends BaseController {
	private static Logger logger = LoggerFactory.getLogger(ShareController.class);

	private static final String MANAGE_NAME = Constants.MANAGE_NAME;

	private final Integer pagerSize = 10;

	@Autowired
	private ShareService shareService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model,
			String currentPager) {
		logger.info("{}查询图片分享列表 shareType={}", MANAGE_NAME);
		requestMessageProcess(request);

		Map<String, Object> pager = shareService.queryForPager("P", currentPager, pagerSize);

		model.addAttribute("pager", pager);

		return "share/list";
	}

	@RequestMapping(value = "/detail")
	public String detail(Model model, String shareid) {
		logger.info("{}显示动态详细 shareid={}", MANAGE_NAME, shareid);

		Share share = shareService.queryDetailById(shareid);

		model.addAttribute("share", share);

		return "share/edit";
	}

	@RequestMapping(value = "/edit")
	public String edit(Model model) {
		logger.info("{}显示编辑动态详细页面", MANAGE_NAME);
		return "share/edit";
	}

	@RequestMapping(value = "/doEdit")
	@ResponseBody
	public Result doEdit(Model model, Share share) {
		logger.info("{}保存动态详细信息", MANAGE_NAME);

		Result result = new Result();
		
		try {
			share.setShareType("P");
			String responseMessage = shareService.save(share);
			if (StringUtils.isNotEmpty(responseMessage)) {
				model.addAttribute(Constants.MSG_WARN, responseMessage);
				logger.warn("保存失败：{}", responseMessage);
				return result.error(responseMessage);
			}
		} catch (Exception e) {
			model.addAttribute(Constants.MSG_ERROR, "保存异常, 请联系管理员");
			return result.error("保存异常, 请联系管理员");
		}

		result.setSuccessMsg("保存成功");
		result.setRedirectUrl("/manage/share/list");
		
		return result.success();
	}

	@RequestMapping(value = "/delete")
	public String delete(Model model, String shareid) {
		logger.info("{}删除动态 eventid={}", MANAGE_NAME, shareid);

		shareService.deleteById(shareid);
		model.addAttribute(Constants.MSG_SUCCESS, "删除成功");

		return "redirect:list";
	}
}
