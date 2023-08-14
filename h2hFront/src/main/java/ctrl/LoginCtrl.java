package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.LoginSvc;
import vo.MemberInfo;

@Controller
@RequestMapping("/login")
public class LoginCtrl {
	private LoginSvc loginSvc;
	
	public void setLoginSvc(LoginSvc loginSvc) {
		this.loginSvc = loginSvc;
	}
	
	@GetMapping
	public String loginForm() {
		return "member/login_form";
	}
	
	@PostMapping
	public String loginProc(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		String url = request.getParameter("url");
		String uid = request.getParameter("uid").trim().toLowerCase();
		String pwd = request.getParameter("pwd").trim();
		MemberInfo loginInfo = loginSvc.getLoginInfo(uid, pwd);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (loginInfo == null) {
			out.println("<script>");
			out.println("alert('아이디 또는 비밀번호가 틀립니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
		}
		
		return "redirect:/" + url;
	}
}
