<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="${root}/assets/images/logo.png" type="image/x-icon" rel="shortcut icon" />
    <link href="${root}/assets/images/logo.png" type="image/x-icon" rel="icon" />
</head>
<body>
	<jsp:include page="../top.jsp" />
	
	<div class="container main-container">
		<h5 class="page-header page-target">每日金句分享管理 - 编辑分享内容</h5>
		<form id="form" action="${root}/manage/share/doEdit" role="form" method="post" enctype="multipart/form-data">
		  <input type="hidden" id="shareid" name="shareid" value="${share.shareid}" />
          <div class="form-group">
            <textarea cols="30" id="shareContent" class="form-control" name="shareContent" rows="5" 
                    style="width: 500px;" placeholder="请输入分享金句">${share.shareContent}</textarea>
          </div>
		<hr>
		<input id="saveButton" type="button" class="btn btn-primary btn-sm" value="保存" />
		</form>
	</div>
	
	<jsp:include page="../bottom.jsp" />
    <script type="text/javascript">
    $(function() {
    	$("#saveButton").click(function() {
			$.post("${root}"+"/manage/quote/doEdit", $("#form")
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
