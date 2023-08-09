package ctrl;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class LogoutCtrl {
	@RequestMapping("/logout")
	public String logout(HttpSession session) { // request가 따로 할 일이 없을 때는 session을 선언해도 됨        
		session.invalidate();
        
		return "redirect:/";        
	}
}
