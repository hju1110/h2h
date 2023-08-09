<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ServiceChart</title>
<style>
body, th, td, div, p { font-size:12px; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; color:red; }
#list th, #list td { padding:8px 3px; }
#list th { border-bottom:double black 3px; }
#list td { border-bottom:dotted black 1px; }
</style>
<script>
function serChk(){
	var button = document.getElementById("chk");
	
	if(button != null) {
		alert("모집마감 하시겠습니까?")
	}
	
}
</script>
</head>
<body>
<table>
<tr><td colspan="2" align="center">
	<form name= "frmSch">
	<fieldset>
		<legend>봉사모집 검색</legend>
			<select name="schtype">
				<!-- <option value="">검색조건</option> -->
				<option value="title" <c:if test="${pi.getSchtype() == 'title'}"> selected="selected"</c:if>>활동명</option>
				<!--  <option value="content"<c:if test="${pi.getSchtype() == 'content'}"> selected="selected"</c:if>>내용</option>
				<option value="writer"<c:if test="${pi.getSchtype() == 'writer'}"> selected="selected"</c:if>>작성자</option>
				<option value="tc"<c:if test="${pi.getSchtype() == 'tc'}"> selected="selected"</c:if>>제목+내용</option>  -->
			</select>
			<input type="text" name="keyword" value="${pi.getKeyword() }"/>
			<input type="submit" value="검색" />

	</fieldset>
	</form>
</td>
</tr>
</table>
<h2>봉사활동 모집</h2>
<table width="700" border="0" cellpadding="0" cellspacing="0" id="list" border="1">
<tr height="30">
<th width="10%">No</th>
<th width="10%">모집상태</th>
<th width="*">봉사활동명</th>
<th width="15%">모집인원</th>
<th width="15%">활동일</th>
<th width="10%">등록일</th>  
</tr>
<c:if test="${serviceChartInfo.size() > 0}"><!-- 게시판 정보가 있으면~ else를 쓰고 싶으면 반대조건 주면 됨-->
	<c:forEach items="${serviceChartInfo}" var="sci" varStatus="status">
  <tr height="30">
    <td align="center">${pi.getNum() - status.index}</td>
    <td align="center">${sci.getSi_is_recruit() }</td>
    <td>
      <a href="serviceCheck?siidx=${sci.getSi_idx() }${pi.getArgs() }">${sci.getSi_title() }</a>
    </td>
    <td align="center">${sci.getSi_person() }</td>
    <td align="center">${sci.getSi_acdate() }</td>
    <td align="center">${sci.getSi_date() }<input type="button" id ="chk" value="모집마감" onclick="serChk();" /></td>
    <td align="center">
      <c:if test="${sci.getSi_is_recruit() eq '마감'}">
        <button disabled>마감</button>
      </c:if>
    </td>
  </tr>
</c:forEach>
</c:if>	
<c:if test="${serviceChartInfo.size() == 0}">
	<tr height="50"><td colspan="5" align="center">
	검색결과가 없습니다.
	</td></tr>
</c:if>
</table>
<br />
<table width="700" cellpadding="5">
<tr>
<td width="600">
	<c:if test="${serviceChartInfo.size() > 0 }">
		<c:if test="${pi.getCpage() == 1}">
			[처음]&nbsp;&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;
		</c:if>
		<c:if test="${pi.getCpage() > 1}">
			<a href="serviceChart?cpage=1${pi.getSchargs() }">[처음]</a>&nbsp;&nbsp;&nbsp;
			<a href="serviceChart?cpage=${pi.getCpage() - 1}${pi.getSchargs() }">[이전]</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${pi.getSpage() }"
			end="${pi.getSpage() + pi.getBsize() - 1 <= pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }">
				<c:if test="${i == pi.getCpage() }">
					&nbsp;<strong>${i }</strong>&nbsp;
				</c:if>
				<c:if test="${i != pi.getCpage() }">
					&nbsp;<a href="serviceChart?cpage=${i }${pi.getSchargs() }">${i }</a>&nbsp;
				</c:if>
		</c:forEach>
		
		<c:if test="${pi.getCpage() == pi.getPcnt() }">
			&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]
		</c:if>
		<c:if test="${pi.getCpage() < pi.getPcnt()}">
			&nbsp;&nbsp;<a href="serviceChart?cpage=${pi.getCpage() + 1}${pi.getSchargs() }">[다음]</a>
			&nbsp;&nbsp;&nbsp;<a href="serviceChart?cpage=${pi.getPcnt() }${pi.getSchargs() }">[마지막]</a>
		</c:if>
	</c:if>
</td>
<td width="*">
</td>
</tr>
</table>
</body>
</html>