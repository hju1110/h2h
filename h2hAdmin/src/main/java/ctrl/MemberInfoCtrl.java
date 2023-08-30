package ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class MemberInfoCtrl {
	private MemberInfoSvc memberInfoSvc;
	
	public void setMemberInfoSvc(MemberInfoSvc memberInfoSvc) {
		this.memberInfoSvc = memberInfoSvc;
	}
	
	@GetMapping("/memberInfo")
	public String MemberInfo(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 5, num = 0;
		// 현재 페이지 번호, 페이지 수, 시작페이지, 게시글 수, 페이지 크기, 블록 크기, 번호, 블록 크기 번호
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		// int 형으로 변환
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String type = request.getParameter("sv");
		String where = "", args = "", schargs = "";
		if (type == null) {
			type = "";
		} else if (type != null) {
			if (type.equals("nm")) {
				where += " WHERE mi_type = 'a' ";
			} else if (type.equals("gb")) {
				where += " WHERE (mi_type = 'b' OR mi_type = 'c') ";
			} else if (type.equals("al") && schtype != null && schtype != "") {
				where += " WHERE ";
			}
			
			if (where.contains("WHERE") && !type.equals("al") && schtype != null && schtype != "") {
				where += "AND";
			}
		}
		
		if (schtype == null || keyword == "") {
			schtype = "";
			keyword = "";
		} else if (!schtype.equals("") && !keyword.equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();
			if (type == "")
				where += " WHERE ";
			
			if (schtype.equals("tc")) {	// 검색조건이 '제목 + 내용'이면
				where += " (mi_name LIKE '%" + keyword + "%' OR mi_gname LIKE '%" + keyword + "%') ";
			} else if (schtype.equals("all")) {
				where += " (mi_name LIKE '%" + keyword + "%' OR mi_gname LIKE '%" + keyword + "%' OR mi_id LIKE '%" + keyword + "%') ";
			} else {
				where += " mi_id LIKE '%" + keyword + "%' ";
			}
			
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		
		if (!type.equals("")) {
			 schargs += "&sv=" + type;
		}
		
		args = "&cpage=" + cpage + schargs;
		
		System.out.println(where);
		
		rcnt = memberInfoSvc.getMemberListCount(where);

		List<MemberManagementInfo> memberManagementInfo = memberInfoSvc.getMemberManagementInfo(where, cpage, psize);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0) pcnt ++;
		spage = (cpage - 1) / bsize * bsize + 1;
		num  = rcnt - (psize * (cpage - 1));
		
		PageInfo pi = new PageInfo();		
		pi.setBsize(bsize);		pi.setCpage(cpage);
		pi.setPsize(psize);		pi.setPcnt(pcnt);
		pi.setRcnt(rcnt);		pi.setSpage(spage);
		pi.setSchargs(schargs); pi.setNum(num);
		pi.setKeyword(keyword); pi.setArgs(args);
		pi.setSchtype(schtype); pi.setType(type);
		// 페이징에 필요한 정보들과 검색 조건을 PageInfo형 인스턴스에 저장
		
		model.addAttribute("pi", pi);
		model.addAttribute("mi", memberManagementInfo);
		
		return "memberinfo/member_info";
	}
}
