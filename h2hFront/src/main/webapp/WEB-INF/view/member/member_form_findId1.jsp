<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/test.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
$(document).ready(function() {
	$('#join').click(function() {
		var form = document.frm;
	    form.submit();
	});
	
});
</script>
</head>
<body>
<div class="wrapper center">
<fieldset>
<h2 class="textcenter">아이디 찾기</h2>
<form id="frm" method="post" action="findId">
	<input type="text" name="name" id="name" class="tsize" placeholder="이름"><br>
	<input type="text" name="email" id="email" class="tsize" placeholder="이메일"><br><br>
	<input type="submit" id="join" value="아이디 찾기" class="btn"><br>
	<a href="findPw" style="font-size: 10px;">비밀번호 재설정</a>
</form>
</fieldset>
</div>
</body>
</html>