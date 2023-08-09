package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;	// ��� ����� ���� ArrayList����� ���� import
import svc.*;
import vo.*;


@WebServlet("/freeReplyProcDel")
public class FreeReplyProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FreeReplyProcDelCtrl() {  super();  }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int fridx = Integer.parseInt(request.getParameter("fridx"));
		int flidx = Integer.parseInt(request.getParameter("flidx"));
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();	
				
		if (loginInfo == null) {
			out.println("<script>");
			out.println("alert('�α��� �� ����ϽǼ� �ֽ��ϴ� .');");
			out.println("</script>");
			out.close();
		}
		
		FreeReply freeReply = new FreeReply();
		freeReply.setFl_idx(flidx);
		freeReply.setFr_idx(fridx);
		freeReply.setMi_id(loginInfo.getMi_id());
		
		FreeReplyProcSvc freeReplyProcSvc = new FreeReplyProcSvc();
		int result = freeReplyProcSvc.replyDel(freeReply);
		out.println(result);
	}

}
