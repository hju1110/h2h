<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="left">
<div class="login-wrapper">
	<h2>로그인</h2>
	<form action="login" id="loginform" name="frmLogin" method="post">
		<input type="text" name="uid" placeholder="아이디" value="admin">
		<input type="password" name="pwd" placeholder="비밀번호" value="1234">
		<input type="submit" value="로그인">
		<input type="checkbox" id="remember-check"><label for="remember-check">아이디 저장</label>
	</form>
</div>
</div>
</body>
</html>