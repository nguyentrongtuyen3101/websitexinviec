package topcv.demo.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import topcv.demo.entity.Category;
import topcv.demo.entity.Company;
import topcv.demo.entity.Recruitment;
import topcv.demo.entity.SaveJob;
import topcv.demo.entity.User;
import topcv.demo.service.account__service;
import topcv.demo.service.dangtuyen_service;
@Controller
@RequestMapping("/home")
public class home_controller {
	@Autowired
	private account__service account__service;
	@Autowired
	private dangtuyen_service dangtuyen_service;
	@GetMapping("/show_home")
	public String hienthitrangchu(HttpSession session,Model model)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
		model.addAttribute("user", account__service.timaccountbygmail(gmail));
		model.addAttribute("company", new Company());
		model.addAttribute("recruitment",new Recruitment());
		List<Category> listcCategories=dangtuyen_service.getcategory();
		model.addAttribute("listcCategories",listcCategories);
		model.addAttribute("now", new Date()); 
		return"home";
	}
	@GetMapping("/timkiemlob")
	public String timkiemjob(@ModelAttribute("recruitment") Recruitment recruitment,@RequestParam("categoryid") int categoryId,Model model,
			@RequestParam("textinput") String textinput,@RequestParam("chouse") int chouse,@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam("typeselect") String typeselect,HttpSession session)
	{
		int pageSize = 5;
		List<Recruitment> listrecruitments=null;
		long totalRecruitments=0;
		Company company=null;
		Category category=dangtuyen_service.getCategory(categoryId);
		String gmail = (String) session.getAttribute("userEmail");
	    User user = account__service.timaccountbygmail(gmail);
		if(chouse==1)
		{
			 listrecruitments=dangtuyen_service.getlisstRecruitments("title", page, pageSize, typeselect, category,textinput,company);
			 totalRecruitments = dangtuyen_service.getTotalRecruitmentsdk("title",typeselect, category,textinput,company);
		}
		else if(chouse==2)
		{
			 listrecruitments=dangtuyen_service.getlisstRecruitments("address", page, pageSize, typeselect, category,textinput,company);
			 totalRecruitments = dangtuyen_service.getTotalRecruitmentsdk("address",typeselect, category,textinput,company);
		}
		else if(chouse==3)
		{
			company=dangtuyen_service.timCompanybynamecompany(textinput);
			if(company==null)
			{
				model.addAttribute("error", "ko tim thay cong ty này");
				return "home";
			}
			 listrecruitments=dangtuyen_service.getlisstRecruitments("company", page, pageSize, typeselect, category,textinput,company);
			 totalRecruitments = dangtuyen_service.getTotalRecruitmentsdk("company",typeselect, category,textinput,company);
		}
		
        int totalPages = (int) Math.ceil((double) totalRecruitments / pageSize);
        List<Category> listcCategories=dangtuyen_service.getcategory();
		model.addAttribute("listcCategories",listcCategories);
		model.addAttribute("listrecruitments", listrecruitments);
		model.addAttribute("recruitment", recruitment);
		model.addAttribute("category", new Category());
		model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalRecruitments", totalRecruitments);
        model.addAttribute("now", new Date()); 
        model.addAttribute("user", user);
        model.addAttribute("chouse", chouse); 
        model.addAttribute("textinput", textinput); 
        model.addAttribute("categoryid", categoryId); 
        model.addAttribute("typeselect", typeselect);

        
        if (user != null && listrecruitments != null) {
            Map<Integer, Boolean> saveStatusMap = new HashMap<>();
            for (Recruitment rec : listrecruitments) {
                SaveJob savedJob = dangtuyen_service.timjobbyuserandidrecruirement(user, rec.getId());
                saveStatusMap.put(rec.getId(), savedJob != null);
            }
            model.addAttribute("saveStatusMap", saveStatusMap);
        }
        return "home";
	}
}

