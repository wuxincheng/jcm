<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
      <button type="button" class="btn btn-primary btn-sm">新增发布内容</button>
    </a>
    <hr />
    <div class="table-responsive">
      <table class="table table-hover">
        <thead>
          <tr>
            <th style="text-align: center;">序号</th>
            <th style="text-align: center;">排序</th>
            <th style="text-align: center;">
            </th>
            <th style="text-align: center;">标题</th>
            <th style="text-align: center;">来源</th>
            <!-- 
            <th style="text-align: center;">真象指数</th>
             -->
            <th style="text-align: center;">阅读数</th>
            <th style="text-align: center;">发布时间</th>
            <!-- 
            <th style="text-align: center;">发表人</th>
             -->
            <th style="text-align: center;">状态</th>
            <th style="text-align: center;">操作</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="totalRead" value="0" />
          <c:choose>
            <c:when test="${not empty pager.news}">
              <c:forEach items="${pager.news}" var="obj" varStatus="s">
                <tr>
                  <td style="text-align: center;">${s.index+1}</td>
                  <td style="text-align: center;">
                    <c:if test="${'-1' eq obj.state}">
                      <img src="${root}/assets/images/sort-up.png" onClick="moveUp(this);" style="cursor: pointer;" />
                      <img src="${root}/assets/images/sort-down.png" onClick="moveDown(this);" style="cursor: pointer;" />
                    </c:if>
                    <c:if test="${'0' eq obj.state}">---</c:if>
                  </td>
                  <td style="text-align: center;">
                    <c:if test="${'-1' eq obj.state}">
                      <input type="checkbox" id="subcheck" value="${obj.id}" />
                    </c:if>
                  </td>
                  <td style="text-align: left;">
                    <a href="${obj.url}" target="_blank">
                    <img src="${root}/imgbase/${obj.imgLocPath}" height="30px" width="30px" />&nbsp;
                    ${obj.title}
                    </a>
                  </td>
                  <td style="text-align: left;">${obj.domain}<br>${obj.weChatPublicNO}</td>
                  <!-- 
                  <td style="text-align: right;"><fmt:formatNumber value="${obj.truthDegree}" pattern="#" type="number"/>%</td>
                   -->
                  <td style="text-align: right;">${obj.readerCount}</td>
                  <td style="text-align: center;">${obj.createTime}</td>
                  <!-- 
                  <td style="text-align: left;">${obj.creator}</td>
                   -->
                  <td style="text-align: center;">
                    <c:if test="${'0' eq obj.state}">
                      <span class="text-success">已发布</span>
                    </c:if> 
                    <c:if test="${'-1' eq obj.state}">
                      <a href="${root}/manage/news/send/send?newsId=${obj.id}">
                        <button type="button" class="btn btn-primary btn-sm">发布</button>
                      </a>
                    </c:if>
                  </td>
                  <td style="text-align: center;">
                    <!-- 
                    <a href="${root}/manage/news/send/comment?newsId=${obj.id}&commentId=${obj.commentId}">
                      <button type="button" class="btn btn-primary btn-sm">评论</button></a>
                     -->
                    <a href="${root}/manage/news/send/edit?newsId=${obj.id}">
                      <button type="button" class="btn btn-primary btn-sm">修改</button>
                    </a>
                    <button type="button" class="btn btn-primary btn-sm"
                      onclick="if(confirm('您确定执行退回吗?')) document.location = '${root}/manage/news/send/rollback?newsId=${obj.id}';">退回</button>
                  </td>
                </tr>
              </c:forEach>
              
              <div class="tab-bottom-line"></div>

              <ul class="pager">
                <li
                  <c:if test="${'1' eq pager.currentPage}">class="disabled"</c:if>>
                  <a
                  <c:if test="${pager.currentPage > 1}">href="${root}/manage/news/send/list?currentPage=1"</c:if>>首页</a>
                </li>
        
                <li
                  <c:if test="${'1' eq pager.currentPage}">class="disabled"</c:if>>
                  <a
                  <c:if test="${pager.currentPage > 1}">href="${root}/manage/news/send/list?currentPage=${pager.currentPage-1}"</c:if>>上一页</a>
                </li>
        
                <li
                  <c:if test="${pager.lastPage eq pager.currentPage}">class="disabled"</c:if>>
                  <a
                  <c:if test="${pager.currentPage < pager.lastPage}">href="${root}/manage/news/send/list?currentPage=${pager.currentPage+1}"</c:if>>下一页</a>
                </li>
        
                <li
                  <c:if test="${pager.lastPage eq pager.currentPage}">class="disabled"</c:if>>
                  <a
                  <c:if test="${pager.currentPage < pager.lastPage}">href="${root}/manage/news/send/list?currentPage=${pager.lastPage}"</c:if>>尾页</a>
                </li>
        
                <li class="">&nbsp;</li>
                <li class=""><strong>${pager.currentPage}/${pager.lastPage}</strong></li>
                <li class="">&nbsp;</li>
                <li class="disabled">共<strong>${pager.totalCount}</strong>条
                </li>
                <li class="">&nbsp;</li>
                <li class="">每页显示<strong>${pageSize}</strong>条
                </li>
              </ul>
            </c:when>
            <c:otherwise>
              <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert"
                  aria-hidden="true">&times;</button>
                <strong>提示：</strong>没有查询到发布信息！
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
