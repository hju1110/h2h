<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String url = "/h2hFront/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DonationList</title>
    <div class="hero-wrap" style="background-image: url('/h2hFront/resources/img/bg_5.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Donation</h1>
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
    						<p>장기적이고 지속적인 지원을 통해 도움이 필요한 아이들의 안정적인 성장 발판을 마련합니다.</p>
    						<span class="donation-time mb-3 d-block">Last donation 1w ago</span>
                <div class="progress custom-progress-success">
                  <div class="progress-bar bg-primary" role="progressbar" style="width: 28%" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <span class="fund-raised d-block">$12,000 raised of $30,000</span>
    					</div>
    				</div>
      		</div>
      		
      
        </div>
        
    </section>
</body>
</html>
<%@ include file="../_inc/inc_foot.jsp" %>