<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<link href="${root}/assets/images/logo.png" type="image/x-icon" rel="shortcut icon" />
<link href="${root}/assets/images/logo.png" type="image/x-icon" rel="icon" />

<title>南口堂网站后台管理- V1.0</title>

<link href="${root}/assets/css/bootstrap.css" rel="stylesheet">
<link href="${root}/assets/css/dashboard.css" rel="stylesheet">
</head>
<style type="text/css">
  .page-target {
    font-weight: bold;
    color: #222533;
  }
  .tab-bottom-line {
    margin: 0 auto 0;
    border-top: 1px solid #E0E0E0;
  }
  .table {
    margin-bottom: 0px;
  }
  body {
    background-color: #F5F5F5;
  }
  .main-container {
    background-color: #FFFFFF;
    margin: 10px auto;
    padding: 5px 20px 30px 20px;
    border-radius: 3px;
  }
</style>
<body>
  <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand"><strong>南口堂网站管理平台</strong></a>
      </div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-left">
          <li><a href="${root}/admins/main"><span class="glyphicon glyphicon-home"></span> 首页</a></li>
          <li><a href="${root}/manage/event/list"><span class="glyphicon glyphicon-th-list"></span> 发布管理</a></li>
          <li><a href="${root}/manage/member/list"><span class="glyphicon glyphicon-th-list"></span> 成员管理</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a data-toggle="modal" data-target=".logout-modal" href=""><span class="glyphicon glyphicon-log-out"></span> 退出系统</a></li>
        </ul>
      </div>
    </div>
  </div>
  
  <div class="modal fade logout-modal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h5 class="modal-title">系统提示</h5>
        </div>
        <div class="modal-body" style="text-align: center; font-weight: bold;">您确定退出管理系统吗？</div>
        <div class="modal-footer">
          <a href="<%=request.getContextPath()%>/admins/logout">
            <button type="button" class="btn btn-primary btn-sm">确定</button>
          </a>
          <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">取消</button>
        </div>
      </div>
    </div>
  </div>
  
</body>
</html>
