<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("UTF-8");

CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");
int sy = ci.getSchYear(), sm = ci.getSchMonth(), sd = ci.getSchDay();
int sWeek = ci.getsWeek(), eDay = ci.getSchLast();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사 일정 등록</title>
<script src="${pageContext.request.contextPath}/resources/js/date_change.js"></script>
<script>
$(document).ready(function() {
	$("#btn").click(function() {
		var date = $("#y").val() + "-" + $("#m").val() + "-" + $("#d").val();
		var time = $("#h").val() + ":" + $("#n").val();
		
		$("#si_date").val(date);
		$("#si_time").val(time);
	//	alert($("#si_date").val() + "::" + $("#si_time").val());
		document.frm.submit();
	});
});
</script>
</head>
<body>
<h2>일정 등록 폼</h2>
<form name="frm" action="scheduleInProc" method="post">
<input type="hidden" name="si_date" id="si_date" value="" />
<input type="hidden" name="si_time" id="si_time" value="" />
<table width="500" cellpadding="5">
<tr>
	<th width="15%">일시</th>
	<td width="*">
		<select name="y" id="y" onchange="resetday(this.value, this.form.m.value, this.form.d);">
		<% for (int i = 2000 ; i <= ci.getCurYear() + 10 ; i++) { %>
			<option <% if (i == sy) { %>selected="selected" <% } %>><%=i %></option>
		<% } %>
		</select>년
		<select name="m" id="m" onchange="resetday(this.form.y.value, this.value, this.form.d);">
		<% for (int i = 1 ; i <= 12 ; i++) { 
			String tmp = (i < 10 ? "0" + i : i + "");
			String slt = (i == sm ? " selected='selected'" : "");
		%>
			<option <%=slt %>><%=tmp %></option>
			
		<% } %>
		</select>월
		<select name="d" id="d">
		<% for (int i = 1 ; i <= eDay ; i++) { 
			String tmp = (i < 10 ? "0" + i : i + "");
			String slt = (i == sd ? " selected='selected'" : "");
		%>
			<option <%=slt %>><%=tmp %></option>
		<% } %>
		</select>일&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="h" id="h">
		<% for (int i = 0 ; i <= 23 ; i++) { 
			String tmp = (i < 10 ? "0" + i : i + "");
		%>
			<option><%=tmp %></option>
		<% } %>
		</select>시
		<select name="n" id="n">
		<% for (int i = 0 ; i <= 59 ; i++) { 
			String tmp = (i < 10 ? "0" + i : i + "");
		%>
			<option><%=tmp %></option>
		<% } %>
		</select>분
	</td>
</tr>
<tr>
	<th>일정내용</th>
	<td><textarea name="content" rows="5" cols="45"></textarea></td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="button" value="일정 등록" id="btn" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="취소" onclick="history.back();" />
	</td>
</tr>
</table>
</form>
</body>
</html>
