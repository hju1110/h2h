<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/incHead2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%
request.setCharacterEncoding("utf-8");
ProductInfo productInfo = (ProductInfo)request.getAttribute("productInfo");
// 화면에서 보여줄 상품 정보들을 저장한ProductInfo 형 인스턴스를 받아옴
// ProductInfo 에 들어있는 옵션별 재고량 목로을 받아옴
// 해당 상품의 구매 후기 목록을 받아옴
long realPrice = productInfo.getPi_price();		 //수량 변경에 따른 가격 연산을 위한 변수 
String price = productInfo.getPi_price() + "원";	 //가격 출력을 위한 변수

%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function swapImg(img) {
	var big = document.getElementById("bigImg");
	//큰 이미지를보여주는 img태그를 big테그를 가져옴
	big.src = "resources/img/" + img;
}


function liek() {	
	  const pi_id = $('#piid').val(); 
	  $.ajax({
	    type: "POST",
	    url: "./productLiek",
	    data: {"piid": pi_id},
	    success: function(chkRs) {
	      if (chkRs != 1) {
	        alert("좋아요 처리 실패했습니다.");
	      } else {
	        alert("좋아요 눌러줘서 감사요 .");
	        location.reload(); 
	      }
	    }
	  });
	}
function setCnt(op) {
	var price = <%=realPrice %>;
	var frm = document.frm;
	var size = frm.size.value;	// 10:150 -> ps_idx:ps_stock 이라는 뜻
	
	if (size != "") {
		var cnt = parseInt(frm.cnt.value);
		if (op == "+")	{	
			frm.cnt.value = cnt + 1; 
			if (cnt > 9) {
				frm.cnt.value = 10;
				alert("최대 10개 까지 구매 가능합니다.");
			} 
		}
	if (op == "-" && frm.cnt.value >= 2) 	frm.cnt.value = cnt - 1;
		
		var total = document.getElementById("total");
		total.innerHTML = price * frm.cnt.value;
	} else {
		alert("옵션을 먼저 선택하세요.");
	}
}

function buy(kind) {
	var frm = document.frm;
	var size = frm.size.value;
	var cnt = frm.cnt.value;
	if (size == "") { alert("옵션(사이즈)을 선택하세요."); return; }
	
		frm.action = "OrderForm";
		frm.submit();
	

}

function showTab(chk) {
	var obj1 = document.getElementById("desc");
	obj1.style.display = "none"; 
	var obj2 = document.getElementById("review");
	obj2.style.display = "none";
	
	var obj3 = document.getElementById(chk);
	obj3.style.display = "block";
	
}
</script>
<style>
#info td { font-size:1.5em; }
#cnt { width:20px; text-align:right; }
.smt { width:150px; height:30px; }
#review { display:none; }
h2,h3 {
       margin-bottom: 20px;
       text-align: center;
   }
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<br />

<table width="800" cellpading="5" align="center">
<tr align="center">
<td width="35%">
<!-- 이미지 관련 영역 -->
	<table width="100%" cellpading="5" border="1" >
	<tr><td colspan="3" align="center">
		<img src="resources/img/<%=productInfo.getPi_img1() %>" width="260" height="230" id="bigImg" />
	</td></tr>
	<tr align="center">
	<td width="33.3%">
		<img src="resources/img/<%=productInfo.getPi_img1() %>" width="80" height="80" onclick="swapImg('<%=productInfo.getPi_img1() %>');"/>
	</td>
	<td width="33.3%">
<% if (productInfo.getPi_img2() != null && !productInfo.getPi_img2().equals("")) { %>		
		<img src="resources/img/<%=productInfo.getPi_img2() %>" width="80" height="80" onclick="swapImg('<%=productInfo.getPi_img2() %>');"/>
<% } %>			
	</td>
	<td width="33.3%">
<% if (productInfo.getPi_img3() != null && !productInfo.getPi_img3().equals("")) { %>		
		<img src="resources/img/<%=productInfo.getPi_img3() %>" width="80" height="80"onclick="swapImg('<%=productInfo.getPi_img3() %>');" />
<% } %>	
		
	</td></tr>
	</table>
	</td>
<td width="*" valign="top" >
<!-- 상품 관련 영역 -->
	<form name="frm" method="post">
	<input type="hidden" name="kind" value="d" />
	<input type="hidden" name="piid" id = "piid" value="<%=productInfo.getPi_id() %>" />
	<table width="100%" cellpading="5" id="info">
	<tr><td colspan="2">&nbsp;&nbsp;&nbsp;
		상품 분류 :	<%=productInfo.getPcs_name() %>
	</td></tr>
	
	<tr>
	<td width="30%" align="right">상품명 : </td>
	<td width="*"><%=productInfo.getPi_name() %></td>
	</tr>
	<tr><td align="right">가격 : </td><td><%=price %></td></tr>	
	<tr><td align="right">남은 수량  : </td><td> ( <%=productInfo.getPi_stock() %> ) </td></tr>	
	<tr><td align="right">좋아요 수 : </td><td>( <%=productInfo.getPi_good() %> )</td>
	<td align="right"><img src="resources/img/like.png" width="40" title="좋아요" class="hand" onclick="liek();" /></td></tr>	
	<tr>
	<td align="right">옵션 : </td>
	<td>
		<select name="size" id="size">
			<option value="">사이즈선택</option>
			<option value="<%=productInfo.getPi_size() %>">f</option>
		</select>
	</td>
	</tr>
	<tr>
	<td align="right">수량 : </td>
	<td>
		<input type="button" value="-" onclick="setCnt(this.value);" />
		<input type="text" name="cnt" id="cnt" value="1" readonly="readonly" />
		<input type="button" value="+" onclick="setCnt(this.value);" />
	</td>
	</tr>
	<tr><td colspan="2" align="right">
		구매 가격 : <span id="total" ><%=realPrice %></span>원
	</td></tr>	
	<tr><td colspan="2" align="center">
		<input type="button" value="결제하기 " class="smt" onclick="buy('d');"  class="btn btn-primary btn-block" />
                <small class="text-danger">결제는 로그인 후 가능합니다.</small>
	</td></tr>	
	</table>
	</form>
</td>
</tr>
</table>
<hr />
<div align="center">
<input type="button" value="상품설명" onclick="showTab('desc');" />
<input type="button" value="구매후기" onclick="showTab('review');"/><br />
<div id="desc" >
	<img src="resources/img/<%=productInfo.getPi_desc() %>" width="700" height="800" />
</div>
<div id="review">
	<iframe width="560" height="315" src="https://www.youtube.com/embed/zS_UgqhSS50?si=Pcz22JlsjMwC0Taj" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
	<iframe width="560" height="315" src="https://www.youtube.com/embed/1DQbQmfSOxA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</div>
</div>
<hr />
<p style="width:1400px; text-align:center;">
<input type="button" value="상품 목록" onclick="location.href='ProductProc';">
</p>
<%@ include file="../inc/incFoot.jsp" %>