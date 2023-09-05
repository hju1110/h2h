<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/incHead2.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/test.css">
<style>
#e1, #e2, #e3 {
	height: 40px;
	width: 110px;
}
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/email_address.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberStyle.css">
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
<div class="wrapper memcenter" style="width: 500px; height: 300px; line-height: 50%;">
<fieldset>
<h2 class="textcenter">아이디 찾기</h2><br>
<form id="frm" method="post" action="findId">
	<input type="text" name="name" id="name" class="tsize" placeholder="이름" style="width: 353px;"><br><br>
	<input type="text" name="e1" id="e1" size="5" class="tsize" placeholder="이메일"> @ <input type="text" name="e2" id="e2" size="10" class="tsize"> 
	<select name="e3" id="e3" class="tsize">
		<option value="">도메인 선택</option>
		<option value="naver.com">naver.com</option>
		<option value="hanmail.net">hanmail.net</option>
		<option value="gmail.com">gmail.com</option>
		<option value="nate.com">nate.com</option>
		<option value="direct">직접 입력</option>
	</select><br><br>
	<input type="submit" id="join" value="아이디 찾기" class="btn" style="width: 353px;"><br><br>
	<a href="findPw" style="font-size: 10px;">비밀번호 재설정</a>
</form>
</fieldset>
</div>
</body>
</html>
<%@ include file="../inc/incFoot.jsp" %>