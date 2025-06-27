package topcv.demo.controller;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.PublicKey;
//import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;

import topcv.demo.entity.ApplyPost;
import topcv.demo.entity.CV;
import topcv.demo.entity.Category;
import topcv.demo.entity.Company;
import topcv.demo.entity.FollowCompany;
import topcv.demo.entity.Recruitment;
import topcv.demo.entity.SaveJob;
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
        if(dangtuyen_service.timApplyPostbybyrecruirement(dangtuyen_service.timRecruitmentbyid(id))!=null)dangtuyen_service.deleteapplypostbycruiment(dangtuyen_service.timRecruitmentbyid(id));
        if(dangtuyen_service.timjobbyrecruirement(id)!=null)dangtuyen_service.deleteSaveJobbyecruiment(id);
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
        if (user == null) {
        	return "redirect:/account/show_form_dangky";
        }
        Company company=new Company();
        int pageSize = 5;
        int totalPages=0;
        List<Recruitment> recruitments=null;
        Long totalRecruitments=null;
        if("COMPANY".equals(user.getRoleName().toString()))
        {
        	company= account__service.timcompanybyuserid(user);
            if (company == null) {
            	return "redirect:/account/show_form_dangnhap";
            }
        	 recruitments = dangtuyen_service.getRecruitments(user, page, pageSize);
             totalRecruitments = dangtuyen_service.getTotalRecruitments(user);  
            totalPages = (int) Math.ceil((double) totalRecruitments / pageSize);
        }

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
	@GetMapping("/showformapplyspost")
	public String showformappltypage(@RequestParam("recruitmentsId")int id,HttpSession session,Model model)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user=account__service.timaccountbygmail(gmail);
        if (user == null) {
        	return "redirect:/account/show_form_dangky";
        }
        Recruitment recruitment=dangtuyen_service.timRecruitmentbyid(id);
        if(recruitment==null)
        {
        	model.addAttribute("error", "Khong co bai dang tuyen dung nay");
        	return "redirect:/home/show_home";
        }
        boolean hasApplied = dangtuyen_service.timApplyPostbybyuserandrecruirement(user, dangtuyen_service.timRecruitmentbyid(id))!= null;
        boolean isfollow=dangtuyen_service.timFollowCompanybyuserandidrecruirement(user, recruitment.getCompany().getId())!=null;
        model.addAttribute("hasApplied", hasApplied);
        model.addAttribute("user",user);
        model.addAttribute("recruitments",recruitment);
        model.addAttribute("applyPost",new ApplyPost());
        model.addAttribute("isfollow",isfollow);
        return"formApplyPost";
	}
	@PostMapping("/applypostaction")
	public String applyPostaction(@ModelAttribute("applyPost") ApplyPost applyPost,@RequestParam("recruitmentsId") int recruitmentID,@RequestParam("chouseCV") boolean chouseCV,Model model,HttpSession session,@RequestParam("fileName") MultipartFile cvFile)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        CV cv=null;
        ApplyPost applyPost2=applyPost;
        applyPost2.setCreatedAt(applyPost.getCreatedAt());
        if(chouseCV)
        {
        	if (user2.getCv()==null) {
				model.addAttribute("failCV", "Bạn chưa chọn cv mạc định hoặc chưa có cv !!!");
				return"redirect:/dangtuyen/showformapplyspost?recruitmentsId="+recruitmentID;
			}
        	cv=account__service.timCvbyid(user2.getCv().getId());
        	applyPost2.setNameCv(cv.getFileName());
        }
        else {
	        if (cvFile == null || cvFile.isEmpty()) {
	            model.addAttribute("error", "Vui lòng chọn một tệp CV!");
	            return"redirect:/dangtuyen/showformapplyspost?recruitmentsId="+recruitmentID;
	        }
	        String fileName = cvFile.getOriginalFilename();
	        String fileExt = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
	        String[] validExts = {"pdf", "doc", "docx", "png", "jpg", "jpeg"};
	        if (!List.of(validExts).contains(fileExt)) {
	            model.addAttribute("error", "Định dạng tệp không hợp lệ! Chỉ chấp nhận .pdf, .doc, .docx, .png, .jpg, .jpeg.");
	            return"redirect:/dangtuyen/showformapplyspost?recruitmentsId="+recruitmentID;
	        }
	        CV cv2=new CV();
	        cv2.setUser(user2);
	        String result=account__service.luucvvaodb(cv2, cvFile);
	        if ("error".equals(result)) {
	            model.addAttribute("error", "Upload Cv that bai"); 
	        } else {
	            account__service.updateCVdefault(user2, account__service.getidcvmoinhat(user2));
	        }
        	applyPost2.setNameCv(fileName);
		}
        applyPost2.setRecruitment(dangtuyen_service.timRecruitmentbyid(recruitmentID));
        applyPost2.setStatus(0);
        applyPost2.setText(applyPost.getText());
        applyPost2.setUser(user2);
        String createapplypoString=dangtuyen_service.createApplyPost(applyPost2);
        if("welldone".equals(createapplypoString))model.addAttribute("welldone", "Bạn đã ứng tuyển thành công");
        else model.addAttribute("fail","Ứng tuyển công việc thất bại !!!");
        return"redirect:/dangtuyen/showformapplyspost?recruitmentsId="+recruitmentID;
	}
	@PostMapping("/deleteapplypost")
	public String deleteapplypost(@RequestParam("recruitmentsId") int id,HttpSession session,Model model)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        dangtuyen_service.deleteapplypost(user2, dangtuyen_service.timRecruitmentbyid(id));
        return"redirect:/dangtuyen/showformapplyspost?recruitmentsId="+id;
	}
	@GetMapping("/showformchitietbaidang")
	public String showformchitietbaidang(Model model,HttpSession session,@RequestParam("recruitmentsId")int recruitmentsId)
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
        Recruitment recruitment=dangtuyen_service.timRecruitmentbyid(recruitmentsId);
        List<ApplyPost> listaApplyPosts=dangtuyen_service.getlisstapplipostbyrecruirement(dangtuyen_service.timRecruitmentbyid(recruitmentsId));
        model.addAttribute("recruitment",recruitment);
        model.addAttribute("listaApplyPosts",listaApplyPosts);
        model.addAttribute("user",user);
        return "chitietbaodang";
	}
	@GetMapping("luucongviec")
	public String luucongviec(@RequestParam("recruitmentsId") int id,HttpSession session,Model model,@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "categoryid", defaultValue = "0") int categoryId,
	        @RequestParam(value = "textinput", defaultValue = "") String textinput,
	        @RequestParam(value = "chouse", defaultValue = "1") int chouse,
	        @RequestParam(value = "typeselect", defaultValue = "") String typeselect,
			@RequestParam(value = "source", defaultValue = "home") String source)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        SaveJob saveJob = dangtuyen_service.timjobbyuserandidrecruirement(user2, id);
        if (saveJob != null) {
            
            dangtuyen_service.deleteSaveJob(user2, id);
        } else {
           
            saveJob = new SaveJob();
            saveJob.setRecruitmentId(id);
            saveJob.setUser(user2);
            dangtuyen_service.savejob(saveJob);
        }
        
        if("home".equals(source))
        {
        	List<Recruitment>recruitments=dangtuyen_service.getnewlistRecruitments();
    		List<Category> categories=dangtuyen_service.getTop4CategoriesByJobCount();
    		model.addAttribute("recruitments",recruitments);
    		model.addAttribute("categories",categories);
        	model.addAttribute("chouse", chouse); 
            model.addAttribute("textinput", textinput); 
            model.addAttribute("categoryid", categoryId); 
            model.addAttribute("typeselect", typeselect);
        	return"redirect:/home/timkiemlob?page="+page;
       	}
        else if("listsavejob".equals(source))return"redirect:/dangtuyen/showformlistsavejob?page="+page;
        return "redirect:/account/show_form_dangnhap";
	}
	@PostMapping("/followcompany")
	public String luucongviec(@RequestParam(value = "recruitmentsId",defaultValue = "0") int id,HttpSession session,Model model,@RequestParam("source")String source,@RequestParam(value = "companyID",defaultValue = "0")int idcompany)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        
        FollowCompany followCompany=new FollowCompany();
        if("applipost".equals(source))
        {
        	Recruitment recruitment=dangtuyen_service.timRecruitmentbyid(id);
        	followCompany.setCompanyId(recruitment.getCompany().getId());
        	followCompany.setCompany(recruitment.getCompany());
        }
        else if("chitietcompany".equals(source))
        {
        	followCompany.setCompanyId(idcompany);
        	followCompany.setCompany(account__service.timcompanybyid(idcompany));
        }
        followCompany.setUser(user2);
        dangtuyen_service.folowcompany(followCompany);
        if("applipost".equals(source))return"redirect:/dangtuyen/showformapplyspost?recruitmentsId="+id;
        else if("chitietcompany".equals(source))return"redirect:/dangtuyen/showcompanybyid?companyID="+idcompany;
        return "redirect:/account/show_form_dangnhap";
	}
	@PostMapping("/deletefollow")
	public String deletefollow(@RequestParam(value = "recruitmentsId",defaultValue = "0") int id,HttpSession session,Model model,@RequestParam("source")String source,@RequestParam(value = "companyID",defaultValue = "0")int idcompany)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        if("applipost".equals(source))
        {
        	Recruitment recruitment=dangtuyen_service.timRecruitmentbyid(id);
            dangtuyen_service.deleteFollowCompany(user2, recruitment.getCompany().getId());
        	return"redirect:/dangtuyen/showformapplyspost?recruitmentsId="+id;
       	}
        else if("chitietcompany".equals(source))
        {
        	dangtuyen_service.deleteFollowCompany(user2,idcompany);
        	return"redirect:/dangtuyen/showcompanybyid?companyID="+idcompany;
        }
        return "redirect:/account/show_form_dangnhap";
	}
	@GetMapping("/showformlistsavejob")
	public String showlistsavejob(Model model, HttpSession session,
			@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "companyID", required = false) Integer companyID) {
		String gmail = (String) session.getAttribute("userEmail");
		System.out.println("userEmail in profile_company_controller: " + gmail);
		if (gmail == null) {
			System.out.println("userEmail is null, redirecting to login page");
			return "redirect:/account/show_form_dangnhap";
		}
		User user = account__service.timaccountbygmail(gmail);
		if (user == null) {
			System.out.println("userEmail is null, redirecting to login page");
			return "redirect:/account/show_form_dangky";
		}
		int pageSize = 5;
		List<Recruitment> recruitments;
		long totalRecruitments;
		int totalPages;
		Company company = null;
		String title = "Danh Sách Công Việc Đã Lưu";
		if (companyID != null && companyID > 0) {
			company = account__service.timcompanybyid(companyID);
			if (company == null) {
				System.out.println("Company not found for companyID = " + companyID);
				return "redirect:/home/show_home";
			}
			recruitments = dangtuyen_service.getRecruitmentsbycompany(company, page, pageSize);
			totalRecruitments = dangtuyen_service.getTotalRecruitmentsbycompany(company);
			title = "Danh Sách Bài Đăng Của " + company.getNameCompany();
		} else {
			recruitments = dangtuyen_service.getSavedRecruitmentsByUser(user, page, pageSize);
			totalRecruitments = dangtuyen_service.getTotalSavedRecruitments(user);
		}
		totalPages = (int) Math.ceil((double) totalRecruitments / pageSize);

		model.addAttribute("recruitments", recruitments);
		model.addAttribute("user", user);
		model.addAttribute("company", company);
		model.addAttribute("currentPage", page);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("totalRecruitments", totalRecruitments);
		model.addAttribute("now", new Date());
		model.addAttribute("title", title);
		return "listsavejob";
	}
	@GetMapping("/showlistfollowcompany")
	public String showlistfollowcompany(Model model,HttpSession session,@RequestParam(value = "page", defaultValue = "0") int page)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        int pageSize = 5;
        List<FollowCompany> followCompanies = dangtuyen_service.getlistFollowCompanies(user2, page, pageSize);
        long totalfollowcompany = dangtuyen_service.gettotalFollowCompanies(user2);
        
        int totalPages = (int) Math.ceil((double) totalfollowcompany / pageSize);

        model.addAttribute("followCompanies", followCompanies);
        model.addAttribute("user", user2);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalfollowcompany", totalfollowcompany);
        model.addAttribute("now", new Date()); 
        return"listfollowcompany";
	}
	@PostMapping("/showdanhsachcongviectheocompany")
	public String showdanhsachcongviectheocompany(Model model,HttpSession session,@RequestParam(value = "page", defaultValue = "0") int page,@RequestParam("companyID")int id)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        int pageSize = 5;
        Company company=account__service.timcompanybyid(id);
        
        List<Recruitment> recruitments = dangtuyen_service.getRecruitmentsbycompany(company, page, pageSize);
        long totalfollowcompany = dangtuyen_service.getTotalRecruitmentsbycompany(company);
        
        int totalPages = (int) Math.ceil((double) totalfollowcompany / pageSize);

        model.addAttribute("recruitments", recruitments);
        model.addAttribute("user", user2);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalfollowcompany", totalfollowcompany);
        model.addAttribute("now", new Date()); 
        return"redirect:/dangtuyen/listsavejob";
	}
	@GetMapping("/listungvien")
	public String listungvien(Model model,HttpSession session)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null && "COMPANY".equals(user2.getRoleName().toString())) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        List<ApplyPost> applyPosts=dangtuyen_service.getlistApplyPosts(user2);
        model.addAttribute("user",user2);
        model.addAttribute("applyPosts", applyPosts);
        return"listungvien";
	}
	@GetMapping("/showcompanybyid")
	public String showcompany(Model model,HttpSession session,@RequestParam("companyID") int id)
	{
		String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user2 == null && "COMPANY".equals(user2.getRoleName().toString())) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangky";
        }
        boolean isfollow=dangtuyen_service.timFollowCompanybyuserandidrecruirement(user2, id)!=null;
        Company company=account__service.timcompanybyid(id);
        model.addAttribute("company",company);
        model.addAttribute("user",user2);
        model.addAttribute("isfollow",isfollow);
        System.out.print("welldone");
        return "companychitiet";
	}
}