package kr.or.ddit.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {
	
	@RequestMapping(value="/errorDefault")
	public String basicErrorPage() {
		
		return "error/error";
	}
}
