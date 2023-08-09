<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String memType = loginInfo.getMi_type();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ServiceView</title>
<style>
  /* 오른쪽 상단 배치를 위한 추가적인 CSS 스타일 */
  .align-right {
    text-align: right;
  }
</style>
</head>
<script>
function serChk(){
	var button = document.getElementById("chk");
	
	if(button != null) {
		alert("'참여' 신청이 완료 됐습니다.")
	}
}
</script>
<body>
<div class="container mt-5">
<form name="frmSView" action="serviceView">
<h2>봉사활동 글보기</h2>
<div align="right">
<% if (!memType.equals("c")) { %>
	<input type="button" class="btn btn-primary" id= "chk" value="참여하기" onclick="location.href='service${args}';" />
<% } %>
</div>
<br />
<table class="table table-bordered" width="1000" cellpadding="5">
<tr>
<th width="150">봉사활동명</th><td width=150>${si.getSi_acname() }</td>
<th width="150">봉사활동포인트</th><td width=50>${si.getSi_point() }</td>
<th width="150">봉사활동일자</th><td width=150>${si.getSi_acdate() }</td>
</tr>
<tr>
<th width="150">모집인원</th><td width = "80">${si.getSi_person() }명</td>
<th width="150">봉사자유형</th><td width = "80">${si.getSi_type() }</td>
<th width="150">봉사마감일자</th><td width = "200">${si.getSi_edate() }</td>
</tr>

<tr><th>글 제목</th><td colspan="5">${si.getSi_title() }</td></tr>
<tr><th>글 내용</th><td colspan="5">${si.getSi_content() }</td></tr>
<tr><th>활동상세내용</th><td colspan="5">${si.getSi_content() }</td></tr>
</table>
</form>
</div>
</body>
</html>