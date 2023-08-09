<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
String url = "/h2hFront/";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DonationList</title>
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
  </head>
  <body>
 <form name="frmDona" action="donationList">
  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">
      <a class="navbar-brand" href="<%=url %>">Hand2Hand</a>
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
          <li class="nav-item"><a href="noticeList" class="nav-link">공지사항</a></li>
          <li class="nav-item"><a href="myPage" class="nav-link">마이페이지</a></li>
          <li class="nav-item"><a href="login" class="nav-link">로그인</a></li>
          <% } else { %>
          <li class="nav-item"><a href="service" class="nav-link">참여</a></li>
          <li class="nav-item"><a href="reviewList" class="nav-link">후기게시판</a></li>
          <li class="nav-item"><a href="donationMain" class="nav-link">후원</a></li>
          <li class="nav-item"><a href="ProductProc" class="nav-link">쇼핑몰</a></li>
          <li class="nav-item"><a href="ParcelProc" class="nav-link">현황</a></li>
          <li class="nav-item"><a href="noticeList" class="nav-link">공지사항</a></li>
          <li class="nav-item"><a href="myPage" class="nav-link">마이페이지</a></li>
          <li class="nav-item"><a href="logout" class="nav-link">로그아웃</a></li>
          <% } %>
        </ul>
      </div>
    </div>
  </nav>
    <!-- END nav -->
    
    <div class="hero-wrap" style="background-image: url('/h2hFront/resources/img/bg_5.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
             <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"><a href="index.html">Home</a></span> <span>Causes</span></p>
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Causes</h1>
          </div>
        </div>
      </div>
    </div>

    
    <section class="ftco-section">
      <div class="container">
      	<div class="row">
      		<div class="col-md-4 ftco-animate">
      			<div class="cause-entry">
    				<a href="/h2hFront/donaRequest?kind=a" class="img" style="background-image: url(/h2hFront/resources/img/cause-1.jpg);"></a>
    					<div class="text p-3 p-md-4">
    						<!-- <h3><a href="loginSpr">일반 후원</a></h3> -->
    						<h3><a href="donaRequest?kind=a">일반 후원</a></h3>
    						<p>원하실 때 언제든지 자유롭게 나눔을 전할 수 있습니다.</p>
    						<span class="donation-time mb-3 d-block">Last donation 1w ago</span>
                <div class="progress custom-progress-success">
                  <div class="progress-bar bg-primary" role="progressbar" style="width: 28%" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <span class="fund-raised d-block">$12,000 raised of $30,000</span>
    					</div>
    				</div>
      		</div>
      		<div class="col-md-4 ftco-animate">
      			<div class="cause-entry">
    					<a href="donaRequest?kind=b" class="img" style="background-image: url(/h2hFront/resources/img/cause-2.jpg);"></a>
    					<div class="text p-3 p-md-4">
    						<h3><a href="donaRequest?kind=b">정기 후원</a></h3>
    						<p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life</p>
    						<span class="donation-time mb-3 d-block">Last donation 1w ago</span>
                <div class="progress custom-progress-success">
                  <div class="progress-bar bg-primary" role="progressbar" style="width: 28%" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <span class="fund-raised d-block">$12,000 raised of $30,000</span>
    					</div>
    				</div>
      		</div>
      		<div class="col-md-4 ftco-animate">
      			<div class="cause-entry">
    					<a href="#" class="img" style="background-image: url(/h2hFront/resources/img/cause-3.jpg);"></a>
    					<div class="text p-3 p-md-4">
    						<h3><a href="#">기업 단체 후원</a></h3>
    						<p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life</p>
    						<span class="donation-time mb-3 d-block">Last donation 1w ago</span>
                <div class="progress custom-progress-success">
                  <div class="progress-bar bg-primary" role="progressbar" style="width: 28%" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <span class="fund-raised d-block">$12,000 raised of $30,000</span>
    					</div>
    				</div>
      		</div>
      		<div class="col-md-4 ftco-animate">
      			<div class="cause-entry">
    					<a href="#" class="img" style="background-image: url(/h2hFront/resources/img/cause-4.jpg);"></a>
    					<div class="text p-3 p-md-4">
    						<h3><a href="#">Clean water for the urban area</a></h3>
    						<p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life</p>
    						<span class="donation-time mb-3 d-block">Last donation 1w ago</span>
                <div class="progress custom-progress-success">
                  <div class="progress-bar bg-primary" role="progressbar" style="width: 28%" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <span class="fund-raised d-block">$12,000 raised of $30,000</span>
    					</div>
    				</div>
      		</div>
      		<div class="col-md-4 ftco-animate">
      			<div class="cause-entry">
    					<a href="#" class="img" style="background-image: url(/h2hFront/resources/img/cause-5.jpg);"></a>
    					<div class="text p-3 p-md-4">
    						<h3><a href="#">Clean water for the urban area</a></h3>
    						<p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life</p>
    						<span class="donation-time mb-3 d-block">Last donation 1w ago</span>
                <div class="progress custom-progress-success">
                  <div class="progress-bar bg-primary" role="progressbar" style="width: 28%" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <span class="fund-raised d-block">$12,000 raised of $30,000</span>
    					</div>
    				</div>
      		</div>
      		<div class="col-md-4 ftco-animate">
      			<div class="cause-entry">
    					<a href="#" class="img" style="background-image: url(/h2hFront/resources/img/cause-6.jpg);"></a>
    					<div class="text p-3 p-md-4">
    						<h3><a href="#">Clean water for the urban area</a></h3>
    						<p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life</p>
    						<span class="donation-time mb-3 d-block">Last donation 1w ago</span>
                <div class="progress custom-progress-success">
                  <div class="progress-bar bg-primary" role="progressbar" style="width: 28%" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <span class="fund-raised d-block">$12,000 raised of $30,000</span>
    					</div>
    				</div>
      		</div>
        </div>
        <div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
                <li><a href="#">&lt;</a></li>
                <li class="active"><span>1</span></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">&gt;</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section-3 img" style="background-image: url(/h2hFront/resources/img/bg_3.jpg);">
    	<div class="overlay"></div>
    	<div class="container">
    		<div class="row d-md-flex">
    		<div class="col-md-6 d-flex ftco-animate">
    			<div class="img img-2 align-self-stretch" style="background-image: url(/h2hFront/resources/img/bg_4.jpg);"></div>
    		</div>
    		<div class="col-md-6 volunteer pl-md-5 ftco-animate">
    			<h3 class="mb-3">Be a volunteer</h3>
    			<form action="#" class="volunter-form">
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Your Name">
            </div>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Your Email">
            </div>
            <div class="form-group">
              <textarea name="" id="" cols="30" rows="3" class="form-control" placeholder="Message"></textarea>
            </div>
            <div class="form-group">
              <input type="submit" value="Send Message" class="btn btn-white py-3 px-5">
            </div>
          </form>
    		</div>    			
    		</div>
    	</div>
    </section>
		

    <footer class="ftco-footer ftco-section img">
    	<div class="overlay"></div>
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-3">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">About Us</h2>
              <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
              <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-4">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Recent Blog</h2>
              <div class="block-21 mb-4 d-flex">
                <a class="blog-img mr-4" style="background-image: url(/h2hFront/resources/img/image_1.jpg);"></a>
                <div class="text">
                  <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control about</a></h3>
                  <div class="meta">
                    <div><a href="#"><span class="icon-calendar"></span> July 12, 2018</a></div>
                    <div><a href="#"><span class="icon-person"></span> Admin</a></div>
                    <div><a href="#"><span class="icon-chat"></span> 19</a></div>
                  </div>
                </div>
              </div>
              <div class="block-21 mb-4 d-flex">
                <a class="blog-img mr-4" style="background-image: url(/h2hFront/resources/img/image_2.jpg);"></a>
                <div class="text">
                  <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control about</a></h3>
                  <div class="meta">
                    <div><a href="#"><span class="icon-calendar"></span> July 12, 2018</a></div>
                    <div><a href="#"><span class="icon-person"></span> Admin</a></div>
                    <div><a href="#"><span class="icon-chat"></span> 19</a></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-2">
             <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">Site Links</h2>
              <ul class="list-unstyled">
                <li><a href="#" class="py-2 d-block">Home</a></li>
                <li><a href="#" class="py-2 d-block">About</a></li>
                <li><a href="#" class="py-2 d-block">Donate</a></li>
                <li><a href="#" class="py-2 d-block">Causes</a></li>
                <li><a href="#" class="py-2 d-block">Event</a></li>
                <li><a href="#" class="py-2 d-block">Blog</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-3">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Have a Questions?</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon icon-map-marker"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
	                <li><a href="#"><span class="icon icon-phone"></span><span class="text">+2 392 3929 210</span></a></li>
	                <li><a href="#"><span class="icon icon-envelope"></span><span class="text">info@yourdomain.com</span></a></li>
	              </ul>
	            </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="/h2hFront/resources/js/jquery.min.js"></script>
  <script src="/h2hFront/resources/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/h2hFront/resources/js/popper.min.js"></script>
  <script src="/h2hFront/resources/js/bootstrap.min.js"></script>
  <script src="/h2hFront/resources/js/jquery.easing.1.3.js"></script>
  <script src="/h2hFront/resources/js/jquery.waypoints.min.js"></script>
  <script src="/h2hFront/resources/js/jquery.stellar.min.js"></script>
  <script src="/h2hFront/resources/js/owl.carousel.min.js"></script>
  <script src="/h2hFront/resources/js/jquery.magnific-popup.min.js"></script>
  <script src="/h2hFront/resources/js/aos.js"></script>
  <script src="/h2hFront/resources/js/jquery.animateNumber.min.js"></script>
  <script src="/h2hFront/resources/js/bootstrap-datepicker.js"></script>
  <script src="/h2hFront/resources/js/jquery.timepicker.min.js"></script>
  <script src="/h2hFront/resources/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/h2hFront/resources/js/google-map.js"></script>
  <script src="/h2hFront/resources/js/main.js"></script>
  </form>
</body>
</html>