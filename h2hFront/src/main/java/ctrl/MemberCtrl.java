package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class MemberCtrl {
	private MemberSvc memberSvc;
	private LoginSvc loginSvc;
	
	public void setMemberSvc(MemberSvc memberSvc) {
		this.memberSvc = memberSvc;
	}
	
	public void setLoginSvc(LoginSvc loginSvc) {
		this.loginSvc = loginSvc;
	}
	
	@GetMapping("/emailAuthentication")
	public String memberFormAcemail() {
		return "member/member_form_acemail";
	}
	
	@GetMapping("/memberGForm")
	public String memberGForm() {
		return "member/member_gform";
	}
	
	@GetMapping("/findId")
	public String memberFormFindId1() {
		return "member/member_form_findId1";
	}
	
	@GetMapping("/memberJoin")
	public String memberFromSelect() {
		return "member/member_form_select";
	}
	
	@PostMapping("/insertMemberJoin")
	public String joinProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");	// 회원 종류(일반, 기업, 단체)
		String phone = "010-" + request.getParameter("p1") + "-" + request.getParameter("p2");	// 핸드폰 번호
		
		MemberInfo mi = new MemberInfo();
		MemberAddr2 ma = new MemberAddr2();
		mi.setMi_id(request.getParameter("id"));
		mi.setMi_pw(request.getParameter("pw"));
		mi.setMi_name(request.getParameter("name"));
		mi.setMi_phone(phone);
		mi.setMi_type(type);
		
		if (type.equals("a")) {	// 일반회원
			String aphone = "010-" + request.getParameter("adp1") + "-" +request.getParameter("adp2");
			String birth = "19" + request.getParameter("birth").substring(0, 2) + "-" + request.getParameter("birth").substring(2, 4) + "-" + request.getParameter("birth").substring(4);
			String gender = request.getParameter("birth2");	// 성별
			if (gender.equals("1") || gender.equals("3"))
				gender = "남";
			else
				gender = "여";
			
			mi.setMi_gender(gender);
			mi.setMi_birth(birth);
			ma.setMi_id(request.getParameter("id"));
			ma.setMa_name(request.getParameter("name"));
			ma.setMa_rname(request.getParameter("rname"));
			mi.setMi_email(request.getParameter("email"));
			ma.setMa_phone(aphone);
			ma.setMa_zip(request.getParameter("zip"));
			ma.setMa_addr1(request.getParameter("addr1"));
			ma.setMa_addr2(request.getParameter("addr2"));
		} else if (type.equals("c")) { // 기업 회원
			String email =  request.getParameter("e1").trim() + "@" + request.getParameter("e2").trim();
			mi.setMi_email(email);
			mi.setMi_bnum(request.getParameter("bnum"));
			mi.setMi_gname(request.getParameter("gname"));
		} else {	// 단체 회원
			String email =  request.getParameter("e1").trim() + "@" + request.getParameter("e2").trim();
			mi.setMi_email(email);
			mi.setMi_gname(request.getParameter("gname"));
		}

		int result = memberSvc.memberInsert(mi);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (result != 1) {
			out.println("<script>");
			out.println("alert('회원가입에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		if (type.equals("a")) { // 일반회원일 경우 주소도 추가
			result = memberSvc.memberAddrInsert(ma);
		}
		
		out.println("<script>");
		out.println("('회원가입에 성공했습니다.');");
		out.println("</script>");

		return "member/login_form";
	}
	
	@PostMapping("/dupEmail")
	@ResponseBody
	public String dupEmail(HttpServletRequest request) throws IOException {
		request.setCharacterEncoding("utf-8");
		String email = request.getParameter("email");
		int result = memberSvc.chkDupEmail(email);
		
		return result + "";
	}
	
	@PostMapping("/memberForm")
	public String memberForm(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		String email1 = request.getParameter("e1").trim();
		String email2 = request.getParameter("e2").trim();
		String email = email1 + "@" + email2;
		
		request.setAttribute("email", email);
		
		return "member/member_form";
	}
	
	@PostMapping("/findId")
	public String findId(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String email =  request.getParameter("e1").trim() + "@" + request.getParameter("e2").trim();
		String result = memberSvc.findId(name, email);
		
		if (result == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('사용자 정보가 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else {
			request.setAttribute("id", result);
		}
		
		return "member/member_form_findid2";
	}
	
	@GetMapping("/findPw")
	public String findPw() {
		return "member/member_form_findPw1";
	}

	@PostMapping("/findPw")
	public String findPw(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email =  request.getParameter("e1").trim() + "@" + request.getParameter("e2").trim();
		int result = memberSvc.findPw(id, name, email);
		
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('사용자 정보가 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		request.setAttribute("id", id);
		
		return "member/member_form_findPw2";
	}
	
	@PostMapping("/chgPw")
	public String chgPw(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		int result = memberSvc.chgPw(id, pw);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (result != 1) {
			out.println("<script>");
			out.println("alert('비밀번호 변경에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

		out.println("<script>");
		out.println("alert('비밀번호를 변경했습니다.');");
		out.println("</script>");

		return "member/login_form";
	}
	
	@GetMapping("/myPage")
	public String myPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용 해주세요.');");
			out.println("location.href='login?url=myPage';");
			out.println("</script>");
			out.close();
		}
		return "member/myPage";
	}
	
	@GetMapping("/myInfoChk")
	public String myInfoChk() {
		return "member/my_info_chk";
	}
	
	@PostMapping("/Info")
	public String chkPw(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pwChk");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		int result = memberSvc.chkPw(id, pw);
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		request.setAttribute("name", name);
		request.setAttribute("phone", phone);
		request.setAttribute("email", email);
		
		return "member/my_info";
	}
	/*
	@GetMapping("/Info")
	public String Info() {
		return "member/my_info";
	}*/
	
	@GetMapping("/chgPw2")
	public String chgPw() {
		return "member/member_from_chgPw";
	}
	
	@PostMapping("/chgPw2")
	public String chgPw2(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String npw = request.getParameter("npw");
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		int result = memberSvc.chkPw(id, pw);
		if (result != 1) {
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		result = memberSvc.chgPw(id, npw);
		if (result != 1) {
			out.println("<script>");
			out.println("alert('비밀번호 변경에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

		out.println("<script>");
		out.println("alert('비밀번호를 변경했습니다.');");
		out.println("</script>");

		return "member/my_info";
	}
	
	@PostMapping("/chgMemberInfo")
	public String chgMemberInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");
		String phone = request.getParameter("p1") + "-" + request.getParameter("p2") + "-" + request.getParameter("p3");
		String email =  request.getParameter("e1").trim() + "@" + request.getParameter("e2").trim();
		String uid = request.getParameter("id");
		String pwd = request.getParameter("pw");
		
		MemberInfo mi = new MemberInfo();
		mi.setMi_id(uid);
		mi.setMi_type(type);
		mi.setMi_phone(phone);
		mi.setMi_email(email);
		if (!type.equals("a")) {
			mi.setMi_name(request.getParameter("name").trim());
		}
		
		int result = memberSvc.chgMemberInfo(mi);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (result != 1) {
			out.println("<script>");
			out.println("alert('회원정보 변경에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		out.println("<script>");
		out.println("alert('정보를 수정했습니다.');");
		out.println("</script>");
		
		if (!type.equals("a")) {
			
		}
		request.setAttribute("phone", phone);
		request.setAttribute("email", email);
		
		return "member/my_info";
	}
}
