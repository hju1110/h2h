<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ServiceList</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <div class="hero-wrap" style="background-image: url('/h2hFront/resources/img/bg_6.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Volunteer participation</h1>
          </div>
        </div>
      </div>
    </div>
      
<section class="ftco-section">
    	<div class="container">
        <h1 class="text-center text-primary ftco-animate mb-3">참여</h1>
    		<div class="row">
          <div class="col-lg-12">
    			<form name="frmSch">
            <table class="table table-sm w-100 mb-5">
            <tbody>
                     <tr>
              <th class="bg-primary text-white text-center align-middle">활동 지역</th>
              <td>
                <input type="text" name="seoul" class="w-100" value="서울 특별시" disabled="disabled">
              </td>
              <td>
                <select class="form-control" name="place">
                  <option>서울 은평구</option>
                  <option>서울 동작구</option>
                  <option>서울 강남구</option>
                  <option>서울 동구</option>
                  <option>서울 중구 데이케어센터</option>
                </select>
              </td>
            </tr>
			<th class="bg-primary text-white text-center align-middle">활동 일자</th>
            <td colspan="4">
              <input type="text" name="siAcdate" id="edusdate" value="" size="20" class="ipt hasDatepicker">
            </td>
            </tr>
            <tr>
            <th class="bg-primary text-white text-center align-middle">활동명</th>
		  <td class="text-center">
              <select class="form-control" name="schtype">
                <option value="acname">활동명</option>
              </select>
            </td>
			<td>
            <div class="input-group">
              <input type="text" name="keyword" class="form-control" value="">&nbsp;&nbsp;
              <input type="submit" class="btn btn-primary" value="검색">&nbsp;&nbsp;
              <input type="button" class="btn btn-secondary" value="전체글" onclick="location.href='service';">
            </div>
            </td>
            </tr>
            </tbody></table>
            </form>
            <table class="table table-bordered" id="list">
	<form>
	<div class="mb-3 d-flex justify-content-end">
	<% if (loginInfo != null && !loginInfo.getMi_type().equals("a")) { %>
		<input type="button" class="btn btn-primary" value="봉사 등록 요청" onclick="location.href='svcRequestForm';" />
	<% } %>
	</div>
</form>
    <table class="table table-bordered" id="list">
                  <thead>
                      <tr>
                    <th class="text-center" style="width:5%;">No</th>
                    <th class="text-center" style="width:33%;">봉사활동명</th>
                    <th class="text-center" style="width:15%;">활동일</th>
                    <th class="text-center" style="width:25%;">모집 기간</th>			
                    <th class="text-center" style="width:10%;">모집 인원</th>
                     <th class="text-center" style="width:45%;">모집 여부</th>
                    <th class="text-center" style="width:25%;">등록일</th>
                  </tr>
                </thead>
<c:if test="${serviceInfo.size() > 0}"><!-- 게시판 정보가 있으면~ else를 쓰고 싶으면 반대조건 주면 됨-->
	<c:forEach items="${serviceInfo}" var="si" varStatus="status">	<!-- varStatus="status"하고 var 값만큼 돈다! -->
	<tr height="30">
	<td align="center">${pi.getNum() - status.index}</td><!-- - status.index 씀으로써 페이지 넘버가 하나씩 줄어듬 -->
	<td><a href="serviceView?siidx=${si.getSi_idx() }${pi.getArgs() }">${si.getSi_acname() }</a></td>
	<td align="center">${si.getSi_acdate().substring(0, 11) }</td>
	<td align="center">${si.getSi_sdate().substring(0, 11) } ~ ${si.getSi_edate().substring(0, 11) }</td>
	<td align="center">${si.getSi_person() }</td>
	<td align="center">
		<c:if test="${si.getSi_recruit() == 'y' }">모집 중</c:if>
		<c:if test="${si.getSi_recruit() == 'n' }">모집 마감</c:if>
	</td>
	<td align="center">${si.getSi_date().substring(0, 11) }</td>
	</c:forEach>
</c:if>	
<c:if test="${serviceList.size() == 0}">
	<tr height="50"><td colspan="5" align="center">
	검색결과가 없습니다.
	</td></tr>
</c:if>
</table>
<br />
<div align="center">
<tr>
<td width="600">
	<c:if test="${serviceInfo.size() > 0 }">
		<c:if test="${pi.getCpage() == 1}">
			[처음]&nbsp;&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;
		</c:if>
		<c:if test="${pi.getCpage() > 1}">
			<a href="service?cpage=1${pi.getSchargs() }">[처음]</a>&nbsp;&nbsp;&nbsp;
			<a href="service?cpage=${pi.getCpage() - 1}${pi.getSchargs() }">[이전]</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${pi.getSpage() }"
			end="${pi.getSpage() + pi.getBsize() - 1 <= pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }">
				<c:if test="${i == pi.getCpage() }">
				</c:if>
				<c:if test="${i != pi.getCpage() }">
					&nbsp;<a href="service?cpage=${i }${pi.getSchargs() }">${i }</a>&nbsp;
				</c:if>
		</c:forEach>
		
		<c:if test="${pi.getCpage() == pi.getPcnt() }">
			&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]
		</c:if>
		<c:if test="${pi.getCpage() < pi.getPcnt()}">
			&nbsp;&nbsp;<a href="service?cpage=${pi.getCpage() + 1}${pi.getSchargs() }">[다음]</a>
			&nbsp;&nbsp;&nbsp;<a href="service?cpage=${pi.getPcnt() }${pi.getSchargs() }">[마지막]</a>
		</c:if>
	</c:if>
</td>
</tr>
</div>
</table>
</div>
</div>
<script>
$(function() {
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		//buttonImage: "/images/kr/create/btn_calendar.gif",
		buttonImageOnly: true,
		// showOn :"both",
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		duration:200,
		showAnim:'show',
		showMonthAfterYear: false
		// yearSuffix: '년'
	};
	$.datepicker.setDefaults($.datepicker.regional['ko']);

	$( "#edusdate" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#eday" ).datepicker( "option", "minDate", selectedDate );
		}
	});
	$( "#eduedate" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#sday" ).datepicker( "option", "maxDate", selectedDate );
		}
	});
});
</script>
</div>
</section>
<%@ include file="../_inc/inc_foot.jsp" %>