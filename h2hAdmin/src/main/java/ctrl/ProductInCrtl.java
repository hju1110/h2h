package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ProductInCrtl {
	@GetMapping("/ProductIn")
	public String productForm() {
		
		return "product/product_in";
	}
}
