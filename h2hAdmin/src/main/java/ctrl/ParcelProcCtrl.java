package ctrl;

import java.io.PrintWriter;
import java.lang.ProcessBuilder.Redirect;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import svc.*;
import vo.*;

@Controller
public class ParcelProcCtrl {
	private ParcelProcSvc parcelProcSvc;
	
	public void setParcelProcSvc(ParcelProcSvc parcelProcSvc) {
		this.parcelProcSvc = parcelProcSvc;
	}

	// 二쇰Ц �쁽�솴 由ъ뒪�듃 蹂댁뿬二쇰뒗 硫붿냼�뱶
	@GetMapping("/ParcelProc")
	public String parcelList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 10; 
		if (request.getParameter("cpage") != null)	cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		
		String where = " where oi_status != 'd'";
		String args = "", schargs = "";
		if (schtype == null || keyword == null) {
			schtype = ""; keyword ="";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();
			
			if (schtype.equals("oi_name")) {	// 검색조건이 '이름이면
				where += " and " + schtype + " like '%" + keyword + "%' ";		
			} else if (schtype.equals("mi_id")) {
				where += " and " + schtype + " like '%" + keyword + "%' ";
			} else {
				where += " and " + schtype + " like '%" + keyword + "%' ";
			}
			schargs = "&schargs=" + schtype + "&keyword=" + keyword;
		}
		args = "&cpage=" + cpage + schargs;
		
		
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
		
		String miid = loginInfo.getAi_id();
		rcnt = parcelProcSvc.getParcelListCount(where);
		List<OrderProcInCtrl> parcelList = parcelProcSvc.getParcelList(where, cpage, psize, miid);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0) pcnt ++;
		spage = (cpage - 1) / bsize * bsize + 1;
		
		
		PageInfo pi = new PageInfo();		
		pi.setBsize(bsize);		pi.setCpage(cpage);
		pi.setPsize(psize);		pi.setPcnt(pcnt);
		pi.setRcnt(rcnt);		pi.setSpage(spage);
		pi.setSchargs(schargs); 
		pi.setKeyword(keyword); pi.setArgs(args);
		pi.setSchtype(schtype);
		
	    request.setAttribute("pi",pi);
	    request.setAttribute("parcelList",parcelList);
		return "parcel/parcel_list";
	}
	
	// 二쇰Ц �쁽�솴 �긽�꽭 蹂닿린 酉� 蹂댁뿬二쇰뒗 硫붿냼�뱶 
	@GetMapping("/ParcelView")
	public String ParcelView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		
		String pi_id = request.getParameter("piid");
		String oi_id = request.getParameter("oi_id");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
	
		
		String miid = loginInfo.getAi_id();
		
		ParcelInfo parcelInfo = parcelProcSvc.getParcelView(miid, pi_id, oi_id);
		request.setAttribute("parcelInfo", parcelInfo);
		
		return "parcel/parcel_view";
	}
	
	// 二쇰Ц �긽�꽭蹂닿린 李쎌뿉�꽌 諛곗넚吏� �젙蹂� �닔�젙
	@PostMapping("/orderProcUp")
	@ResponseBody	// �옄諛붽컼泥대�� http �쓳�떟�슜 媛앹껜濡� 蹂��솚�븯�뿬 �겢�씪�씠�뼵�듃�뿉 �쟾�넚
	public String orderProcUp(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String oi_name = request.getParameter("oi_name");
		String oi_addr1 = request.getParameter("oi_addr1");
		String oi_addr2 = request.getParameter("oi_addr2");
		String oi_zip = request.getParameter("oi_zip");
		String oi_memo = request.getParameter("oi_memo");
		String oi_phone = request.getParameter("oi_phone");;
		String oi_id = request.getParameter("oi_id");
		String mi_id = request.getParameter("mi_id");
		
		ParcelInfo pi = new ParcelInfo();
		pi.setMi_id(mi_id);
		pi.setOi_addr1(oi_addr1);
		pi.setOi_addr2(oi_addr2);
		pi.setOi_zip(oi_zip);
		pi.setOi_memo(oi_memo);
		pi.setOi_phone(oi_phone);
		pi.setOi_id(oi_id);
		pi.setOi_name(oi_name);
		
		int result = parcelProcSvc.orderProcUp(pi);			
		return result + "";
	}
	
	@PostMapping("/orderProcB")
	@ResponseBody	// �옄諛붽컼泥대�� http �쓳�떟�슜 媛앹껜濡� 蹂��솚�븯�뿬 �겢�씪�씠�뼵�듃�뿉 �쟾�넚
	public String orderProcB(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String oi_id = request.getParameter("oi_id");
		String mi_id = request.getParameter("mi_id");
		String oi_status = request.getParameter("oi_status");
	
		int result = parcelProcSvc.orderProcB(oi_id, mi_id, oi_status);
		return result + "";
	}
	
	@PostMapping("/orderProcC")
	@ResponseBody	
	public String orderProcC(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String oi_id = request.getParameter("oi_id");
		String mi_id = request.getParameter("mi_id");
		String oi_status = request.getParameter("oi_status");
	
		int result = parcelProcSvc.orderProcC(oi_id, mi_id, oi_status);
		return result + "";
	}
	
	@PostMapping("/orderProcD")
	@ResponseBody	
	public String orderProcD(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String oi_id = request.getParameter("oi_id");
		String mi_id = request.getParameter("mi_id");
		String pi_id = request.getParameter("pi_id");
		int oi_pay = Integer.parseInt(request.getParameter("oi_pay"));
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
		
		int result = parcelProcSvc.orderProcD(oi_id, mi_id, pi_id, oi_pay);
		request.setAttribute("loginInfo",loginInfo);
			
		return result + "";
	}
}
