<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<%
AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
List<OrderProcInCtrl> parcelList = (List<OrderProcInCtrl>)request.getAttribute("parcelList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pi");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문확인/배송조회</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    h2 {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
    }
    table {
        width: 100%;
        margin: 0 auto;
        border-collapse: collapse;
    }
    th, td {
        padding: 10px;
        text-align: left;
    }
    a {
        color: #007bff;
        text-decoration: none;
    }
    hr {
        border: 1px solid #ddd;
    }
    form {
        text-align: right;
    }
    fieldset {
        border: 1px solid #ddd;
        padding: 10px;
    }
    legend {
        font-size: 16px;
        font-weight: bold;
        padding: 0 5px;
    }
    input[type="submit"], input[type="button"] {
        width: 100px;
        height: 30px;
        background-color: #007bff;
        color: #fff;
        border: none;
        cursor: pointer;
    }
</style>
</head>
<body>
<div class="left">
    <h2>주문확인/배송조회</h2>
    <hr />
    <table>
        <% 
        String lnk = "";
        if (parcelList.size() > 0) {
        for (OrderProcInCtrl oc : parcelList) {       
                    String price = oc.getOi_pay() + "원";
                    lnk = "ParcelView?piid=" + oc.getPi_id() + "&oi_id=" + oc.getOi_id();
        %>  
        <tr>
            <td>
                <strong>주문 날짜:</strong> <%=oc.getOi_date() %><br>
                <strong>상품명:</strong> <%=oc.getPi_id() %>&nbsp;&nbsp;&nbsp;&nbsp;<strong>주문번호:</strong> <%=oc.getOi_id() %><br>
                <strong>가격:</strong> <%=price %><br>
                <strong>주문자:</strong> <%=oc.getOi_name() %>&nbsp;&nbsp;&nbsp;&nbsp;<strong>아이디:</strong> <%=oc.getMi_id() %><br>
                <a href="<%=lnk %>">주문 상세보기</a>
            </td>
        </tr>
        <tr>
            <td><hr /></td>
        </tr>
        <% }
        } else {  %>
        <tr>
            <td>
                <h2>주문한 상품이 없습니다.</h2>
            </td>
        </tr>
        <% } %>
    </table>
    <table width="700">
        <tr>
            <td align="right">
                <form name="frmSch" method="get">
                    <fieldset>
                        <legend>게시판 검색</legend>
                        <select name="schtype">
                            <option value="">검색조건</option>
                            <option value="oi_name" <% if (pageInfo.getSchtype().equals("oi_name")) { %> selected="selected"<% } %>>수취인명</option>
                            <option value="mi_id" <% if (pageInfo.getSchtype().equals("mi_id")) { %> selected="selected"<% } %>>회원 ID</option>
                            <option value="pi_id" <% if (pageInfo.getSchtype().equals("pi_id")) { %> selected="selected"<% } %>>상품 ID</option>
                        </select>
                        <input type="text" name="keyword" value="<%=pageInfo.getKeyword() %>" />
                        <input type="submit" value="검색" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" value="전체 글보기" onclick="location.href='ParcelProc'" />
                    </fieldset>
                </form>
            </td>
        </tr>
    </table>
  </div>  
</body>
</html>