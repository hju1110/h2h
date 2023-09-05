<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/incHead2.jsp" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <title>나의 참여 현황</title>
    <!-- Custom fonts for this template -->
    <link href="/h2hFront/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <!-- Custom styles for this template -->
      <link href="/h2hFront/resources/css/sb-admin-2.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
      
        }

        h1 {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            margin-top:100px;
            
        }

        hr {
            border: 1px solid #ddd;
            margin: 20px 0;
        }

        fieldset {
            margin-bottom: 20px;
        }

        select, input[type="button"], input[type="text"] {
            padding: 5px;
        }

        input[type="button"] {
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #efefef;
        }

        #list {
            margin-top: 20px;
        }

        p {
            text-align: center;
            margin: 20px 0;
        }
    </style>
<script src="${pageContext.request.contextPath}/resources/js/date_change.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function total() {
	var siSch = $("#siSch").val(), miid = $('#miid').val();
	$.ajax({
		type : "POST",
		url: "./mySvcSch",
		data : {"siSch" : siSch, "miid" : miid},
		success : function(chkRs) {
			if (chkRs < 1) {
				alert("검색 결과가 없습니다.");
			} else {
				alert("검색 완료");
			}
		}
	});
}

function svcDelete() {
    const result = confirm("봉사 참여 신청을 취소하시겠습니까?");
    if (result) {
        del();
    } else {
    }
}
function del() {
	const sj_idx = $('#sj_idx').val();
	const si_idx = $('#si_idx').val();
	const miid = $('#miid').val();
	$.ajax({
		type: "POST",
		url: "./svcCancel",
		data: {"sj_idx": sj_idx, "si_idx": si_idx, "miid": miid },
		success: function(chkRs) {
			if (chkRs == 0) {
		        alert("봉사 참여신청 취소에 실패했습니다.");
			} else {
				alert("봉사 참여신청 취소 했습니다.");
				location.reload(); 
			}
		}
	});
}
</script>
</head>
<body>
<div>
<br />
<h1>내가 신청한 참여</h1>
<hr />

<select id="siSch" onchange="location.href='serviceTotalList?siSch=' + this.value;">
	<option value="g" <c:if test="${pi.getSchargs() == 'g' }" >selected="selected"</c:if>>봉사 신청 내역</option>
	<option value="y" <c:if test="${pi.getSchargs() == 'y' }" >selected="selected"</c:if>>활동 내역</option>
</select>
<input type="hidden" name="miid" id="miid" value="<%=loginInfo.getMi_id() %>" />
<!-- <input type="button" name="btn" id="btn" value="확인" onclick="total();"/> -->
<br /><br />
<hr />
<table width="1400" cellpaddnng="0" cellspacing="0" id="list">
	<tr align="center">
		<th class="text-center" style="width:5%;">No</th>
		<th width="200" style="border-top: none; border-bottom: none;">활동명</th>
		<th width="200" style="border-top: none; border-bottom: none;">봉사 신청일자</th>
		<th width="200" style="border-top: none; border-bottom: none;">봉사 활동일자</th>
		<th width="200" style="border-top: none; border-bottom: none;">봉사 신청 상태</th>
		<th width="200" style="border-top: none; border-bottom: none;">신청 취소</th>
	</tr>
<tr align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';"></tr>
	<c:forEach items="${serviceInfo }" var="si" varStatus="status">
	<input type="hidden" name="sjidx" id="sj_idx" value="${si.getSj_idx() }"  />
	<input type="hidden" name="siidx" id="si_idx" value="${si.getSi_idx() }" />
		<tr align="center">
			<td align="center">${pi.getNum() - status.index}</td>
			<td width="100"><a href="serviceView?siidx=${si.getSi_idx() }${pi.getArgs()}">${si.getSi_acname() }</a></td>
			<td width="100">${si.getSj_date().substring(0, 11) }</td>
			<td width="100">${si.getSi_acdate().substring(0, 11) }</td>
			<td width="100">
				<c:if test="${si.getSj_status() == 'g' }">대기 중</c:if>
				<c:if test="${si.getSj_status() == 'y' }">승인</c:if>
				<c:if test="${si.getSj_status() == 'n' }">미승인</c:if>
			</td>
			<td width="100">
			<c:if test="${si.getSj_status() == 'g' && si.getSi_recruit() == 'y' }">
			<input type="button" name="btn2" id="btn1" value="취소하기" onclick="svcDelete();"/>
			</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
<br />
<table width="700" cellpadding="5">
<tr>
<td width="600">
<c:if test="${serviceInfo.size() > 0 }">
	<c:if test="${pi.getCpage() == 1}">
		[처음]&nbsp;&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;
	</c:if>
	<c:if test="${pi.getCpage() > 1}">
		<a href="serviceTotalList?cpage=1">[처음]</a>&nbsp;&nbsp;&nbsp;
		<a href="serviceTotalList?cpage=${pi.getCpage() - 1} ">[이전]</a>&nbsp;&nbsp;
	</c:if>
	
	<c:forEach var="i" begin="${pi.getSpage() }"
		end="${pi.getSpage() + pi.getBsize() - 1 <= pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }">
			<c:if test="${i == pi.getCpage() }">
				&nbsp;<strong>${i }</strong>&nbsp;
			</c:if>
			<c:if test="${i != pi.getCpage() }">
				&nbsp;<a href="serviceTotalList?cpage=${i }">${i }</a>&nbsp;
			</c:if>
	</c:forEach>
	
	<c:if test="${pi.getCpage() == pi.getPcnt() }">
		&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]
	</c:if>
	<c:if test="${pi.getCpage() < pi.getPcnt()}">
		&nbsp;&nbsp;<a href="serviceTotalList?cpage=${pi.getCpage() + 1} ">[다음]</a>
		&nbsp;&nbsp;&nbsp;<a href="serviceTotalList?cpage=${pi.getPcnt() } ">[마지막]</a>
	</c:if>
</c:if>
</td>
</tr>
</table>
<br />
</div>
<%@ include file="../inc/incFoot.jsp" %>
