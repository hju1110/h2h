<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>주문확인/배송조회</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
       
        }

        h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #efefef;
        }

        .status {
            color: red;
        }

        .price {
            color: blue;
        }
    </style>
</head>
<body>
<br/>
<h2>주문확인/배송조회</h2>
<hr />
<% 
    List<OrderProcInCtrl> parcelList = (List<OrderProcInCtrl>)request.getAttribute("parcelList");

    String lnk = "";
    boolean hasOrders = false;
    for (OrderProcInCtrl oc : parcelList) {		
        if (loginInfo.getMi_id().equals(oc.getMi_id())) {
            String price = oc.getOi_pay() + "원";
            lnk = "ParcelView?piid=" + oc.getPi_id() + "&oi_id=" + oc.getOi_id();

            String ss = oc.getOi_status();
            String status = "";
            if (ss.equals("a")) {
                status = "상품준비중";
            } else if (ss.equals("b")) {
                status = "발송완료";
            } else if (ss.equals("c")) {
                status = "배송완료";
            } else {
                status = "주문취소";
            }
%>
    <% hasOrders = true; %>
    <table>
        <tr>
            <th width="20%">주문 날짜:</th>
            <td><%=oc.getOi_date() %></td>
        </tr>
        <tr>
            <th>주문번호:</th>
            <td><%=oc.getOi_id() %></td>
        </tr>
        <tr>
            <th>주문상태:</th>
            <td class="status"><%=status %></td>
        </tr>
        <tr>
            <th>주문자:</th>
            <td><%=oc.getOi_name() %></td>
        </tr>
        <tr>
            <th>가격:</th>
            <td class="price"><%=price %></td>
        </tr>
        <tr>
            <td colspan="2">
                <a href="<%=lnk %>">
                    상품 상세보기
                </a>
            </td>
        </tr>
    </table>
    <hr />
<%     
        }
    }

    if (!hasOrders) { 
%>
    <h2>주문한 상품이 없습니다</h2>
<%
    }
%>
</body>
</html>
<%@ include file="../_inc/inc_foot.jsp" %>