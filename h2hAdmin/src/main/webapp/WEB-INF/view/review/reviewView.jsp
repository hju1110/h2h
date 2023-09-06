<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>후기 게시판 상세</title>
<script>
function confirmDelete(rlIdx) {
    if (confirm("정말로 이 글을 삭제하시겠습니까?")) {
        // 확인을 눌렀을 때
        location.href = "reviewdeleteform?rlidx=" + rlIdx;
    }
}
</script>
</head>
<body>
<div class="container mt-5">
<br />
<table class="table table-bordered">
    <tr>
        <th class="col-md-1"style="text-align:center;">작성자</th>
        	<td class="col-md-1"style="text-align:center;">${rl.getRl_writer()}</td>
        <th class="col-md-1"style="text-align:center;">조회수</th>
        	<td class="col-md-1"style="text-align:center;">${rl.getRl_read()}</td>
        <th class="col-md-1"style="text-align:center;">작성일</th>
        	<td class="col-md-1"style="text-align:center;">${rl.getRl_date().replace("-", ".").substring(0,10)}</td>
    </tr>
    <tr><th>글제목</th><td>${rl.getRl_title()}</td></tr>
    <tr><th>글내용</th><td>${rl.getRl_content()}</td></tr>
    <tr>
        <td colspan="6" class="center">
            <img src="resources/img/${rl.getRl_name()}" width="300" />
        </td>
    </tr>
    <tr>
       <td colspan="6" class="text-center">
           <input type="button" class="btn btn-secondary" value="글목록" onclick="location.href='reviewList';" />
           <input type="button" class="btn btn-danger" value="글삭제" onclick="confirmDelete(${rl.getRl_idx()});" />
           <input type="button" class="btn btn-primary" value="글수정" onclick="location.href='reviewFormUp?rl_idx=${rl.getRl_idx()}';" />
           <!-- 이미지 다운로드 버튼 -->
           <a href="downloadImage?filename=${rl.getRl_name()}" download>
               <input type="button" class="btn btn-success" value="다운로드" />
           </a>
       </td>
    </tr>
</table>

<c:if test="${empty reviewReply}">
<div class="alert alert-info">
    등록된 댓글이 없습니다.
</div>
</c:if>

<hr>

<form action="addReviewReply" method="post" class="comment-form">
    <input type="hidden" name="rl_idx" value="${rl.getRl_idx()}" />
	<div class="form-group">
	<label for="rr_writer">작성자:</label><input type="text" name="rr_writer" class="form-control" /><br>
<!-- <textarea rows="5" cols="40" name="rr_content"></textarea><br> -->
	<!-- 댓글 작성일은 자동으로 서버에서 처리하므로 input 요소에서는 입력하지 않습니다. -->
	<!-- <input type="submit" value="댓글 등록" /> -->
	<div class="form-group">
		<label for="rr_content">댓글 내용:</label>
		<textarea rows="5" cols="40" name="rr_content" id="rr_content" class="form-control"></textarea>
	</div>
    <!-- 댓글 작성일은 자동으로 서버에서 처리하므로 input 요소에서는 입력하지 않습니다. -->
    <button type="submit" class="btn btn-primary">댓글 등록</button>

</form>
<hr>
<c:if test="${not empty reviewReply}">
	<ul class="list-group comment-list">
		<c:forEach var="reply" items="${reviewReply}">
		<li class="list-group-item">
			<span class="font-weight-bold writer">작성자: ${reply.rr_writer}</span><br>
			<span class="content">내용: ${reply.rr_content}</span><br>
			<span class="text-muted date">작성일: ${reply.rr_date}</span>
		</li>
		</c:forEach>
	</ul>
</c:if>
</div>
</body>
</html>
