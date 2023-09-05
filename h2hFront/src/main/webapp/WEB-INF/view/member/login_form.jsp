<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ include file="../inc/incHead2.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");
if (url == null)	url = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>h2h</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberStyle.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"charset="utf-8"></script>
<style>
a, label {
	font-size: 11px;
}
#kakao {
	background-color: yellow;
	color: black;
}

#naver {
	background-color: #2DB400;
	color: black;
}

#login {
	background-color: #FF3232;
	color: white;
}

</style>
</head>
<body>
<div class="wrapper memcenter" style="width: 400px; height: 500px;">
<fieldset id="member">
	<h2>HAND2HAND 로그인</h2>
	<form action="login" id="loginform" name="frmLogin" method="post">
		<input type="text" name="uid" class="tsize" placeholder="아이디" value="ucheri72"><br>
		<input type="password" name="pwd" class="tsize" placeholder="비밀번호" value="1234"><br><br>
		<input type="submit" class="tsize" id="login" value="로그인"><br>
		<input type="hidden" name="url" value="<%=url %>" />
		<div class="fontsize">
			<input type="checkbox" id="remember-check"><label for="remember-check">아이디 저장</label>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="findId">아이디 찾기</a> | 
			<a href="findPw">비밀번호 재설정</a>
		</div>
		<br>
		<input type="button" class="tsize" id="kakao" onclick="" value="카카오톡 로그인"><br>
		<input type="button" class="tsize" id="naver" onclick="" value="네이버 로그인"><br>
		<a href="memberJoin" style="text-align: right;">회원가입</a>
	</form>
</fieldset>
</div>
</body>
</html>
<%@ include file="../inc/incFoot.jsp" %>