package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;	
import svc.*;
import vo.*;

@WebServlet("/cartProcIn")
public class CartProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;      
    public CartProcInCtrl() {  super();  }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");				
		String piid = request.getParameter("piid");
		String tmp = request.getParameter("psidx");		
		int psidx = Integer.parseInt(tmp.substring(0, tmp.indexOf(":")));
		// psidx�� �ɼ� ��ȣ�� ����� ���� ������ �����Ƿ� �ɼ� ��ȣ�κи� �����Ͽ� ��� 
		
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();	
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			out.println("<script>");
			out.println("alert('�ٽ� �α����ϼ���.');");
			out.println("location.href='login_form?url=/mvcSite/productView?piid=" + piid + "';");
			out.println("</script>");
		}
		String miid = loginInfo.getMi_id();
		
		OrderCart oc = new OrderCart();
		oc.setMi_id(miid);		oc.setPi_id(piid);
		oc.setPs_idx(psidx);	oc.setOc_cnt(cnt);
		// ��ٱ��� ���̺� �������� ���� OrderCart�� �ν��Ͻ� ���� 
		
		CartProcSvc cartProcSvc = new CartProcSvc();
		int result = CartProcSvc.cartInsert(oc);
		
		out.println(result);
		//out.close();
	}
}


