<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head2.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>h2h</title>
<style>
#textu {
	text-align: center;
}

#sizem {
	width: 700px;
	text-align: center;
}

.center {
	position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.di1{ 
	height: 300px;
	text-align: center;
	border: 1px solid;
    float: left;
    width:300px;
    box-sizing: border-box;
	display:grid;
	place-content:center;
}

.di2{ 
	height: 300px;
	text-align: center;
	border: 1px solid;
    float: right;
    width:300px;
    box-sizing: border-box;
    display:grid;
	place-content:center;
}

.button {
	height: 40px;
	width: 250px;
	background-color: #B3B1B1;
	color: white;
}

.p1 {
	font-size: 12px;
}

.p2 {
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>
<body>
<div class="center">
	<div id="sizem">
		<div id="textu">
			<h2>회원가입</h2>
			<h3>해당하는 유형을 선택하세요</h3>
		</div><br>
		<div class="di1">
			<p class="p1">14세 이상</p>
			<p class="p2">개인 회원</p><br>
			<input type="button" class="button" value="가입하기" onclick="location.href='emailAuthentication'">
		</div>
		<div class="di2">
			<p class="p1">일반기업 및 2인 이상 단체</p>
			<p class="p2">기업·단체 회원</p><br>
			<input type="button" class="button" value="가입하기" onclick="location.href='memberGForm'">
		</div>
	</div>
</div>
</body>
</html>
<%@ include file="../_inc/inc_foot.jsp" %>