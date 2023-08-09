<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<style>
  body {
    font-family: Arial, sans-serif;
    text-align: center;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
  }
  .container1 {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }
  .success-message {
    font-size: 18px;
    color: #4caf50;
    margin-bottom: 20px;
  }
  .link {
    display: inline-block;
    margin-right: 20px;
    color: #007bff;
    text-decoration: none;
  }
</style>
</head>
<body>
<div class="container1">
  <p class="success-message">상품등록에 성공하셨습니다.</p>
  <a class="link" href="ProductProc">상품 목록</a>
  <a class="link" href="ParcelProc">주문 현황</a>
</div>
</body>
</html>
