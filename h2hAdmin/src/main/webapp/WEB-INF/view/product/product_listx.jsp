<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
 <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }

        table {
            width: 800px;
            margin: 0 auto;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
        }

        th {
            background-color: #efefef;
        }

        img {
            width: 125px;
            height: 100px;
            border: 1px solid #c1c1c1;
        }

        .stock {
            font-size: 0.8em;
        }

        .paging {
            margin-top: 20px;
        }
    </style>
<script>
function makeSch() {
// 검색 폼의 조건들을 쿼리스트링 sch의 값으로 만듬	예제 : ntest,bB1:B2:B3,p100000~200000
	var frm = document.frm2;	var sch = "";
	
	// 상품명 검색어 조건
	var pdt = frm.pdt.value.trim();		// 검색어를 받아와 pdt 에 담아옴
	if (pdt != "")	sch += "n" + pdt;	// 검색어가 빈문자열이 아닐때 sch에 추가 예 sch=n검색어
	
	// 브랜드 조건
	var arr = frm.brand;				// brand라는 이름의 컨트롤들을 배열로 받아옴 ( 여러개의 같은 이름은 배열로 받아옴)
	var isFirst = true;					// brand 체크박스들 중 첫번째로 선택한 체크박스인지 여부를 저장할 변수
	for (var i = 1; i < arr.length; i++) {
		if (arr[i].checked)	{			// 체크드 기본값이 true 기 떄문에 조건으로 사용할 수 있음
			if (isFirst) {				// 첫번째로 선택한 체크박스 이면 이라는 조건 
				isFirst = false;
				if (sch != "")	sch += ","; // 기존에 검색어가 있을 경우 쉼표로 구분 
				sch += "b" + arr[i].value;
			} else {
				sch += ":" + arr[i].value;
			}
		}
	}		// 예 : sch=검색어,b브랜드(들)
		
	// 가격대 조건 
	var sp = frm.sp.value, ep = frm.ep.value;
	if (sp != "" || ep != "") {			// 가격대 중 하나라도 값이 있으면 ( 둘다 없으면 작동을 안해도 상관없으니 검사 따로x)
		if (sch != "")	sch += ",";		// 앞에 검색 조건이 있으면 , 을 붙여서 sch 에 저장 
		sch += "p" + sp + "~" + ep;		// P 와 ~ 붙여p100000~200000식으로 만듬 예: sch=n검색어,b브랜드(들),p최저가~최고가
	}
	
	//alert(sch);   // 검색어 제대로 받아오는지 test
	document.frm1.sch.value = sch;	// frm1 에 있는 sch에  sch값 넣어주기 
	document.frm1.submit();			// 히든 동작
}

function initSch() {
// 검색조건 (상품명, 브랜드, 가격대)들을 모두 없애주는 함수	
	var frm = document.frm2;
	frm.pdt.value = "";		frm.sp.value = "";		frm.ep.value = "";
	var arr = frm.brand;	// brand라는 이름의 컨트롤들을 배열로 받아옴 ( 여러개의 같은 이름은 배열로 받아옴)
	for (var i = 1; i < arr.length; i++) {
		arr[i].checked = false;			// 체크박스 다 날리는 방법 
	}
}
</script>
<body>
<div class="left">
    <h2>상품 목록(판매중지)</h2>
    <hr />
        <table>
   <div align="center" ><input type="button" value="판매중 인 상품 보기" onclick="location.href='productList';" ></div>
    </table>
    <hr />
    <table>
        <tr>
            <th>이미지</th>
            <th>상품명</th>
            <th>가격</th>
            <th>재고</th>
        </tr>
        <% 								
            //보기 방식이 목록형 일 경우
            for (int i = 0; i < productList.size(); i++) {
                ProductInfo pi = productList.get(i); // productList에서 ProductInfo 객체를 가져옴
                String stockText = pi.getPi_stock() + "ea";
                if (pi.getPi_stock() <= 0) {
                    stockText = "품절(SOLD OUT)";
                }

                String priceText = pi.getPi_price() + "원";
                
        %>	
        <tr>
            <td>
                <a href="ProductView?piid=<%=pi.getPi_id()%>">
                    <img src="resources/img/<%=pi.getPi_img1()%>" alt="상품 이미지">
                </a>
            </td>
            <td align="left">
                <a href="ProductView?piid=<%=pi.getPi_id()%>"><%=pi.getPi_name()%></a>
            </td>
            <td><%=priceText%></td>
            <td class="stock">판매 : <%=pi.getPi_sale()%>ea<br /> 재고 : <%=stockText%></td>
        </tr>
        <% 		
            }	
        %>	
    </table>
    <div class="paging">
        <%
            String qs = pageInfo.getSchargs() + pageInfo.getObargs() + pageInfo.getVargs();
            //페이징 영역 링크에서 사용할 쿼리 스트링의 공통 부분 (검색조건들, 정렬방식, 보기방식)

            //이전 버튼 
            if (pageInfo.getCpage() == 1) {
                out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;");
            } else {
                out.println("<a href='productList?cpage=1" + qs + "'>[&lt;&lt;]</a>&nbsp;&nbsp;");
                out.println("<a href='productList?cpage=" + (pageInfo.getCpage() - 1) + qs + "'>[&lt;]</a>&nbsp;&nbsp;");
            }

            //페이징 번호 
            int spage = (pageInfo.getCpage() - 1) / pageInfo.getBsize() * pageInfo.getBsize() + 1; 
            for (int i = 1, j = spage ; i <= pageInfo.getBsize() && j <= pageInfo.getPcnt(); i++,j++) {
                if (j == pageInfo.getCpage()) {
                    out.println("&nbsp;<strong>"+ j + "</strong>&nbsp;");
                } else {
                    out.println("&nbsp;<a href='productList?cpage=" + j + qs + "'>" + j + "</a>&nbsp;");
                }
            }

            //다음 버튼 
            if (pageInfo.getCpage() == pageInfo.getPcnt()) {
                out.println("&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
            } else {
                out.println("&nbsp;<a href='productList?cpage=" + (pageInfo.getCpage() + 1) + qs + "'>[&gt;]</a>");
                out.println("&nbsp;&nbsp;<a href='productList?cpage=" + pageInfo.getPcnt() + qs + "'>[&gt;&gt;]</a>");		
            }	
        %>	
        
    </div>
    <br />
    <input type="button" value="상품등록" onclick="location.href='productIn';">
    </div>
</body>
</html>

