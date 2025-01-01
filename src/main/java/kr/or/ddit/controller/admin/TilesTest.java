package kr.or.ddit.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class TilesTest {

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test() {
		return "admin/Test";
	}
	
}
