<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <link rel="stylesheet" href="${root}/assets/vendor/croppic/croppic.css" />
	<link href="${root}/assets/images/logo.png" type="image/x-icon" rel="shortcut icon" />
    <link href="${root}/assets/images/logo.png" type="image/x-icon" rel="icon" />
</head>
<body>
	<jsp:include page="../top.jsp" />
	
	<div class="container main-container">
		<h5 class="page-header page-target">图片分享管理 - 编辑分享内容</h5>
		<form id="form" action="${root}/manage/share/doEdit" role="form" method="post" enctype="multipart/form-data">
		  <input type="hidden" id="shareid" name="shareid" value="${share.shareid}" />
          <div class="form-group">
            <label for="title">首页图片（图片长宽比例：750*375）：</label>
            <input type="hidden" name="shareImage" id="shareImage" value="${share.shareImage}" />
            <div style="width: 750px; height: 375px; overflow: hidden;" class="control-img cropContainer"
              id="shareImageCrop">
              <c:if test="${not empty share.shareImage}">
              <img src="${share.shareImage}" />
              </c:if>
            </div>
          </div>
          <div class="form-group">
            <label for="subTitle">图片说明：</label>
            <textarea cols="30" id="shareContent" class="form-control" name="shareContent" rows="3" 
                    style="width: 750px;" placeholder="请输入图片说明">${share.shareContent}</textarea>
          </div>
		<hr>
		<input id="saveButton" type="button" class="btn btn-primary btn-sm" value="保存" />
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
      cropOptions.outputUrlId = "shareImage";
      var backgroundCrop = new Croppic('shareImageCrop', cropOptions);
    </script>
    <script type="text/javascript">
    $(function() {
    	$("#saveButton").click(function() {
			$.post("${root}"+"/manage/share/doEdit", $("#form")
					.serialize(), function(data) {
				//checkDataAndReload(data);
				if (data.success) {
					layer.confirm(data.successMsg, {
						btn : [ '确定' ],
						closeBtn : 0
					}, function() {
						window.location = "${root}"+data.redirectUrl;
					});
				} else {
					layer.alert(data.errorMsg);
				}
			});
		});
    });
    </script>
</body>
</html>
