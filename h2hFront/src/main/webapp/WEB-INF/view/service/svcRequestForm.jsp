<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Add Bootstrap CSS link -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>ServiceRequestForm</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script> 
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> 
</head>
<body>
<div class="container mt-5">
<h4 class="text-center">봉사 등록 요청</h4>
<form name="frm" action="svcProcIn" method="post" enctype="multipart/form-data">
<table class="table table-bordered table-striped" width="800">
<tr>
	<th width="10%">활동일자</th>
	<td width="25%"><input type="text" name="siAcdate" id="edussdate" value="" size="15" class="ipt form-control" /></td>
</tr>
<tr>
	<th width="15%">봉사활동명</th>
	<td colspan="3"><input type="text" name="siAcname" size="60" class="form-control" /></td>
</tr>
<tr>
	<th width="15%">봉사활동 포인트</th>
	<td colspan="3"><input type="text" name="siPoint" size="60" class="form-control" value="2000" readonly="readonly" /></td>
</tr>
<tr>
	<th width="10%">모집기간</th>
	<td colspan="3">
		<input type="text" name="siSdate" id="edusdate" value="" size="15" class="ipt form-control" /> ~
		<input type="text" name="siEdate" id="eduedate" value="" size="15" class="ipt form-control" />
	</td>
</tr>
<tr>
	<th width="10%">봉사자 유형</th>
	<td>
		<select name="siType">
			<option value="a">청소년</option>
			<option value="b">성인</option>
		</select>
	</td>
	<th width="10%">봉사자 인원</th>
	<td>
		<select name="siPerson">
			<option value="10">10명</option>
			<option value="20">20명</option>
			<option value="30">30명</option>
			<option value="40">40명</option>
			<option value="50">50명</option>
		</select>
	</td>
</tr>
<tr>
	<th>글내용</th>
	<td colspan="4"><textarea name="siContent" rows="10" cols="65" class="form-control"></textarea></td>
</tr>
<tr>
	<td colspan="5" align="center">
		<input type="submit" value="봉사 등록 신청" class="btn btn-primary" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="다시 입력" class="btn btn-secondary" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="목록" class="btn btn-primary" onclick="location.href='service'" />
    </td>
</tr>
</table>
</form>
</div>
</body>
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

	$( "#edussdate" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#eday" ).datepicker( "option", "minDate", selectedDate );
		}
	});
	
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
</html>
