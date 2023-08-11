<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
PageInfo pageInfo = (PageInfo)request.getAttribute("pi");
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

<script>
function total() {
    const mdCtgr = $('#mdCtgr').val();	const dnSponsor = $('#dnSponsor').val();
    const ydate = $('#y').val();		const mdate = $('#m').val();
    const miid = $('#miid').val();
    $.ajax({
        type: "POST",
        url: "./donaTotalPrice",
        data: {
            "mdCtgr": mdCtgr,
            "dnSponsor": dnSponsor,
            "ydate": ydate,
            "mdate": mdate,
            "miid" : miid
        },
        dataType: "text",
        success: function (data) {
            alert("검색완료");
            if (data == "") {
            	data = "0";
            	$('#totalPrice').val(data);
            } else {
            	$('#totalPrice').val(data); // 변경: total -> data
            }
        },
        error: function (request, status, error) {
            alert("검색 실패");
        }
    });
}
function confirmDelete() {
    const result = confirm("정기 결제를 취소하시겠습니까?");
    if (result) {
        del();
    } else {
    }
}
function del() {
    const md_idx = $('#md_idx').val();
    const di_idx = $('#di_idx').val();
    const miid = $('#miid').val();
    const md_price = $('#md_price').val();
    $.ajax({
	    type: "POST",
	    url: "./donaDel",
	    data: {"md_idx": md_idx, "di_idx": di_idx, "miid": miid, "md_price" : md_price },
	    success: function(chkRs) {
	      if (chkRs != 2) {
	        alert("결제 취소에 실패했습니다.");
	      } else {
	        alert("결제 취소 했습니다.");
	        location.reload(); 
	     }
    }
  });
}
</script>
</head>
<body>
<dnv>
<br />
<h1>내가 신청한 후원</h1>
<hr />
<fieldset>	
<legend>총 후원한 금액</legend>
<select id="mdCtgr">
	<option value="d">전체</option>
	<option value="a">일반후원</option>
	<option value="b">정기후원</option>
	<option value="c">정기후원 취소</option>
</select>
<select id="dnSponsor">
	<option value="d">전체</option>
	<option value="a">행복한 손길</option>
	<option value="b">서울청소년 지원부</option>
	<option value="c">즐거운 어린이집</option>
</select>
<input type="hidden" name="miid" id="miid" value="<%=loginInfo.getMi_id() %>" />
<input type="button" name="btn" id="btn" value="확인" onclick="total();"/>
<input type="text" name="totalPrice" id="totalPrice" value="0" />원
</fieldset>
</dnv>
<br /><br />
<!-- --------------------------------검색 시작 부분------------------- -->

<!-- --------------------------------검색 종료 부분------------------- -->
<hr width="1400" align="left"/>
<table width="1400" cellpaddnng="0" cellspacing="0" id="list">
	<tr align="center">
		<th width="200" style="border-top: none; border-bottom: none;">활동명</th>
		<th width="200" style="border-top: none; border-bottom: none;">봉사 신청일자</th>
		<th width="200" style="border-top: none; border-bottom: none;">봉사 활동일자</th>
	</tr>
<tr align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';"></tr>

	<tr align="center">
		<td  width="100">${si.getSi_acname() }</td>
		<td  width="100">${si.getSi_sjdate().substring(0, 11) }</td>
		<td  width="100">${si.getSi_acdate().substring(0, 11) }</td>
		<td  width="100"><input type="button" name="btn2" id="btn1" value="취소하기" onclick="confirmDelete();"/></td>
	</tr>	

	<td width="200">검색결과가 없습니다</td>
</table>
<%
out.println("<p align='center'>");

String qs = pageInfo.getSchargs();
//페이징 영역 링크에서 사용할 쿼리 스트링의 공통 부분 (검색조건들)
if (qs == null)	qs = "";

//이전 버튼 
if (pageInfo.getCpage() == 1) {
	out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;");
} else {
	out.println("<a href='serviceTotalList?cpage=1" + qs + "'>[&lt;&lt;]</a>&nbsp;&nbsp;");
	out.println("<a href='serviceTotalList?cpage=" + (pageInfo.getCpage() - 1) + qs + "'>[&lt;]</a>&nbsp;&nbsp;");
}

//페이징 번호 
 int spage = (pageInfo.getCpage() - 1) / pageInfo.getBsize() * pageInfo.getBsize() + 1; 

 for (int k = 1, j = spage ; k <= pageInfo.getBsize() && j <= pageInfo.getPcnt(); k++,j++) {
	 if (j == pageInfo.getCpage()) {
         out.println("&nbsp;<strong>"+ j + "</strong>&nbsp;");
      } else {
         out.println("&nbsp;<a href='serviceTotalList?cpage=" + j + qs + "'>" + j + "</a>&nbsp;");
      }
 }
 
//다음 버튼 
if (pageInfo.getCpage() == pageInfo.getPcnt()) {
	out.println("&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
} else {
	out.println("&nbsp;<a href='serviceTotalList?cpage=" + (pageInfo.getCpage() + 1) + qs + "'>[&gt;]</a>");
	out.println("&nbsp;&nbsp;<a href='serviceTotalList?cpage=" + pageInfo.getPcnt() + qs + "'>[&gt;&gt;]</a>");		
}

out.println("</p>");
%>
<hr align="left"/>
<br />
</body>
</html>