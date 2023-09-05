<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/incHead.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>후기 게시판 목록</title>
<div class="hero-wrap" style="background-image: url('/h2hFront/resources/img/bg_5.jpg');" data-stellar-background-ratio="0.5">
	<div class="overlay"></div>
	<div class="container">
		<div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
			<div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
				<h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Review List</h1>
			</div>
		</div>
	</div>
</div>
</head>
<body>
<div align="center" style="padding:100px;">
 <h1 class="text-center text-primary ftco-animate mb-3">후기게시판</h1>
 <table class="table table-bordered" id="list">
<thead>
	<tr height="30">
		<th class="text-center" style="width:5%;">No</th>
		<th class="text-center" style="width:30%;">제목</th>
		<th class="text-center" style="width:15%;">작성자</th>
		<th class="text-center" style="width:25%;">작성일</th>   
		<th class="text-center" style="width:5%;">조회</th>
	</tr>
 </thead>
 </div>
<c:if test="${reviewList.size() > 0}">
   <c:forEach items="${reviewList}" var="rl" varStatus="status">
   <tr height="30">
   <td align="center">${pi.getNum() - status.index}</td>
   <td><a href="reviewView?rlidx=${rl.getRl_idx()}${pi.getArgs()}">${rl.getRl_title()}</a></td>
   <td align="center">${rl.getRl_writer()}</td>
   <td align="center">${rl.getRl_date()}</td>
   <td align="center">${rl.getRl_read()}</td>
   </tr>
   </c:forEach>
</c:if>
<c:if test="${reviewlist.size() == 0 }">
   <tr height="50"><td colspan="5" align="center">
   검색결과가 없습니다.
   </td></tr>
</c:if>
</table>
<br />
</table>
<div align="center">
<tr>
<td width="600">
<c:if test="${reviewList.size() > 0}">
   <c:if test="${pi.getCpage() == 1}">
      [처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;
   </c:if>
   <c:if test="${pi.getCpage() > 1}">
      <a href="reviewList?cpage=1${pi.getSchargs()}">[처음]</a>&nbsp;&nbsp;&nbsp;
      <a href="reviewList?cpage=${pi.getCpage() - 1}">[이전]</a>&nbsp;&nbsp;&nbsp;
   </c:if>
   
   <c:forEach var="i" begin="${pi.getSpage()}" end="${pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt() ? 
   pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt()}">
      <c:if test="${i == pi.getCpage()}">
         &nbsp;<strong>${i}</strong>&nbsp;
      </c:if>
      <c:if test="${i != pi.getCpage()}">
         &nbsp;<a href="reviewList?cpage=${i}${pi.getSchargs()}">${i}</a>&nbsp;
      </c:if>
   </c:forEach>
   
   <c:if test="${pi.getCpage() == pi.getPcnt()}">
      &nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]
   </c:if>
   <c:if test="${pi.getCpage() < pi.getPcnt()}">
      &nbsp;&nbsp;<a href="reviewList?cpage=${pi.getCpage() + 1}${pi.getSchargs()}">[다음]</a>
      &nbsp;&nbsp;&nbsp;<a href="reviewList?cpage=${pi.getPcnt()}${pi.getSchargs()}">[마지막]</a>
   </c:if>
</c:if>
</td>
<!-- <td width="*">
   <% if (loginInfo != null) { %>
      <input type="button" value="글 등록" onclick="location.href='reviewFormIn';" />
   <% } %>
</td> -->
</tr>
<tr><td colspan="2" align="center">
   <form name="frmSch">
   <fieldset>
      <legend>게시판 검색</legend>
      <select name="schtype">
         <option value="">검색조건</option>
         <option value="title" <c:if test="${pi.getSchtype() == 'title'}">selected="selected"</c:if>>제목</option>
         <option value="content"<c:if test="${pi.getSchtype() == 'content'}">selected="selected"</c:if>>내용</option>
         <option value="writer"<c:if test="${pi.getSchtype() == 'writer'}">selected="selected"</c:if>>작성자</option>
         <option value="tc" <c:if test="${pi.getSchtype() == 'tc'}">selected="selected"</c:if>>제목+내용</option>
      </select>
      <input type="text" name="keyword" value="${pi.getKeyword() }"/>
      <input type="submit" value="검색" />
      <input type="button" value="전체글" onclick="location.href='reviewList';" />
   </fieldset>
   </form>
   </td>
   </tr>
</table>
</div>
</div>
<%@ include file="../inc/incFoot.jsp" %>