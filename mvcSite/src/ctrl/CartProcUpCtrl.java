package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;	
import svc.*;
import vo.*;

@WebServlet("/cartProcUp")
public class CartProcUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CartProcUpCtrl() {  super();  }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");				
		int ocidx = Integer.parseInt(request.getParameter("ocidx"));
		// 변경시 where 에서 조건으로 사용될 장바구니 테이블의 pk
		int opt = Integer.parseInt(request.getParameter("opt"));		
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		// opt 변경할 옵션 인덱스 번호, cnt 변경할 수량 
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if (loginInfo == null) {
			out.println("<script>");
			out.println("alert('다시 로그인하세요.');");
			out.println("location.href='login_form?url=cartView';");
			out.println("</script>");		
		}
		
		
		OrderCart oc = new OrderCart();
		oc.setOc_idx(ocidx);
		oc.setPs_idx(opt);
		oc.setOc_cnt(cnt);
		oc.setMi_id(loginInfo.getMi_id());
		
		CartProcSvc cartProcSvc = new CartProcSvc();
		int result = cartProcSvc.cartUpdate(oc);
		
		out.println(result);
	}

}
