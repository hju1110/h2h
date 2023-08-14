package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ParcelProcCtrl {
	private ParcelProcSvc parcelProcSvc;
	
	public void setParcelProcSvc(ParcelProcSvc parcelProcSvc) {
		this.parcelProcSvc = parcelProcSvc;
	}


	@GetMapping("/ParcelProc")
	public String parcelList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인이 필요합니다.');");
			out.println("location.href='login?url=ParcelProc';");
			out.println("</script>");	
			out.close();
		}
		
		String miid = loginInfo.getMi_id();
		
		List<OrderProcInCtrl> parcelList = parcelProcSvc.getParcelList(miid);
		
		request.setAttribute("parcelList", parcelList);
		
		return "parcel/parcel_list";
	}
	
	@GetMapping("/ParcelView")
	public String ParcelView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		
		String pi_id = request.getParameter("piid");
		String oi_id = request.getParameter("oi_id");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인이 필요합니다.');");
			out.println("location.href='login?url=ParcelView';");
			out.println("</script>");	
			out.close();
		}
		
		String miid = loginInfo.getMi_id();
		
		ParcelInfo parcelInfo = parcelProcSvc.getParcelView(miid, pi_id, oi_id);
		
		request.setAttribute("parcelInfo", parcelInfo);
		
		return "parcel/parcel_view";
	}
	
}
