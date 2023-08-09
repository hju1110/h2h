<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
body {
  font-size: 12px;
}

a:link, a:visited {
  text-decoration: none;
  color: black;
}

a:hover {
  text-decoration: underline;
  color: red;
}

#list {
  width: 700px;
  border-collapse: collapse;
  margin-bottom: 20px;
}

#list th, #list td {
  padding: 8px 3px;
}

#list th {
  border-bottom: double black 3px;
}

#list td {
  border-bottom: dotted black 1px;
}

#list th:nth-child(1) {
  width: 10%;
}

#list th:nth-child(2) {
  width: 50%;
}

#list th:nth-child(3),
#list th:nth-child(4),
#list th:nth-child(5),
#list td:nth-child(3),
#list td:nth-child(4),
#list td:nth-child(5) {
  width: 15%;
}

#list tr:nth-child(odd) {
  background-color: #f2f2f2;
}

#list tr:hover {
  background-color: #f9f9f9;
}

form {
  margin-top: 20px;
  text-align: center;
}

fieldset {
  border: 1px solid #ccc;
  padding: 10px;
}

legend {
  font-size: 14px;
  font-weight: bold;
}

select, input[type="text"], input[type="submit"], input[type="button"] {
  font-size: 12px;
  padding: 5px;
  margin: 5px;
}

input[type="submit"] {
  background-color: #007bff;
  color: white;
  border: none;
  cursor: pointer;
}

input[type="submit"]:hover {
  background-color: #0056b3;
}

input[type="button"] {
  background-color: #28a745;
  color: white;
  border: none;
  cursor: pointer;
}

input[type="button"]:hover {
  background-color: #1b6f2c;
}

#notice-form {
  width: 700px;
  margin: 20px auto;
  padding: 10px;
  border: 1px solid #ccc;
}

</style>
</head>
<body>
<h2>QnA</h2>
<table id="list">
<tr height="30">
<th>번호</th>
<th>제목</th>
<th>작성자</th>
<th>작성일</th>	
<th>답변여부</th>
</tr>
<c:if test="${qnaList.size() > 0}">
	<c:forEach items="${qnaList}" var="ql" varStatus="status">
	<tr height="30">
	<td align="center">${pi.getNum() - status.index}</td>
	<td><a href="qnaView?qlidx=${ql.getQl_idx()}${pi.getArgs()}">${ql.getQl_title()}</a></td>
	<td align="center">${ql.getMi_id()}</td>
	<td align="center">${ql.getQl_qdate()}</td>
	<td align="center">
		<c:if test="${ql.getQl_isanswer() == 'n' }">처리중</c:if>
		<c:if test="${ql.getQl_isanswer() == 'y' }">답변 완료</c:if>
	</td>
	</tr>
	</c:forEach>
</c:if>
<c:if test="${qnalist.size() == 0 }">
	<tr height="50"><td colspan="5" align="center">
	검색결과가 없습니다.
	</td></tr>
</c:if>
</table>
<br />
<table width="700" cellpadding="5">
<tr>
<td width="600">
<c:if test="${qnaList.size() > 0}">
	<c:if test="${pi.getCpage() == 1}">
		[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;
	</c:if>
	<c:if test="${pi.getCpage() > 1}">
		<a href="qnaList?cpage=1${pi.getSchargs()}">[처음]</a>&nbsp;&nbsp;&nbsp;
		<a href="qnaList?cpage=${pi.getCpage() - 1}">[이전]</a>&nbsp;&nbsp;&nbsp;
	</c:if>
	
	<c:forEach var="i" begin="${pi.getSpage()}" end="${pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt() ? 
	pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt()}">
		<c:if test="${i == pi.getCpage()}">
			&nbsp;<strong>${i}</strong>&nbsp;
		</c:if>
		<c:if test="${i != pi.getCpage()}">
			&nbsp;<a href="qnaList?cpage=${i}${pi.getSchargs()}">${i}</a>&nbsp;
		</c:if>
	</c:forEach>
	
	<c:if test="${pi.getCpage() == pi.getPcnt()}">
		&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]
	</c:if>
	<c:if test="${pi.getCpage() < pi.getPcnt()}">
		&nbsp;&nbsp;<a href="qnaList?cpage=${pi.getCpage() + 1}${pi.getSchargs()}">[다음]</a>
		&nbsp;&nbsp;&nbsp;<a href="qnaList?cpage=${pi.getPcnt()}${pi.getSchargs()}">[마지막]</a>
	</c:if>
</c:if>
</td>
<td width="*">
	<input type="button" value="글 등록" onclick="location.href='qnaFormIn';" />
</td>
</tr>
<tr><td colspan="2" align="center">
	<form name="frmSch">
	<fieldset>
		<legend>게시판 검색</legend>
		<select name="schtype">
			<option value="">검색조건</option>
			<option value="title" <c:if test="${pi.getSchtype() == 'title'}">selected="selected"</c:if>>제목</option>
			<option value="content"<c:if test="${pi.getSchtype() == 'content'}">selected="selected"</c:if>>내용</option>
			<option value="id"<c:if test="${pi.getSchtype() == 'id'}">selected="selected"</c:if>>질문자</option>
			<option value="tc" <c:if test="${pi.getSchtype() == 'tc'}">selected="selected"</c:if>>제목+내용</option>
		</select>
		<input type="text" name="keyword" value="${pi.getKeyword() }"/>
		<input type="submit" value="검색" />
		<input type="button" value="전체글" onclick="location.href='qnaList';" />
	</fieldset>
	</form>
</table>
</body>
</html>
