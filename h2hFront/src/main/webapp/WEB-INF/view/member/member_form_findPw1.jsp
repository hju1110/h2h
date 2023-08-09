<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
</style>
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
<h2>비밀번호 재설정</h2>
<form id="frm" method="post" action="findPw">
	<input type="text" name="id" id="id" class="tsize" placeholder="아이디"><br><br>
	<input type="text" name="name" id="name" class="tsize" placeholder="이름"><br><br>
	<input type="text" name="email" id="email" class="tsize" placeholder="이메일"><br><br>
	<input type="submit" id="join" class="btn" value="확인"><br>
</form>
</fieldset>
</div>
</body>
</html>