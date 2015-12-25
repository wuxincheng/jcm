<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<body>
  
  <div class="footer text-center">
    <div class="container">
      <div class="copyright">
        © Copyright 2015 - <a href="http://www.nankoutang.com">nankoutang.com</a> - All Rights Reserved.
      </div>
      <p>&nbsp;</p>
    </div>
  </div>
  
  <script src="<%=request.getContextPath()%>/assets/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/assets/js/docs.min.js"></script>
  <script src="<%=request.getContextPath()%>/assets/vendor/layer/layer.js"></script>
  
  <script type="text/javascript">
  	$("#support").click(function(){
  		layer.open({
  		    type: 2,
  		    skin: 'layui-layer-rim', //加上边框
  		    area: ['370px', '210px'], //宽高
  		  	shadeClose: true,
  		    content: '${root}/manage/support/'
  		});
  	});
  </script>
</body>
</html>
