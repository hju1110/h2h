<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ include file="../inc/incHead2.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
%>
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
	<h2>나의 회원정보</h2>
	회원님의 정보를 안전하게 보호하기 위하여 <br>
	비밀번호를 다시 한 번 입력해주세요<br><br>
	<form id="frm" method="post" action="Info">
		<input type="hidden" name="id" value="<%=loginInfo.getMi_id() %>">
		<input type="password" name="pwChk" id="pwChk" class="tsize" placeholder="비밀번호" ><br><br>
		<input type="hidden" name="name" value="<%=loginInfo.getMi_name() %>">
		<input type="hidden" name="phone" value="<%=loginInfo.getMi_phone() %>">
		<input type="hidden" name="email" value="<%=loginInfo.getMi_email() %>">
		<input type="submit" id="join" class="btn" style="width: 300px" value="확인"><br>
	</form>
</fieldset>
</div>
<%@ include file="../inc/incFoot.jsp" %>