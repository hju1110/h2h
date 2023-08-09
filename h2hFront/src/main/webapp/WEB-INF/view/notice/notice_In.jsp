<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../menuBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form name="frm" action="noticeProcIn" method="post" enctype="multipart/form-data">
<p><input type="file" name="uploadFile" multiple="multiple" /></p>
<p><input type="submit" value="업로드" /></p>
</form>
</body>
</html>