<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="vo.MemberInfo" %>
<%@ include file="../inc/incHead2.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberStyle.css">
<script>
$(document).ready(function() {
	$('#join').click(function() {
		var frm = document.frm;
		
		if (frm.npw.value != frm.npwchk.value) {
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
<div class="wrapper memcenter" style="width: 500px; height: 300px; line-height: 50%;">
<fieldset>
	<h2>비밀번호 재설정</h2>	
	<form id="frm" method="post" action="chgPw2">
		<input type="hidden" name="id" value="<%=mi.getMi_id() %>">
		<input type="password" name="pw" class="tsize" placeholder="현재 비밀번호"><br><br>
		<input type="password" id="npw" name="npw" class="tsize" placeholder="변경할 비밀번호"><br><br>
		<input type="password" id="npwchk" name="npwchk" class="tsize" placeholder="비밀번호 확인"><br><br>
		<input type="submit" id="join" class="btn2" value="비밀번호 재설정"><br>
	</form>
</fieldset>
</div>
</body>
</html>
<%@ include file="../inc/incFoot.jsp" %>