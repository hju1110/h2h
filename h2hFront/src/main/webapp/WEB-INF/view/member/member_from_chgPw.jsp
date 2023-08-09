<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="vo.MemberInfo" %>
<%
request.setCharacterEncoding("UTF-8");
MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
%>
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
	<h2>비밀번호 재설정</h2>	
	<form id="frm" method="post" action="chgPw2">
		<input type="hidden" name="id" value="<%=mi.getMi_id() %>">
		<input type="password" name="pw" class="tsize" placeholder="현재 비밀번호"><br><br>
		<input type="password" id="pw" name="npw" class="tsize" placeholder="변경할 비밀번호"><br><br>
		<input type="password" id="pwchk" name="npwchk" class="tsize" placeholder="비밀번호 확인"><br><br>
		<input type="submit" id="join" class="btn2" value="비밀번호 재설정"><br>
	</form>
</fieldset>
</div>
</body>
</html>