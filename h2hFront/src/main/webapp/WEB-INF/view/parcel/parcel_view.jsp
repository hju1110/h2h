<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menuBar.jsp" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%
ParcelInfo pi = (ParcelInfo)request.getAttribute("parcelInfo");

String ss = pi.getOi_status();
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문</title>
<style>
   body {
       font-family: Arial, sans-serif;
       line-height: 1.6;
   }

   h2,h3 {
       margin-bottom: 20px;
       text-align: center;
   }

   table {
       width: 800px;
       border-collapse: collapse;
       border: 1px solid #ddd;
       margin: 0 auto;
   }

   th, td {
       padding: 10px;
       border: 1px solid #ddd;
   }

   th {
       background-color: #f2f2f2;
   }

   td input[type="text"], textarea {
       border: none;
       width: 100%;
       background-color: transparent;
       resize: none;
   }

   textarea {
       height: 100px;
   }

   hr {
       border: none;
       height: 1px;
       background-color: #ddd;
       margin: 20px 0;
   }

   img {
       width: 100px;
       height: 90px;
   }

   p {
       width: 1750px;
       text-align: center;
       margin-bottom: 30px;
   }
</style>
</head>
<body>
<br/>
<h2>주문</h2>
<h3>주문자 정보</h3>
<form name="frmOrder" action="orderProcIn" method="post">
    <table>
        <tr>
            <th width="25%">주문상태</th>
            <td><%=status %></td>
        </tr>
        <tr>
            <th width="25%">이름</th>
            <td>
                <input type="text" name="mi_name" value="<%=loginInfo.getMi_name() %>" disabled="disabled"/>
            </td>
        </tr>
        <tr>
            <th width="25%">이메일</th>
            <td>
                <input type="text" name="mi_email" value="<%=loginInfo.getMi_email() %>" disabled="disabled"/>
            </td>
        </tr>
        <tr>
            <th width="25%">연락처</th>
            <td>
                <input type="text" name="mi_phone" value="<%=loginInfo.getMi_phone() %>" disabled="disabled"/>
            </td>
        </tr>
    </table>
    <h3>배송지 정보</h3>
    <table>
        <tr>
            <th width="15%">주소명</th>
            <td width="35%">
                <input type="text" name="ma_name" value="기본주소" readonly="readonly" onfocus="this.blur();" disabled="disabled"/>
            </td>
            <th width="15%">수취인 명</th>
            <td width="35%">
                <input type="text" name="oi_name" value="<%=pi.getOi_name() %>" disabled="disabled"/>
            </td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td>
                <input type="text" name="p2" value="<%=pi.getOi_phone() %>" disabled="disabled"/>
            </td>
            <th>우편번호</th>
            <td>
                <input type="text" name="oi_zip" value="<%=pi.getOi_zip() %>" size="5" maxlength="5" disabled="disabled"/>
            </td>
        </tr>
        <tr>
            <th>주소</th>
            <td colspan="3">
                <input type="text" name="oi_addr1" value="<%=pi.getOi_addr1() %>" size="40" disabled="disabled"/>
                <input type="text" name="oi_addr2" value="<%=pi.getOi_addr2() %>" size="40" disabled="disabled"/>
            </td>
        </tr>
        <tr>
            <th>요청사항</th>
            <td colspan="3">
                <textarea rows="5" cols="50" name="oi_memo" disabled="disabled">
                    <%=pi.getOi_memo()%>
                </textarea>
            </td>
        </tr>
    </table>
    <hr />
    <h3>결제 정보</h3>
    <hr />
    <h3>구매할 상품 목록</h3>
    <table>
        <tr align="center">
            <td width="20%"><img src="resources/img/<%=pi.getPi_img1() %>" alt="<%=pi.getPi_name() %> 이미지" /></td>
            <td width="20%">상품명 : <%=pi.getPi_name() %></td>
            <td colspan="5" align="right">총 결제 금액 : <%=pi.getOi_pay() %>원</td>
        </tr>
    </table>
    <hr />
    <p>
    <input type="button" value="목록" onclick="location.href='ParcelProc';">
    </p>
</form>
</body>
</html>
