<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../_inc/inc_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
if (loginInfo == null) {
    response.setContentType("text/html; charset=utf-8");
    out.println("<script>");
    out.println("alert('로그인이 필요합니다.');");
    out.println("location.href='login';");
    out.println("</script>");   
    out.close();
}
String name = loginInfo.getMi_name();
String[] arrBirth = loginInfo.getMi_birth().split("-");
String birth = arrBirth[0] + "년" + arrBirth[1] + "월" + arrBirth[2] + "일";
String[] arrPhone = loginInfo.getMi_phone().split("-");
String p2 = arrPhone[1], p3 = arrPhone[2];
String[] arrEmail = loginInfo.getMi_email().split("@");
String e1 = arrEmail[0], e3 = arrEmail[1];
String memType = loginInfo.getMi_type();
String bnum = loginInfo.getMi_bnum();
String gname = loginInfo.getMi_gname();
String kind = request.getParameter("kind");	// 일반(a), 정기(b) 후원 여부
String ctgrName = "정기 후원";
if (kind.equals("a"))	ctgrName = "일반 후원";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DonationRequest</title>
<!-- Custom fonts for this template-->
<link href="/h2hFront/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="/h2hFront/resources/css/sb-admin-2.min.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
</head>
<body>
<div style=" margin-top:100px;" >
<h4><span style="color:red">01</span> 후원 분야 선택</h4>
<hr />
<form name="frmRequest" action="donaFinish" method="post">
<input type="hidden" name="uname" value="<%=name %>" />
<input type="hidden" name="memType" value="<%=memType %>" />
<input type="hidden" name="bnum" value="<%=bnum %>" />
<input type="hidden" name="gname" value="<%=gname %>" />
<table width="1000" cellpadding="10" border="0">
<tr>
	<th width="200">
		<input type="radio" name="chkType" id="a" value="a" style="font-size:20px;" onclick='checkOnlyOne(this)' 
		<% if(kind.equals("a")) { %>checked="checked"<% } %> />
		<label for="a">일반 후원</label>
	</th>
	<td width="*">
		<select style="font-size:20px;" name="money" id="price1" <% if(kind.equals("b")) { %>disabled="disabled"<% } %>>
			<option value="">선택</option>
			<option value="100,000">100,000</option>
			<option value="50,000">50,000</option>
			<option value="30,000">30,000</option>
			<option value="20,000">20,000</option>
			<option value="direct">직접입력</option>
		</select>
		<input type="text" name="cmoney" id="price2" size="10" style="font-size:20px; text-align:right;"
		<% if(kind.equals("b")) { %>disabled="disabled"<% } %> onkeyup="showPrice(this.value);" /> 원
	</td>
</tr>
<tr class="sponsor1">
	<th>- 피후원자 선택</th>
	<td>
		<select name="mdSponsor1" id="spon1" style="font-size:20px;">
			<option value="">선택</option>
			<option value="a행복한 손길">행복한 손길</option>
			<option value="b서울청소년 지원부">서울청소년 지원부</option>
			<option value="c즐거운 어린이집">즐거운 어린이집</option>
		</select>
	<!-- <input type="text" name="sponsora" id="spon2" size="20" style="font-size:20px; text-align:right;" /> -->
	</td>
</tr>
<tr>
	<th><input type="radio" name="chkType" id="b" value="b" style="font-size:20px;" onclick='checkOnlyOne(this)'  
	<% if(kind.equals("b")) { %>checked="checked"<% } %> />
		<label for="b" id="month">정기 후원</label></th>
	<td>
		<select style="font-size:20px;" name="money" id="price3" <% if(kind.equals("a")) { %>disabled="disabled"<% } %>>
			<option value="">선택</option>
			<option value="100,000">100,000</option>
			<option value="50,000">50,000</option>
			<option value="30,000">30,000</option>
			<option value="20,000">20,000</option>
			<option value="direct">직접입력</option>
		</select>
		<input type="text" name="cmoney" id="price4" size="10" style="font-size:20px; text-align:right;" 
			<% if(kind.equals("a")) { %>disabled="disabled"<% } %> onkeyup="showPrice(this.value);" /> 원
	</td>
</tr>
<tr class="sponsor2">
	<th>- 피후원자 선택</th>
	<td>
		<select name="mdSponsor2" id="spon3" style="font-size:20px;" >
			<option value="">선택</option>
			<option value="a행복한 손길">행복한 손길</option>
			<option value="b서울청소년 지원부">서울청소년 지원부</option>
			<option value="c즐거운 어린이집">즐거운 어린이집</option>
		</select>
<!-- 		<input type="text" name="sponsorb" id="spon4" size="20" style="font-size:20px; text-align:right;"  /> -->
	</td>
</tr>
</table>
<hr />
<h4><span style="color:red">02</span> 후원자 정보</h4>
<hr />
<table width="500" cellpadding="10" border="0">
<tr>
	<td width="*" style="margin-left:10px;"><span id="mdCtgr"><%=ctgrName %></span></td>
	<td width="*" style="border:1px solid black; border-top: none; border-bottom: none; border-right: none; 
		border-collapse:5px; "><span id="price"></span></td>
</tr>
<tr>
	<td width="100" style="border:1px solid black; border-top: none; border-bottom: none; border-left: none; 
		margin-left:10px;">피후원자</td>
	<td width="*" style="border:1px solid black; border-top: none; border-bottom: none; border-right: none; 
		tet"><span id="mdSponsor"></span></td>
</tr>
</table>
<hr/>
<table cellpadding="10">
<tr>
	<th>후원자 정보</th>
	<td><div>
		<p><%=name %></p>
		<p><%=birth %></p>
		<p>010 - 
			<input type="text" name="p2" size="4" maxlength="4" value="<%=p2 %>" 
				oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/> - 
			<input type="text" name="p3" size="4" maxlength="4" value="<%=p3 %>"
				oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
		</p>
		<% if (memType.equals("c")) { %><p><%=bnum %></p><% } %>
	</div></td>
</tr>
<tr class="al-first">
<th>이메일</th>
	<td>
	<input type="text" name="e1" id="e1" size="10" value="<%=e1 %>" /> @ 
	<select name="e2" id="e2">
		<option value="naver.com" <% if (e3.equals("naver.com")) { %>selected="selected"<% } %>>네이버</option>
		<option value="nate.com" <% if (e3.equals("nate.com")) { %>selected="selected"<% } %>>네이트</option>
		<option value="gmail.com" <% if (e3.equals("gmail.com")) { %>selected="selected"<% } %>>지메일</option>
		<option value="direct">직접 입력</option>
	</select>
	<input type="text" name="e3" id="e3" size="10" value="<%=e3 %>" />
	</td>
</tr>
</table>
<hr />
<table width="1000" cellpadding="10" border="0">
<tr><th colspan="3">이용약관, 개인정보 수집 및 이용, Hand2Hand 활동 안내 수신에 모두 동의합니다.</th></tr>
<tr>
	<td colspan="2">이용약관(필수)&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight:bold"><a href="">보기</a></span></td>		
	<td style="padding-left:20px;"><label for="aChkAll">
		전체 동의</label>&nbsp;&nbsp;&nbsp;<input type="checkbox" name="aChkAll" id="aChkAll" />
	</td>
</tr>
<tr>
	<td colspan="2">개인정보 수집 및 이용(필수)&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight:bold"><a href="">보기</a></span></td>
	<td style="padding-left:100px;"><label for="aChk1"><input type="checkbox" name="aChk" id="aChk1" /></label></td>
</tr>
<tr>
	<td width="60%">
		Hand2Hand 활동 안내 수신에 동의합니다(선택)<span style="margin-left:50px; font-weight:bold"><a href="">보기</a></span>
	</td>
	<td width="25%">
		<label for="amobile"><input type="checkbox" name="aChk" id="choose" />&nbsp;&nbsp;모바일</label>
		<label for="aemil"><input type="checkbox" name="aChk" id="choose" />&nbsp;&nbsp;이메일</label>
		<label for="aaddr"><input type="checkbox" name="aChk" id="choose" />&nbsp;&nbsp;우편</label>
	</td>
	<td width="*" style="padding-left:100px;">
		<label for="aChk2"><input type="checkbox" name="aChk" id="aChk2" /></label>
	</td>
</tr>
<tr>
	<td colspan="2">후원 미완료 시 연락 수신에 동의합니다(선택)&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight:bold"><a href="">보기</a></span></td>
	<td style="padding-left:100px;"><label for="aChk3"><input type="checkbox" name="aChk" id="aChk3" /></label></td>
</tr>
</table>
<hr />
<h4><span style="color:red">03</span> 결제 및 신청완료</h4>
<hr />
<table cellpadding="10">
<tr>
	<td width="100" style="border:1px solid black; border-top: none; border-bottom: none; border-left: none;"
		id="mdCtgr2"><span><%=ctgrName %></span></td>
	<td width="100" style="border:1px solid black; border-top: none; border-bottom: none; border-right: none;"
		id="price5"><span></span></td>
</tr>
</table>
<hr />
<table cellpadding="10">
<tr>
    <th class="text-center">결제 정보</th>
    <td>
        <div class="btn-group btn-group-lg" role="group" aria-label="Large button group">
            <input type="radio" name="payment" id="paymenta" value="a" class="btn-check" />&nbsp;&nbsp;
            <label for="paymenta" class="btn btn-outline-primary rounded-pill">실시간 계좌이체</label>&nbsp;&nbsp;
            <input type="radio" name="payment" id="paymentb" value="b" class="btn-check" />&nbsp;&nbsp;
            <label for="paymentb" class="btn btn-outline-primary rounded-pill">신용 카드</label>&nbsp;&nbsp;
            <input type="radio" name="payment" id="paymentc" value="c" class="btn-check" />&nbsp;&nbsp;
            <label for="paymentc" class="btn btn-outline-primary rounded-pill">휴대폰 결제</label>
        </div>
    </td>
</tr>

</table>
<hr />
<h3>후원금 결제 안내</h3>
<p>선택하신 결제 방법에 따라 결제가 진행 됩니다.</p>
<br />
  <input type="submit" style="font-size:30px;" value="후원하기" />
<br />
</form>
</div>
</body>
<script>
function showPrice(val) {
	$("#price").text(val);
	$("#price5").text(val);
}

$(document).ready(function() {
	$("#price1").change(function() {
		if ($(this).val() == "") {
			$("#price2").val("");
			$("#price").text("");
			$("#price5").text("");
		} else if ($(this).val() == "direct") {
			$("#price").text("");
			$("#price5").text("");
			$("#price2").val("");
			$("#price2").focus();
		} else {
			$("#price2").val($(this).val());
			$("#price").text($(this).val());
			$("#price5").text($(this).val());
		}
	});
	
	$("#price3").change(function() {
		if ($(this).val() == "") {
			$("#price4").val("");
			$("#price5").text("");
			$("#price").text("");
		} else if ($(this).val() == "direct") {
			$("#price").text("");
			$("#price5").text("");
			$("#price4").val("");
			$("#price4").focus();
		} else {
			$("#price4").val($(this).val());
			$("#price").text($(this).val());
			$("#price5").text($(this).val());
		}
	});
	
});

$(document).ready(function() {
	$("#spon1").change(function() {
		if ($(this).val() == "") {
			$("#spon2").val("");
			$("#mdSponsor").text("");
		} else {
			$("#spon2").val($(this).val());
			$("#mdSponsor").text($(this).val().substring(1));
		}
	});
	
	$("#spon3").change(function() {
		if ($(this).val() == "") {
			$("#mdSponsor").text("");
		} else {
			$("#mdSponsor").text($(this).val().substring(1));
		}
	});
});

function checkOnlyOne(checkbox) {
    const chkType = document.getElementsByName("chkType");
    chkType.forEach((cb) => {
        if (cb !== checkbox) {
            cb.checked = false;
        }
    });
	var tmp1 = document.getElementById("price1");
	var tmp2 = document.getElementById("price2");
	var tmp3 = document.getElementById("price3");
	var tmp4 = document.getElementById("price4");
	if (checkbox.checked && checkbox.value == "a") {
		tmp1.disabled = false;    	tmp2.disabled = false;
		tmp3.disabled = true;    	tmp4.disabled = true;
	} else {
		tmp1.disabled = true;    	tmp2.disabled = true;
		tmp3.disabled = false;    	tmp4.disabled = false;
	}
    
    const mdCtgr = document.getElementById("mdCtgr");
    const mdCtgr2 = document.getElementById("mdCtgr2");
    const price = document.getElementById("price");
    const price5 = document.getElementById("price5");
    const mdSponsor = document.getElementById("mdSponsor");
    
    if (checkbox === null) {
        mdCtgr.textContent = "-";
    } else if (checkbox.checked) {
        if (checkbox.id === "a") {
            mdCtgr.textContent = "일반 후원";
            price.innerHTML = document.getElementById("price2").value;
            mdCtgr2.textContent = "일반 후원";
            price5.innerHTML = document.getElementById("price2").value;
            // mdSponsor.innerHTML = document.getElementById("mdSponsor").value;
        } else if (checkbox.id === "b") {
            mdCtgr.textContent = "정기 후원";
            price.innerHTML = document.getElementById("price4").value;
            mdCtgr2.textContent = "정기 후원";
            price5.innerHTML = document.getElementById("price4").value;
         // mdSponsor.innerHTML = document.getElementById("mdSponsor").value;
        }
    }
}

$(document).ready(function() {
<% if (kind.equals("a")) { %>
    $('.sponsor2').hide(); // Hide the sponsor row for 정기 후원
<% } else { %>
	$('.sponsor1').hide(); // Hide the sponsor row for 일반 후원
<% } %>

    $('#a').on('click', function() {
        if ($(this).prop('checked')) {
            $('.sponsor1').show(); // Show the sponsor row for 일반 후원
            $('.sponsor2').hide(); // Hide the sponsor row for 정기 후원
        } else {
            $('.sponsor1').hide(); // Hide the sponsor row for 일반 후원
        }
    });

    $('#b').on('click', function() {
        if ($(this).prop('checked')) {
            $('.sponsor2').show(); // Show the sponsor row for 정기 후원
            $('.sponsor1').hide(); // Hide the sponsor row for 일반 후원
        } else {
            $('.sponsor2').hide(); // Hide the sponsor row for 정기 후원
        }
    });
});

$(document).ready(function() {
	$("#e2").change(function() {
		if ($(this).val() == "") {
			$("#e3").val("");
		} else if ($(this).val() == "direct") {
			$("#e3").val("");
			$("#e3").focus();
		} else {
			$("#e3").val($(this).val());
		}
	});
})

$(document).ready(function() {
	$("#aChkAll").click(function() {
		if($("#aChkAll").is(":checked")) $("input[name=aChk]").prop("checked", true);
		else $("input[name=aChk]").prop("checked", false);
	});

	$("input[name=aChk]").click(function() {
		var total = $("input[name=aChk]").length;
		var checked = $("input[name=aChk]:checked").length;

		if(total != checked) $("#aChkAll").prop("checked", false);
		else $("#aChkAll").prop("checked", true); 
	});
	
	$("#aChk2").click(function() {
		if($("#aChk2").is(":checked")) $("input[id=choose]").prop("checked", true);
		else $("input[id=choose]").prop("checked", false);
	});
	
	$("input[id=choose]").click(function() {
		var total1 = $("input[id=choose]").length;
		var checked2 = $("input[id=choose]:checked").length;

		if(total1 != checked2) $("#aChk2").prop("checked", false);
		else $("#aChk2").prop("checked", true); 
	});
});

</script>
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