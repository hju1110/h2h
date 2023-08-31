<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>후기 작성 등록</title>
<!-- Add Bootstrap CSS link -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

</head>
<body>

<div class="container mt-5">
<h2 class="text-center">후기 작성</h2>
<form name="frm" action="reviewProcIn" method="post" enctype="multipart/form-data">
<table class="table table-bordered table-striped" width="600" cellpadding="5">
<tr>
<th width="15%">작성자</th>
<td width="35%"><input type="text" name="rl_writer" class="form-control" value="<%=loginInfo.getMi_name() %>" readonly /></td>
</tr>
<tr>
<th width="15%">활동 명</th>
<td width="35%">
	<select name="siAcname">
	<c:if test="${rl > 0 }" var="sj">
	<c:forEach items="${sj.getSjStatus() == 'y' }">
		<option>${sj.getSjAcname() }</option>
	</c:forEach>
	</c:if>
	</select>
</td>
</tr>
<tr>
<th width="15%">글제목</th>
<td colspan="3"><input type="text" name="rl_title" size="60" class="form-control" />${rl.getRl_title()}</td>
<td><p><input type="file" name="rl_file" multiple="multiple" class="form-control-file" /></p></td>
</tr>
<tr>
<th>글내용</th>
<td colspan="4"><textarea name="rl_content" rows="10" cols="65" class="form-control" />${rl.getRl_content()}</textarea></td>
</tr>
<tr>
<td colspan="5" align="center">
   <input type="submit" value="글등록" class="btn btn-primary" 
          onclick="return checkFileUpload();" />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="reset" value="다시 입력" class="btn btn-secondary" />
</td>
</tr>
</table>
</form>
</div>

<script>
function checkFileUpload() {
    var fileInput = document.querySelector('input[type="file"]');
    if (fileInput && fileInput.files.length === 0) {
        alert("파일을 등록해주세요.");
        return false;
    }
    return true;
}
</script>

</body>
</html>
<%@ include file="../_inc/inc_foot.jsp" %>