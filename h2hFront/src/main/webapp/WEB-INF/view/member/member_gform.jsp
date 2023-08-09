<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
fieldset {
	width: 600px;
}

#center {
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
	align-items: center;
}

.btn {
	height: 40px;
	width: 100px;
	background-color: red;
	color: white;
}

.btn2 {
	height: 40px;
	width: 100px;
	background-color: #B3B1B1;
	color: white;
}

.btn3 {
	height: 40px;
	width: 100px;
	background-color: white;
	color: black;
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
	
	$('#chG').click(function() {
		$('#type').val('b');
		$('#bNum').css("display", "none");
		$('#chC').css("color", "black");
		$('#chC').css("background-color", "white");
		$('#chG').css("color", "white");
		$('#chG').css("background-color", "#B3B1B1");
	});


	$('#chC').click(function() {
		$('#type').val('b');
		$('#bNum').css("display", "");
		$('#chG').css("color", "black");
		$('#chG').css("background-color", "white");
		$('#chC').css("color", "white");
		$('#chC').css("background-color", "#B3B1B1");
	});
});

const autoHyphen2 = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,2})(\d{0,5})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
</script>
</head>
<body>
<div class="center">
<h2 class="textcenter">회원가입</h2>
<form name="frm" method="post" action="insertMemberJoin">
	<input type="hidden" id="type" name="type" value="c">
	<div>
	<fieldset>
		<p>회원 정보를 입력해주세요.</p>
		<hr>
		<table>
		<tr>
			<td width="130"><p>구분</p></td>
			<td>
				<input type="button" value="기업" class="btn2" id="chC"><input type="button" value="단체" class="btn3" id="chG">
			</td>
		</tr>
		<tr>
			<td width="130"><p>기업/단체명</p></td>
			<td><input type="text" name="gname"></td>
		</tr>
		<tr>
			<td width="130"><p>담당자명</p></td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr style="display: " id="bNum" >
			<td width="130"><p>사업자 번호</p></td>
			<td><input type="text" name="bnum" placeholder="xxx-xx-xxxxx" oninput="autoHyphen2(this)" maxlength="12"></td>
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
			<td width="130"><p>전화번호</p></td>
			<td>010 - <input type="text" name="p1" size="5" maxlength="4"> - <input type="text" name="p2" size="5" maxlength="4"></td>
		</tr>
		<tr>
			<td width="130"><p>이메일</p></td>
			<td>
				<input type="text" name="e1" id="e1" size="10" class="textp"> @ <input type="text" name="e2" id="e2" size="10" class="textp">
				<select name="e3" id="e3" class="textp">
					<option value="">도메인 선택</option>
					<option value="naver.com">naver.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="gmail.com">gmail.com</option>
					<option value="nate.com">nate.com</option>
					<option value="direct">직접 입력</option>
				</select>
			</td>
		</tr>
		</table>
	</fieldset>
	</div>
	<p id="center"><input type="button" id="join" value="회원가입" class="btn textcenter"></p>
</form>
</div>
</body>
</html>