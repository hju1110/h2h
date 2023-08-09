<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
List<DonationInfo> dl = (List<DonationInfo>)request.getAttribute("dl");
DonationInfo di = (DonationInfo)request.getAttribute("di");
PageInfo pageInfo = (PageInfo)request.getAttribute("pi");
LocalDate today = LocalDate.now();
int cYear = today.getYear();
int cMonth = today.getMonthValue();
String Month = String.valueOf(cMonth);
if (cMonth < 10) { Month = "0" + Month; }

String ctgr = "";
String sponsor = "";
String payment = "";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내가 신청한 후원</title>
    <!-- Custom fonts for this template -->
    <link href="/h2hFront/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="/h2hFront/resources/css/sb-admin-2.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
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
<div class="container" style="margin-top: 50px;">
<h1>내가 신청한 후원</h1>
</div>
<hr />
<fieldset>	
<legend>총 후원한 금액</legend>
<select id="mdCtgr">
	<option value="a">일반후원</option>
	<option value="b">정기후원</option>
	<option value="c">정기후원 취소</option>
</select>
<select id="dnSponsor">
	<option value="a">사랑의 밥차</option>
	<option value="b">청소년지킴이</option>
	<option value="c">아이사랑보육원</option>
</select>
<select name="ydate" id="y" onchange="resetday(this.value, this.form.mdate.value);">
		<option>전체</option>
	<% for(int i = 2022 ; i <= cYear ; i++) { %>
		<option <% if (i == cYear) { %>selected="selected" <% } %> value="<%=i %>"><%=i %></option>
	<% } %>
</select>
<select name="mdate" id="m" onchange="resetday(this.form.ydate.value, this.value);">
		<option>전체</option>
	<% for(int i = 1 ; i <= 12 ; i++) { %>
		<option <% if (i == cMonth) { %>selected="selected" <% } %> value="<%=i %>"><%=i %></option>
	<% } %>
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
		<th width="200" style="border-top: none; border-bottom: none;">후원분야</th>
		<th width="200" style="border-top: none; border-bottom: none;">피후원자</th>
		<th width="200" style="border-top: none; border-bottom: none;">회원 아이디</th>
		<th width="200" style="border-top: none; border-bottom: none;">회원 이름</th>
		<th width="200" style="border-top: none; border-bottom: none;">후원 날짜</th>
		<th width="200" style="border-top: none; border-bottom: none;">후원 금액</th>
		<th width="200" style="border-top: none; border-bottom: none;">결제 방법</th>
		<th width="200" style="border-top: none; border-bottom: none;">결제 취소</th>
	</tr>
<tr align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';"></tr>
<% if (dl.size() > 0) {  
	for (DonationInfo dn : dl) { 
		if (dn.getMd_ctgr().equals("a")) {
			ctgr = "일반후원";
		} else if (dn.getMd_ctgr().equals("b")) {
			ctgr = "정기후원";
		}  else {
			ctgr = "정기후원 취소";
		}
		
		if (dn.getDi_sponsor().equals("a")) {
			sponsor = "사랑의 밥차";
		} else if (dn.getDi_sponsor().equals("b")) {
			sponsor = "청소년지킴이";
		}  else {
			sponsor = "아이사랑보육원";
		}
		
		if (dn.getMd_payment().equals("a")) {
			payment = "계좌이체";
		} else if (dn.getMd_payment().equals("b")) {
			payment = "신용카드";
		}  else {
			payment = "휴대폰결제";
		}
%>
	<tr align="center">
		<td  width="100"><%=ctgr %></td>
		<td  width="100"><%=sponsor %></td>
		<td  width="100"><%=dn.getMd_id() %></td>
		<td  width="100"><%=dn.getMd_name() %></td>
		<td  width="100"><%=dn.getMd_sdate() %></td>
		<td  width="100"><%=dn.getMd_price() %></td>
		<td  width="100"><%=payment %></td>		
		<td  width="100"><% if (dn.getMd_sdate().substring(5,7).equals(Month) && dn.getMd_ctgr().equals("b")) { %>
		<input type="button" name="btn2" id="btn1" value="결제 취소" onclick="confirmDelete();"/><% } %></td>
	</tr>
<% if (dn.getMd_sdate().substring(5,7).equals(Month) && dn.getMd_ctgr().equals("b")) { %>
<input type="hidden" name="md_price" id="md_price" value="<%=dn.getMd_price() %>" />
<input type="hidden" name="di_idx" id="di_idx" value="<%=dn.getDi_idx() %>" />
<input type="hidden" name="md_idx" id="md_idx" value="<%=dn.getMd_idx() %>" /><% } %>	
<% }
} else { %>
	<td width="200">검색결과가 없습니다</td>
<% } %>
</table>
<% 
out.println("<p align='center'>");

String qs = pageInfo.getSchargs();
//페이징 영역 링크에서 사용할 쿼리 스트링의 공통 부분 (검색조건들)

//이전 버튼 
if (pageInfo.getCpage() == 1) {
	out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;");
} else {
	out.println("<a href='donaMemList?cpage=1" + qs + "'>[&lt;&lt;]</a>&nbsp;&nbsp;");
	out.println("<a href='donaMemList?cpage=" + (pageInfo.getCpage() - 1) + qs + "'>[&lt;]</a>&nbsp;&nbsp;");
}

//페이징 번호 
 int spage = (pageInfo.getCpage() - 1) / pageInfo.getBsize() * pageInfo.getBsize() + 1; 

 for (int k = 1, j = spage ; k <= pageInfo.getBsize() && j <= pageInfo.getPcnt(); k++,j++) {
	 if (j == pageInfo.getCpage()) {
         out.println("&nbsp;<strong>"+ j + "</strong>&nbsp;");
      } else {
         out.println("&nbsp;<a href='donaMemList?cpage=" + j + qs + "'>" + j + "</a>&nbsp;");
      }
 }
 
//다음 버튼 
if (pageInfo.getCpage() == pageInfo.getPcnt()) {
	out.println("&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
} else {
	out.println("&nbsp;<a href='donaMemList?cpage=" + (pageInfo.getCpage() + 1) + qs + "'>[&gt;]</a>");
	out.println("&nbsp;&nbsp;<a href='donaMemList?cpage=" + pageInfo.getPcnt() + qs + "'>[&gt;&gt;]</a>");		
}

out.println("</p>");
%>
<hr align="left"/>
<br />
</body>
</html>