<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
request.setCharacterEncoding("UTF-8");
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hand2hand</title>
<!-- Custom fonts for this template-->
<link href="/h2hFront/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="/h2hFront/resources/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">
      <a class="navbar-brand" href="/h2hFront/">Hand2Hand</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
      </button>

      <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
        <% if (loginInfo == null) { %>
          <li class="nav-item"><a href="service" class="nav-link">참여</a></li>
          <li class="nav-item"><a href="reviewList" class="nav-link">후기게시판</a></li>
          <li class="nav-item"><a href="donationMain" class="nav-link">후원</a></li>
          <li class="nav-item"><a href="ProductProc" class="nav-link">쇼핑몰</a></li>
          <li class="nav-item"><a href="ParcelProc" class="nav-link">현황</a></li>
          <li class="nav-item"><a href="ProductView" class="nav-link">상품</a></li>
          <li class="nav-item"><a href="noticeList" class="nav-link">공지사항</a></li>
          <li class="nav-item"><a href="myPage" class="nav-link">마이페이지</a></li>
          <li class="nav-item"><a href="login" class="nav-link">로그인</a></li>
          <% } else { %>
          <li class="nav-item"><a href="service" class="nav-link">참여</a></li>
          <li class="nav-item"><a href="reviewList" class="nav-link">후기게시판</a></li>
          <li class="nav-item"><a href="donationMain" class="nav-link">후원</a></li>
          <li class="nav-item"><a href="ProductProc" class="nav-link">쇼핑몰</a></li>
          <li class="nav-item"><a href="ParcelProc" class="nav-link">현황</a></li>
          <li class="nav-item"><a href="ProductView" class="nav-link">상품</a></li>
          <li class="nav-item"><a href="noticeList" class="nav-link">공지사항</a></li>
          <li class="nav-item"><a href="myPage" class="nav-link">마이페이지</a></li>
          <li class="nav-item"><a href="logout" class="nav-link">로그아웃</a></li>
          <% } %>
        </ul>
      </div>
    </div>
  </nav>
    <!-- END nav -->
</body>
</html>