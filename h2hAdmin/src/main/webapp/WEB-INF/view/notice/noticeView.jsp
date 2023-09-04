<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항</title>
<style>
    body {
        font-family: Arial, sans-serif;
        line-height: 1.6;
        margin: 0;
        padding: 0;
    }
    h2 {
        background-color: #007BFF;
        color: #FFF;
        padding: 10px;
        margin: 0;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #E0E0E0;
        padding: 10px;
        text-align: center;
    }
    th {
        background-color: #F0F0F0;
    }
    a {
        text-decoration: none;
        color: #007BFF;
    }
    a:hover {
        text-decoration: underline;
    }
    .content {
        padding: 20px;
    }
    .buttons {
        margin-top: 10px;
    }
    .buttons input {
        padding: 5px 10px;
        margin-right: 10px;
        background-color: #007BFF;
        color: #FFF;
        border: none;
        cursor: pointer;
    }
    .buttons input:hover {
        background-color: #0056b3;
    }
</style>
<script>
function confirmDelete(nlIdx) {
    if (confirm("정말로 이 글을 삭제하시겠습니까?")) {

        location.href = "noticedeleteform?nlidx=" + nlIdx;
    }
}
</script>
</head>
<body>
<div class="left">
<h2>공지사항</h2>
<table>
    <tr>
        <th width="10%">작성자</th>
        <td width="15%">${nl.getNl_writer()}</td>
        <th width="10%">조회수</th>
        <td width="15%">${nl.getNl_read()}</td>
        <th width="10%">작성일</th>
        <td width="15%">${nl.getNl_date()}</td>
        <th width="10%">파일</th>
        <td width="15%">
            <a href="downloadImage?filename=${nl.getNl_name()}" download>${nl.getNl_name()}</a>
        </td>
    </tr>
    <tr>
        <th>글제목</th>
        <td colspan="7">${nl.getNl_title()}</td>
    </tr>
    <tr>
        <th>글내용</th>
        <td colspan="7" class="content">${nl.getNl_content()}</td>
    </tr>
    <tr>
        <td colspan="8" class="buttons">
            <input type="button" value="글삭제" onclick="confirmDelete(${nl.getNl_idx()});" />

            <input type="button" value="글목록" onclick="location.href='noticeList';" />
            <input type="button" value="글수정" onclick="location.href='noticeFormUp?nl_idx=${nl.getNl_idx()}';" />
        </td>
    </tr>
</table>
</div>
</body>
</html>
