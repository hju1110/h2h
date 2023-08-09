<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String email = (String)request.getAttribute("email");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
fieldset {
	width: 600px;
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

.btn {
	height: 40px;
	width: 100px;
	background-color: red;
	color: white;
}
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
$(document).ready(function() {
	$('#join').click(function() {
		var frm = document.frm;
	    frm.submit();
	});
});
</script>
</head>
<body>
<div class="center">
<h2 class="textcenter">회원가입</h2>
<form name="frm" method="post" action="insertMemberJoin">
	<input type="hidden" name="type" value="a">
	<div>
	<fieldset>
		<p>회원 정보를 입력해주세요.</p>
		<hr>
		<table>
		<tr>
			<td width="130"><p>이름</p></td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td width="130"><p>생년월일</p></td>
			<td><input type="text" name="birth" maxlength="6" placeholder="주민등록번호 앞 6자리"> - <input type="text" name="birth2" size="1" maxlength="1">******</td>
		</tr>
		<tr>
			<td width="130"><p>아이디</p></td>
			<td><input type="text" name="id"></td>
		</tr>
		<tr>
			<td width="130"><p>비밀번호</p></td>
			<td><input type="password" name="pw"></td>
		</tr>
		<tr>
			<td width="130"><p>비밀번호 확인</p></td>
			<td><input type="password"></td>
		</tr>
		<tr>
			<td width="130"><p>휴대폰번호</p></td>
			<td>010 - <input type="text" name="p1" size="5" maxlength="4"> - <input type="text" name="p2" size="5" maxlength="4"></td>
		</tr>
		<tr>
			<td width="130"><p>이메일</p></td>
			<td><input type="text" value="<%=email %>" name="email" readonly="readonly"></td>
		</tr>
		</table><hr>
		<h3>주소</h3>
		<table>
		<tr>
			<td width="130"><p>수취인</p></td>
			<td><input type="text" name="rname"></td>
		</tr>
		<tr>
			<td width="130"><p>휴대폰번호</p></td>
			<td>010 - <input type="text" name="adp1" size="5" maxlength="4"> - <input type="text" name="adp2" size="5" maxlength="4"></td>
		</tr>
		<tr>
			<td width="130"><p>우편번호</p></td>
			<td><input type="text" name="zip" maxlength="5"></td>
		</tr>
		<tr>
			<td width="130"><p>주소</p></td>
			<td><input type="text" name="addr1"></td>
		</tr>
		<tr>
			<td width="130"><p>상세주소</p></td>
			<td><input type="text" name="addr2"></td>
		</tr>
		</table>
		</fieldset>
	</div><br>
	<p id="center"><input type="button" id="join" value="회원가입" class="btn textcenter"></p>
</form>
</div>
</body>
</html>