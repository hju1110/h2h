<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ServiceChart</title>
<style>
body, th, td, div, p { font-size:12px; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; color:red; }
#list th, #list td { padding:8px 3px; }
#list th { border-bottom:double black 3px; }
#list td { border-bottom:dotted black 1px; }
</style>
</head>
<body>

<h2>봉사활동 신청현황</h2>
<table width="700" border="0" cellpadding="0" cellspacing="0" id="list" border="1">
<tr height="30">
<th width="10%">No</th>
<th width="*">봉사활동명</th>
<th width="15%">신청일</th>
<th width="10%">봉사일자</th>  
<th width="10%">봉사취소</th>  
</tr>
<c:if test="${serviceRequestListInfo.size() > 0}"><!-- 게시판 정보가 있으면~ else를 쓰고 싶으면 반대조건 주면 됨-->
	<c:forEach items="${serviceRequestListInfo}" var="sc" varStatus="status">
  <tr height="30">
    <td align="center">${pi.getNum() - status.index}</td>
    <td align="center">${sc.getSi_acname() }</td>

    <td align="center">${sc.getMs_sdate() }</td>
    <td align="center">${sc.getSi_acdate() }</td>	
    <td align="center"><input type="button"  value="취소" onclick="location.href='';" />
    </td>
  </tr>
</c:forEach>
</c:if>	

</table>
<br />
<table width="700" cellpadding="5">
<tr>
<td width="600">
	<c:if test="${serviceRequestListInfo.size() > 0 }">
		<c:if test="${pi.getCpage() == 1}">
			[처음]&nbsp;&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;
		</c:if>
		<c:if test="${pi.getCpage() > 1}">
			<a href="serviceRequestListInfo?cpage=1${pi.getSchargs() }">[처음]</a>&nbsp;&nbsp;&nbsp;
			<a href="serviceRequestListInfo?cpage=${pi.getCpage() - 1}${pi.getSchargs() }">[이전]</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${pi.getSpage() }"
			end="${pi.getSpage() + pi.getBsize() - 1 <= pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }">
				<c:if test="${i == pi.getCpage() }">
					&nbsp;<strong>${i }</strong>&nbsp;
				</c:if>
				<c:if test="${i != pi.getCpage() }">
					&nbsp;<a href="serviceRequestListInfo?cpage=${i }${pi.getSchargs() }">${i }</a>&nbsp;
				</c:if>
		</c:forEach>
		
		<c:if test="${pi.getCpage() == pi.getPcnt() }">
			&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]
		</c:if>
		<c:if test="${pi.getCpage() < pi.getPcnt()}">
			&nbsp;&nbsp;<a href="serviceRequestListInfo?cpage=${pi.getCpage() + 1}${pi.getSchargs() }">[다음]</a>
			&nbsp;&nbsp;&nbsp;<a href="serviceRequestListInfo?cpage=${pi.getPcnt() }${pi.getSchargs() }">[마지막]</a>
		</c:if>
	</c:if>
</td>
<td width="*">
</td>
</tr>
</table>
</body>
</html>