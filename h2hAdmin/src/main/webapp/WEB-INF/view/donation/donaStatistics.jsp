<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후원 통계</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<!-- Custom fonts for this template-->
<link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" 
rel="stylesheet">
<!-- Custom styles for this template-->
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<style>
#chartDiv { height:500px; border:1px solid black; margin:0 0 10px 0; }
</style>
</head>
<body>
<div class="row">
	<!-- 후원 총액 보여주는 부분 -->
	<div class="col-xl-3 col-md-6 mb-4">
		<div class="card border-left-primary shadow h-100 py-2">
			<div class="card-body">
				<div class="row no-gutters align-items-center">
					<div class="col mr-2">
						<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> 일반후원</div>
						<c:forEach items="${donationList }" var="dl" varStatus="status">
						<c:if test="${status.index == 0}">
						<div class="h5 mb-0 font-weight-bold text-gray-800">${dl.getDi_gprice() }원</div>
						</c:if>
						</c:forEach>
					</div>
					<div class="col-auto">
						<i class="fas fa-calendar fa-2x text-gray-300"></i>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Earnings (Monthly) Card Example -->
	<div class="col-xl-3 col-md-6 mb-4">
		<div class="card border-left-success shadow h-100 py-2">
			<div class="card-body">
				<div class="row no-gutters align-items-center">
					<div class="col mr-2">
						<div class="text-xs font-weight-bold text-success text-uppercase mb-1"> 정기후원</div>
						<c:forEach items="${donationList }" var="dl" varStatus="status">
						<c:if test="${status.index == 0}">
						<div class="h5 mb-0 font-weight-bold text-gray-800">${dl.getDi_rprice() }원</div>
						</c:if>
						</c:forEach>
					</div>
					<div class="col-auto">
						<i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Pending Requests Card Example -->
	<div class="col-xl-3 col-md-6 mb-4">
		<div class="card border-left-warning shadow h-100 py-2">
			<div class="card-body">
				<div class="row no-gutters align-items-center">
					<div class="col mr-2">
						<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">	총 후원현황</div>
						<c:forEach items="${donationList }" var="dl" varStatus="status">
						<c:if test="${status.index == 0}">
						<div class="h5 mb-0 font-weight-bold text-gray-800">
							${dl.getDi_gprice() + dl.getDi_rprice() }원
						</div>
						</c:if>
						</c:forEach>
					</div>
					<div class="col-auto">
						<i class="fas fa-comments fa-2x text-gray-300"></i>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 통계 차트 부분 -->
<div id="chartDiv"></div>
<div id="chart">
</div>
<script>
var donadata = [
	[ "피후원자", "금액", {role:"style"}], 
	<c:forEach items="${donationList}" var="dl" begin="1">
		["${dl.getDi_name() }", ${dl.getDi_gprice() }, "red"],
	</c:forEach>
	<c:forEach items="${donationList}" var="dl" begin="1">
		["${dl.getDi_name() }", ${dl.getDi_rprice() }, "blue"], 
	</c:forEach>
];

google.charts.load("current", {packages: ["corechart"]});
google.charts.setOnLoadCallback(drawBasic);

function drawBasic() {
	var data = google.visualization.arrayToDataTable(donadata);
	var options = {title: "후원 전체 통계", "is3D": true};
	var chart = new google.visualization.ColumnChart(document.getElementById("chartDiv"));
	// ColumnChart : 세로 막대 차트 | BarChart : 가로 막대 차트
	chart.draw(data, options);
}

new Vue({
	el: "#chart",
	data: {
		dataArray: donadata
	}
});
</script>
