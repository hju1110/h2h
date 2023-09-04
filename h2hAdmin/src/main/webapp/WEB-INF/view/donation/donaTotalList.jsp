<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
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

String ydate = pageInfo.getYdate();
String mdate = pageInfo.getMdate();

if (ydate == null)	ydate = cYear + "";
if (mdate == null) mdate = cMonth + "";

String ctgr = "";
String sponsor = "";
String payment = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>donaTotalList</title>
<style>
  th, td { border: 1px solid #000; }
  .container { max-width: 1400px; margin: 0 auto; padding: 20px; }
  .heading { font-size: 24px; font-weight: bold; }
  .sub-heading { font-size: 18px; font-weight: bold; }
  .btn { display: inline-block; padding: 10px 20px; background-color: #4CAF50; color: #fff; text-decoration: none; border: none; cursor: pointer; }
  .btn:hover { background-color: #45a049; }
  table { width: 100%; border-collapse: collapse; }
  th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
  tr:nth-child(even) { background-color: #f2f2f2; }
  tr:hover { background-color: #f5f5f5; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/date_change.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
function total() {
    const mdCtgr = $('#mdCtgr').val();
    const dnSponsor = $('#dnSponsor').val();
    const ydate = $('#y').val();
    const mdate = $('#m').val();
    $.ajax({
        type: "POST",
        url: "./donaTotalPrice",
        data: {
            "mdCtgr": mdCtgr,
            "dnSponsor": dnSponsor,
            "ydate": ydate,
            "mdate": mdate
        },
        dataType: "text",
        success: function (data) {
            alert("검색완료");
            $('#totalPrice').val(data); // 변경: total -> data
        },
        error: function (request, status, error) {
            alert("검색 실패");
        }
    });
}
</script>
</head>
<body>
<div class="left">
<div class="container">
<h1 class="heading">후원현황</h1>
			<form name="frmDtl" action="donaTotal">
				<div class="row">
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card border-left-primary shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div
											class="text-xs font-weight-bold text-primary text-uppercase mb-1">일반후원</div>
										<div class="h5 mb-0 font-weight-bold text-gray-800"><%=di.getDi_gprice()%></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card border-left-success shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div
											class="text-xs font-weight-bold text-success text-uppercase mb-1">정기후원</div>
										<div class="h5 mb-0 font-weight-bold text-gray-800"><%=di.getDi_rprice()%></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
<div>
	<h3 class="sub-heading">총 후원 금액</h3>
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
	<input type="button" name="btn" id="btn" class="btn btn-primary" value="확인" onclick="total();"/>
	<input type="text" name="totalPrice" id="totalPrice" value="0" />원
</div>
<br /><br />
<!-- --------------------------------검색 시작 부분------------------- -->
<form name="frmSch" >
	<fieldset>	
	<legend>후원자 검색</legend>
	<div>
		<select name="dnSponsor">
			<option value="d" <% if (pageInfo.getDnSponsor() != null && pageInfo.getDnSponsor().equals("d")) { %> selected="selected"<% } %>>전체</option>
			<option value="a" <% if (pageInfo.getDnSponsor() != null && pageInfo.getDnSponsor().equals("a")) { %> selected="selected"<% } %>>행복한 손길</option>
			<option value="b" <% if (pageInfo.getDnSponsor() != null && pageInfo.getDnSponsor().equals("b")) { %> selected="selected"<% } %>>서울청소년 지원부</option>
			<option value="c" <% if (pageInfo.getDnSponsor() != null && pageInfo.getDnSponsor().equals("c")) { %> selected="selected"<% } %>>즐거운 어린이집</option>
		</select>
		<select name="mdCtgr">
			<option value="d" <% if (pageInfo.getMdCtgr() != null && pageInfo.getMdCtgr().equals("d")) { %> selected="selected"<% } %>>전체</option>
			<option value="a" <% if (pageInfo.getMdCtgr() != null && pageInfo.getMdCtgr().equals("a")) { %> selected="selected"<% } %>>일반후원</option>
			<option value="b" <% if (pageInfo.getMdCtgr() != null && pageInfo.getMdCtgr().equals("b")) { %> selected="selected"<% } %>>정기후원</option>
			<option value="c" <% if (pageInfo.getMdCtgr() != null && pageInfo.getMdCtgr().equals("c")) { %> selected="selected"<% } %>>정기후원 취소</option>
		</select>
		<select name="mi">
			<option value="md_id" <% if (pageInfo.getMi() != null && pageInfo.getMi().equals("md_id")) { %> selected="selected"<% } %>>아이디</option>
			<option value="md_name" <% if (pageInfo.getMi() != null && pageInfo.getMi().equals("md_name")) { %> selected="selected"<% } %>>이름</option>
		</select>
		<select name="ydate" id="y" onchange="resetday(this.value, this.form.mdate.value);">
			<option value="all">전체</option>
		<% for(int i = 2022 ; i <= cYear ; i++) { %>
			<option <% if (ydate.equals(i + "")) { %>selected="selected"<% } %> value="<%=i %>" ><%=i %></option>
		<% } %>
		</select>
		<select name="mdate" id="m" onchange="resetday(this.form.ydate.value, this.value);">
			<option value="all">전체</option>
		<% for(int i = 1 ; i <= 12 ; i++) { %>
			<option <% if (mdate.equals(i + "")) { %>selected="selected"<% } %> value="<%=i %>"><%=i %></option>
		<% } %>
		</select>
		<input type="text" name="keyword" value="<%=pageInfo.getKeyword() %>" />
		<input type="submit" class="btn btn-primary" value="검색" />
		<input type="button" class="btn btn-secondary" value="전체 후원자 보기" onclick="location.href='donaMemList'" />
	</div>
	</fieldset>
</form>
<!-- --------------------------------검색 종료 부분------------------- -->
<hr/>
<table>
	<tr align="center">
		<th width="200">후원분야</th>
		<th width="200">피후원자</th>
		<th width="200">회원 아이디</th>
		<th width="200">회원 이름</th>
		<th width="200">후원 날짜</th>
		<th width="200">후원 금액</th>
		<th width="200">결제 방법</th>
	</tr>
	<% if (dl.size() > 0) {  
	for (DonationInfo dn : dl) {
		if (dn.getMd_ctgr().equals("a")) {
			ctgr = "일반후원";
		} else if (dn.getMd_ctgr().equals("b")) {
			ctgr = "정기후원";
		}  else if (dn.getMd_ctgr().equals("c")) {
			ctgr = "정기후원 취소";
		} else {
			ctgr = "전체";
		}
        
		if (dn.getDi_sponsor().equals("a")) {
			sponsor = "행복한 손길";
		} else if (dn.getDi_sponsor().equals("b")) {
			sponsor = "서울청소년 지원부";
		}  else if (dn.getDi_sponsor().equals("c")) {
			sponsor = "즐거운 어린이집";
		} else {
			sponsor = "전체";
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
		<td><%=ctgr %></td>
		<td><%=sponsor %></td>
		<td><%=dn.getMd_id() %></td>
		<td><%=dn.getMd_name() %></td>
		<td><%=dn.getMd_sdate().substring(0, 11) %></td>
		<td><%=dn.getMd_price() %></td>
		<td><%=payment %></td>
	</tr>
	<% }
	} else { %>
	<tr align="center">
		<td colspan="7">검색결과가 없습니다</td>
	</tr>
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
<hr/>
</div>
</div>
</body>
</html>