package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;	
import svc.*;
import vo.*;


@WebServlet("/orderEnd")
public class OrderEndCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;      
    public OrderEndCtrl() { super();}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String oiid = request.getParameter("oiid");
		
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");		
		String miid = mi.getMi_id();
		
		OrderProcSvc orderProcSvc = new OrderProcSvc();
		OrderInfo orderInfo = orderProcSvc.getOrderInfo(miid, oiid);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
