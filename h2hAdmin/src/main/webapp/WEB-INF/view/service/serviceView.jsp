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
    width: 100%;
    border: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
  }
</style>
<script>
function serChk(){
	var button = document.getElementById("chk");
	
	if(button != null) {
		alert("등록되었습니다.")
	}
}
</script>
<body>
<div class="left">
<h2>봉사활동 글보기</h2>
<table width="600" cellpadding="5">
<tr>
<th width="10%">봉사활동명</th><td width = "15%">${si.getSi_acname() }</td>
<th width="10%">봉사활동포인트</th><td width = "15%">${si.getSi_point() }</td>
<th width="10%">봉사활동일자</th><td width = "15%">${si.getSi_acdate() }</td>
</tr>
<tr>
<th width="10%">모집인원</th><td width = "25%">${si.getSi_person() }명</td>
<th width="10%">봉사자유형</th><td width = "25%">${si.getSi_type() }</td>
<th width="10%">봉사마감일자</th><td width = "25%">${si.getSi_edate() }</td>
</tr>

<tr><th>글 제목</th><td colspan="5">${si.getSi_title() }</td></tr>
<tr><th>글 내용</th><td colspan="5">${si.getSi_content() }</td></tr>
<tr><th>활동상세내용</th><td colspan="5">${si.getSi_content() }</td></tr>
<tr><td colspan="20" align="center">
	<input type="button" id= "chk" value="등 록" onclick="location.href='service';" />
	<input type="button" value="미 등 록" />
	<input type="button" value="수 정" onclick="location.href='freeFormIn';" />
</td></tr>
</table>
</div>
</body>
</html>