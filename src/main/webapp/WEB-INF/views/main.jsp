<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<link href="${root}/assets/images/logo.png"
  type="image/x-icon" rel="shortcut icon" />
<link href="${root}/assets/images/logo.png"
  type="image/x-icon" rel="icon" />
  
<link href="${root}/assets/css/bootstrap.min.css" rel="stylesheet">
<link href="${root}/assets/css/dashboard.css" rel="stylesheet">
</head>
<style type="text/css">
</style>
<body>
  <jsp:include page="top.jsp" />
  
  <div class="container main-container">
    <h5 class="page-header page-target">管理平台 - 首页</h5>
    <div class="welcome-panel">
      <div>
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">系统管理员，您好：</h3>
          </div>
          <div class="panel-body" style="text-align: center;">
            <p>&nbsp;</p>
            <h4 class="text-primary">
              <img src="${root}/assets/images/logo.png" height="100" width="100">
              &nbsp;&nbsp;&nbsp;
              <strong>欢迎登录南口堂网站后台管理系统</strong>
            </h4>
            <p>&nbsp;</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="bottom.jsp" />
</body>
</html>
