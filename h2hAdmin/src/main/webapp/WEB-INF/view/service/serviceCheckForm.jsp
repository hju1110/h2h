<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/resources/jsp/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
  table {
    width: 800px;
    border: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
  }
</style>
<script>
//전체 선택 체크박스 클릭 시 모든 체크박스에 대한 체크 여부를 처리하는 함수
function chkAll(all) {
	var arr = document.frmAcceptChk.chk;
	for (var i = 1 ; i < arr.length ; i++) {
		arr[i].checked = all.checked;
	}
}
// 특정 체크박스 클릭 시 체크 여부에 따른 '전체 선택' 체크박스의 체크 여부를 처리하는 함수
function chkOne(one) {
	var frm = document.frmAcceptChk;
	var all = frm.all;	// '전체 선택' 체크박스
	if (one.checked) {	// 특정 체크박스를 체크 했을 경우
		var arr = frm.chk;
		var isChk = true;
		for (var i = 1 ; i < arr.length ; i++) {
			if(!arr[i].checked) {	// 하나라도 체크가 안돼있으면
				isChk = false;
				break;
			}
		}
		all.checked = isChk;
	} else {	// 특정 체크박스를 체크 해제 했을 경우
		all.checked = false;
	}
}
//참여 승인 리스트내 등록을 미등록으로 변경하는 함수
function chkDel(scidx) {
	if (confirm("선택한 회원의 승인여부를 미승인으로 변경하시겠습니까?")) {
		$.ajax ({
			type : "POST",
			url : "/h2hAdmin/chkProcDel",
			data : {"scidx" : scidx},
			success : function (chkRs) {
				if (chkRs == 0) {	// 미등록 변경에 실패했을 때
					alert("미등록 변경에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
}

function getSelectedChk() {
// 체크박스들 중 선택된 체크박스들의 값(value)들을 쉼표로 구문하여 문자열로 리턴하는 함수
	var chk = document.frmAcceptChk.chk;
	var idxs = "";	// chk컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장할 변수
	for (var i = 1 ; i < chk.length ; i++) {
		if (chk[i].checked) {	// 체크박스에 체크가 돼있으면  idxs에 누적시키기
			idxs += "," + chk[i].value;
		}
	}
	return idxs.substring(1);
}

//사용자가 선택한 상품(들)을 삭제하는 함수
function chkNo() {
	// 선택한 체크박스의 oc_idx 값들이 쉼표를 기준으로 '1,2,3,4'형태의 문자열로 저장됨
	var scidx = getSelectedChk();
	if (scidx == "") {	// '선택한 상품삭제'를 눌렀을 때 체크가 안 돼있으면
		alert("삭제할 상품을 선택하세요.");
	} else {
		chkDel(scidx);
	}
}

// 관리자가 선택한 사람들만 등록시키는 함수
function chkOk() {
	var scidx = getSelectedChk();
	if (scidx == "") {	// '선택한 상품구매'를 눌렀을 때 체크가 안 돼있으면
		alert("구매할 상품을 선택하세요.");
	} else {
		document.frmAcceptChk.submit();
	}
}

</script>
<body>
<div class="left">
<h2>봉사참여 승인현황</h2>
<form name="frmAcceptChk">
<input type="hidden" name="chk"><!-- chk 체크박스를 배열로 처리하기 위해 인위적으로 지정해 놓은 컨트롤 -->
<table width="30" cellpadding="5">
<tr>
<td colspan="2">
	<label for="all">전체 선택</label>
	<input type="checkbox" name="all" id="all" checked="checked" onclick="chkAll(this);" />
</td>
</tr>
<c:forEach items="${scList}" var="sc">
<tr>
<td>
	<input type="checkbox" name="chk" value="${sc.getSi_idx() }" checked="checked" onclick="chkOne(this);" />
</td>
<th width="10%">이름</th><td width = "15%">${sc.getMi_name() }</td>
<th width="10%">생년월일</th><td width = "15%">${sc.getMi_birth() }</td>
<th width="10%">승인여부</th><td width = "15%">${sc.getSi_accept() }</td>
<th width="10%">포인트</th><td width = "15%">${sc.getSi_point() }</td>
</tr>
</c:forEach>
<tr><td colspan="20" align="center">
	<input type="button" value="참여 등록" onclick="chkOk();" />
	<input type="button" value="참여 미등록"	onclick="chkNo();" />
</td></tr>
</table>
</form>
</div>
</body>
</html>