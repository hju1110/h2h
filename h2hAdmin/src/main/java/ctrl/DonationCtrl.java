package ctrl;

import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class DonationCtrl {
	private DonationSvc donationSvc;
	
	public void setDonationSvc(DonationSvc donationSvc) {
		this.donationSvc = donationSvc;
	}
	
	@GetMapping("/donaMemList")
	public String DonaMemList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용가능합니다.');");
			out.println("location.href='login?url=donaMemList';");
			out.println("</script>");
			out.close();
		}
		
		int cpage = 1, pcnt = 0, spage = 0,  rcnt = 0, psize = 20, bsize = 10;
		
		if (request.getParameter("cpage")!= null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
		
		String mdCtgr = request.getParameter("mdCtgr");
	    String dnSponsor = request.getParameter("dnSponsor");
	    String ydate = request.getParameter("ydate");
	    String mdate = request.getParameter("mdate");
	    String mi = request.getParameter("mi");
	    String keyword = request.getParameter("keyword");

	    String where = " WHERE a.di_idx = b.di_idx ";
	    String schargs = "";
	    if (keyword == null) {
	        keyword = "";
	    }
	    if (mdCtgr != null && dnSponsor != null && ydate != null && mdate != null && mi != null && keyword != null) {
	        if (!mdCtgr.equals("") && !dnSponsor.equals("") && !ydate.equals("") && !mdate.equals("") 
	        	&& !mi.equals("") && !keyword.trim().equals("")) {
	            // 검색 조건이 선택된 경우 해당 조건을 where 절에 추가
	            if (mdCtgr.equals("a") || mdCtgr.equals("b") || mdCtgr.equals("c")) {
	                where += " AND b.md_ctgr = '" + mdCtgr + "' ";
	            }
	            if (dnSponsor.equals("a") || dnSponsor.equals("b") || dnSponsor.equals("c")) {
	                where += " AND a.di_sponsor = '" + dnSponsor + "' ";
	            }
	            if (!ydate.equals("all")) {
	                where += " AND YEAR(b.md_sdate) = " + ydate + " ";
	            }
	            if (!mdate.equals("all")) {
	                where += " AND MONTH(b.md_sdate) = " + mdate + " ";
	            }
	            // keyword 검색 조건 추가
	            if (mi.equals("md_name")) {
	                where += " AND b.md_name LIKE '%" + keyword + "%' ";
	            } else if (mi.equals("md_id")) {
	                where += " AND b.md_id LIKE '%" + keyword + "%' ";
	            }
	            schargs = "&dnSponsor=" + dnSponsor + "&mdCtgr=" +  mdCtgr + "&ydate=" + ydate + "&mdate=" + mdate + "&keyword=" + keyword;
	        }
	    }
	    
		rcnt = donationSvc.getDonaMemListCount(where);
		List<DonationInfo> dl = donationSvc.getDonaMemList(where, cpage, psize);
		DonationInfo di = donationSvc.getDonaTotal();
		//System.out.println(dl);
		
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
		pi.setKeyword(keyword);
		pi.setMdCtgr(mdCtgr);
		pi.setDnSponsor(dnSponsor);
		pi.setYdate((ydate == null ? "all" : ydate));
		pi.setMdate((mdate == null ? "all" : mdate));
		pi.setMi(mi);
		pi.setSchargs(schargs);
		request.setAttribute("pi",pi);
		request.setAttribute("dl",dl);
		request.setAttribute("di",di);
					
		return "donation/donaTotalList";
	}
	
	@PostMapping("/donaTotalPrice")
	@ResponseBody	
   public String donaTotalPrice(Model model, HttpServletRequest request) throws Exception {
      request.setCharacterEncoding("UTF-8");
     
      String mdCtgr = request.getParameter("mdCtgr");
      String dnSponsor = request.getParameter("dnSponsor");
      String ydate = request.getParameter("ydate");
      String mdate = request.getParameter("mdate");
      
		
      String where = " where a.di_idx = b.di_idx ";
      if (mdCtgr != null && dnSponsor != null && ydate != null && mdate != null) {
          if (!mdCtgr.equals("") && !dnSponsor.equals("") && !ydate.equals("") && !mdate.equals("")) {
        	// 검색 조건이 선택된 경우 해당 조건을 where 절에 추가
              if (mdCtgr.equals("a") || mdCtgr.equals("b") || mdCtgr.equals("c")) {
                  where += " AND b.md_ctgr = '" + mdCtgr + "' ";
              }
              if (dnSponsor.equals("a") || dnSponsor.equals("b") || dnSponsor.equals("c")) {
                  where += " AND a.di_sponsor = '" + dnSponsor + "' ";
              }
              if (!ydate.equals("전체")) {
                  where += " AND YEAR(b.md_sdate) = " + ydate + " ";
              }
              if (!mdate.equals("전체")) {
                  where += " AND MONTH(b.md_sdate) = " + mdate + " ";
              }
          }
      }
      
      String total = donationSvc.getDonaTotalPrice(where);          
      return total;
   }
	
}
