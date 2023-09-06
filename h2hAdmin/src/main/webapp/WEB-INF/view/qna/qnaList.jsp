<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>QnA 목록</title>
</head>
<body>
<div class="container mt-5">
<h2>QnA</h2>
<br />
<table id="list" class="table table-bordered table-striped">
<thead>
	<tr>
		<th scope="col">번호</th>
		<th scope="col">제목</th>
		<th scope="col">작성자</th>
		<th scope="col">작성일</th>	
		<th scope="col">답변여부</th>
	</tr>
</thead>
<tbody>
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
</tbody>
</table>
<br />
<div align="center">
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
</div>
<div align="right">
	<button class="btn btn-primary" onclick="location.href='qnaFormIn';" >글 등록</button>
</div><br />
<div>
<form name="frmSch">
	<div class="row">
		<div class="col-md-2">
			<select class="form-select" aria-label="Default select example" name="schtype">
				<option value="">검색조건</option>
				<option value="title" <c:if test="${pi.getSchtype() == 'title'}">selected="selected"</c:if>>제목</option>
				<option value="content"<c:if test="${pi.getSchtype() == 'content'}">selected="selected"</c:if>>내용</option>
				<option value="id"<c:if test="${pi.getSchtype() == 'id'}">selected="selected"</c:if>>질문자</option>
				<option value="tc" <c:if test="${pi.getSchtype() == 'tc'}">selected="selected"</c:if>>제목+내용</option>
			</select>
		</div>
		<div class="col-md-3">
			<input type="text" class="form-control" name="keyword" value="${pi.getKeyword() }"/>
		</div>
		<div class="col-md-1">
			<input type="submit" class="btn btn-primary" value="검색" />
		</div>
		<div class="col-md-1">
			<input type="button" class="btn btn-secondary" value="전체글" onclick="location.href='qnaList';" />
		</div>
	</div>
</form>
</div>
</div>
</body>
</html>
