<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%
AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function chk() {	
	  const oi_id = $('#oi_id').val(); const mi_id = $('#mi_id').val();const oi_addr1 = $('#oi_addr1').val();
	  const oi_addr2 = $('#oi_addr2').val(); const oi_zip = $('#oi_zip').val();const oi_memo = $('#oi_memo').val();
	  const oi_name = $('#oi_name').val(); const oi_phone = "010-" + $('#p2').val() + "-" + $('#p3').val();     			
	  $.ajax({
	    type: "POST",
	    url: "./orderProcUp",
	    data: {"oi_id": oi_id, "mi_id": mi_id, "oi_addr1": oi_addr1, "oi_addr2": oi_addr2, "oi_zip": oi_zip,
	      "oi_memo": oi_memo, "oi_name": oi_name, "oi_phone": oi_phone },
	    success: function(chkRs) {
	      if (chkRs != 1) {
	        alert("상품수정에 실패했습니다.");
	      } else {
	        alert("배송정보지가 수정되었습니다.");
	     }
    }
  });
}
function b() {	
  const oi_id = $('#oi_id').val(); const mi_id = $('#mi_id').val(); const oi_status = $('#oi_status').val();
  $.ajax({
    type: "POST",
    url: "./orderProcB",
    data: {"oi_id": oi_id, "mi_id": mi_id, "oi_status": oi_status },
    success: function(chkRs) {
      if (chkRs != 1) {
        alert("주문 확정 처리 실패했습니다.");
      } else {
        alert("주문 확정 되었습니다.");
        location.reload(); // 배송 완료 후 페이지를 리로드합니다.
      }
    }
  });
}

function c() {	
  const oi_id = $('#oi_id').val(); const mi_id = $('#mi_id').val(); const oi_status = $('#oi_status').val();
  $.ajax({
    type: "POST",
    url: "./orderProcC",
    data: {"oi_id": oi_id, "mi_id": mi_id, "oi_status": oi_status },
    success: function(chkRs) {
      if (chkRs != 1) {
        alert("배송 완료 처리 실패했습니다.");
      } else {
        alert("배송 완료 되었습니다.");
        location.reload(); // 배송 완료 후 페이지를 리로드합니다.
      }
    }
  });
}

function d() {	
	  const oi_id = $('#oi_id').val(); const mi_id = $('#mi_id').val(); const pi_id = $('#pi_id').val();
	  const oi_pay = $('#oi_pay').val();
	  $.ajax({
	    type: "POST",
	    url: "./orderProcD",
	    data: {"oi_id": oi_id, "mi_id": mi_id, "pi_id": pi_id, "oi_pay" : oi_pay},
	    success: function(chkRs) {
	      if (chkRs != 4) {
	        alert("주문 취소 처리 실패했습니다."); 
	      } else {
	        alert("주문 취소 되었습니다.");
	        location.href = "ParcelProc";
	      }
	  }
  });
}
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문 현황 상세보기</title>
<style>
    body {
        font-family: Arial, sans-serif;
     
    }
    h2 {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
    }
    h3 {
        text-align: center;
        font-size: 18px;
        font-weight: bold;
    }
    table {
        width: 800px;
        margin: 0 auto;
        border-collapse: collapse;
        margin-bottom: 20px;
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
        margin: 20px 0;
    }
    input[type="text"], textarea {
        width: 100%;
        padding: 5px;
    }
    textarea {
        resize: vertical;
    }
    input[type="submit"], input[type="button"] {
        width: 120px;
        height: 30px;
        background-color: #007bff;
        color: #fff;
        border: none;
        cursor: pointer;
        margin: 5px;
    }
    .info-table th, .info-table td {
        border: 1px solid #ddd;
    }
    .info-table th {
        width: 25%;
    }
    .info-table td {
        width: 75%;
    }
</style>
</head>
<body>
<div class="left">
<h2>주문 현황 상세보기</h2>
<h3>주문자 정보</h3>
<table class="info-table">
     <tr>      
        <th>주문상태</th>
        <td><span style="color: orange;"><%= status %></span></td>
    </tr>
    <tr>
        <th>상품명</th>
        <td><%=pi.getPi_name() %></td>
   </tr>
    <tr>
        <th>이름</th>
        <td><input type="text" name="mi_name" value="<%=pi.getMi_id() %>" style="border:none;"/></td>
    </tr>
    <tr>
        <th>연락처</th>
        <td><input type="text" name="mi_phone" value="<%=pi.getOi_phone()%>" style="border:none;"/></td>
    </tr>
</table>

<!-- 배송지 정보 -->
<h3>배송지 정보</h3>
<table class="info-table">
    <tr>
        <th>수취인 명</th>
        <td>
            <input type="text" name="oi_name" id="oi_name" value="<%=pi.getOi_name() %>" style="width: 250px;" />
        </td>
    </tr>
    <tr>
        <th>전화번호</th>
        <td colspan="3">
            010 - <input type="text" name="p2" id="p2" value="<%=pi.getOi_phone().substring(4,8) %>" maxlength="4" size="4" style="width: 60px;"/> 
            - <input type="text" name="p3" id="p3" value="<%=pi.getOi_phone().substring(9) %>" maxlength="4" size="4" style="width: 60px;"/>
        </td>
        <th>우편번호</th>
        <td>
            <input type="text" name="oi_zip" id="oi_zip" value="<%=pi.getOi_zip() %>" size="5" maxlength="5" style="width: 120px;"/>
        </td>
    </tr>
    <tr>
        <th>주소</th>
        <td colspan="5">
            <input type="text" name="oi_addr1" id="oi_addr1" value="<%=pi.getOi_addr1() %>" size="80"  style="width: 550px;"/>
        </td>
    </tr>
    <tr>
        <th></th>
        <td colspan="5">
            <input type="text" name="oi_addr2" id="oi_addr2" value="<%=pi.getOi_addr2() %>" size="80" style="width: 550px;"/>
        </td>
    </tr>
    <tr>
        <th>요청사항</th>
        <td colspan="5">
            <textarea rows="5" cols="80" name="oi_memo" id="oi_memo"><%=pi.getOi_memo() %></textarea>
        </td>
    </tr>
</table>
<input type="hidden" value="<%=pi.getOi_status() %>"  id="oi_status" name="oi_status" />
<input type="hidden" value="<%=pi.getMi_id() %>"  id="mi_id" name="mi_id" />
<input type="hidden" value="<%=pi.getOi_id() %>"  id="oi_id" name="oi_id" />
<input type="hidden" value="<%=pi.getPi_id() %>"  id="pi_id" name="pi_id" />
<input type="hidden" value="<%=pi.getOi_pay() %>"  id="oi_pay" name="oi_pay" />
<p style="text-align:center;">
<input type="button" value="수정하기" name="chk" id="chk" onclick="chk();" />
</p>
<hr />

<h3>결제 정보</h3>
<hr />

<h3>구매할 상품 목록</h3>
<!-- 상품 목록 테이블 -->
<table width="800" cellpadding="5">
    <tr align="center">
        <td width="15%">
            <img src="resources/img/<%=pi.getPi_img1() %>" width="100" height="90" />
        </td>
        <td width="15%">
            상품명 : <%=pi.getPi_name() %>
        </td>
        <td width="25%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="ParcelProc">목록</a><br />
        </td>
    </tr>
    <tr>
        <td colspan="5" align="right">총 결제 금액 : <%=pi.getOi_pay() %>원</td>
    </tr>
</table>

<hr />
<!-- 주문 취소, 주문 확정, 배송 완료 버튼 -->
<p style="text-align:center;">
    <input type="submit" value="주문취소" name="d" id="d" onclick="d();"/>
    <input type="button" value="주문확정" name="b" id="b" onclick="b();" />
    <input type="button" value="배송완료" name="c" id="c" onclick="c();" />
</p>
<hr />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</div>
</body>
</html>