package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/dupId")
public class DupIdCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DupIdCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		
		DupIdSvc dupIdSvc = new DupIdSvc();
		int result = dupIdSvc.chkDupId(uid);
		
		response.setContentType("text/html; charset=utf-8");	// 최종적으로 받아온 값을 사용자에게 응답할 방법 
		PrintWriter out = response.getWriter();		
		out.println(result);									// 요청한 곳으로 result값 보내는 방법 
	}
}
