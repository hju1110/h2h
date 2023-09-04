<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
List<ServiceInfo> serviceList = (List<ServiceInfo>)request.getAttribute("serviceList");
PageInfo pi = (PageInfo)request.getAttribute("pi");
String chk = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }
  th, td {
    padding: 10px;
    text-align: center;
    border: 1px solid #ccc;
  }
  th {
    background-color: #f2f2f2;
  }
  tr:nth-child(odd) {
    background-color: #f9f9f9;
  }
  a:link, a:visited {
    text-decoration: none;
    color: #333;
  }
  a:hover {
    text-decoration: underline;
    color: #d9534f;
  }
  .btn {
    padding: 5px 10px;
    border: none;
    border-radius: 3px;
    background-color: #d9534f;
    color: white;
    cursor: pointer;
  }
  .btn:hover {
    background-color: #c9302c;
  }
  .search-form {
    margin-bottom: 20px;
  }
  .search-form select, .search-form input[type="text"], .search-form input[type="submit"], .search-form input[type="button"] {
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 3px;
  }
  .paging {
    margin-top: 10px;
  }
  .paging a {
    margin: 0 5px;
    color: #333;
  }
  .paging strong {
    margin: 0 5px;
    color: #d9534f;
  }
  #co h2 {
  color: blue;
}

</style>
<script>
function del(siidx) {
  var confirmed = confirm("정말로 마감하시겠습니까?");
  if (confirmed) {
    $.ajax({
      type: "POST",
      url: "./serviceStop",
      data: {"siidx": siidx},
      success: function(chkRs) {
        if (chkRs != 1) {
          alert("마감 처리시 문제가 생겼습니다."); 
        } else {
          alert("마감되었습니다.");
          location.reload();
        }
      }
    });
  }
}
</script>
</head>
<body>
<div align="center">
<div class="left">
<table>
<tr><td colspan="2" align="center">
	<form name= "frmSch">
	<fieldset>
		<legend>봉사일정 검색</legend>
			<select name="schtype">
				<!-- <option value="">검색조건</option> -->
				<option value="acname" <c:if test="${pi.getSchtype() == 'acname'}"> selected="selected"</c:if>>활동명</option>
				<!--  <option value="content"<c:if test="${pi.getSchtype() == 'content'}"> selected="selected"</c:if>>내용</option>
				<option value="writer"<c:if test="${pi.getSchtype() == 'writer'}"> selected="selected"</c:if>>작성자</option>
				<option value="tc"<c:if test="${pi.getSchtype() == 'tc'}"> selected="selected"</c:if>>제목+내용</option>  -->
			</select>
			<input type="text" name="keyword" value="${pi.getKeyword() }"/>
			<input type="submit" value="검색" />
			<input type="button" value="전체글" onclick="location.href='service';" />
	</fieldset>
	</form>
</td>
</tr>
</table>
<br />
<div id="co"><h2>봉사활동 신청(승인)</h2></div>
<a href="service">봉사활동 신청(미승인목록)</a>
<table width="700" border="0" cellpadding="0" cellspacing="0" id="list" border="1">
<tr height="30">
<th width="10%">No</th>
<th width="10%">모집상태</th>
<th width="*">봉사활동명</th>
<th width="15%">모집인원</th>
<th width="15%">활동일</th>
<th width="10%">등록일</th> 
<th width="10%">버튼</th>  
</tr>
<% if (serviceList.size() > 0)  { %>
	<% for (ServiceInfo si : serviceList) { 
	 	if (si.getSi_recruit().equals("y")) { chk = "모집중"; } else { chk = "모집종료"; } 
	%>
	<tr height="30">
	<td align="center"><%=si.getSi_idx() %></td> 
	<td align="center"><%=chk %></td> 
	<td><a href="serviceCheckForm?siidx=<%=si.getSi_idx() %><%=pi.getArgs() %>"><%=si.getSi_acname() %></a></td>
	<td align="center"><div><%=si.getSi_cnt() %>/<%=si.getSi_person()%></div></td>
	<td align="center"><%=si.getSi_acdate().substring(0, 11) %></td>
	<td align="center"><%=si.getSi_date().substring(0, 11) %></td>
	<td><% if (si.getSi_recruit().equals("y")) { %><input type="button" value="마감" onclick="del(<%=si.getSi_idx() %>);"/>   <% } %> </td>	
	<% } %>
<% } else { %>
	<tr height="50"><td colspan="5" align="center">
	검색결과가 없습니다.
	</td></tr>
<% } %>	
</table>
<br />
<table width="700" cellpadding="5">
<tr>
<td width="600">
	<c:if test="${serviceInfo.size() > 0 }">
		<c:if test="${pi.getCpage() == 1}">
			[처음]&nbsp;&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;
		</c:if>
		<c:if test="${pi.getCpage() > 1}">
			<a href="serviceChartz?cpage=1${pi.getSchargs() }">[처음]</a>&nbsp;&nbsp;&nbsp;
			<a href="serviceChartz?cpage=${pi.getCpage() - 1}${pi.getSchargs() }">[이전]</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${pi.getSpage() }"
			end="${pi.getSpage() + pi.getBsize() - 1 <= pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }">
				<c:if test="${i == pi.getCpage() }">
					&nbsp;<strong>${i }</strong>&nbsp;
				</c:if>
				<c:if test="${i != pi.getCpage() }">
					&nbsp;<a href="serviceChartz?cpage=${i }${pi.getSchargs() }">${i }</a>&nbsp;
				</c:if>
		</c:forEach>
		
		<c:if test="${pi.getCpage() == pi.getPcnt() }">
			&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]
		</c:if>
		<c:if test="${pi.getCpage() < pi.getPcnt()}">
			&nbsp;&nbsp;<a href="serviceChartz?cpage=${pi.getCpage() + 1}${pi.getSchargs() }">[다음]</a>
			&nbsp;&nbsp;&nbsp;<a href="serviceChartz?cpage=${pi.getPcnt() }${pi.getSchargs() }">[마지막]</a>
		</c:if>
	</c:if>
</td>
<td width="*">
</td>
</tr>
</table>
</div>
</div>
</body>
</html>