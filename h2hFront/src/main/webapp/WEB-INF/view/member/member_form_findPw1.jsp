<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/incHead2.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberStyle.css">
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

.textcenter {
	text-align: center;
}

.tsize {
	height: 40px;
	width: 300px;
}

.btn {
	height: 40px;
	width: 100px;
	background-color: #B3B1B1;
	color: white;
}

#e1, #e2, #e3 {
	height: 40px;
	width: 110px;
}

#id, #name, #join {
	width: 353px;
}
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/email_address.js"></script>
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
<h2>비밀번호 재설정</h2><br>
<form id="frm" method="post" action="findPw">
	<input type="text" name="id" id="id" class="tsize" placeholder="아이디"><br><br>
	<input type="text" name="name" id="name" class="tsize" placeholder="이름"><br><br>
	<input type="text" name="e1" id="e1" size="5" class="tsize" placeholder="이메일"> @ <input type="text" name="e2" id="e2" size="10" class="tsize"> 
	<select name="e3" id="e3" class="tsize">
		<option value="">도메인 선택</option>
		<option value="naver.com">naver.com</option>
		<option value="hanmail.net">hanmail.net</option>
		<option value="gmail.com">gmail.com</option>
		<option value="nate.com">nate.com</option>
		<option value="direct">직접 입력</option>
	</select><br><br>
	<input type="submit" id="join" class="btn" value="확인" style=""><br>
</form>
</fieldset>
</div>
</body>
</html>
<%@ include file="../inc/incFoot.jsp" %>