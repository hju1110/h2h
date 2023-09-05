<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ include file="../inc/incHead.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<ProductInfo> productList = (List<ProductInfo>)request.getAttribute("productList");
String name = "", chkBrd = "", sp = "", ep = "", sch = pageInfo.getSch();
//상품명 브랜드 시작가 종료가 
if (sch != null && !sch.equals("")) {
//검색조건 : &sch=ntest,bB1:B2:B3,p100000~200000
	String[] arrSch = sch.split(",");
	for (int i = 0 ; i < arrSch.length ; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'n') {				// 상품명 검색일 경우('n'검색어)
			name =  arrSch[i].substring(1);
		} else if (c == 'b') {		// 브랜드 검색일 경우(b브랜드1:브랜드2)
			chkBrd =  arrSch[i].substring(1);			
		} else if (c == 'p') {		// 가격대 검색일 경우 (p시작가~종료가)
			sp =  arrSch[i].substring(1,  arrSch[i].indexOf('~'));
			ep =  arrSch[i].substring(arrSch[i].indexOf('~') + 1);
		}
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta >
<title>상품 목록</title>
    <div class="hero-wrap" style="background-image: url('/h2hFront/resources/img/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Shopping	</h1>
          </div>
        </div>
      </div>
    </div>
<style>
    body {
        font-family: Arial, sans-serif;
       
    }
    h2 {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
    }
    hr {
        border: 1px solid #ddd;
        margin: 20px 0;
    }
    table {
        width: 800px;
        margin: 0 auto;
        border-collapse: collapse;
    }
    td {
        padding: 10px;
        text-align: center;
    }
    a {
        text-decoration: none;
    }
    img {
        width: 150px;
        height: 150px;
        border: none;
    }
    .saleStok {
        font-size: 0.8em;
    }
    p {
        text-align: center;
    }
</style>
</head>
<body>
<br />
 <h1 class="text-center text-primary ftco-animate mb-3">상품목록</h1>
<hr />
<table>
<tr>
    <td valign="top">
        <!-- 상품 목록 및 페이지 영역  -->
    <% if (pageInfo.getRcnt() > 0) { %>
    <p align="right">
        <select name="ob" onchange="location.href='ProductProc?cpage=1<%= pageInfo.getSchargs() + pageInfo.getVargs() %>&ob=' + this.value;">
            <option value="a" <% if (pageInfo.getOb().equals("a")) { %>selected="selected"<% } %>>신상품 순</option>
            <option value="b" <% if (pageInfo.getOb().equals("b")) { %>selected="selected"<% } %>>인기 순</option>
            <option value="c" <% if (pageInfo.getOb().equals("c")) { %>selected="selected"<% } %>>낮은 가격순</option>
            <option value="d" <% if (pageInfo.getOb().equals("d")) { %>selected="selected"<% } %>>높은 가격순</option>
            <option value="e" <% if (pageInfo.getOb().equals("e")) { %>selected="selected"<% } %>>조회수 높은순</option>
            <option value="f" <% if (pageInfo.getOb().equals("f")) { %>selected="selected"<% } %>>좋아요 많은 순</option>
        </select>
    </p>
    <hr />
    <table width="100%" cellpadding="10" cellspacing="0">
        <%
        int i = 0;
        for (i = 0; i < productList.size(); i++) {
            ProductInfo pi = productList.get(i);
            String Stock = pi.getPi_stock() > 0 ? pi.getPi_stock() + "ea" : "품절(SOLD OUT)";
            String lnk = "ProductView?piid=" + pi.getPi_id();
            String price = pi.getPi_price() + "원";
            if (i % 4 == 0) { %>
        <tr>
            <% } %>
            <td width="25%" align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
                <a href="<%=lnk %>">
                    <img src="resources/img/<%=pi.getPi_img1() %>" alt="<%=pi.getPi_name() %> 이미지" />
                    <br /><%=pi.getPi_name() %>
                </a>
                <br />
                <span class="saleStok">판매 : <%=price %> / 재고 : <%=Stock %></span>
            </td>
            <% if (i % 4 == 3) { %>
        </tr>
        <% }
        }
        if (i % 4 > 0) {
            for (int j = 0; j < (4 - (i % 4)); j++) { %>
        <td width="25%"></td>
        <% }
        } %>
    </table>
    <p>
        <% 
        String qs = pageInfo.getSchargs() + pageInfo.getObargs() + pageInfo.getVargs();
        //페이징 영역 링크에서 사용할 쿼리 스트링의 공통 부분 (검색조건들, 정렬방식, 보기방식)
        if (pageInfo.getCpage() > 1) { %>
        <a href='ProductProc?cpage=1<%= qs %>'>&lt;&lt;</a>&nbsp;&nbsp;
        <a href='ProductProc?cpage=<%= pageInfo.getCpage() - 1 %><%= qs %>'>&lt;</a>&nbsp;&nbsp;
        <% }
        //페이징 번호
        int spage = (pageInfo.getCpage() - 1) / pageInfo.getBsize() * pageInfo.getBsize() + 1;
        for (int k = 1, j = spage; k <= pageInfo.getBsize() && j <= pageInfo.getPcnt(); k++, j++) {
            if (j == pageInfo.getCpage()) {
                out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
            } else {
                out.println("&nbsp;<a href='ProductProc?cpage=" + j + qs + "'>" + j + "</a>&nbsp;");
            }
        }
        if (pageInfo.getCpage() < pageInfo.getPcnt()) { %>
        &nbsp;<a href='ProductProc?cpage=<%= pageInfo.getCpage() + 1 %><%= qs %>'>&gt;</a>
        &nbsp;&nbsp;<a href='ProductProc?cpage=<%= pageInfo.getPcnt() %><%= qs %>'>&gt;&gt;</a>
        <% } %>
    </p>
    <% } else { %>
    <p>검색된 상품이 없습니다.</p>
    <% } %>
    </td>
</tr>
</table>
<%@ include file="../inc/incFoot.jsp" %>