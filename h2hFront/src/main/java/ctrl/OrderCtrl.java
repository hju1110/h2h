package ctrl;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import svc.*;
import vo.*;


@Controller
public class OrderCtrl {
	private OrderProcSvc orderProcSvc;
		
	public void setOrderProcSvc(OrderProcSvc orderProcSvc) {
		this.orderProcSvc = orderProcSvc;
	}


	@PostMapping("/OrderForm")
	public String orderForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");	
		
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인이 필요합니다 로그인 창으로 이동합니다.');");
			out.println("location.href='login';");
			out.println("</script>");	
			out.close();
		}
		String miid = loginInfo.getMi_id();
	
		
		String piid = request.getParameter("piid");
		String tmp = request.getParameter("size");
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		String select = "select pi_name, pi_img1, pi_size, round(pi_price * " + cnt + ") pi_price, pi_stock, ";
		String from = " from t_product_info ";
		String where = " where pi_id = '" + piid + "' and pi_isview = 'y' and pi_stock > 0 ";
		
		
		//int size = Integer.parseInt(tmp.substring(0, tmp.indexOf(":")));
		select += cnt + " cnt ";			
		
		List<OrderCart> pdtList = orderProcSvc.getBuyList(select + from + where, cnt);
		
		List<MemberAddr> addrList = orderProcSvc.getAddrList(miid);
		
		
		request.setAttribute("addrList", addrList);
		request.setAttribute("pdtList", pdtList);
		request.setAttribute("pi_id", piid);
		
		return "product/product_order";
	}
	
	@PostMapping("/orderProcIn")
	public String orderProcIn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");	
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인이 필요합니다.');");
			out.println("location.href='login';");
			out.println("</script>");	
			out.close();
		}
		
		int cnt = Integer.parseInt(request.getParameter("occnt"));
		OrderProcInCtrl oi = new OrderProcInCtrl();
		
		String pi_id = request.getParameter("pi_id");
		//System.out.println(pi_id);
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		
		
		String oi_id = generateRandomString(8);
		
		String oi_name = request.getParameter("oi_name").trim();
		String oi_phone = "010" + "-" + p2 + "-" + p3; 
		String oi_addr1 = request.getParameter("oi_addr1").trim();
		String oi_addr2 = request.getParameter("oi_addr2").trim();
		String oi_zip = request.getParameter("oi_zip").trim();
		String oi_memo = request.getParameter("oi_memo").trim();
		int oi_pay = Integer.parseInt(request.getParameter("total"));
		int oi_upoint = Integer.parseInt(request.getParameter("total"));
		String oi_invoice = generateRandomString(8);
		
		oi.setOi_id(oi_id);			oi.setMi_id(loginInfo.getMi_id());
		oi.setPi_id(pi_id);
		oi.setOi_name(oi_name);		oi.setOi_phone(oi_phone);
		oi.setOi_zip(oi_zip);
		oi.setOi_addr1(oi_addr1);	oi.setOi_addr2(oi_addr2);
		oi.setOi_memo(oi_memo);		oi.setOi_pay(oi_pay);
		oi.setOi_upoint(oi_upoint);	oi.setOi_invoice(oi_invoice);
		
		int result = orderProcSvc.orderProcIn(oi, pi_id, cnt);
		//System.out.println(result);
		if (result != 4) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('상품 구매에  실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		
		return "product/product_in";
	}
	
	 // 8자리 랜덤 문자열 생성 메서드
    public String generateRandomString(int length) {
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        return uuid.substring(0, length);
    }
    
    @PostMapping("/productLiek")
    @ResponseBody
	public String productLiek(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("utf-8");
    	String pi_id = request.getParameter("piid");
    	
		int result = orderProcSvc.productLiek(pi_id);
		return result + "";
    }
}
