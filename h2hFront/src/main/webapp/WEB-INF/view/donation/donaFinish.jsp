<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DonaFinish</title>
    <!-- Custom fonts for this template -->
    <link href="/h2hFront/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/h2hFront/resources/css/sb-admin-2.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fc;
            font-family: 'Nunito', sans-serif;
            font-size: 16px;
            line-height: 1.6;
        }
        .container {
            max-width: 1000px; /* 조정된 max-width */
            margin: 0 auto;
            padding: 60px; /* 조정된 padding */
            text-align: center;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            /* 추가된 스타일 */
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .message {
            font-size: 18px;
            margin-bottom: 30px;
        }
        .button-group {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .btn {
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin: 10px;
            color: #ffffff;
        }
        .btn-primary {
            background-color: #007bff;
        }
        .btn-danger {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="title">후원하기 완료!</div>
    <div class="message">
        후원 신청이 완료 됐습니다.<br>
        '내가 신청한 후원' 확인은 '마이페이지' 내에서도 확인이 가능합니다.
    </div>
    <div class="button-group">
        <button type="button" class="btn btn-primary btn-lg" onclick="location.href='donaMemList';">내가 신청한 후원</button>
        <button type="button" class="btn btn-primary btn-lg btn-danger" onclick="location.href='/h2hFront/';">홈으로 가기</button>
    </div>
</div>
</body>
</html>
