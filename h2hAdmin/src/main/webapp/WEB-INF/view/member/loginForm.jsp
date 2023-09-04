<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");
if (url == null)	url = "index";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<title>LoginForm</title>
</head>
<body>
<div class="d-flex justify-content-center align-items-center h-100">
<div class="login-wrapper">
	<h2>로그인</h2>
	<form action="login" id="loginform" name="frmLogin" method="post">
	<input type="hidden" name="url" value="<%=url %>" />
	<div class="form-group">
		<input type="text" name="uid" placeholder="아이디" value="admin">
	</div>
	<div class="form-group">
		<input type="password" name="pwd" placeholder="비밀번호" value="1234">
	</div>
	<div class="form-group">
		<input type="submit" class="btn btn-primary" value="로그인">
	</div>
		<input type="checkbox" id="remember-check"><label for="remember-check">아이디 저장</label>
	</form>
</div>
</div>
</body>
</html>