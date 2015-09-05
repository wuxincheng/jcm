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
			var editor = CKEDITOR.replace('blogContent');
			CKFinder.setupCKEditor(editor,'/ckeditor/');
		};
	</script>
</head>
<body>
	<jsp:include page="../top.jsp" />
	
	<div class="container main-container">
		<h5 class="page-header page-target">发布管理 - 编辑发布内容</h5>
		<form action="${root}/manage/news/send/doEdit" role="form" method="post">
			<div class="row">
				<div class="col-xs-9">
					<input type="hidden" id="id" name="id" value="${news.id}" />
					<div class="form-group">
						<label for="title">发布标题：</label>
					    <input type="text" name="title" value="${news.title}" class="form-control" style="width: 100%;" autocomplete="off" placeholder="请输入标题" />
					</div>
                    <div class="form-group">
                      <label for="title">首页图片（图片长宽比例：440*326）：</label>
                      <input type="text" name="title" value="${news.title}" class="form-control" style="width: 100%;" autocomplete="off" placeholder="请输入标题" />
                    </div>
		            <div class="form-group">
		              <label for="subTitle">发布简介：</label>
		              <textarea cols="30" id="subTitle" class="form-control" name="subTitle" rows="2" style="width: 100%;" autocomplete="off" placeholder="请输入简介">${news.subTitle}</textarea>
		            </div>
		            <div class="form-group">
		              <label for="domain">发布类型：</label>
		              	<select class="form-control">
                          <c:forEach items="${eventTypeMap}" var="eventType">
                            <option value="${eventType.key}">${eventType.value}</option>
                          </c:forEach>
						</select>
		            </div>
					<div class="form-group">
						<label for="blogContent">发布内容：</label>
					    <textarea id="blogContent" name="blogContent">${blogInfo.blogContent}</textarea>
					</div>
					<div class="form-group">
						<label for="blogState">发布状态：</label><br>
					    
					    <label class="radio-inline">
						  <input type="radio" name="state" id="state" value="0" 
					    	<c:if test="${'0' eq news.state}">checked="checked"</c:if>
		                    <c:if test="${empty news.state}">checked="checked"</c:if>>
					    	已经完成，立即发布
						</label>
						&nbsp;&nbsp;
						<label class="radio-inline">
						  <input type="radio" name="state" id="state" value="1" 
					    	<c:if test="${'1' eq news.state}">checked="checked"</c:if>>
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
		              <img id="indexImg" name="indexImg" src="${root}/imgbase/${news.imgLocPath}" class="img-thumbnail" />
		            </div>
				</div>
			</div>
		</form>
	</div>
	
	<jsp:include page="../bottom.jsp" />
	
	<script type="text/javascript">
		$('#refetchImgLink').on('input',function(e){
			var link = $.trim($('#refetchImgLink').val());
			if (link == '') {
				$('#refetchImgBut').attr("disabled", true);
			} else {
				$('#refetchImgBut').attr("disabled", false);
			}
		});
		
		$("#refetchImgBut").click( function() {
			var link = $.trim($('#refetchImgLink').val());
			var resLink = $('#imgLocPath').val();
			$.ajax({
    		  	url : '${root}/manage/news/refetchImage', // 跳转到 action    
    		  	data : {link : link, resLink: resLink},
    		  	type : 'post',
    		  	beforeSend:function(){
    		  		$("#indexImg").attr("src", "${root}/assets/images/loading.gif");
    		  	},
    		  	cache : false,
    		  	dataType : 'json',
    		  	success : function(data) {
    		  		$('#imgLocPath').val(data.imgRefetchPath);
    		  		$("#indexImg").attr("src", "${root}/imgbase/" + data.imgRefetchPath);
    		  	},
    		  	error : function() {
    		  		$("#indexImg").attr("src", "${root}/assets/images/111.png");
    		  		alert("获取异常，请检查你输入的图片链接！友情提示：如果是直接在微信网页中复制图片网址链接的话，则不可用。");
    		  	}
		  	});
		});
	</script>
</body>
</html>
