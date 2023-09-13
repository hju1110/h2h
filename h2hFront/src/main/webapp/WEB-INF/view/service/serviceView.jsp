<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/incHead.jsp" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ServiceView</title>
<style>
 .line {
        text-align: center;
        }


</style>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05ba8c1922ba85f754e733751fea4251&libraries=services"></script>
</head>
<body>
<div class="container mt-5"align="center" style="padding:100px;">
<h2>봉사활동 상세내용</h2>
<br />
<table class="table table-bordered">
<tr>
<th width="150">봉사활동명</th><td width=150>${si.getSi_acname() }</td>
<th width="150">봉사활동포인트</th><td width=50>${si.getSi_point() }</td>
<th width="150">봉사활동일자</th><td width=150>${si.getSi_acdate().substring(0, 11) }</td>
</tr>
<tr> 
<th width="150">모집인원</th><td width = "80">${si.getSi_person() }명</td>
<th width="150">봉사자유형</th><td width = "80">${si.getSi_type() }</td>
<th width="150">봉사마감일자</th><td width = "200">${si.getSi_edate().substring(0, 11) }</td>
</tr>

<tr><th>글 내용</th><td colspan="5">${si.getSi_content() }</td></tr>
<tr><th>활동상세내용</th><td colspan="5">${si.getSi_content() }</td></tr>
</table>
<hr />
<h5>신청자정보</h5>
<h6>연락처 번호 변경은 오른쪽 연락처 수정버튼을 클릭하여 변경해주시기 바라겠습니다.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" class="btn btn-primary" id= "chk" value="회원정보 수정" 
onclick="location.href='myInfoChk';" /></h6>
<!-- 지도 추가 -->
<div style="border:1px solid; padding:10px;">
	<h5 align="center" >[봉사장소 지도]</h5>
		<input type="button" value="지도보기" onclick="showMap();" />
		<input type="button" value="지도축소" onclick="zoom('+1');" />
		<input type="button" value="지도확대" onclick="zoom('-1');" />
		<input type="button" value="지도 이동 불가" onclick="setDraggable(false);" />
		<input type="button" value="지도 이동 가능" onclick="setDraggable(true);" />
<br />
주소 : <input type="text" name="addr" id="addr" /> 
<input type="button" value="지도 위치 변경" onclick="addr2Geo();" />
<div id ="map"></div>
</div>
<!-- 지도 종료 -->
<hr />
<br />
<div style="border:1px solid; padding:10px;">
	<li>회원님이 등록하신 정보로 전송됩니다. 등록된 정보가 정확한지 확인해주세요</li>
	<li><font color="orange">연락처 및 이메일 주소는 확인 정보로 일회성으로만 사용됩니다.</font></li>
	<li>휴대폰번호 및 이메일로 봉사활동 정보를 제공 및 사용을 동의하십니까?</li>
<div class="line"><input type="checkbox" name="agree" value="chkVal();">정보제공 및 수신 동의</div>

</div>
<br />
<div class="line">
<c:if test="${si.getSi_recruit()  == 'y' }" >
<input type="button" class="btn btn-primary" id= "chk" value="봉사활동 신청" 
	<% if (loginInfo != null) { %>onclick="document.frmSView.submit();" <% } else { %>
	onclick="alert('로그인 후에 사용하실 수 있습니다.'); location.href='login?url=serviceView?siidx=${si.getSi_idx()}';" <% } %> />
</c:if>
</div>
<form name="frmSView" action="serviceFinish">
<input type="hidden" name="siidx" value="${si.getSi_idx()}" />
<input type="hidden" name="siAcname" value="${si.getSi_acname() }" />
</form>
</div>
<script>
  var mapObj;	// 파일 전체에서 사용하기 위해 전역변수로 선언함

  function showMap() {
  	var mapBox = document.getElementById("map");
  	var mapOpt = {
  			center: new kakao.maps.LatLng(33.450701, 126.570667),
  			// 위도와 경도로 지도의 중심좌표값
  			level: 3	// 지도의 크기 레벨로 최대 확대(1) 부터 최대 축소까지 설정가능
  			// 현재 level 값 추출 : getLevel() / 새로운 level 지정 : setLevel(lvl)
  	};
  	mapObj = new kakao.maps.Map(mapBox, mapOpt);	//지도 객체 생성
  	
  	// 지도 컨트롤 추가 (확대했다가 줄어들었다가 하는거)
  	var zoomCtrl = new kakao.maps.ZoomControl();
  	mapObj.addControl(zoomCtrl, kakao.maps.ControlPosition.RIGHT);
  	// 지도 확대 및 축소 제어 줌 컨트롤 추가 및 위치지정
  	
  	var mapCtrl = new kakao.maps.MapTypeControl();
  	mapObj.addControl(mapCtrl, kakao.maps.ControlPosition.TOPRIGHT);
  	// 일반 지도와 스카이뷰로 타입 전환이 가능한 컨트롤 추가 및 컨트롤 위치 지정

  }

  function zoom(val) {
  	var level = mapObj.getLevel();
  	console.log(level + val);
  	mapObj.setLevel(eval(level + val));
  	
  }

  function setDraggable(chk) {
  	mapObj.setDraggable(chk);
  }

  function addr2Geo() {
  	var geocoder = new kakao.maps.services.Geocoder();
  	// 주소를 좌표로 변경해주는 객체 생성
  	var addr = document.getElementById("addr").value;

  	
  	geocoder.addressSearch(addr, function(result, status) {		// 미리 입력하면 나옴
  		if (status == kakao.maps.services.Status.OK) {
  			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
  			var marker = new kakao.maps.Marker({
  				map: mapObj, position: coords
  			});	//결과값을 받은 위치를 마커로 생성
  			
  			var infowindow = new kakao.maps.InfoWindow({
  				content: "<div id='infowin'>봉사장소 <hr/></div>"
  			});
  			infowindow.open(mapObj, marker);
  			
  			mapObj.setCenter(coords);
  		}
  	});
  }
</script>
<script>
function serChk(){
	var button = document.getElementById("chk");
	
	if(button != null) {
		alert("'참여' 신청이 완료 됐습니다.")
	}
}
showMap();
</script>
<%@ include file="../inc/incFoot.jsp" %>
