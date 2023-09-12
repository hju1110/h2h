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
<title>Hand2Hand</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

  <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Overpass:300,400,400i,600,700" rel="stylesheet">

    <link rel="stylesheet" href="/h2hFront/resources/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="/h2hFront/resources/css/animate.css">
    
    <link rel="stylesheet" href="/h2hFront/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/h2hFront/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/h2hFront/resources/css/magnific-popup.css">

    <link rel="stylesheet" href="/h2hFront/resources/css/aos.css">

    <link rel="stylesheet" href="/h2hFront/resources/css/ionicons.min.css">

    <link rel="stylesheet" href="/h2hFront/resources/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/h2hFront/resources/css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="/h2hFront/resources/css/flaticon.css">
    <link rel="stylesheet" href="/h2hFront/resources/css/icomoon.css">
    <link rel="stylesheet" href="/h2hFront/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
  </head>
  <body>
  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar ftco-navbar-light" id="ftco-navbar">
    <div class="container">
      <a class="navbar-brand" style="color:black;" href="/h2hFront/">Hand2Hand</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
      </button>
      
      <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
        <% if (loginInfo == null) { %>
			<li class="nav-item"><a href="service" class="nav-link">참여</a></li>
          <li class="nav-item"><a href="reviewList" class="nav-link">후기게시판</a></li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="donationMain">후원</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="#">일반 후원</a>
              <a class="dropdown-item" href="#">정기 후원</a>
              <a class="dropdown-item" href="#">기업 단체 후원</a>
            </div>
          </li>
         <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="ProductProc">쇼핑몰</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="blog.html">상품목록</a>
              <a class="dropdown-item" href="#">이용약관</a>
              <a class="dropdown-item" href="#">주문현황</a>
            </div>
          </li>
   
          <li class="nav-item"><a href="qnaList" class="nav-link">QnA</a></li>
          <li class="nav-item"><a href="noticeList" class="nav-link">공지사항</a></li>
          <li class="nav-item"><a href="login" class="nav-link">로그인</a></li>
          <% } else { %>
           <li class="nav-item"><a href="service" class="nav-link">참여</a></li>
          <li class="nav-item"><a href="reviewList" class="nav-link">후기게시판</a></li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="donationMain">후원</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="donaRequest?kind=a">일반 후원</a>
              <a class="dropdown-item" href="donaRequest?kind=b">정기 후원</a>
            </div>
          </li>
         <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="ProductProc">쇼핑몰</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="ProductProc">상품목록</a>
              <a class="dropdown-item" href="ParcelProc">주문현황</a>
            </div>
			</li>
		<li class="nav-item"><a href="qnaList" class="nav-link">QnA</a></li>
		<li class="nav-item"><a href="noticeList" class="nav-link">공지사항</a></li>
		<li class="nav-item"><a href="myPage" class="nav-link">마이페이지</a></li>
		<li class="nav-item"><a href="logout" class="nav-link">로그아웃</a></li>
         
          <% } %>
        </ul>
      </div>
    </div>
  </nav>
    <!-- END nav -->

