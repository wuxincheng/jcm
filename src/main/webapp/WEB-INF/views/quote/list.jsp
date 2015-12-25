<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="nkt" uri="/WEB-INF/nkt.tld"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<link href="${root}/assets/images/logo.png" type="image/x-icon" rel="shortcut icon" />
<link href="${root}/assets/images/logo.png" type="image/x-icon" rel="icon" />
<script type="text/javascript" src="${root}/assets/js/popup.js"></script>
</head>
<body>
  <jsp:include page="../top.jsp" />

  <div class="container main-container">
    <h5 class="page-header page-target">每日金句分享管理</h5>
    <a href="${root}/manage/quote/edit">
      <button type="button" class="btn btn-primary btn-sm">新增</button>
    </a>
    <hr />
    <div style="text-align: right; color: #CE9D9D; padding-bottom: 10px;">提示：目前只显示第一条金句</div>
    <div class="table-responsive">
      <table class="table table-hover">
        <thead>
          <tr>
            <th style="text-align: center;">序号</th>
            <th style="text-align: left;">说明</th>
            <th style="text-align: center;">操作时间</th>
            <th style="text-align: center;">状态</th>
            <th style="text-align: center;">操作</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="totalRead" value="0" />
          <c:choose>
            <c:when test="${not empty pager.shares}">
              <c:forEach items="${pager.shares}" var="obj" varStatus="s">
                <tr>
                  <td style="text-align: center;">${s.index+1}</td>
                  <td style="text-align: left;">${fn:substring(obj.shareContent, 0, 28)} ... ...</td>
                  <td style="text-align: center;">${obj.shareTime}</td>
                  <td style="text-align: center;">
                    <c:if test="${'1' eq obj.shareState}">
                    <span class="label label-success">显示</span>
                    </c:if>
                    <c:if test="${'0' eq obj.shareState}">
                    <span class="label label-danger">不显示</span>
                    </c:if>
                  </td>
                  <td style="text-align: center;">
                    <a href="${root}/manage/quote/detail?shareid=${obj.shareid}">
                      <button type="button" class="btn btn-primary btn-sm">修改</button>
                    </a>
                    <button type="button" onclick="delShare('${obj.shareid}');" class="btn btn-primary btn-sm">删除</button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert"
                  aria-hidden="true">&times;</button>
                <strong>提示：</strong>没有查询到分享的金句信息！
              </div>
            </c:otherwise>
          </c:choose>
          <jsp:include page="../msg.jsp" />
        </tbody>
      </table>
    </div>
  </div>

  <jsp:include page="../bottom.jsp" />
</body>
<script type="text/javascript">
function delShare(shareid){
	layer.confirm('您确定要删除吗？', {
	    btn: ['确定','取消'] //按钮
	}, function(){
		document.location = '${root}/manage/quote/delete?shareid='+shareid;
	}, function(){
	    layer.msg('并没有删除哦');
	});
}
</script>
</html>
