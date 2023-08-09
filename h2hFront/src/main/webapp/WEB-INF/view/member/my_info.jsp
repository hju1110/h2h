<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<%@ page import="vo.MemberInfo" %>
<%
request.setCharacterEncoding("UTF-8");
MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
String name = mi.getMi_name();
String p = mi.getMi_phone();
String e = mi.getMi_email(); 

String type = mi.getMi_type();
String birth = "";
if (type.equals("a")) {
	birth = mi.getMi_birth().substring(0, 4) + "년" + mi.getMi_birth().substring(5, 7) + "월" + mi.getMi_birth().substring(8) + "일";	
}
String[] phone = p.split("-");
String[] email = e.split("@");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/test.css">
<style>
span {
	width: 120px;
	display: inline-block;
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
<h2>나의 회원정보</h2><hr>
<form name="frm" id="frm" method="post" action="chgMemberInfo">
	<input type="hidden" name="type" value="<%=type %>">
	<input type="hidden" name="id" value="<%=mi.getMi_id() %>">
	<input type="hidden" name="pw" value="<%=mi.getMi_pw() %>">
	<% if (type.equals("a")) { %>
	<span>성명</span><%=mi.getMi_name() %><br>
	<% } else if (type.equals("b")) { %>
	<span>기업/단체명</span><%=mi.getMi_gname() %><br>
	<span>사업자번호</span><%=mi.getMi_bnum() %><br>
	<% } else { %>
	<span>기업/단체명</span><%=mi.getMi_gname() %><br>
	<% } %>
	<% if (type.equals("a")) { %><span>생년월일</span><%=birth %><br> <% } %>
	<span>아이디</span><%=mi.getMi_id() %><br>
	<hr>
	<span>비밀번호</span><input type="button" id="chgPw" value="비밀번호 변경하기" style="width: 300px; height: 35px;" class="btn" onclick="location.href='chgPw2'">
	<hr>
	<% if (!type.equals("a")) { %>
	<span>담당자명</span><input type="text" name="name" value="<%=mi.getMi_name() %>">
	<hr>
	<% } %>
	<span>휴대폰 번호</span><input type="text" name="p1" value="<%=phone[0] %>" size="5"> - <input type="text" name="p2" value="<%=phone[1] %>" size="5"> - <input type="text" name="p3" value="<%=phone[2] %>" size="5">
	<hr>
	<span>이메일</span><input type="text" name="e1" value="<%=email[0] %>"> @ <input type="text" name="e2" value="<%=email[1] %>">
	<hr>
	<input type="button" value="취소" class="btn1" onclick="location.href='/h2hFront'">
	<input type="submit" id="join" class="btn" value="저장">
</form>

</body>
</html>