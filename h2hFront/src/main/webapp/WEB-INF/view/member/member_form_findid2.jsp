<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String id = (String)request.getAttribute("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
fieldset {
	width: 400px;
}
.wrapper {
	text-align: center;
}

.center {
	position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.tsize {
	height: 40px;
	width: 300px;
}

.btn {
	height: 40px;
	width: 300px;
	background-color: red;
	color: black;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="wrapper center">
<fieldset>
	<h2>아이디 찾기</h2>
	회원님이 입력하신 정보와 일치하는 아이디 입니다.<br><br>
	<input type="text" id="idbox" class="tsize" value="<%=id %>" size="20" readonly="readonly"><br><br>
	<input type="button" class="btn" value="로그인" onclick="location.href='login'"><br>
	<a href="findPw" style="font-size: 10px;">비밀번호 찾기</a>
</fieldset>
</div>
</body>
</html>