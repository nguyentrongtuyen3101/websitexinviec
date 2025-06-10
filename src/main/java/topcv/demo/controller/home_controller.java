package topcv.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import topcv.demo.entity.User;
import topcv.demo.service.account__service;

@Controller
@RequestMapping("home")
public class home_controller {
	@Autowired
	private account__service account__service;
	@GetMapping("/show_home")
	public String hienthitrangchu(HttpSession session,Model model)
	{
		String gmal =(String)session.getAttribute("userEmail");
		User user=account__service.timaccountbygmail(gmal);
		if(user!=null)
		{
			model.addAttribute("user",user);
		}
		return"home";
	}
}
