<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
function chkAll(all) {
// '전체선택' 체크박스 클릭시 모든 체크박스에 대한 체크여부를 처리하는 함수
	var arr = document.frmCart.chk;
	for (var i = 1 ; i < arr.length ; i++) {	//배열로 만들었기 때문에 한개만 있을 때는 쓸 수 가 없음
		arr[i].checked = all.checked;
	} 
	
}
function chkNo() {
	// 사용자가 미등록하는 함수
		var ocidx = getSelectedChk();
		//선택한 체크박스의 oc_idx 값들이 쉼표를 기준으로 '1,2,3,4' 형태의 문자열로 저장됨
		if (ocidx == "")	alert("미등록 할 회원을 선택하세요.");//체크 안되어있을때 빈문자열로 해주기
		else 				cartDel(ocidx);
	}

	function chkOk() {
	// 사용자가 등록하는 함수
		var ocidx = getSelectedChk();	// 체크된거 받아오기
		if (ocidx == "")	alert("등록할을 회원을 선택하세요."); //체크 안되어있을때 
		else 				document.frmCart.submit();
	}
	function chkAll() {
		// 사용자가 전체 회원을 등록하는 함수
			var arr = document.frmCart.chk;
			for (var i = 1 ; i < arr.length ; i++) {	//배열로 만들었기 때문에 한개만 있을 때는 쓸 수 가 없음
				arr[i].checked = true;
			} 
			document.frmCart.submit();
		}
</script>
<body>
<h2>봉사참여 승인현황</h2>
<label for="all">전체 선택</label>
<table width="30" cellpadding="5">
<c:forEach items="${scList}" var="sc">
<tr>
<td>
	<input type="checkbox" name="all" id="all" checked="checked" onclick="chkAll(this);" />
</td>
<th width="10%">이름</th><td width = "15%">${sc.getMi_name() }</td>
<th width="10%">생년월일</th><td width = "15%">${sc.getMi_birth() }</td>
<th width="10%">승인여부</th><td width = "15%">${sc.getSi_accept() }</td>
<th width="10%">포인트</th><td width = "15%">${sc.getSi_point() }</td>
</tr>
</c:forEach>
<tr><td colspan="20" align="center">
	<input type="button" value="등 록" onclick="chkOk();" />
	<input type="button" value="미 등 록"	onclick="chkNo();" />
	<input type="button" value="전체 등록" onclick="chkALl();" />
	<input type="button" value="수 정" onclick="location.href='freeFormIn';" />
</td></tr>
</table>

</body>
</html>