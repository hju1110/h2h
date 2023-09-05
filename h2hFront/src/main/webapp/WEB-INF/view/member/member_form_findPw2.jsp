<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/incHead2.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
request.setCharacterEncoding("utf-8");
String id = (String)request.getAttribute("id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberStyle.css">
<style>
#pw, #pwchk, #join {
	width: 353px;
}
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
$(document).ready(function() {
	
	$('#join').click(function() {
		var frm = document.frm;
		
		if (frm.pw.value != frm.pwchk.value) {
			alert("비밀번호가 일치하지 않습니다.");
			frm.pwchk.focus();
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
	<form id="frm" method="post" action="chgPw">
		<input type="hidden" name="id" class="tsize" value="<%=id %>">
		<input type="password" id="pw" name="pw" class="tsize" placeholder="변경할 비밀번호"><br><br>
		<input type="password" id="pwchk" name="pwchk" class="tsize" placeholder="비밀번호 확인"><br><br>
		<input type="submit" id="join" class="btn" value="비밀번호 재설정">
	</form>
</fieldset>
</div>
</body>
</html>
<%@ include file="../inc/incFoot.jsp" %>