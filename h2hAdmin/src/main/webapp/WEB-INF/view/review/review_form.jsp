<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div class="left">
<h2>후기 작성</h2>
<form name="frm" action="noticeProcIn" method="post" enctype="multipart/form-data">
<table width="600" cellpadding="5">
<tr>
<tr>
	<th width="15%">작성자</th>
	<td width="35%"><input type="text" name="nl_writer" class="form-control" value="관리자" readonly/></td>
</tr>
<tr>
<th width="15%">글제목</th>
<td colspan="3"><input type="text" name="nl_title" size="60" /></td>
<td><p><input type="file" name="nl_file" multiple="multiple" /></p></td>
</tr>
<tr>
<th>글내용</th>
<td colspan="3"><textarea name="nl_content" rows="10" cols="65" /></textarea></td>
</tr>
<tr><td colspan="4" align="center">
	<input type="submit" value="글등록" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" value="다시 입력" />
</td></tr>
</table>
</form>
</div>
</body>
</html>
