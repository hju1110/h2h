package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import java.util.*;
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
		int cpage = 1, pcnt = 0, spage = 0,  rcnt = 0, psize = 10, bsize = 10;
		
		if (request.getParameter("cpage")!= null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
	    
		HttpSession session = request.getSession();
	    MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
	      
	    if (loginInfo == null) {
	         response.setContentType("text/html; charset=utf-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('로그인이 필요합니다.');");
	         out.println("location.href='/h2hFront/login';");
	         out.println("</script>");
	         out.close();
	    }
	      
	    String miid = loginInfo.getMi_id();
        
		rcnt = donationSvc.getDonaMemListCount(miid);
		List<DonationInfo> dl = donationSvc.getDonaMemList(miid, cpage, psize);
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
		request.setAttribute("pi",pi);
		request.setAttribute("dl",dl);
			
		return "donation/donaTotalList";
	}

	
	
   @PostMapping("/donaTotalPrice")
   @ResponseBody	
   public String donaTotalPrice(Model model, HttpServletRequest request) throws Exception {
      request.setCharacterEncoding("UTF-8");
      String miid = request.getParameter("miid");
      String mdCtgr = request.getParameter("mdCtgr");
      String dnSponsor = request.getParameter("dnSponsor");
      String ydate = request.getParameter("ydate");
      String mdate = request.getParameter("mdate");
      
		
      String where = " where b.md_id = '" +  miid + "' ";
      if (mdCtgr != null && dnSponsor != null && ydate != null && mdate != null) {
          if (!mdCtgr.equals("") && !dnSponsor.equals("") && !ydate.equals("") && !mdate.equals("")) {
              // 검색 조건이 선택된 경우 해당 조건을 where 절에 추가
              if (mdCtgr.equals("a") || mdCtgr.equals("b") || mdCtgr.equals("c")) {
                  where += " AND b.md_ctgr = '" + mdCtgr + "' ";
              }
              if (dnSponsor.equals("a") || dnSponsor.equals("b") || dnSponsor.equals("c")) {
                  where += " AND b.md_sponsor = '" + dnSponsor + "' ";
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
   
   @PostMapping("/donaDel")
   @ResponseBody	
   public String donaDel(Model model, HttpServletRequest request) throws Exception {
      request.setCharacterEncoding("UTF-8");
      String miid = request.getParameter("miid");
      int di_idx = Integer.parseInt(request.getParameter("di_idx"));
      int md_idx = Integer.parseInt(request.getParameter("md_idx"));
      int md_price = Integer.parseInt(request.getParameter("md_price"));
      
      int result = donationSvc.donaDel(miid, di_idx, md_idx, md_price);
	  return result + "";
   }

	@GetMapping("/donationMain")
	public String donationList() {
		
		return "donation/donationMain";
	}
	
	@GetMapping("/donaRequest")
	public String donaRequest() {
		
		return "donation/donaRequest";
	}
	
//	@GetMapping("/donaFinish")
//	public String donaFinish() {
//		
//		return "donation/donaFinish";
//	}
//	
	
	@PostMapping("/donaFinish")
	public String donaFinishs(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		MemberInfo mi = new MemberInfo();
		mi.setMi_id(loginInfo.getMi_id());
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		mi.setMi_phone("010-" + p2 + "-" + p3);
		
		String e1 = request.getParameter("e1");
		String e3 = request.getParameter("e3");
		mi.setMi_email(e1 + "@" + e3);
		
		String uname = request.getParameter("uname");
		String memType = request.getParameter("memType");
		String ctgr = request.getParameter("chkType");
		String bnum = request.getParameter("bnum");
		String gname = request.getParameter("gname");
		int money = Integer.parseInt(request.getParameter("money").replace(",", "").trim());
		String mdSponsor1 = "";
	    String mdSponsor2 = "";
	      if (!request.getParameter("mdSponsor1").equals("")) {
	         mdSponsor1 = request.getParameter("mdSponsor1").substring(0,1);
	      } else if (!request.getParameter("mdSponsor2").equals("")) {
	         mdSponsor2 = request.getParameter("mdSponsor2").substring(0,1);
	      }
		String payment = request.getParameter("payment");
		
		DonationInfo di = new DonationInfo();
		di.setMd_name(uname);
		System.out.println("사용자 이름 : " + uname);
		di.setMd_ctgr(ctgr);
		System.out.println("후원 유형 : " + ctgr);
		di.setMd_bnum(bnum);
		System.out.println("사업자번호 : " + bnum);
		di.setMd_gname(gname);
		System.out.println("단체 이름 : " + gname);
		di.setMd_price(money);
		System.out.println("후원 금액 : " + money);
		
		if (ctgr.equals("a")) {
			di.setMd_sponsor(mdSponsor1);
		} else {
			di.setMd_sponsor(mdSponsor2);
		}
		
		System.out.println("일반 피후원자 : " + mdSponsor1);
		System.out.println("정기 피후원자 : " + mdSponsor2);
		
		di.setMd_payment(payment);
		System.out.println("결제 방법 : " + payment);
		di.setMd_type(memType);
		System.out.println("회원 유형 : " + memType);
		
		if (memType.equals("a")) {
			memType = "일반";
		} else if (memType.equals("b")) {
			memType = "단체";
		} else if (memType.equals("c")) {
			memType = "기업";
		}
		
		int di_idx = 0;
		if (mdSponsor1.equals("a") || mdSponsor2.equals("a")) {
			di_idx = 1;
		} else if (mdSponsor1.equals("b") || mdSponsor2.equals("b")) {
			di_idx = 2;
		} else {
			di_idx = 3;
		}
		
		di.setDi_idx(di_idx);
		System.out.println("후원정보 번호 : " + di_idx);
		
		if (payment.equals("a")) {
			payment = "계좌이체";
		} else if (payment.equals("b")) {
			payment = "신용카드";
		} else if (payment.equals("c")) {
			payment = "휴대폰결제";
		}
		
		int result = donationSvc.donaInsert(mi, di);
		if (result == 3) {
	         response.setContentType("text/html; charset=utf-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('후원에 실패했습니다.');");
	         out.println("location.href='donationMain';");
	         out.println("</script>");
	         out.close();
	    }
		
		return "donation/donaFinish";
	}
}
