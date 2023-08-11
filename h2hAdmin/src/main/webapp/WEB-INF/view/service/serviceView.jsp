<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="vo.*" %>
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
    width: 600px;
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
    background-color: #007bff;
    color: white;
  }
  .btn-secondary {
    background-color: #6c757d;
  }
</style>
<script>
function serChk(){
	var button = document.getElementById("chk");
	if(button != null) {
		alert("등록되었습니다.");
	}
}
</script>
<body>
<div align="center">
<div class="left">
<br />
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
<tr><td colspan="19" align="center">
	<c:if test="${si.getSi_accept() == 'n' }">
	<input type="button"  class="btn btn-danger ml-2" value="봉사 승인" onclick="location.href='serviceProcUp?siidx=${si.getSi_idx()}';"/>
	</c:if>
</td></tr>
</table>
<br />
<input type="button" class="btn btn-primary" value="목록 보기" onclick="location.href='service';"/>
</div>
</div>
</body>
</html>