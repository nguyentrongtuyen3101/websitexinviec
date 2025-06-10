package topcv.demo.controller;

import javax.servlet.http.HttpSession;

import org.hibernate.validator.internal.util.privilegedactions.NewInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import topcv.demo.entity.Company;
import topcv.demo.entity.User;
import topcv.demo.service.account__service;

@Controller
@RequestMapping("/account")
public class account_controller {
	@Autowired
	private account__service account__service;
	@GetMapping(value = {"/", ""})
    public String redirectToRegister() {
        return "redirect:/account/show_form_dangky";
    }
	@GetMapping("/show_form_dangky")
	public String showformdangky(Model model)
	{
		model.addAttribute("user",new User());
		return"dangky";
	}
	@PostMapping("/dangky")
    public String processRegister(@ModelAttribute("user") User user,@RequestParam("role") String role, Model model) {
		if (role == null || role.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng chọn vai trò!");
            return "dangky";
        }
        if ("USER".equalsIgnoreCase(role)) {
            user.setRoleName(User.Role.USER);
        } else if ("COMPANY".equalsIgnoreCase(role)) {
            user.setRoleName(User.Role.COMPANY);
        } else {
            model.addAttribute("error", "Vai trò không hợp lệ!");
            return "dangky";
        }
        String result = account__service.dangkytaikhoan(user);

        if (result.startsWith("error:")) {
            
            model.addAttribute("error", result.substring(6)); 
            return "dangky"; 
        } else {
           
            model.addAttribute("success", result.substring(8)); 
            if (user.getRoleName() == User.Role.COMPANY)
            {
            	 Company company=new Company();
                 company.setUser(user);
                 account__service.saveorupdatecompany(company);
            } 
            return "redirect:/account/show_form_dangnhap"; 
        }
    }
	@GetMapping("/show_form_dangnhap")
	public String showformdangnhap(Model model)
	{
		model.addAttribute("user",new User());
		return"dangnhap";
	}
	@PostMapping("/dangnhap")
    public String processLogin(@RequestParam("email") String email, @RequestParam("password") String password,
                               HttpSession session, Model model) {
        User user = account__service.login(email, password);
        if (user != null) {
            // Lưu thông tin vào session
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userId", user.getId());
            System.out.println("Login successful, userEmail set to: " + user.getEmail());
            return "redirect:/account/checkRole"; // Chuyển hướng để kiểm tra vai trò
        } else {
            model.addAttribute("error", "Email hoặc mật khẩu không đúng!");
            return "dangnhap";
        }
    }
	@GetMapping("/checkRole")
    public String checkRole(HttpSession session,Model model) {
        String email = (String) session.getAttribute("userEmail");
        User user = account__service.timaccountbygmail(email);
        if (user != null) {
        	model.addAttribute("user",user);
            String role = user.getRoleName().name();
            if ("ADMIN".equals(role)) {
                return "redirect:/admin/dashboard";
            } else if ("USER".equals(role) || "COMPANY".equals(role)) {
                return "redirect:/home/show_home";
            }
        }
        return "redirect:/account/show_form_dangnhap?error=true";
    }
	@GetMapping("/show_form_quenmk")
	public String showformquenmk(Model model)
	{
		model.addAttribute("user",new User());
		return"quenmk";
	}
	@PostMapping("/quenmk")
	public String quenmk(@RequestParam("otp") String inputotp ,Model model,HttpSession session)
	{
		String otpended =(String)session.getAttribute("otp");
		String gmail = (String)session.getAttribute("userEmail");
		String matkhaumoi =(String)session.getAttribute("newPassword");
		if(otpended.equals(inputotp))
		{
			account__service.updatemk(gmail, matkhaumoi);
			session.removeAttribute("otp");
            session.removeAttribute("newPassword");
			return "redirect:/account/show_form_dangnhap";
		}
		else {
			model.addAttribute("errorotp","Mã OTP không hợp lệ !!!");
			model.addAttribute("showOtpModal", true); 
	        return "quenmk";
		}
	}
		
	@PostMapping("/send_otp")
	public String sendotp(@RequestParam("email") String gmail,@RequestParam("mkmoi") String mkmoi,Model model, HttpSession session)
	{
		User usercheck = account__service.timaccountbygmail(gmail);
		if(usercheck==null)
		{
			 model.addAttribute("error", "Email này chưa được đăng ký !!!");
			 return"quenmk";
		}
		String otp=account__service.sendOtp(gmail);
		session.setAttribute("otp", otp);
        session.setAttribute("newPassword", mkmoi);
        session.setAttribute("userEmail", gmail);

        model.addAttribute("success", "Mã OTP đã được gửi đến email của bạn. Vui lòng kiểm tra!");
        return "quenmk";
	}
	@RequestMapping("/logout")
	public String dangxuat(HttpSession session)
	{
		session.removeAttribute("userEmail");
        session.removeAttribute("userId");
        return"dangnhap";
	}
}