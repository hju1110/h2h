<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
fieldset {
	width: 500px;
}

div[id^=modal] {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
    display: none;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: rgba(255, 255, 255, 0.25);
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
    backdrop-filter: blur(1.5px);
    -webkit-backdrop-filter: blur(1.5px);
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.18);
}

br {
	
}
.modal-window {
    background: rgba( 69, 139, 197, 0.70 );
    box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
    backdrop-filter: blur( 13.5px );
    -webkit-backdrop-filter: blur( 13.5px );
    border-radius: 10px;
    border: 1px solid rgba( 255, 255, 255, 0.18 );
    width: 400px;
    height: 400px;
    position: relative;
    top: -100px;
    padding: 10px;
}
.title {
    padding-left: 10px;
    display: inline;
    text-shadow: 1px 1px 2px gray;
    color: white;
}
.title h2 {
    display: inline;
}
.close-area {
    display: inline;
    float: right;
    padding-right: 10px;
    cursor: pointer;
    text-shadow: 1px 1px 2px gray;
    color: white;
}

.content {
    margin-top: 20px;
    padding: 0px 10px;
    text-shadow: 1px 1px 2px gray;
    color: white;
}

.attribute {
	display: inline-block;
	width: 110px;
}

.center {
	position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

</style>
<script type="text/javascript">
function modalUp(status) {
	const modalId = 'modal' + status;
	const modal = document.getElementById(modalId);
	modal.style.display = "flex";
}

function modalClose(status) {
	const modalId = 'modal' + status;
	const modal = document.getElementById(modalId);
	modal.style.display = "none";
}

function selectView(val) {
	var currentUrl = window.location.href;
	
	if (currentUrl.includes( '?' ) && val == "al" && !currentUrl.includes('schtype') && !currentUrl.includes( 'cpage=' )) {
		currentUrl = currentUrl.substring(0, (currentUrl.length)-6);
		location.href = currentUrl;
	} else if (currentUrl.includes( 'cpage=' )) {
		currentUrl = currentUrl.replace('cpage=', '');
	}
	
	if (currentUrl.includes( '&sv=nm' ) || currentUrl.includes( '&sv=gb' ) || currentUrl.includes( '?sv=nm' ) || currentUrl.includes( '?sv=gb' ) || currentUrl.includes( '&sv=al' ) || currentUrl.includes( '?sv=al' )) {
		currentUrl = currentUrl.substring(0, (currentUrl.length)-6);
	}
	
	if (currentUrl.includes( '&sv=' ) || currentUrl.includes( '&sv=' )) {
		currentUrl = currentUrl.substring(0, (currentUrl.length)-4);
	}
	
	if (currentUrl.includes( '?' )) {
		location.href = currentUrl + '&sv=' + val;
	} else {
		location.href = currentUrl + '?sv=' + val;
	}
	
}

</script>
</head>
<body>
<div class="center">
<h2>회원 목록</h2>
<table width="800" border="0" cellpadding="0">
<tr>
	<td align="right">
		<select onchange="selectView(this.value)">
			<option value="">옵션 선택</option>
			<option value="al" <c:if test="${ pi.getType() == 'al' }">selected="selected"</c:if>>전체 보기</option>
			<option value="nm" <c:if test="${ pi.getType() == 'nm' }">selected="selected"</c:if>>일반회원 보기</option>
			<option value="gb" <c:if test="${ pi.getType() == 'gb' }">selected="selected"</c:if>>기업,단체회원 보기</option>
		</select>
	</td>
</tr>
</table>
<hr width="800" align="left">
<table width="800" border="0" cellpadding="0">
<tr height="30">
	<th width="20%">아이디</th><th width="*">이름 / 기업,단체명(담당자명)</th><th width="15%">회원가입일</th>
</tr>
<tr>
	<!-- 회원 정보가 있을 경우 -->
	<c:if test="${ mi.size() > 0 }">
		<c:forEach items="${mi}" var="mi" varStatus="status">
			<tr height="30" onclick="modalUp(${ status.index });" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
				<td align="center">${ mi.getMi_id() }</td>
				<c:if test="${ mi.getMi_type() == 'a' }">
					<td align="center">${ mi.getMi_name() }</td>
				</c:if>
				<c:if test="${ mi.getMi_type() != 'a' }">
					<td align="center">${ mi.getMi_gname() }(${ mi.getMi_name() })</td>
				</c:if>
				<td align="center">${ mi.getMi_date() }</td>
			</tr>
			<div id="modal${ status.index }" class="modal-overlay">
        		<div class="modal-window" onclick="modalClose(${ status.index });">
            		<div class="title">
                		<c:if test="${ mi.getMi_type() == 'a' }"><h2>일반 회원</h2></c:if>
                		<c:if test="${ mi.getMi_type() != 'a' }"><h2>기업/단체 회원</h2></c:if>
            		</div>
            	<div class="close-area">X</div><hr>
		            <div class="content">
		                <span class="attribute">아이디</span><span>${ mi.getMi_id() }</span><br>
		                <c:if test="${ mi.getMi_type() == 'a' }">
			                <span class="attribute">성명</span><span>${ mi.getMi_name() }</span><br>
			                <span class="attribute">생년월일</span><span>${ mi.getMi_birth() }</span><br>
		                </c:if>
		                <c:if test="${ mi.getMi_type() == 'c' }">
		          			<span class="attribute">기업/단체명</span><span>${ mi.getMi_gname() }</span><br>
			                <span class="attribute">담당자명</span><span>${ mi.getMi_name() }</span><br>
			                <span class="attribute">사업자 번호</span><span>${ mi.getMi_bnum() }</span><br>
		                </c:if>
		                <c:if test="${ mi.getMi_type() == 'b' }">
							<span class="attribute">기업/단체명</span><span>${ mi.getMi_gname() }</span><br>
			                <span class="attribute">담당자명</span><span>${ mi.getMi_name() }</span><br>
		                </c:if>
		                <span class="attribute">휴대폰 번호</span><span>${ mi.getMi_phone() }</span><br>
		                <span class="attribute">이메일</span><span>${ mi.getMi_email() }</span><br>
		                <span class="attribute"></span><span></span><br>
		                <hr>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>
	<!-- 회원 정보가 없을 경우 -->
	<c:if test="${ mi.size() == 0 }"><tr><td colspan="5" align="center">검색 결과가 없습니다.</td></tr></c:if>
</tr>
</table>
<hr width="800" align="left">
<div style="width: 800px; text-align: center;">
	<c:if test="${ mi.size() > 0 }">
		<c:if test="${ pi.getCpage() == 1 }">
			[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;
		</c:if>
		<c:if test="${ pi.getCpage() > 1 }">
			<a href="memberInfo?cpage=1${ pi.getSchargs() }">[처음]</a>&nbsp;&nbsp;&nbsp;
			<a href="memberInfo?cpage=${ pi.getCpage() - 1 }${ pi.getSchargs() }">[이전]</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${ pi.getSpage() }" end="${ pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }">
			<c:if test="${ i == pi.getCpage() }">
				&nbsp;<strong>${ i }</strong>&nbsp;
			</c:if>
			<c:if test="${ i!= pi.getCpage() }">
				&nbsp;<a href="memberInfo?cpage=${ i }${ pi.getSchargs() }">${ i }</a>&nbsp;
			</c:if>
		</c:forEach>
		
		<c:if test="${ pi.getCpage() == pi.getPcnt() }">
			&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]
		</c:if>
		<c:if test="${ pi.getCpage() < pi.getPcnt() }">
			&nbsp;&nbsp;<a href="memberInfo?cpage=${ pi.getCpage() + 1 }${ pi.getSchargs() }">[다음]</a>
			&nbsp;&nbsp;&nbsp;<a href="memberInfo?cpage=${ pi.getPcnt() }${ pi.getSchargs() }">[마지막]</a>
		</c:if>
	</c:if>
</div>
<br>
<div class="sch">
<fieldset>
<legend>회원 검색</legend>
	<form name="frmSch">
		<select name="schtype" style="width: 100px;">
			<option value="">검색 조건</option>
			<option value="all" <c:if test="${ pi.getSchtype() == 'all' }">selected="selected"</c:if>>전체 검색</option>
			<option value="id" <c:if test="${ pi.getSchtype() == 'id' }">selected="selected"</c:if>>아이디 검색</option>
			<option value="tc" <c:if test="${ pi.getSchtype() == 'tc' }">selected="selected"</c:if>>이름/기업,단체 검색</option>
		</select>
		<input type="text" name="keyword" value="${ pi.getKeyword() }">
		<input type="submit" value="검색">
		<input type="button" value="전체글 보기" onclick="location.href='memberInfo';">
	</form>
</fieldset>
</div>
</div>
</body>
</html>