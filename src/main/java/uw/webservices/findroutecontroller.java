package uw.webservices;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class findroutecontroller {
	@RequestMapping("/")
	public String findRoute() {
		return "findroute";
	}
	
	@RequestMapping("/directions")
	public String directions() {
		return "directions";
	}

}
