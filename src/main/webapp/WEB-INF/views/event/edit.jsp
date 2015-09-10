<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<script src="${root}/ckeditor/ckeditor.js" type="text/javascript"></script>
	<script src="${root}/ckfinder/ckfinder.js" type="text/javascript"></script>
	<link href="${root}/assets/images/logo.png" type="image/x-icon" rel="shortcut icon" />
    <link href="${root}/assets/images/logo.png" type="image/x-icon" rel="icon" />
	
	<script type="text/javascript">
		window.onload = function() {
			var editor = CKEDITOR.replace('eventContent');
			CKFinder.setupCKEditor(editor,'/ckeditor/');
		};
	</script>
</head>
<body>
	<jsp:include page="../top.jsp" />
	
	<div class="container main-container">
		<h5 class="page-header page-target">发布管理 - 编辑发布内容</h5>
		<form action="${root}/manage/event/doEdit" role="form" method="post">
			<div class="row">
				<div class="col-xs-9">
                    <jsp:include page="../msg.jsp" />
					<input type="hidden" id="eventid" name="eventid" value="${event.eventid}" />
					<div class="form-group">
						<label for="title">发布标题：</label>
					    <input type="text" name="eventTitle" value="${event.eventTitle}" class="form-control" style="width: 100%;" autocomplete="off" placeholder="请输入标题" />
					</div>
                    <div class="form-group">
                      <label for="title">首页图片链接（图片长宽比例：440*326）：</label>
                      <input type="text" name="eventIndexImg" id="eventIndexImg" value="${event.eventIndexImg}" class="form-control" style="width: 100%;" autocomplete="off" placeholder="请输入标题" />
                    </div>
		            <div class="form-group">
		              <label for="subTitle">发布简介：</label>
		              <textarea cols="30" id="eventSubTitle" class="form-control" name="eventSubTitle" rows="2" style="width: 100%;" autocomplete="off" placeholder="请输入简介">${event.eventSubTitle}</textarea>
		            </div>
		            <div class="form-group">
		              <label for="domain">发布类型：</label>
		              	<select class="form-control" id="eventType" name="eventType">
                          <c:forEach items="${eventTypeMap}" var="eventType">
                            <option value="${eventType.key}" <c:if test="${event.eventType == eventType.key}">selected="selected"</c:if>>${eventType.value}</option>
                          </c:forEach>
						</select>
		            </div>
					<div class="form-group">
						<label for="eventContent">发布内容：</label>
					    <textarea id="eventContent" name="eventContent">${event.eventContent}</textarea>
					</div>
					<div class="form-group">
						<label for="blogState">发布状态：</label><br>
					    
					    <label class="radio-inline">
						  <input type="radio" name="eventState" id="eventState" value="1" 
					    	<c:if test="${'1' eq event.eventState}">checked="checked"</c:if>
		                    <c:if test="${empty event.eventState}">checked="checked"</c:if>>
					    	已经完成，立即发布
						</label>
						&nbsp;&nbsp;
						<label class="radio-inline">
						  <input type="radio" name="eventState" id="eventState" value="0" 
					    	<c:if test="${'0' eq event.eventState}">checked="checked"</c:if>>
					    	还未完成，保存到素材库
						</label>
					</div>
					<hr>
					<input type="submit" class="btn btn-primary btn-sm" value="保存" />
				</div>
				
				<div class="col-xs-3">
					<div class="form-group">
		              <label for="title">首页图片预览：</label>
		            </div>
					<div class="form-group">
                      <c:if test="${not empty event.eventIndexImg}">
		              <img id="eventIndexImgShow" name="eventIndexImgShow" src="${event.eventIndexImg}" class="img-thumbnail" />
                      </c:if>
                      <c:if test="${empty event.eventIndexImg}">
                      <img id="eventIndexImgShow" name="eventIndexImgShow" src="${root}/assets/images/nophoto.jpg" class="img-thumbnail" />
                      </c:if>
		            </div>
				</div>
			</div>
		</form>
	</div>
	
	<jsp:include page="../bottom.jsp" />
	
	<script type="text/javascript">
		$('#eventIndexImg').on('input',function(e){
			var link = $.trim($('#eventIndexImg').val());
			if (link == '') {
				$("#eventIndexImgShow").attr("src", "${root}/assets/images/nophoto.jpg");
			} else {
				$("#eventIndexImgShow").attr("src", link);
			}
		});
	</script>
</body>
</html>
