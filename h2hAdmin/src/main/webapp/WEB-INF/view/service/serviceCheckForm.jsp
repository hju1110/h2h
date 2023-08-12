<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="vo.*" %>
<%
ServiceInfo si = new ServiceInfo();
String accept = si.getSi_accept();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;

    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
  }
  .container {
    width: 800px;
    padding: 20px;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  table {
    width: 100%;
    border: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
    padding: 8px;
  }
  th {
    background-color: #f2f2f2;
  }
  .text-center {
    text-align: center;
  }
  .btn {
    padding: 8px 15px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
  }
  .btn-primary {
    background-color: #007bff;
    color: white;
  }
  .btn-danger {
    background-color: #dc3545;
    color: white;
  }
  .mt-3 {
    margin-top: 15px;
  }
  .ml-2 {
    margin-left: 10px;
  }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function chkAll(all) {
  var arr = document.frmAcceptChk.chk;
  for (var i = 0; i < arr.length; i++) {
    arr[i].checked = all.checked;
  }
}

function chkOne(one) {
  var frm = document.frmAcceptChk;
  var all = frm.all;
  if (!one.checked) {
    all.checked = false;
  } else {
    var arr = frm.chk;
    var allChecked = true;
    for (var i = 0; i < arr.length; i++) {
      if (!arr[i].checked) {
        allChecked = false;
        break;
      }
    }
    all.checked = allChecked;
  }
}

function getSelectedChk() {
	// 체크박스들 중 선택된 체크박스들의 값(value)들을 쉼표로 구분하여 문자열로 리턴하는 함수
   var chk = document.frmAcceptChk.chk;
   var idxs = "";   // chk컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장
   for (var i = 1 ; i < chk.length ; i++) {
      if (chk[i].checked) idxs += "," + chk[i].value;
	}
   return idxs.substring(1);

}	

function sendAjaxRequestForChkOk(sjidx) {
    if (confirm("정말 승인하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "./ChkOk",
            data: { sjidx : sjidx },
            success: function(response) {
                if (response < 1) {
                    alert("봉사 승인 실패.");
                } else {
                    alert("봉사 승인 성공.");
                    location.reload();
                }
            },
            error: function() {
                alert("오류 발생. 서버에 요청을 보내지 못했습니다.");
            }
        });
    }
}

function sendAjaxRequestForChkNo(sjidx) {
    if (confirm("정말 미승인하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "./ChkNo",
            data: { sjidx : sjidx },
            success: function(response) {
                if (response < 1) {
                    alert("봉사 미승인 실패.");
                } else {
                    alert("봉사 미승인 성공.");
                    location.reload();
                }
            },
            error: function() {
                alert("오류 발생. 서버에 요청을 보내지 못했습니다.");
            }
        });
    }
}

function chkOk() {
    var sjidx = getSelectedChk();
    if (sjidx == "") {
        alert("승인 처리할 회원을 선택하세요.");
    } else {
        sendAjaxRequestForChkOk(sjidx);
    }
}

function chkNo() {
    var sjidx = getSelectedChk();
    if (sjidx == "") {
        alert("미승인 처리할 회원을 선택하세요.");
    } else {
        sendAjaxRequestForChkNo(sjidx);
    }
}

</script>
<body>
<div align="center">
<div class="left">
<h2>봉사활동 글보기</h2>
<table width="600" cellpadding="5">
<tr>
<th width="10%">봉사활동명</th><td width = "15%">${si.getSi_acname() }</td>
<th width="10%">봉사활동포인트</th><td width = "15%">${si.getSi_point() }</td>
<th width="10%">봉사활동일자</th><td width = "15%">${si.getSi_acdate().substring(0, 11) }</td>
</tr>
<tr>
<th width="10%">모집인원</th><td width = "25%">${si.getSi_person() }명</td>
<th width="10%">봉사자유형</th><td width = "25%">
	<c:if test="${si.getSi_type() == 'a'}">청소년</c:if>
	<c:if test="${si.getSi_type() == 'b'}">성인</c:if>
</td>
<th width="10%">봉사마감일자</th><td width = "25%">${si.getSi_edate().substring(0, 11) }</td>
</tr>

<tr><th>글 내용</th><td colspan="5">${si.getSi_content() }</td></tr>
<tr><th>활동상세내용</th><td colspan="5">${si.getSi_content() }</td></tr>
<tr><td colspan="20" align="center">
</td></tr>
</table>
<br />
<h2>봉사참여 승인현황</h2>
<form name="frmAcceptChk">
<input type="hidden" name="chk"><!-- chk 체크박스를 배열로 처리하기 위해 인위적으로 지정해 놓은 컨트롤 -->
<table class="table table-bordered table-striped" width="800" cellpadding="5">
<thead class="thead-dark">
<tr>
<td width="60px">
	<input type="checkbox" name="all" id="all" checked="checked" onclick="chkAll(this);" />&nbsp;&nbsp;
	<label for="all">전체 선택</label>
</td>
	<th scope="col" class="text-center" width="100px">이름</th>
	<th scope="col" class="text-center" width="100px">생년월일</th>
	<th scope="col" class="text-center" width="100px">승인여부</th>
	<th scope="col" class="text-center" width="100px">포인트</th>
</tr>
<c:forEach items="${ml}" var="sc">
<input type="hidden" name="mi_id" value="${sc.getMi_id()}" />
<input type="hidden" name="si_idx" value="${sc.getSi_idx()}" />
<tr>
<td class="text-center">
	<input type="checkbox" name="chk" value="${sc.getSj_idx() }" checked="checked" onclick="chkOne(this);" />
</td>
	<td width="100px" class="text-center">${sc.getMi_name() }</td>
	<td width="100px" class="text-center">${sc.getMi_birth() }</td>
	<td width="100px" class="text-center"><c:if test="${sc.getSj_status() == 'g' }">대기 중</c:if>
	<c:if test="${sc.getSj_status() == 'y' }">승인</c:if><c:if test="${sc.getSj_status() == 'n' }">미승인</c:if></td>
	<td width="100px" class="text-center">${sc.getSi_point() }</td>
</tr>
</c:forEach>
</thead>
</table>
<div class="text-center mt-3">
	<input type="button" class="btn btn-primary" value="참여 등록" onclick="chkOk();" />
	<input type="button" class="btn btn-danger ml-2" value="참여 미등록"	onclick="chkNo();" />
	<input type="button" class="btn btn-primary" value="목록 보기" onclick="location.href='serviceChartz';"/>
</div><br />
</form>
</div>
</div>
</body>
</html>