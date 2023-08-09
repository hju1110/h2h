<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ServiceAcceptView</title>
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
function chkAll(checkbox) {
    // 전체 선택 체크박스가 체크되었을 때, 각 개별 체크박스의 상태를 변경합니다.
    var checkboxes = document.getElementsByName("chk1");
    for (var i = 0; i < checkboxes.length; i++) {
      checkboxes[i].checked = checkbox.checked;
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
		else 				document.frmAccept.submit();
	}
</script>
<body>
<h2>봉사참여 승인현황</h2>
<form name="frmAccept" action="serviceAccept">
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
	<input type="checkbox" name="chk1" id="chk1" checked="checked" onclick="" />
</td>
<th width="10%">이름</th><td width = "15%">${sc.getMi_name() }</td>
<th width="10%">생년월일</th><td width = "15%">${sc.getMi_birth() }</td>
<th width="10%">승인여부</th><td width = "15%">${sc.getSi_accept() }</td>
<th width="10%">포인트</th><td width = "15%">${sc.getSi_point() }</td>
</tr>
</c:forEach>
<tr><td colspan="20" align="center">
	<input type="button" type="submit" value="등 록" onclick="chkOk();" />
	<input type="button" type="submit" value="미 등 록"	onclick="chkNo();" />
	<input type="button" type="submit" value="전체 등록" onclick="chkAll();" />
</td></tr>
</table>
</form>
</body>
</html>