<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="incLoginChk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IdexTest</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<!-- Custom fonts for this template-->
<link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" 
rel="stylesheet">
<!-- Custom styles for this template-->
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<style>
#sideMenu { width:250px; height:100%; position:fixed; top:0; background:#2E75B6; }
hr { width:200px; border-color:#fff; align:left; }
a:link { color:white; text-decoration:none; }
a:visited { color:white; text-decoration:none; }
a:hover { color:yellow; text-decoration:none; }
a:active { color:yellow; text-decoration:none; }
.menu {color:#fff;}
.menu a{cursor:pointer;}
.menu .hide{display:none;}
ul li { list-style-type:none; }
#menuImg { width:30px; height:30px; }
</style>
<script>
// html dom 이 다 로딩된 후 실행된다.
$(document).ready(function(){
	// menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
	$(".menu>a").click(function(){
		var submenu = $(this).next("ul");

		// submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
		if( submenu.is(":visible") ){
			submenu.slideUp();
		}else{
			submenu.slideDown();
		}
	});
});
</script>
</head>
<body>
<div align="left" id="sideMenu">
<div>
<a href="/indexTest/mainPage" target="body"><img src="${pageContext.request.contextPath}/resources/img/logo.png" style="width:250px;"></a>
</div><p />
<div>
	<ul>
		<li class="menu">
			<a>
			<img id="menuImg" src="${pageContext.request.contextPath}/resources/img/person_negative.png" alt="회원 관리"/>&nbsp;
			 회원 관리
			</a>
			<ul class="hide" type="square">
				<li><a href="memberInfo" target="body">회원 목록</a></li>
			</ul>
		</li>
	</ul>
<hr />
	<ul>
		<li class="menu">
			<a>
				<img id="menuImg" src="${pageContext.request.contextPath}/resources/img/hyunhwang_negative.png" alt="봉사"/>&nbsp;
				봉사
			</a>
			<ul class="hide">
				<li><a href="service" target="body">봉사(미승인)</a></li>
				<li><a href="serviceChartz" target="body">봉사(승인)</a></li>
				<li><a href="scedule" target="body">봉사 일정</a></li>
			</ul>
		</li>
	</ul>
<hr />
	<ul>
		<li class="menu">
			<a>
				<img id="menuImg" src="${pageContext.request.contextPath}/resources/img/money_negative.png" alt="후원 관리"/>&nbsp;
				후원 관리
			</a>
			<ul class="hide">
				<li><a href="donaMemList" target="body">후원 목록</a></li>
				<li><a href="" target="body">후원 통계</a></li>
			</ul>
		</li>
	</ul>
<hr />
	<ul>
		<li class="menu">
			<a>
				<img id="menuImg" src="${pageContext.request.contextPath}/resources/img/shopping_negative.png" alt="쇼핑"/>&nbsp;
				쇼핑
			</a>
			<ul class="hide">
				<li><a href="ParcelProc" target="body">주문 현황</a></li>
				<li><a href="productList" target="body">상품 등록</a></li>
			</ul>
		</li>
	</ul>
<hr />
	<ul>
		<li class="menu">
			<a>
				<img id="menuImg" src="${pageContext.request.contextPath}/resources/img/notice_negative.png" alt="게시판 관리"/>&nbsp;
				게시판 관리
			</a>
			<ul class="hide">
				<li><a href="noticeList" target="body">공지 사항</a></li>
				<li><a href="reviewList" target="body">후기 게시판</a></li>
				<li><a href="qnaList" target="body">QnA</a></li>
			</ul>
		</li>
	</ul>
<hr />
</div>
<div style="text-align:center; position:absolute; bottom:100px; left:85px; ">
	<% if (loginInfo == null) { %>
	<a href="login" target="_parent" style="font-weight:bold; color:yellow; background:#2E75B6; font-size:20px;">로그인</a>
	<% } else { %>
	<a href="logout" target="_parent" style="font-weight:bold; color:yellow; background:#2E75B6; font-size:20px;">로그 아웃</a>
	<% } %>
</div>
</div>
