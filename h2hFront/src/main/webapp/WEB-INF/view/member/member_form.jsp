<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head2.jsp" %>
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
	display:grid;
	place-content:center;
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
function onlyNum(num) {	// 숫자만 사용가능한 정규식
	num.value = num.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
}

$(document).ready(function() {
	$('#join').click(function() {
		var frm = document.frm;
		
		if (frm.name.value == "") {
			alert("이름을 입력해 주세요");
			frm.name.focus();
			return false;
		}
		
		if (frm.birth.value == "") {
			alert("생년월일을 입력해 주세요");
			frm.birth.focus();
			return false;
		}
		
		if (frm.birth2.value == "") {
			alert("생년월일을 입력해 주세요");
			frm.birth2.focus();
			return false;
		}
		
		if (frm.id.value == "") {
			alert("아이디를 입력해 주세요");
			frm.id.focus();
			return false;
		}
		
		if (frm.pw.value == "") {
			alert("비밀번호를 입력해 주세요");
			frm.password.focus();
			return false;
		}
		
		if (frm.rname.value == "") {
			alert("수취인을 입력해 주세요");
			frm.rname.focus();
			return false;
		}
		
		if (frm.zip.value == "") {
			alert("우편번호를 입력해 주세요");
			frm.zip.focus();
			return false;
		}
		
		if (frm.addr1.value == "") {
			alert("주소를입력해 주세요");
			frm.addr1.focus();
			return false;
		}
		
		if (frm.addr2.value == "") {
			alert("상세주소를 입력해 주세요");
			frm.addr2.focus();
			return false;
		}
		
		if (frm.pw.value != frm.chkPw.value) {
			alert("비밀번호가 일치하지 않습니다.");
			frm.chkPw.focus();
			return false;
		}
		
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
			<td><input type="text" name="birth" maxlength="6" placeholder="주민등록번호 앞 6자리" oninput="onlyNum(this);"> - <input type="" name="birth2" size="1" maxlength="1" oninput="onlyNum(this);">******</td>
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
			<td><input type="password" name="chkPw"></td>
		</tr>
		<tr>
			<td width="130"><p>휴대폰번호</p></td>
			<td>010 - <input type="text" name="p1" size="5" maxlength="4" oninput="onlyNum(this);"> - <input type="text" name="p2" size="5" maxlength="4" oninput="onlyNum(this);"></td>
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
			<td>010 - <input type="text" name="adp1" size="5" maxlength="4" oninput="onlyNum(this);"> - <input type="text" name="adp2" size="5" maxlength="4" oninput="onlyNum(this);"></td>
		</tr>
		<tr>
			<td width="130"><p>우편번호</p></td>
			<td><input type="text" name="zip" maxlength="5" oninput="onlyNum(this);"></td>
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
<%@ include file="../_inc/inc_foot.jsp" %>