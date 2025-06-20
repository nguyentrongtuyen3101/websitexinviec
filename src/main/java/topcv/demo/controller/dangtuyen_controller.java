package topcv.demo.controller;
import java.security.PublicKey;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.hibernate.validator.internal.util.privilegedactions.NewInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import topcv.demo.entity.Category;
import topcv.demo.entity.Company;
import topcv.demo.entity.Recruitment;
import topcv.demo.entity.User;
import topcv.demo.service.account__service;
import topcv.demo.service.dangtuyen_service;

@Controller
@RequestMapping("/dangtuyen")
public class dangtuyen_controller {
	@Autowired
	private account__service account__service;
	@Autowired
	private dangtuyen_service dangtuyen_service;
	@RequestMapping("/show_page_dangtuyen")
	public String showpagedangtuyen(Model model,HttpSession session)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user=account__service.timaccountbygmail(gmail);
        if (user == null ||!"COMPANY".equals(user.getRoleName().toString())) {
        	return "redirect:/account/show_form_dangnhap";
        }
        List<Category> listcCategories=dangtuyen_service.getcategory();
		model.addAttribute("recruitment",new Recruitment());
		model.addAttribute("listcCategories", listcCategories);
		model.addAttribute(user);
		return"dangtuyenform";
	}
	@PostMapping("/taodangtuyen")
	public String taodangtuyen(@ModelAttribute("recruitment") Recruitment recruitment,@RequestParam("categoryid") int categoryId,Model model,HttpSession session)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user=account__service.timaccountbygmail(gmail);
        if (user == null ||!"COMPANY".equals(user.getRoleName().toString())) {
        	return "redirect:/account/show_form_dangnhap";
        }
        Company company=account__service.timcompanybyuserid(user);
        Category category=dangtuyen_service.getCategory(categoryId);
        Recruitment recruitment2=recruitment;
        recruitment2.setTitle(recruitment.getTitle());
        recruitment2.setDescription(recruitment.getDescription());
        recruitment2.setExperience(recruitment.getExperience());
        recruitment2.setQuantity(recruitment.getQuantity());
        recruitment2.setAddress(recruitment.getAddress());
        recruitment2.setDeadline(recruitment.getDeadline());
        recruitment2.setSalary(recruitment.getSalary());
        recruitment2.setPosition(recruitment.getPosition());
        recruitment2.setType(recruitment.getType());
        recruitment2.setStatus(0);
        recruitment2.setUser(user);
        recruitment2.setCategory(category);
        recruitment2.setCompany(company);
        dangtuyen_service.cereatebaidang(recruitment2);
        return"redirect:/dangtuyen/showformlistbaidang";
	}
	@PostMapping("/deletebaidang")
	public String deletebaidang(@RequestParam("idbaidang") int id,Model model,HttpSession session,@ModelAttribute("user") User user,@RequestParam(value = "page", defaultValue = "0") int page)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null ||!"COMPANY".equals(user2.getRoleName().toString())) {
        	return "redirect:/account/show_form_dangnhap";
        }
        dangtuyen_service.deletebaidang(id);
        return "redirect:/dangtuyen/showformlistbaidang?page=" + page;
	}
	@GetMapping("/showformlistbaidang")
	public String showformlisstbaidang(Model model,HttpSession session,@RequestParam(value = "page", defaultValue = "0") int page)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user=account__service.timaccountbygmail(gmail);
        if (user == null ||!"COMPANY".equals(user.getRoleName().toString())) {
        	return "redirect:/account/show_form_dangnhap";
        }
        Company company=account__service.timcompanybyuserid(user);
        if (company == null) {
        	return "redirect:/account/show_form_dangnhap";
        }
        int pageSize = 5;
        List<Recruitment> recruitments = dangtuyen_service.getRecruitments(user, page, pageSize);
        long totalRecruitments = dangtuyen_service.getTotalRecruitments(user);
        
        int totalPages = (int) Math.ceil((double) totalRecruitments / pageSize);

        model.addAttribute("recruitments", recruitments);
        model.addAttribute("user", user);
        model.addAttribute("company", company);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalRecruitments", totalRecruitments);
        model.addAttribute("now", new Date()); 
        return"listbaidang";
	}
	@GetMapping("/showformupdate")
	public String showformupdate(@RequestParam("idbaidang") int id,Model model,HttpSession session)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user=account__service.timaccountbygmail(gmail);
        if (user == null ||!"COMPANY".equals(user.getRoleName().toString())) {
        	return "redirect:/account/show_form_dangnhap";
        }
        Company company=account__service.timcompanybyuserid(user);
		Recruitment recruitment=dangtuyen_service.timRecruitmentbyid(id);
		model.addAttribute("recruitment", recruitment);
		List<Category> listcCategories=dangtuyen_service.getcategory();
		model.addAttribute("listcCategories", listcCategories);
		model.addAttribute("user", user);
		model.addAttribute("company", company);
		return"dangtuyenform";
	}
	
}
