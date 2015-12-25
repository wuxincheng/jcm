<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<script src="${root}/ckeditor/ckeditor.js" type="text/javascript"></script>
	<script src="${root}/ckfinder/ckfinder.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${root}/assets/vendor/croppic/croppic.css" />
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
		<form action="${root}/manage/event/doEdit" role="form" method="post" enctype="multipart/form-data">
			<div class="row">
				<div class="col-xs-12">
                    <jsp:include page="../msg.jsp" />
					<input type="hidden" id="eventid" name="eventid" value="${event.eventid}" />
					<div class="form-group">
						<label for="title">发布标题：</label>
					    <input type="text" name="eventTitle" value="${event.eventTitle}" class="form-control" style="width: 450px;" autocomplete="off" placeholder="请输入标题" />
					</div>
                    <div class="form-group">
                      <label for="title">首页图片（图片长宽比例：450*300）：</label>
                      <input type="hidden" name="eventIndexImg" id="eventIndexImg" value="${event.eventIndexImg}" />
                      <div style="width: 450px; height: 300px; overflow: hidden;" class="control-img cropContainer"
                        id="eventIndexImgCrop">
                        <c:if test="${not empty event.eventIndexImg}">
                        <img src="${event.eventIndexImg}" />
                        </c:if>
                      </div>
                    </div>
		            <div class="form-group">
		              <label for="subTitle">发布简介：</label>
		              <textarea cols="30" id="eventSubTitle" class="form-control" name="eventSubTitle" rows="2" style="width: 450px;" placeholder="请输入简介">${event.eventSubTitle}</textarea>
		            </div>
		            <div class="form-group">
		              <label for="domain">发布类型：</label>
		              	<select class="form-control" id="eventType" name="eventType" style="width: 450px;">
                          <c:forEach items="${eventTypeMap}" var="eventType">
                            <option value="${eventType.key}" <c:if test="${event.eventType == eventType.key}">selected="selected"</c:if>>${eventType.value}</option>
                          </c:forEach>
						</select>
		            </div>
					<div class="form-group"  style="width: 750px;">
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
			</div>
		</form>
	</div>
	
	<jsp:include page="../bottom.jsp" />
    <script type="text/javascript" src="${root}/assets/vendor/croppic/croppic.min.js"></script>
    <script type="text/javascript">
      var cropOptions = {
        uploadUrl : '${root}' + '/manage/image/upload',
        cropUrl : '${root}' + '/manage/image/crop',
        imgEyecandy : false,
        rotateControls: false,
        modal:false,
        doubleZoomControls:false,
        loaderHtml : '<div class="loader bubblingG"><span id="bubblingG_1"></span><span id="bubblingG_2"></span><span id="bubblingG_3"></span></div>',
      };
      cropOptions.outputUrlId = "eventIndexImg";
      var backgroundCrop = new Croppic('eventIndexImgCrop', cropOptions);
    </script>
</body>
</html>
