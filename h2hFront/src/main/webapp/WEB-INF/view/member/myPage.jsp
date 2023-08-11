<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
    .container {
        text-align: center;
        margin-top: 50px;
    }
    h2 {
        color: #333;
    }
    hr {
        border-color: #333;
    }
    .btn-group-vertical {
        margin-top: 20px;
    }
    .btn-primary {
        background-color: #007bff;
        color: #fff;
        border-color: #007bff;
        width: 300px;
        height: 60px;
        font-size: 20px;
        margin-bottom: 10px;
    }
</style>
</head>
<body>
<div class="container">
    <h2>마이페이지</h2>
    <hr>
    <div class="btn-group-vertical" role="group" aria-label="My Page Navigation">
        <a class="btn btn-primary" href="myInfoChk">나의 회원정보</a>
        <a class="btn btn-primary" href="ParcelProc">주문내역</a>
        <a class="btn btn-primary" href="donaMemList">내가 신청한 후원</a>
        <a class="btn btn-primary" href="serviceTotalList">봉사현황</a>
    </div>
</div>
</body>
</html>