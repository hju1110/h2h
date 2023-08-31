<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
    /* 스타일 추가 */
    body {
        font-family: Arial, sans-serif;
    }
    h2 {
        color: #007bff;
    }
    table {
        width: 600px;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th, td {
        padding: 5px;
        border: 1px solid #ccc;
    }
    th {
        background-color: #f0f0f0;
        text-align: center;
    }
    .center {
        text-align: center;
    }
    .comment-form {
        margin-bottom: 20px;
    }
    .comment-form input[type="text"],
    .comment-form textarea,
    .comment-form input[type="submit"] {
        margin: 5px;
    }
    .comment-list {
        margin-top: 10px;
    }
    .comment-list li {
        margin-bottom: 10px;
        padding: 5px;
        border: 1px solid #ccc;
        list-style-type: none;
    }
    .comment-list .writer {
        font-weight: bold;
    }
    .comment-list .content {
        margin-top: 5px;
    }
</style>
</head>
<body>
<h2>Qna</h2>
<table>
    <tr>
        <th width="10%">작성자</th><td width="15%">${ql.getQl_writer()}</td>
        <th width="10%">조회수</th><td width="15%">${ql.getQl_read()}</td>
        <th width="10%">작성일</th><td width="15%">${ql.getQl_date()}</td>
    </tr>
    <tr><th>글제목</th><td colspan="5">${ql.getQl_title()}</td></tr>
    <tr><th>글내용</th><td colspan="5">${ql.getQl_content()}</td></tr>
    <tr>
        <td colspan="6" class="center">
            <img src="resources/img/${ql.getQl_name()}" width="300" />
        </td>
    </tr>
    <tr>
       <td colspan="6" class="center">
           <input type="button" value="리스트" onclick="location.href='qnaList';" />
           <input type="button" value="글수정" onclick="location.href='qnaFormUp?ql_idx=${ql.getQl_idx()}';" />
           <!-- 이미지 다운로드 버튼 -->
           <a href="downloadImage?filename=${ql.getQl_img1()}" download>
               <input type="button" value="다운로드" />
           </a>
       </td>
    </tr>
</table>

<c:if test="${empty reviewReply}">
    등록된 답변이 없습니다
</c:if>

<hr>

<form action="addReviewReply" method="post" class="comment-form">
    <input type="hidden" name="ql_idx" value="${ql.getQl_idx()}" />
    작성자: <input type="text" name="rr_writer" /><br>
    <textarea rows="5" cols="40" name="rr_content"></textarea><br>
    <!-- 댓글 작성일은 자동으로 서버에서 처리하므로 input 요소에서는 입력하지 않습니다. -->
    <input type="submit" value="댓글 등록" />
</form>

<hr>

<c:if test="${not empty reviewReply}">
    <ul class="comment-list">
        <c:forEach var="reply" items="${reviewReply}">
            <li>
                <span class="writer">작성자: ${reply.rr_writer}</span><br>
                <span class="content">내용: ${reply.rr_content}</span><br>
                <span class="date">작성일: ${reply.rr_date}</span>
            </li>
        </c:forEach>
    </ul>
</c:if>

</body>
</html>
