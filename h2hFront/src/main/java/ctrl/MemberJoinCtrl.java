package ctrl;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import svc.MemberSvc;
import vo.MemberInfo;

@Controller
public class MemberJoinCtrl {
	private MemberSvc memberSvc;
	
	public void setMemberSvc(MemberSvc memberSvc) {
		this.memberSvc = memberSvc;
	}
	
	@GetMapping("/memberJoin")
	public String memberFromSelect() {
		return "member/member_form_select";
	}
	
	@PostMapping("/insertBusinessMemberJoin")
	public String joinProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
			request.setCharacterEncoding("utf-8");
			MemberInfo mi = new MemberInfo();
			mi.setMi_id(request.getParameter("mi_id"));
			mi.setMi_pw(request.getParameter("mi_pw"));
			mi.setMi_name(request.getParameter("mi_name"));
			mi.setMi_bnum(request.getParameter("mi_bnum"));
			mi.setMi_gender(request.getParameter("mi_gender"));
			mi.setMi_birth(request.getParameter("mi_birth"));
			mi.setMi_phone(request.getParameter("mi_phone"));
			mi.setMi_email(request.getParameter("mi_mail"));
			mi.setMi_point(Integer.parseInt(request.getParameter("mi_point")));
			mi.setMi_status(request.getParameter("mi_email"));
			mi.setMi_date(request.getParameter("mi_date"));
			mi.setMi_lastlogin(request.getParameter("mi_lastlogin"));
			mi.setMi_type(request.getParameter("mi_type"));
			mi.setMi_gname(request.getParameter("mi_gname"));

			int result = memberSvc.memberInsert(mi);
			if (result != 1) {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('ȸ�� ���Կ� �����߽��ϴ�.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}

			return "redirect:/member/login_form";
		}
}
