package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;	
import svc.*;
import vo.*;


@WebServlet("/orderProcIn")
public class OrderProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public OrderProcInCtrl() {  super();}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");		
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('다시 로그인하세요.');");
			out.println("location.href='login_form';");
			out.println("</script>");	
			out.close();
		}
		String miid = loginInfo.getMi_id();
		String kind = request.getParameter("kind");
		String ocidxs = request.getParameter("ocidxs"); // 장바구니 pk들 바로구매시 ocidxs 값은 (문자열 )0
		int total = Integer.parseInt(request.getParameter("total"));
		
		// 배송지 및 결제 정보 받아오기 
		String oi_name = request.getParameter("oi_name").trim();
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		String oi_phone = "010-" + p2 + "-" + p3;
		String oi_zip = request.getParameter("oi_zip").trim();
		String oi_addr1 = request.getParameter("oi_addr1").trim();
		String oi_addr2 = request.getParameter("oi_addr2").trim();
		String oi_payment = request.getParameter("oi_payment");
		
		OrderInfo oi = new OrderInfo();
		oi.setMi_id(miid);				oi.setOi_name(oi_name);
		oi.setOi_phone(oi_phone);		oi.setOi_zip(oi_zip);
		oi.setOi_addr1(oi_addr1);		oi.setOi_addr2(oi_addr2);
		oi.setOi_payment(oi_payment);	oi.setOi_pay(total);
		oi.setOi_spoint(Math.round(total * 0.02f));		// 적립 포인트 
		oi.setOi_status(oi_payment.equals("c") ? "a" : "b");
		
		OrderProcSvc orderProcSvc = new OrderProcSvc();
		String result = orderProcSvc.orderInsert(kind, oi, ocidxs);
		// 주문번호, 실제 적용된 레코드 개수, 적용되어야 할 레코드 개수 
		
		String[] arr = result.split(",");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (arr[1].equals(arr[2])) {	// 정상적으로 구매가 이루어졌으면 // (마이페이지로 가던가, 구매 페이지로 가던가)
			out.println("<form name='frm' action='orderEnd' method='post'>");
			out.println("<input type='hidden' name='oiid' value='" + arr[0] + "' />");
			out.println("</form>");
			out.println("<script>");
			out.println("document.frm.submit();");	// 폼이 스크립트 보다 아래에 있어야 함 
			out.println("</script>");
			out.close();
		} else {						// 구매 처리시 오류가 발생했으면
			out.println("<script>");
			out.println("alert('구매 처리시 문제가 발생했습니다.\\n 고객 센터에 문의 하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	}

}
