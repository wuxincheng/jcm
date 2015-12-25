package com.wuxincheng.manage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.wuxincheng.manage.model.Share;

@Repository("shareDao")
public class ShareDao extends BaseDao {

	@SuppressWarnings("unchecked")
	public List<Share> queryPagerByMap(Map<String, Object> queryMap) {
		return this.getSqlMapClientTemplate().queryForList("Share.queryPagerByMap", queryMap);
	}

	public int queryCountByShareType(String shareType) {
		return (Integer) this.getSqlMapClientTemplate().queryForObject(
				"Share.queryCountByShareType", shareType);
	}

	public Share queryDetailById(String shareid) {
		return (Share) this.getSqlMapClientTemplate().queryForObject("Share.queryDetailById",
				shareid);
	}

	public void deleteById(String shareid) {
		this.getSqlMapClientTemplate().delete("Share.deleteById", shareid);
	}

	public void update(Share share) {
		this.getSqlMapClientTemplate().update("Share.update", share);
	}

	public void insert(Share share) {
		this.getSqlMapClientTemplate().insert("Share.insert", share);
	}

}
