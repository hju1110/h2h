<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("UTF-8");
AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
if (loginInfo == null) {
%>
<script>
	parent.location.href = "login";
</script>
<%
}
%>
