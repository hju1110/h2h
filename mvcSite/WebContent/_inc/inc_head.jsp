<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.* " %>
<%
final String ROOT_URL = "/mvcSite/"; 


MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
boolean isLogin = false;
if (loginInfo != null) isLogin = true;
// 로그인 여부를 판단할 변수 isLogin을 생성

String loginUrl = request.getRequestURI();
if (request.getQueryString() != null) 
	loginUrl += "?" +  URLEncoder.encode(request.getQueryString().replace('&', '~'),"utf-8");	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>

body, th, td, div, p { font-size:12px; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; color:red; }
.hand { cursor:pointer; }
.bold { font-weight:bold; }
body { background-color:#ffffcc; }
.ffff2 { background-color:#efefef; }
</style>
<script src="<%=ROOT_URL %>js/jquery-3.6.4.js"></script>
<script>
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";
	}
}
</script>
</head>
<body>
<div class="ffff2">
<a href="<%=ROOT_URL %>">HOME</a>&nbsp;&nbsp;&nbsp;&nbsp;
<% if (isLogin) { %>
<a href="<%=ROOT_URL %>logout.jsp">로그아웃</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="memberFormUp">정보수정</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="cartView">장바구니</a>&nbsp;&nbsp;&nbsp;&nbsp;
<% } else { %>
<a href="login_form">로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="memberFormIn">회원가입</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="login_form?url=cartView">장바구니</a>&nbsp;&nbsp;&nbsp;&nbsp;
<% } %>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="productList?pcb=AA" class="bold">구두</a>&nbsp;&nbsp;&nbsp;
<a href="productList?pcb=BB" class="bold">운동화</a>
</div>
<hr />
