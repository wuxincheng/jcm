package com.wuxincheng.manage.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.wuxincheng.manage.dao.ShareDao;
import com.wuxincheng.manage.model.Share;
import com.wuxincheng.util.DateUtil;

@Service("shareService")
public class ShareService {

	@Resource
	private ShareDao shareDao;

	/**
	 * 按分类分页查询列表
	 * 
	 * @param shareType
	 *            类型, A|P
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
	public Map<String, Object> queryForPager(String shareType, String currentPager, int pagerSize) {
		if (StringUtils.isEmpty(shareType)) {
			// return null;
		}

		Map<String, Object> pager = new HashMap<String, Object>();

		int startIndex = 0;
		int endIndex = 0;

		// 查询条件Map封装
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("shareType", shareType);
		queryMap.put("startIndex", startIndex);
		queryMap.put("endIndex", endIndex);
		List<Share> shares = shareDao.queryPagerByMap(queryMap);

		// 查询总记录数
		int countSum = shareDao.queryCountByShareType(shareType);

		pager.put("shareType", shareType);
		pager.put("startIndex", startIndex);
		pager.put("endIndex", endIndex);
		pager.put("countSum", countSum);
		pager.put("shares", shares);
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
	public Share queryDetailById(String shareid) {
		if (StringUtils.isEmpty(shareid)) {
			return null;
		}
		return shareDao.queryDetailById(shareid);
	}

	/**
	 * 保存数据
	 * 
	 * @param event
	 * @return
	 */
	public String save(Share share) throws Exception {
		String responseMessage = null;

		if ("P|A".indexOf(share.getShareType()) < 0) {
			responseMessage = "无效分享类型";
			return responseMessage;
		}

		// 检查数据项
		if (StringUtils.isEmpty(share.getShareContent())) {
			responseMessage = "分享内容不能为空";
			return responseMessage;
		}

		if ("P".equals(share.getShareType())) { // 图片类型上传
			if (StringUtils.isEmpty(share.getShareImage())) {
				responseMessage = "分享图片不能为空";
				return responseMessage;
			}
		}

		String currentDate = DateUtil.getCurrentDate(new Date(), "yyyy-MM-dd HH:mm:ss");

		if (StringUtils.isNotEmpty(share.getShareid())) {
			// 封装一些数据
			share.setShareTime(currentDate);

			shareDao.update(share);
		} else {
			// 封装一些数据
			share.setShareTag(share.getShareType());
			share.setShareTime(currentDate);
			share.setShareState("0");

			shareDao.insert(share);
		}

		return responseMessage;
	}

	/**
	 * 删除
	 * 
	 * @param eventid
	 */
	public void deleteById(String shareid) {
		if (StringUtils.isEmpty(shareid)) {
			return;
		}
		shareDao.deleteById(shareid);
	}

}
