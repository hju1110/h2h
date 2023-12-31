<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/incHead2.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
fieldset {
	width: 500px;
	text-align: center;
}

#center {
	text-align: center;
	border: 1px solid;
	height: 300px;
	width: 600px;
	display:grid;
	place-content:center;
}

#mail-Check-Btn {
	height: 40px;
	width: 110px;
	background-color: #d74049;
	border-color: black;
	color: black;
	text-align: center;
}

.center {
	position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.btn2 {
	height: 40px;
	width: 110px;
	background-color: #B3B1B1;
	color: white;
}

.textp {
	height: 30px;
}

.acc {
	height: 40px;
	width: 355px;
}

#e1, #e2, #e3 {
	height: 40px;
	width: 110px;
}

</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/email_address.js"></script>
<script>
$(document).ready(function() {
	$('#mail-Check-Btn').click(function() {
		var f = document.frm;
		var regExp = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if (f.e1.value == "") {
			alert("이메일 주소를 확인해 주세요");
			f.e1.focus();
			return false;
		}
		
		if (f.e2.value == "") {
			alert("이메일 주소를 확인해 주세요");
			f.e2.focus();
			return false;
		}
		
		const emailn = $('#e1').val() + "@" + $('#e2').val(); // 이메일 주소값 얻어오기!
		const email = emailn.replace(/\s+/g, '');
		
		if (email.match(regExp) == null) {
			alert("이메일 주소를 확인해 주세요");
			return false;
		}
		
		$.ajax({
			type : "POST", url : "./dupEmail", data : {"email" : email}, 
			success : function(chkRs) {
				if (chkRs == 0) {
					alert("이메일로 인증번호를 보냈습니다.\n인증번호를 입력해주세요");
					$('#acc').prop('disabled', false);
					$('#ac').prop('disabled', false);
				} else {
					alert("해당 이메일로 가입된 계정이 있습니다.");
				}
			}
		});
	}); // end send eamil
});

function chkAcc() {
	let f = document.frm;
	if (f.acc.value == "") {
		alert("인증번호를 입력해주세요");
		return false;
	}
	return true;
}
</script>
</head>
<body>
<div id="center" class="center" style="line-height: 50%;">
<fieldset>
	<h2>회원가입</h2><br>
	<p>회원 가입을 위해 이메일을 인증해 주세요</p><br>
	<div class="input-group">
		<form name="frm" action="memberForm" method="post" onsubmit="return chkAcc();">
			<input type="text" name="e1" id="e1" size="10" class="textp"> @ <input type="text" name="e2" id="e2" size="10" class="textp">
			<select name="e3" id="e3" class="textp">
				<option value="">도메인 선택</option>
				<option value="naver.com">naver.com</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="gmail.com">gmail.com</option>
				<option value="nate.com">nate.com</option>
				<option value="direct">직접 입력</option>
			</select>
			<input type="button" class="btn btn-primary" id="mail-Check-Btn" value="이메일 인증"><br><br>
			<input type="text" class="acc textp" id="acc" name="acc"disabled="disabled">
			<input type="submit" id="ac" name="ac" value="인증번호 확인" class="btn2" disabled="disabled">
		</form>
	</div>
</fieldset>
</div>
</body>
</html>
<%@ include file="../inc/incFoot.jsp" %>