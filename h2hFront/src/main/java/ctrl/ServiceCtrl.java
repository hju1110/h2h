package ctrl;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.http.*;
import org.springframework.context.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ServiceCtrl {
	private ServiceSvc serviceSvc;

	public void setServiceSvc(ServiceSvc serviceSvc) {
		this.serviceSvc = serviceSvc;
		
	}
	
	// 참여를 눌렀을 때 나오는 봉사 리스트
	@GetMapping("/service")
	public String serviceList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");	
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0;
		int psize = 5, bsize = 4, num = 0;
		if(request.getParameter("cpage") != null)	//	request.getParameter("?") -> 받으면 무조건 String 안받으면 null
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String where = " WHERE si_view = 'y' ";
		String args = "", schargs = "";
		if (schtype == null || keyword == null) {		// null을 안하고 페이지소스보면 검색창에 null이 찍힘
			schtype = "";	keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {	//schtype 이 null 아니고, keyword도 null이 아니면~
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();
			where += " AND si_" + schtype + " like '%" + keyword + "%'";
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
			    
		args = "&cpage=" + cpage + schargs;	// 앞에 &가 있다는 것은 얘 앞에 뭔가가 또 올거라는 이야기 , 처음에 작성할 때 잘 생각해서 만들기
		rcnt = serviceSvc.getServiceInfoCount(where);
		
		List<ServiceInfo>serviceInfo = serviceSvc.getServiceInfo(where, cpage, psize);	// jdbc템플릿이 제공하는 것이 List여서 List 사용하는 것임 리미트 절에서 사용해야 하기 때문에 cpage, psize 가져감 아니면 where 절처럼 만들어서 사용가능
		
		pcnt = rcnt / psize;	if(rcnt % psize > 0) pcnt++;	//게시글이 91개면 페이지는 10개까지 이썽야행
		spage = (cpage - 1)	/ bsize * bsize + 1;
		num = rcnt - (psize * (cpage - 1));
		PageInfo pi = new PageInfo();
		 pi.setBsize(bsize);		 pi.setCpage(cpage);		 pi.setPcnt(pcnt);
		 pi.setPsize(psize);		 pi.setRcnt(rcnt);			 pi.setSpage(spage);
		 pi.setNum(num);			 pi.setArgs(args);			 pi.setSchargs(schargs);
		 pi.setKeyword(keyword);	 pi.setSchtype(schtype);	
		
		 model.addAttribute("serviceInfo", serviceInfo);	// model에 담아 보내기
		 model.addAttribute("pi", pi);
		 
		return "service/serviceList";
	}
	
	// 봉사 목록을 눌렀을 때 나오는 상세 화면
	@GetMapping("/serviceView")	
	public String serviceView(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		int siidx = Integer.parseInt(request.getParameter("siidx"));
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String schtype = request.getParameter("schtype");	// 콤부박스니까 trim안함
		String keyword = request.getParameter("keyword");
		String args = "?cpage=" + cpage;	
		
		if (schtype != null && !schtype.equals("") && keyword != null && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			args += "&schtype=" + schtype + "&keyword=" + keyword;
		}

		ServiceInfo si = serviceSvc.getServiceList(siidx);
		
		model.addAttribute("si", si);
		model.addAttribute("args", args);
		
		return "service/serviceView";
	}
	
	// 봉사 신청 버튼 눌렀을 때
	@GetMapping("/serviceFinish")
	public String serviceFinish(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		int siidx = Integer.parseInt(request.getParameter("siidx"));
		System.out.println(siidx);
		
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		String miid = mi.getMi_id();
		
		ServiceMember sm = new ServiceMember();
		sm.setSi_idx(siidx);
		System.out.println("siidx : " + siidx);
		sm.setMi_id(miid);
		System.out.println("miid : " + miid);
		
		int result = serviceSvc.setFinish(sm);
		if (result == 1) {
	         response.setContentType("text/html; charset=utf-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('봉사 신청이 되지 않았습니다.');");
	         out.println("history.back();");
	         out.println("</script>");
	         out.close();
	    }
		
		return "service/serviceFinish";
	}
	
	// 봉사 신청 등록 화면
	@GetMapping("/svcRequestForm")
	public String svcRequestForm() {
		return "service/svcRequestForm";
	}

	// 봉사 등록 요청 처리
	@PostMapping("/svcProcIn")
	public String noticeProcIn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		String siAcdate = request.getParameter("siAcdate");
		String siAcname = request.getParameter("siAcname");
		String siType = request.getParameter("siType");
		String siSdate = request.getParameter("siSdate");
		String siEdate = request.getParameter("siEdate");
		String siContent = request.getParameter("siContent");
		int siPerson = Integer.parseInt(request.getParameter("siPerson"));
		
		ServiceInfo si = new ServiceInfo();
		si.setSi_acdate(siAcdate);
		si.setSi_acname(siAcname);
		si.setSi_type(siType);
		si.setSi_sdate(siSdate);
		si.setSi_edate(siEdate);
		si.setSi_content(siContent);
		si.setSi_person(siPerson);
		
		int result = serviceSvc.setSvcProcIn(si);
		
		return "service/svcReSuccess";
	}
	
	// 나의 참여 현황
	@GetMapping("/serviceTotalList")
	public String serviceTotalList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		int cpage = 1, pcnt = 0, spage = 0,  rcnt = 0, psize = 10, bsize = 10;
		
		String schtype = request.getParameter("schtype");	// 콤부박스니까 trim안함
		String keyword = request.getParameter("keyword");
		String where = "";
		String args = "", schargs = "";
		if (schtype == null || keyword == null) {		// null을 안하고 페이지소스보면 검색창에 null이 찍힘
			schtype = "";	keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {	//schtype 이 null 아니고, keyword도 null이 아니면~
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();
			where += " AND si_" + schtype + " like '%" + keyword + "%'";
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		
		HttpSession session = request.getSession();
	    MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
	      
	    String miid = loginInfo.getMi_id();
        
	    args = "&cpage=" + cpage + schargs;
		rcnt = serviceSvc.getServiceListCount(miid);
		List<ServiceInfo> si = serviceSvc.getServiceMemList(miid, cpage, psize);
		//System.out.println(si);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0) {
			pcnt++;
		}
		spage = (cpage - 1) / bsize * bsize + 1;
		
		PageInfo pi = new PageInfo();
		pi.setBsize(bsize);
		pi.setCpage(cpage);
		pi.setPcnt(pcnt);
		pi.setPsize(psize);
		pi.setRcnt(rcnt);
		pi.setSpage(spage);
		
		model.addAttribute("pi",pi);
		model.addAttribute("args", args);
		model.addAttribute("si", si);
		
		return "service/serviceTotalList";
	}
}
