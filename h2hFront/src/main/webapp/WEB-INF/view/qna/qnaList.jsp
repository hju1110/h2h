<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/incHead.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<div class="hero-wrap" style="background-image: url('/h2hFront/resources/img/bg_5.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">QnA List</h1>
          </div>
        </div>
      </div>
    </div>
</head>
<body>
<div align="center" style="padding:100px;">
 <h1 class="text-center text-primary ftco-animate mb-3">QnA 목록</h1>
 <table class="table table-bordered" id="list">
 	<thead>
		<tr>
			 <th class="text-center" style="width:5%;">번호</th>
			 <th class="text-center" style="width:30%;">제목</th>
			 <th class="text-center" style="width:5%;">작성자</th>
			 <th class="text-center" style="width:5%;">작성일</th>	
			 <th class="text-center" style="width:5%;">답변여부</th>
		</tr>
	</thead>
<c:if test="${qnaList.size() > 0}">
	<c:forEach items="${qnaList}" var="ql" varStatus="status">
	<table class="table table-bordered" width="1000" cellpadding="5">
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
</div>
<%@ include file="../inc/incFoot.jsp" %>