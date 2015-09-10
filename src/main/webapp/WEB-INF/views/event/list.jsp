<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <h5 class="page-header page-target">发布管理</h5>
    <a href="${root}/manage/event/edit">
      <button type="button" class="btn btn-primary btn-sm">新增</button>
    </a>
    <hr />
    <div class="table-responsive">
      <div class="event-tabs">
        <ul class="nav nav-tabs nav-justified">
          <c:forEach items="${eventTypeMap}" var="eventTypeObj">
            <li <c:if test="${eventType == eventTypeObj.key}">class="active"</c:if> role="presentation">
              <a href="${root}/manage/event/list?eventType=${eventTypeObj.key}">${eventTypeObj.value}</a>
            </li>
          </c:forEach>
        </ul>
      </div>
      <table class="table table-hover">
        <thead>
          <tr>
            <th style="text-align: center;">序号</th>
            <th style="text-align: center;">类型</th>
            <th style="text-align: left;">标题</th>
            <th style="text-align: center;">阅读数</th>
            <th style="text-align: center;">操作时间</th>
            <th style="text-align: center;">状态</th>
            <th style="text-align: center;">操作</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="totalRead" value="0" />
          <c:choose>
            <c:when test="${not empty pager.events}">
              <c:forEach items="${pager.events}" var="obj" varStatus="s">
                <tr>
                  <td style="text-align: center;">${s.index+1}</td>
                  <td style="text-align: center;"><span class="label label-primary">${nkt:eventType(obj.eventType)}</span></td>
                  <td style="text-align: left;">${obj.eventTitle}</td>
                  <td style="text-align: center;">${obj.readSum}</td>
                  <td style="text-align: center;">${obj.updateTime}</td>
                  <td style="text-align: center;">
                    <c:if test="${'1' eq obj.eventState}">
                    <span class="label label-success">已发布</span>
                    </c:if>
                    <c:if test="${'0' eq obj.eventState}">
                    <span class="label label-danger">未发布</span>
                    </c:if>
                  </td>
                  <td style="text-align: center;">
                    <a href="${root}/manage/event/detail?eventid=${obj.eventid}">
                      <button type="button" class="btn btn-primary btn-sm">修改</button>
                    </a>
                    <button type="button" class="btn btn-primary btn-sm"
                      onclick="if(confirm('您确定要删除吗?')) document.location = '${root}/manage/news/send/rollback?newsId=${obj.eventid}';">删除</button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert"
                  aria-hidden="true">&times;</button>
                <strong>提示：</strong>没有查询到发布 <b>${eventTypeValue}</b> 的信息！
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
function selected(flag) {
	// 获取选中的CheckBox
	var newsIds = $('input[id="subcheck"]:checked').map(function() {
		return this.value;
	}).get().join();
  	
	// 判断是否已经选择文章
	if (newsIds == '') {
  		alert("请您选择需要操作的文章");
		return;
	}
	
	if (flag == 'show') {
		var url = "${root}/manage/news/send/showBatch?newsIds="+newsIds;
		var pop = new Popup({ contentType:1,scrollType:'auto',isReloadOnClose:false,width:380,height:600});
        pop.setContent("contentUrl", url);
        pop.setContent("title", "南口堂网站 - 每天给你一杯对味的资讯！");
        pop.build();
        pop.show();
	} else if (flag == 'send') {
		window.location.href = "${root}/manage/news/send/sendBatch?newsIds="+newsIds;
	}
}

$(document).ready(function() {
	// 回显微信公众号
	$("[name=sogouOpenid] option[value=${sogouOpenid}]").attr("selected", "selected");
});

// "重置"按钮
function queryReset() {
  $("#queryStartDate").val(null);
  $("#queryEndDate").val(null);
  $("#sogouOpenid").val(null);
}
</script>

<script type="text/javascript">  
function moveUp(obj) {
	var current = $(obj).parent().parent();
	var prev = current.prev();
	if (current.index() > 1) {
		current.insertBefore(prev);
	}
}

function moveDown(obj) {
	var current = $(obj).parent().parent();
	var next = current.next();
	if (next) {
		current.insertAfter(next);
	}
}
</script>
</html>
