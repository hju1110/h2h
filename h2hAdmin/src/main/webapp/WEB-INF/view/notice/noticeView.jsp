<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항</title>
<style>
  /*  body {
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
    }*/
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
<div class="container mt-5">
<br />
<table class="table table-bordered">
	<tr>
		<th class="col-md-1" style="text-align:center;">작성자</th>
			<td class="col-md-1" style="text-align:center;">${nl.getNl_writer()}</td>
		<th class="col-md-1" style="text-align:center;">조회수</th>
			<td class="col-md-1" style="text-align:center;">${nl.getNl_read()}</td>
		<th class="col-md-1" style="text-align:center;">작성일</th>
			<td class="col-md-1" style="text-align:center;">${nl.getNl_date().replace("-", ".").substring(0,10)}</td>
		<th class="col-md-1" style="text-align:center;">파일</th>
			<td class="col-md-1" style="text-align:center;">
			<a href="downloadImage?filename=${nl.getNl_name()}" download>${nl.getNl_name()}</a>
		</td>
	</tr>
	<tr>
		<th style="text-align:center;">글제목</th>
		<td colspan="7">${nl.getNl_title()}</td>
	</tr>
	<tr>
		<th style="text-align:center;">글내용</th>
		<td colspan="7" class="content">${nl.getNl_content()}</td>
	</tr>
</table>
	<div class="text-center">
		<input type="button" class="btn btn-danger" value="글삭제" onclick="confirmDelete(${nl.getNl_idx()});" />
		<input type="button" class="btn btn-secondary" value="글목록" onclick="location.href='noticeList';" />
		<input type="button" class="btn btn-primary" value="글수정" onclick="location.href='noticeFormUp?nl_idx=${nl.getNl_idx()}';" />
	</div>
<br />
</div>
</body>
</html>
