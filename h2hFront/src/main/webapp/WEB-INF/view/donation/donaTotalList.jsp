<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/incHead2.jsp" %>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css">
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
<div>
<br />
<h1>내가 신청한 후원</h1>
<hr />
<fieldset>	
<legend style="margin-left:30px;">총 후원한 금액</legend>
<div class="input-group">
    <div class="col-auto">
		<select class="form-select" id="mdCtgr">
			<option value="d">전체</option>
			<option value="a">일반후원</option>
			<option value="b">정기후원</option>
			<option value="c">정기후원 취소</option>
		</select>
	</div>
    <div class="col-auto">
		<select class="form-select" id="dnSponsor">
			<option value="d">전체</option>
			<option value="a">행복한 손길</option>
			<option value="b">서울청소년 지원부</option>
			<option value="c">즐거운 어린이집</option>
		</select>
	</div>
    <div class="col-auto">
		<select class="form-select" name="ydate" id="y" onchange="resetday(this.value, this.form.mdate.value);">
				<option>전체</option>
			<% for(int i = 2022 ; i <= cYear ; i++) { %>
				<option <% if (i == cYear) { %>selected="selected" <% } %> value="<%=i %>"><%=i %></option>
			<% } %>
		</select>
	</div>
    <div class="col-auto">
		<select class="form-select" name="mdate" id="m" onchange="resetday(this.form.ydate.value, this.value);">
			<option>전체</option>
		<% for(int i = 1 ; i <= 12 ; i++) { %>
			<option <% if (i == cMonth) { %>selected="selected" <% } %> value="<%=i %>"><%=i %></option>
		<% } %>
		</select>
	</div>
<input type="hidden" name="miid" id="miid" value="<%=loginInfo.getMi_id() %>" />
<div class="col-auto" style="display: inline-flex; align-items: center;">
	<button class="btn btn-primary" name="btn" id="btn" onclick="total();">확인</button>
</div>
<div class="col-auto" style="display: inline-flex; align-items: center;">
	<input type="text" class="form-control" name="totalPrice" id="totalPrice" value="0" />&nbsp;원
</div>
</div>
</fieldset>
</div>
<br /><br />
<!-- --------------------------------검색 시작 부분------------------- -->

<!-- --------------------------------검색 종료 부분------------------- -->
<hr />
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
		
		if (dn.getMd_sponsor().equals("a")) {
			sponsor = "행복한 손길";
		} else if (dn.getMd_sponsor().equals("b")) {
			sponsor = "서울청소년 지원부";
		}  else {
			sponsor = "즐거운 어린이집";
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
if (qs == null)	qs = "";

//이전 버튼 
if (pageInfo.getCpage() == 1) {
	out.println("[처음]&nbsp;&nbsp;[이전]&nbsp;");
} else {
	out.println("<a href='donaMemList?cpage=1" + qs + "'>[처음]</a>&nbsp;&nbsp;");
	out.println("<a href='donaMemList?cpage=" + (pageInfo.getCpage() - 1) + qs + "'>[이전]</a>&nbsp;&nbsp;");
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
	out.println("&nbsp;[다음]&nbsp;&nbsp;[마지막]");
} else {
	out.println("&nbsp;<a href='donaMemList?cpage=" + (pageInfo.getCpage() + 1) + qs + "'>[다음]</a>");
	out.println("&nbsp;&nbsp;<a href='donaMemList?cpage=" + pageInfo.getPcnt() + qs + "'>[마지막]</a>");		
}

out.println("</p>");
%>
<hr align="left"/>
<br />
