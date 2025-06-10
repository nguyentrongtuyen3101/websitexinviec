package topcv.demo.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.ServletContext;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import topcv.demo.entity.Company;
import topcv.demo.entity.User;
import topcv.demo.service.account__service;

@Controller
@RequestMapping("/profilecompany")
public class profile_company_controller {
    @Autowired
    private account__service account__service;
    
    private static final String UPLOAD_DIR = "/uploads"; 
    @Autowired
    private ServletContext servletContext;

    @GetMapping("/showprofile_company")
    public String hienthitrangcongty(Model model, HttpSession session) {
        String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user = account__service.timaccountbygmail(gmail);
        if (user != null) {
            model.addAttribute("user", user);
            if (user.getRoleName() == User.Role.COMPANY) 
            {
            	Company company=account__service.timcompanybyuserid(user);
            	if(company!=null)model.addAttribute("company",company);
            	return "profilecompany";
            }  	
            else if ("USER".equals(user.getRoleName().toString())) return "profileuser";
        }
        return "pageadmin";
    }

    @PostMapping("/updateacount")
    public String updateaccount(@ModelAttribute("user") User user, Model model, HttpSession session,@RequestParam(value = "personalDescriptionFile", required = false) MultipartFile descriptionFile) {
        String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
         
        String result = account__service.capnhatthongtintaikhoan(user,descriptionFile);

        if ("error".equals(result)) {
            model.addAttribute("error", "Cập nhật thông tin tài khoản lỗi !!!"); 
        } else {
            model.addAttribute("success", "Cập nhật thông tin tài khoản thành công!");
        }
        return "redirect:/profilecompany/showprofile_company";
    }

    @PostMapping("/uploadimage")
    public String uploadImage(
            @RequestParam("imageFile") MultipartFile imageFile,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in uploadimage: " + gmail);
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }

        User user = account__service.timaccountbygmail(gmail);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy tài khoản!");
            return "redirect:/profilecompany/showprofile_company";
        }
        Company company=new Company();
        String uploadResult = account__service.uploadFile(imageFile, user, "image",company);
        if ("success".equals(uploadResult)) {
            String dbResult = account__service.updateanhvaodb(user);
            if ("success".equals(dbResult)) {
                redirectAttributes.addFlashAttribute("success", "Upload ảnh thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Lỗi khi cập nhật ảnh vào cơ sở dữ liệu!");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", uploadResult);
        }

        return "redirect:/profilecompany/showprofile_company";
    }
    @PostMapping("/updatecompany")
    public String updatecompany(@ModelAttribute("company") Company company, Model model, HttpSession session,@RequestParam(value = "companyDescriptionFile", required = false) MultipartFile descriptionFile) {
        String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user=account__service.timaccountbygmail(gmail);
        if (user == null) {
            return "error: Không tìm thấy người dùng!";
        }
        Company company2=account__service.timcompanybyuserid(user);
        if (company2 == null) {
            return "error: Không tìm thấy thông tin công ty!";
        }
        company2.setEmail(company.getEmail());
        company2.setNameCompany(company.getNameCompany());
        company2.setAddress(company.getAddress());
        company2.setPhoneNumber(company.getPhoneNumber());
        company2.setcompanyDescription(company.getcompanyDescription());
        String result = account__service.capnhatthongtincongty(company2, descriptionFile);

        if ("error".equals(result)) {
            model.addAttribute("error", "Cập nhật thông tin công ty lỗi !!!"); 
        } else {
            model.addAttribute("success", "Cập nhật thông tin công ty thành công!");
        }
        return "redirect:/profilecompany/showprofile_company";
    }

}