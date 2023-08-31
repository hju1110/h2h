<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%
request.setCharacterEncoding("utf-8");
List<OrderCart> pdtList = (List<OrderCart>)request.getAttribute("pdtList");
List<MemberAddr> addrList = (List<MemberAddr>)request.getAttribute("addrList");
String pi_id = (String)request.getAttribute("pi_id");

if (pdtList.size() == 0) {
    out.println("<script>");
    out.println("alert('잘못된 경로로 들어오셨습니다.');");
    out.println("history.back();");
    out.println("</script>");    
    out.close();
} 
%>
<script>
function chAddr(val) {
    var frm = document.frmOrder;
    var arr = val.split("|");
    var phone = arr[2].split("-");
    
    frm.ma_name.value = arr[0];
    frm.oi_name.value = arr[1];
    frm.p2.value = phone[1];
    frm.p3.value = phone[2];
    frm.oi_zip.value = arr[3];
    frm.oi_addr1.value = arr[4];
    frm.oi_addr2.value = arr[5];
    
    // 배송지 정보를 선택할 때마다 기본 정보 삭제 체크박스 초기화
    frm.deleteDefaultAddress.checked = false;
}

function toggleDefaultAddress() {
    var frm = document.frmOrder;
    var isDefaultChecked = frm.deleteDefaultAddress.checked;
    var selectAddress = document.getElementById("selectAddress");
    
    if (isDefaultChecked) {
        // 기본 정보 삭제 체크박스가 선택된 경우, 배송지 정보 초기화
        frm.ma_name.value = "";
        frm.oi_name.value = "";
        frm.p2.value = "";
        frm.p3.value = "";
        frm.oi_zip.value = "";
        frm.oi_addr1.value = "";
        frm.oi_addr2.value = "";
        selectAddress.style.display = "none"; // 배송지 선택 셀렉트 박스 숨기기
    } else {
        // 기본 정보 삭제 체크박스가 선택 해제된 경우, 배송지 정보와 셀렉트 박스를 복원
        var selectedAddr = frm.selectAddress.value;
        chAddr(selectedAddr);
        selectAddress.style.display = "inline"; // 배송지 선택 셀렉트 박스 나타내기
    }
}
</script>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>주문</title>
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
    }
    th, td {
        padding: 5px;
        text-align: center;
    }
    input[type="text"], select {
        width: 100%;
        height: 25px;
        padding: 2px;
    }
    textarea {
        resize: vertical;
    }
    input[type="submit"] {
        width: 150px;
        height: 30px;
        background-color: #007bff;
        color: #fff;
        border: none;
        cursor: pointer;
    }
    hr {
        border: 1px solid #ddd;
        margin: 20px 0;
    }
    textarea {
        width: 100%;
    }
</style>
</head>
<body>
<br />
    <h2>주문자 정보</h2>
    <form name="frmOrder" action="orderProcIn" method="post">
        <input type="hidden" name="pi_id" value="<%=pi_id %>" />
        <table width="800" cellpadding="5" border="0">
            <tr>
                <th width="25%">이름</th>
                <td width="*">
                    <input type="text" name="mi_name" value="<%=loginInfo.getMi_name() %>" style="border:none;" readonly="readonly" />
                </td>
            </tr>
            <tr>
                <th width="25%">이메일</th>
                <td width="*">
                    <input type="text" name="mi_email" value="<%=loginInfo.getMi_email() %>" style="border:none;" readonly="readonly" />
                </td>
            </tr>
            <tr>
                <th width="25%">연락처</th>
                <td width="*">
                    <input type="text" name="mi_phone" value="<%=loginInfo.getMi_phone() %>" style="border:none;" readonly="readonly" />
                </td>
            </tr>
        </table>
        <h3>배송지 정보</h3>
        <table width="800" cellpadding="5" border="0">
            <tr>
                <th>배송지 선택</th>
                <td colspan="3">
                    <select style="width:400px; height:25px;" id="selectAddress" onchange="chAddr(this.value);">
                        <% 
                        String maname = "", marname = "", maphone = "", mazip = "", maaddr1 = "", maaddr2 = "";
                        boolean isDefault = false;

                        for (MemberAddr ma : addrList) { 
                            if (ma.getMa_basic().equals("y")) {        
                                isDefault = true;
                                maname = ma.getMa_name();
                                marname = ma.getMa_rname();
                                maphone = ma.getMa_phone();
                                mazip = ma.getMa_zip();
                                maaddr1 = ma.getMa_addr1();
                                maaddr2 = ma.getMa_addr2();
                            }
                            String val = ma.getMa_name() + "|" + ma.getMa_rname() + "|" + ma.getMa_phone() + "|" + 
                                        ma.getMa_zip() + "|" + ma.getMa_addr1()+ "|" + ma.getMa_addr2();
                            String txt = "[" + ma.getMa_zip() + "] " + ma.getMa_addr1() + " " + ma.getMa_addr2();
                            
                            out.println("<option value='" + val + "'>" + txt + "</option>");
                        }
                        %>
                    </select>
                    <label><input type="checkbox" name="deleteDefaultAddress" value="true" onchange="toggleDefaultAddress();" /> 기본 정보 삭제</label>
                </td>
            </tr>
            <tr>
                <th width="15%">주소명</th>
                <td width="35%">
                    <input type="text" name="ma_name" value="<%=maname %>" readonly="readonly" onfocus="this.blur();" style="border:none;"/>
                </td>
                <th width="15%">수취인 명</th>
                <td width="35%">
                    <input type="text" name="oi_name" value="<%=marname %>" />
                </td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>
                    <% String[] arr = maphone.split("-"); %>
                    010 - <input type="text"  name="p2" value="<%=arr[1] %>" size="4" maxlength="4"  style="width:50px"/> -
                    <input type="text"  name="p3" value="<%=arr[2] %>" size="4" maxlength="4" style="width:50px"/>
                </td>
                <th>우편번호</th>
                <td>
                    <input type="text" name="oi_zip" value="<%=mazip %>" size="5" maxlength="5"/>
                </td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    <input type="text" name="oi_addr1" value="<%=maaddr1 %>" size="40" />
                    <input type="text" name="oi_addr2" value="<%=maaddr2 %>" size="40" />
                </td>
            </tr>
            <tr>
                <th>요청사항</th>
                <td colspan="3">
                    <textarea rows="5" cols="50" name="oi_memo" placeholder="요청사항을 입력해주세요"></textarea>
                </td>
            </tr>
        </table>
        <hr />
        <h3>결제 정보</h3>
        <hr />
        <h3>구매할 상품 목록</h3>
        <table width="800" cellpadding="5">
            <%
            int total = 0;
            // 총 결제금액을 저장할 변수
            String ocidxs = "";
            // 장바구니 인덱스 번호들을 누적 저장할 변수
            int oc_cnt = 0;
            for (OrderCart oc : pdtList) {
                total += oc.getPi_price();
                ocidxs += "," + oc.getOc_idx();
            %>
            <tr align="center">
                <td width="15%">
                    <img src="resources/img/<%=oc.getPi_img1() %>" width="100" height="90" />
                </td>
                <td width="25%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
                    <%=oc.getPi_name() %>
                </td>
                <td width="20%">사이즈 : <%=oc.getPi_size()%></td>
                <td width="15%"><%=oc.getOc_cnt() %>개</td>
                <td width="*"><%=oc.getPi_price() %>원</td>
            </tr>
            <% 
                oc_cnt = oc.getOc_cnt(); 
            }
            ocidxs = ocidxs.substring(1);
            %>
            <tr>
                <td colspan="5" align="right">총 결제 금액 : <%=total %>원</td>
            </tr>
        </table>
        <hr />
        <input type="hidden" name="kind" value="<%=request.getParameter("kind") %>" />
        <input type="hidden" name="occnt" value="<%=oc_cnt %>" />
        <input type="hidden" name="ocidxs" value="<%=ocidxs %>" />
        <input type="hidden" name="total" value="<%=total %>" />
        <p style="width:1700px; text-align:center;">
            <input type="submit" value="결제하기" />
        </p>
    </form>
<footer class="ftco-footer ftco-section img pt-4 pb-4 custom">
    	<div class="overlay"></div>
      <div class="container">
        <div class="row">
          <div class="col-md-12 text-center">

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Hand2Hand &copy;<script>(new Date().getFullYear());</script> 이용약관 | 개인정보처리방침 | 오시는 길 | 고객센터 | 후원문의 | <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">3Jo</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>
    
<!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  <script src="/h2hFront/resources/js/jquery.min.js"></script>
  <script src="/h2hFront/resources/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/h2hFront/resources/js/popper.min.js"></script>
  <script src="/h2hFront/resources/js/bootstrap.min.js"></script>
  <script src="/h2hFront/resources/js/jquery.easing.1.3.js"></script>
  <script src="/h2hFront/resources/js/jquery.waypoints.min.js"></script>
  <script src="/h2hFront/resources/js/jquery.stellar.min.js"></script>
  <script src="/h2hFront/resources/js/owl.carousel.min.js"></script>
  <script src="/h2hFront/resources/js/jquery.magnific-popup.min.js"></script>
  <script src="/h2hFront/resources/js/aos.js"></script>
  <script src="/h2hFront/resources/js/jquery.animateNumber.min.js"></script>
  <script src="/h2hFront/resources/js/bootstrap-datepicker.js"></script>
  <script src="/h2hFront/resources/js/jquery.timepicker.min.js"></script>
  <script src="/h2hFront/resources/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/h2hFront/resources/js/google-map.js"></script>
  <script src="/h2hFront/resources/js/main.js"></script>
</body>
</html>