package com.skilldistillery.dejabrew;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class HomeResource {

	
	@GetMapping("/user")
	public String user() {
		return("<h1 align=\"center\">Welcome User</h1>");
	}

	@GetMapping("/admin")
	public String admin() {
		return ("<h1>Welcome</h1>");
	}	
	
	
}
