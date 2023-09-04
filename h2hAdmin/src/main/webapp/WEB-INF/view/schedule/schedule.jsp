<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("UTF-8");

//
List<ScheduleInfo> scheduleList = (List<ScheduleInfo>)request.getAttribute("scheduleList");

// 달력 출력을 위한 정보(현재 연월일, 검색 연월, 말일 등)들을 저장하고 있는 인스턴스
CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");
int sy = ci.getSchYear(), sm = ci.getSchMonth();	// sy -> searchyear, sm -> searchmonth
int sWeek = ci.getsWeek();	// 1일의 요일 및 시작 번호(1~7, 1: 월요일)
int eDay = ci.getSchLast();	// 말일(루프의 조건으로 사용)

int minYear = 2000, maxYear = ci.getCurYear() + 10;
int nextYear = sy, nextMonth = sm + 1;
if (nextMonth == 13) {	// 12월에서 '다음달' 버튼 클릭 시 월은 1월로 년도를 1증가 시킴 
	nextMonth = 1;
	nextYear++;
}
int prevYear = sy, prevMonth = sm - 1;
if (prevMonth == 0) {	// 1월에서 '이전달' 버튼 클릭 시 월은 12월로 년도를 1감소 시킴 
	prevMonth = 12;
	prevYear--;
}

String prevYearLink = "location.href='schedule?schYear=" + (sy - 1) + "&schMonth=" + sm + "';";
if (sy - 1 < minYear) {
	prevYearLink = "alert=('이전 연도가 없습니다.');";	// 이전 연도 링크
}

String prevMonthLink = "location.href='schedule?schYear=" + prevYear + "&schMonth=" + prevMonth + "';";
if (prevYear < minYear && prevMonth == 12) {
	prevMonthLink = "alert=('이전 연도가 없습니다.');";	// 이전달 링크
}

String nextYearLink = "location.href='schedule?schYear=" + (sy + 1) + "&schMonth=" + sm + "';";
if (sy + 1 > maxYear) {
	nextYearLink = "alert=('다음 연도가 없습니다.');";	// 다음 연도 링크
}

String nextMonthLink = "location.href='schedule?schYear=" + nextYear + "&schMonth=" + nextMonth + "';";
if (nextYear > maxYear && nextMonth == 1) {
	nextMonthLink = "alert=('다음 연도가 없습니다.');";	// 다음달 링크
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사 일정 관리</title>
<style>
a:link { color:black; text-decoration:none; }
a:visited { color:black; text-decoration:none; }

#searchBox { width:700px; text-align:center; }
.calendar, .calendar th, .calendar td { border:1px solid black; }
.calendar { border-collapse:collapse; }
.calendar td { height:70px; }
.txtRed { color:red; font-weight:bold; }
.txtBlue { color:blue; font-weight:bold; }
#txtTpday { background:#efefef; }
.scheduleBox { width:400px; height:150px; background:#fbef84; padding:10px; overflow:auto; position:absolute; top:200px; 
		left:150px; display:none; font-size:0.9em;	}
</style>
<script>
function showSchedule(num) {
	var obj = document.getElementById("box" + num);
	obj.style.display = "block";
}

function hideSchedule(num) {
	var obj = document.getElementById("box" + num);
	obj.style.display = "none";
}

function callDel(idx) {
	if (confirm("정말 삭제 하시겠습니까?")) {
		location.href = "scheduleDel?idx=" + idx + '&sch=<%=sy+""+sm %>';
	}
}
</script>
</head>
<body>
<div class="left">
<div id="searchBox">
	<h2>봉사 일정 관리 - <%=sy %>년<%=sm %>월</h2>
	<form name="frm">
		<input type="button" value="작년" onclick="<%=prevYearLink %>" />
		<input type="button" value="이전달" onclick="<%=prevMonthLink %>" />
			<select name="schYear" onchange="this.form.submit();">
			<% for (int i = minYear ; i <= maxYear ; i++) { %>
				<option <% if (sy == i) { %>selected="selected" <% } %>><%=i %></option>
			<% } %>
			</select>년
			<select name="schMonth" onchange="this.form.submit();">
			<% for (int i = 1 ; i <= 12 ; i++) { %>
				<option <% if (sm == i) { %>selected="selected" <% } %>><%=i %></option>
			<% } %>
			</select>월
		<input type="button" value="오늘" onclick="location.href='schedule';" />
		<input type="button" value="다음달" onclick="<%=nextMonthLink %>" />
		<input type="button" value="내년" onclick="<%=nextYearLink %>" />
	</form>
</div><br />
<table width="700" class="calendar">
<tr height="30">
<th width="100">월</th>
<th width="100">화</th>
<th width="100">수</th>
<th width="100">목</th>
<th width="100">금</th>
<th width="100" class='txtBlue'>토</th>
<th width="100" class='txtRed'>일</th>
</tr>
<%
if (sWeek != 1) {	// 1일이 월요일이 아니면(시작위치가 처음이 아니면)
	out.println("<tr>");
	for (int i = 1 ; i < sWeek ; i++) {
		out.println("<td></td>");
	}
}

for (int i = 1, n = sWeek ; i <= eDay ; i++, n++) {
// i : 날짜의 일(day)을 표현하기 위한 변수
// n : 일주일이 지날 때 마다 다음 줄로 내리기 위한 변수
	String txtClass = "", txtID = "";
	if (n % 7 == 1) {
		out.println("<tr>");	// 요일 번호가 1(월요일)이면 <tr>을 열어줌
	}
	if (n % 7 == 6) {
		txtClass = " class='txtBlue'";
	} else if (n % 7 == 0) {
		txtClass = " class='txtRed'";
	}
	
	String sch = "", close = "";
	if (scheduleList.size() > 0) {	// 검색 연월에 해당하는 일정이 있을 경우
		String schDate = sy + "-" + (sm < 10 ? "0" + sm : sm) + "-" + (i < 10 ? "0" + i : i);	// si_date와 비교할 값
		out.println("<div class='scheduleBox' id='box" + i + "'>");
		for (ScheduleInfo si : scheduleList) {
			if (schDate.equals(si.getSi_date())) {	// 현재 출력할 날짜에 해당하는 일정이 있을 경우
				sch = "<a href='javascript:showSchedule(" + i + ");'>일정확인</a>";
				close = "<input type='button' value='닫기' onclick='hideSchedule(" + i + ");' /><br /><br />";
			%>
				<%=schDate %><span style="margin-right:240px;"></span><%=close %>
				일시 : <%=si.getSi_time() %>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="삭제" onclick="callDel(<%=si.getSi_idx() %>);" />
				<br /> <%=si.getSi_content().replace("\r\n", "<br />") %>
				<br /><br />등록일 : <%=si.getSi_regdate() %><hr />
			<%
			}
		}
		out.println("</div>");
	}
	
	String args = "?y=" + sy + "&m=" + sm + "&d=" + i;
	out.println("<td valign='top'>" + "<a href='scheduleInForm" + args + "' "+ txtClass + ">" + i + "</a><br />" + sch + "</td>");
	
	if (n % 7 == 0) {	// 요일번호가 7의 배수(일요일)이면
		out.println("</tr>");
	} else if (i == eDay) {
		for (int j = n % 7 ; j < 7 ; j++) {
			out.println("<td></td>");
		}
		out.println("</tr>");
	}
}
%>
</table>
</div>
</body>
</html>
