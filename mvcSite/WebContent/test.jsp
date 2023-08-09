<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String tmp = "11:22";
String[] arr = tmp.split(":");	// 없으면 한칸짜리 배열을 만들어줌 
for (int i = 0 ; i < arr.length ; i++) {
	out.println(arr[i] + "<br />");
}
%>
</body>
</html>