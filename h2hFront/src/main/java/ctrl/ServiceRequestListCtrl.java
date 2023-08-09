package ctrl;

import java.net.*;
import java.util.*;
import javax.servlet.http.*;
import org.springframework.context.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ServiceRequestListCtrl {
	private ServiceRequestListSvc serviceRequestListSvc;

		public void setServiceRequestListSvc(ServiceRequestListSvc serviceRequestListSvc) {
			this.serviceRequestListSvc = serviceRequestListSvc;
			
		}
		
		@GetMapping("/serviceRequestList")	// 모집 목록
		public String serviceChart(Model model, HttpServletRequest request) throws Exception {
			request.setCharacterEncoding("UTF-8");
			int cpage = 1, pcnt = 0, spage = 0, rcnt = 0;
			int psize = 5, bsize = 4, num = 0;
			if(request.getParameter("cpage") != null)	//	request.getParameter("?") -> 받으면 무조건 String 안받으면 null
				cpage = Integer.parseInt(request.getParameter("cpage"));
			
			String schtype = request.getParameter("schtype");
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
			args = "&cpage=" + cpage + schargs;	// 앞에 &가 있다는 것은 얘 앞에 뭔가가 또 올거라는 이야기 , 처음에 작성할 때 잘 생각해서 만들기
			rcnt = serviceRequestListSvc.getServiceInfoCount(where);
			
			List<ServiceRequestListInfo> serviceRequestListInfo = serviceRequestListSvc.getServiceRequestListInfo(where, cpage, psize);	// jdbc템플릿이 제공하는 것이 List여서 List 사용하는 것임 리미트 절에서 사용해야 하기 때문에 cpage, psize 가져감 아니면 where 절처럼 만들어서 사용가능
			
			pcnt = rcnt / psize;	if(rcnt % psize > 0) pcnt++;	//게시글이 91개면 페이지는 10개까지 이썽야행
			spage = (cpage - 1)	/ bsize * bsize + 1;
			num = rcnt - (psize * (cpage - 1));
			PageInfo pi = new PageInfo();
			 pi.setBsize(bsize);		 pi.setCpage(cpage);		 pi.setPcnt(pcnt);
			 pi.setPsize(psize);		 pi.setRcnt(rcnt);			 pi.setSpage(spage);
			 pi.setNum(num);			 pi.setArgs(args);			 pi.setSchargs(schargs);
			 pi.setKeyword(keyword);	 pi.setSchtype(schtype);	
			
			 model.addAttribute("serviceRequestListInfo", serviceRequestListInfo);	// model에 담아 보내기
			 model.addAttribute("pi", pi);

			return "service/serviceRequestList";
		}
	}
