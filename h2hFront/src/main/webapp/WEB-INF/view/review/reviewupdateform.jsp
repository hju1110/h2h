<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>후기 수정</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="left">
<div class="container mt-5">
<h2 class="text-center">후기 수정</h2>
<form name="frm" action="reviewProcUp" method="post" enctype="multipart/form-data">
<table class="table table-bordered table-striped" width="600" cellpadding="5">
<tr>
    <th width="15%">작성자</th>
    <td width="35%"><input type="text" name="rl_writer" class="form-control" value="${rl.getRl_writer()}" /></td>
</tr>
<tr>
    <th width="15%">글제목</th>
    <td colspan="3"><input type="text" name="rl_title" size="60" class="form-control" value="${rl.getRl_title()}" /></td>
    <td>
        <input type="file" name="rl_file" multiple="multiple" class="form-control-file" />
        <!-- 기존 이미지 파일명을 hidden 필드로 추가하여 기존 파일명을 유지하도록 합니다. -->
        <input type="hidden" name="rl_name" value="${rl.getRl_name()}" />
        <input type="hidden" name="rl_idx" value="${rl.getRl_idx()}" />
    </td>
</tr>
<tr>
    <th>글내용</th>
    <td colspan="4"><textarea name="rl_content" rows="10" cols="65" class="form-control" >${rl.getRl_content()}</textarea></td>
</tr>
<tr>
    <td colspan="5" align="center">
        <input type="submit" value="글수정" class="btn btn-primary" 
               onclick="return checkFileUpload();" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="reset" value="다시 입력" class="btn btn-secondary" />
    </td>
</tr>
</table>
</form>
</div>
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
