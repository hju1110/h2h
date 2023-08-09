<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 삭제</title>
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
</head>
<body>
<div class="left">
<h2>글 삭제 확인</h2>
<div class="content">
    <p>정말로 글을 삭제하시겠습니까?</p>
    <form action="delete" method="post">
        <input type="hidden" name="reviewIdx" value="${rl.getRl_idx()}" />
        <div class="buttons">
            <input type="submit" value="확인" />
            <input type="button" value="취소" onclick="history.back();" />
        </div>
    </form>
</div>
</div>
</body>
</html>
