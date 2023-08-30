package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class IndexCtrl {
	@GetMapping("/incLeft")
	public String incLeft() {
		return "inc/incLeft";
	}

	@GetMapping("/mainPage")
	public String mainPage() {
		return "inc/mainPage";
	}

	@GetMapping("/index")
	public String index() {
		return "index";
	}
}
