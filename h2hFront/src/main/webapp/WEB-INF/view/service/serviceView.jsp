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
 .line {
        text-align: center;
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
<hr />
<h5>신청자정보</h5>
<h6>연락처 번호 변경은 오른쪽 연락처 수정버튼을 클릭하여 변경해주시기 바라겠습니다.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-primary" id= "chk" value="회원정보 수정" onclick="location.href='http://localhost:8088/h2hFront/myInfoChk';" /></h6>
<hr />
<h6>핸드폰 번호 : <input type="text" name="e1" id="e1" size="10" class="textp"> - <input type="text" name="e1" id="e1" size="10" class="textp">  - <input type="text" name="e1" id="e1" size="10" class="textp"> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>	
<div id="center" class="center">
<h6>E-mail :
		<form name="frm" action="memberForm" method="post" onsubmit="return chkAcc();">
			<input type="text" name="e1" id="e1" size="10" class="textp"> @ <input type="text" name="e2" id="e2" size="10" class="textp">
			<select name="e3" id="e3" class="textp">
				<option value="">도메인 선택</option>
				<option value="naver.com">naver.com</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="gmail.com">gmail.com</option>
				<option value="nate.com">nate.com</option>
				<option value="direct">직접 입력</option>
			</select>
		</form>
	</h6>
</div>
<br />
<div style="border:1px solid; padding:10px;">
<li>회원님이 등록하신 정보로 전송됩니다. 등록된 정보가 정확한지 확인해주세요</li>
<li><font color="orange">연락처 및 이메일 주소는 확인 정보로 일회성으로만 사용됩니다.</font></li>
<li>휴대폰번호 및 이메일로 봉사활동 정보를 제공 및 사용을 동의하십니까?</li>
<div class="line"><input type="checkbox" value="정보제공 및 수신 동의">정보제공 및 수신 동의</div>
</div>
</form>
</div>
<br />
<div class="line">
<input type="button" class="btn btn-primary" id= "chk" value="봉사활동 신청" onclick="location.href='';" />
</div>
</body>
</html>