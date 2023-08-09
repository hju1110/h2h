<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
ProductInfo productInfo = (ProductInfo)request.getAttribute("productInfo");
// 화면에서 보여줄 상품 정보들을 저장한ProductInfo 형 인스턴스를 받아옴
ArrayList<ProductStock> stockList = productInfo.getStockList();
// ProductInfo 에 들어있는 옵션별 재고량 목로을 받아옴
ArrayList<ReviewList> reviewList = (ArrayList<ReviewList>)request.getAttribute("reviewList");
// 해당 상품의 구매 후기 목록을 받아옴
long realPrice = productInfo.getPi_price();		 //수량 변경에 따른 가격 연산을 위한 변수 
String price = productInfo.getPi_price() + "원";	 //가격 출력을 위한 변수
if (productInfo.getPi_dc() > 0) {				 // 할인율이 있으면
	realPrice = Math.round(realPrice * (1 - productInfo.getPi_dc()));
	price = "<del>" + productInfo.getPi_price() + "</del>&nbsp;&nbsp;&nbsp;" + price;	
}
%>
<style>
#info td { font-size:1.5em; }
#cnt { width:20px; text-align:right; }
.smt { width:150px; height:30px; }
#review { display:none; }
</style>
<script>
function swapImg(img) {
	var big = document.getElementById("bigImg");
	//큰 이미지를보여주는 img태그를 big테그를 가져옴
	big.src = "/mvcSite/product/pdt_img/" + img;
}

function setCnt(op) {
	var price = <%=realPrice %>;
	var frm = document.frm;
	var size = frm.size.value;	// 10:150 -> ps_idx:ps_stock 이라는 뜻
	
	if (size != "") {
		var cnt = parseInt(frm.cnt.value);
		var max = size.substring(size.indexOf(":") + 1);
		if (max >= 10) max = 10;			//재고가 10이상일 경우 10을 최대값으로 지정
	
		if (op == "+" && cnt < max)		frm.cnt.value = cnt + 1;
		else if (op == "-" && cnt > 1) 	frm.cnt.value = cnt - 1;
		
		var total = document.getElementById("total");
		total.innerHTML = price * frm.cnt.value;
	} else {
		alert("옵션을 먼저 선택하세요.");
	}
}

function buy(kind) {
<% if (isLogin) { %>
	var frm = document.frm;
	var size = frm.size.value;
	var cnt = frm.cnt.value;
	if (size == "") { alert("옵션(사이즈)을 선택하세요."); return; }
	
	//
	if (kind == "c") {	// 장바구니 담기일 경우
		$.ajax ({
			type : "POST", url : "/mvcSite/cartProcIn",
			data : {"piid" : "<%=productInfo.getPi_id() %>", "psidx" : size, "cnt" : cnt},
			success : function(chkRs) {
				if (chkRs == 0) {		// 장바구니 담기에 실패했을경우.
					alert("장바구니 담기에 실패했습니다. \n 다시시도해보세요.");
					return;
				} else {			// 장바구니 담기에 성공했을경우.					
					if (confirm("장바구니에 담았습니다\n 장바구니로 이동하시겠습니까?")) {
						
						location.href = "cartView";	
					}
				}
			}
		});
	} else {		// 바로 구매하기일 경우
		frm.action = "orderForm";
		frm.submit();
	}
<% } else { %>
	location.href="login_form?url=/mvcSite/productView?piid=<%=productInfo.getPi_id() %>";
<% }%>
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
<h2>상품 상세 화면</h2>
<table width="800" cellpading="5">
<tr align="center">
<td width="35%">
<!-- 이미지 관련 영역 -->
	<table width="100%" cellpading="5" border="1">
	<tr><td colspan="3" align="center">
		<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_img1() %>" width="260" height="230" id="bigImg" />
	</td></tr>
	<tr align="center">
	<td width="33.3%">
		<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_img1() %>" width="80" height="80" onclick="swapImg('<%=productInfo.getPi_img1() %>');"/>
	</td>
	<td width="33.3%">
<% if (productInfo.getPi_img2() != null && !productInfo.getPi_img2().equals("")) { %>		
		<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_img2() %>" width="80" height="80" onclick="swapImg('<%=productInfo.getPi_img2() %>');"/>
<% } %>			
	</td>
	<td width="33.3%">
<% if (productInfo.getPi_img3() != null && !productInfo.getPi_img3().equals("")) { %>		
		<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_img3() %>" width="80" height="80"onclick="swapImg('<%=productInfo.getPi_img3() %>');" />
<% } %>	
		
	</td></tr>
	</table>
	</td>
<td width="*" valign="top" >
<!-- 상품 관련 영역 -->
	<form name="frm" method="post">
	<input type="hidden" name="kind" value="d" />
	<input type="hidden" name="piid" value="<%=productInfo.getPi_id() %>" />
	<table width="100%" cellpading="5" id="info">
	<tr><td colspan="2">&nbsp;&nbsp;&nbsp;
		<a href="productList?pcb=<%=productInfo.getPcs_id().substring(0, 2) %>"><%=productInfo.getPcb_name() %></a> ->
		<a href="productList?pcb=<%=productInfo.getPcs_id().substring(0, 2) %>&pcs=<%=productInfo.getPcs_id() %>">
		<%=productInfo.getPcs_name() %></a>
	</td></tr>
	
	<tr>
	<td width="20%" align="right">상품명 : </td>
	<td width="*"><%=productInfo.getPi_name() %></td>
	</tr>
	
	<tr><td align="right">브랜드 : </td><td><%=productInfo.getPb_name() %></td></tr>
	<tr><td align="right">제조사 : </td><td><%=productInfo.getPi_com() %></td></tr>
	<tr><td align="right">가격 : </td><td><%=price %></td></tr>	
	<tr>
	<td align="right">옵션 : </td>
	<td>
		<select name="size">
			<option value="">사이즈선택</option>
<%
for (ProductStock ps : stockList) {
	String opt = ps.getPs_size() + "mm (재고 :" + ps.getPs_stock() + "개)";
	String disabled = "";
	if (ps.getPs_stock() <= 0) {
		disabled = " disabled=\"disabled\"";
		opt = ps.getPs_size() + " mm (재고없음 : 품절)";
	}
	out.println("<option value='" + ps.getPs_idx() + ":" + ps.getPs_stock() + "'" + disabled + ">" + opt + "</option>");
}
%>
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
		구매 가격 : <span id="total"><%=realPrice %></span>원
	</td></tr>	
	<tr><td colspan="2" align="center">
		<input type="button" value="장바구니 담기" class="smt" onclick="buy('c');" />
		<input type="button" value="바로 구매하기 " class="smt" onclick="buy('d');" />
	</td></tr>	
	</table>
	</form>
</td>
</tr>
</table>
<hr />
<input type="button" value="상품설명" onclick="showTab('desc');"/>
<input type="button" value="구매후기" onclick="showTab('review');"/><br />
<div id="desc" >
	<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_desc() %>" width="700" height="1000" />
</div>
<div id="review">
	<iframe width="560" height="315" src="https://www.youtube.com/embed/fA01LNcFopA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
	<iframe width="560" height="315" src="https://www.youtube.com/embed/1DQbQmfSOxA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</div>
</body>
</html>