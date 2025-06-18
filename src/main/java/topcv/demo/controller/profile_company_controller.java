package topcv.demo.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
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

import topcv.demo.entity.CV;
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
            else if ("USER".equals(user.getRoleName().toString())) 
            {
            	List<CV> cvList = account__service.getCV(user);
                model.addAttribute("cvList", cvList);
                model.addAttribute("cv", new CV()); 
                return "profileuser";
            }
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
        User user2=account__service.timaccountbygmail(gmail);
        user2.setEmail(user.getEmail());
        user2.setFullName(user.getFullName());
        user2.setAddress(user.getAddress());
        user2.setPhoneNumber(user.getPhoneNumber());
     // Xử lý file mô tả
        if (descriptionFile != null && !descriptionFile.isEmpty()) {
            // Có file mới, xử lý upload
            String uploadResult = account__service.uploadDescriptionFile(descriptionFile, "description");
            if (uploadResult.startsWith("error:")) {
                model.addAttribute("error", "Lỗi khi upload file mô tả: " + uploadResult);
                return "redirect:/profilecompany/showprofile_company";
            }
            user2.setDescription(uploadResult); // Cập nhật tên file mới
        } else {
            // Giữ file cũ từ hidden input nếu có, nếu không thì dùng từ user2
            String existingDescription = user.getDescription(); // Từ hidden input
            if (existingDescription != null && !existingDescription.isEmpty()) {
                user2.setDescription(existingDescription); // Giữ file cũ từ hidden
            } else if (user2.getDescription() != null && !user2.getDescription().isEmpty()) {
                user2.setDescription(user2.getDescription()); // Giữ file cũ từ database
            } else {
                user2.setDescription(null); // Không có file cũ
            }
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
     // Xử lý file mô tả
        if (descriptionFile != null && !descriptionFile.isEmpty()) {
            // Có file mới, xử lý upload
            String uploadResult = account__service.uploadDescriptionFile(descriptionFile, "companyDescription");
            if (uploadResult.startsWith("error:")) {
                model.addAttribute("error", "Lỗi khi upload file mô tả: " + uploadResult);
                return "redirect:/profilecompany/showprofile_company";
            }
            company2.setcompanyDescription(uploadResult); // Cập nhật tên file mới
        } else {
            // Giữ file cũ từ hidden input nếu có, nếu không thì dùng từ company2
            String existingDescription = company.getcompanyDescription(); // Từ hidden input
            if (existingDescription != null && !existingDescription.isEmpty()) {
                company2.setcompanyDescription(existingDescription); // Giữ file cũ từ hidden
            } else if (company2.getcompanyDescription() != null && !company2.getcompanyDescription().isEmpty()) {
                company2.setcompanyDescription(company2.getcompanyDescription()); // Giữ file cũ từ database
            } else {
                company2.setcompanyDescription(null); // Không có file cũ
            }
        }
        String result = account__service.capnhatthongtincongty(company2, descriptionFile);
        if ("error".equals(result)) {
            model.addAttribute("error", "Cập nhật thông tin công ty lỗi !!!"); 
        } else {
            model.addAttribute("success", "Cập nhật thông tin công ty thành công!");
        }
        return "redirect:/profilecompany/showprofile_company";
    }
    @PostMapping("/uploadlogo")
    public String uploadlogo(
            @RequestParam("logoFile") MultipartFile logoFile,
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
        Company company2=account__service.timcompanybyuserid(user);
        if (company2 == null) {
            return "error: Không tìm thấy thông tin công ty!";
        }
        company2.setUser(user);
        String uploadResult = account__service.uploadFile(logoFile, user, "logo",company2);
        if ("success".equals(uploadResult)) {
            String dbResult = account__service.updatelogovaodb(company2);
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
    @PostMapping("/uploadcv")
    public String uploadcv(@RequestParam("userEmail") String userEmail,@RequestParam("fileName") MultipartFile cvFile,Model model,HttpSession session) {
        String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }

        User user = account__service.timaccountbygmail(gmail);
        if (user == null) {
            model.addAttribute("error", "Không tìm thấy người dùng!");
            return "redirect:/profilecompany/showprofile_company";
        }

        // Kiểm tra file
        if (cvFile == null || cvFile.isEmpty()) {
            model.addAttribute("error", "Vui lòng chọn một tệp CV!");
            return "redirect:/profilecompany/showprofile_company";
        }

        // Kiểm tra định dạng file
        String fileName = cvFile.getOriginalFilename();
        String fileExt = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
        String[] validExts = {"pdf", "doc", "docx", "png", "jpg", "jpeg"};
        if (!List.of(validExts).contains(fileExt)) {
            model.addAttribute("error", "Định dạng tệp không hợp lệ! Chỉ chấp nhận .pdf, .doc, .docx, .png, .jpg, .jpeg.");
            return "redirect:/profilecompany/showprofile_company";
        }

        CV cv = new CV();
        cv.setUser(user);
        String result = account__service.luucvvaodb(cv, cvFile);

        if ("error".equals(result)) {
            model.addAttribute("error", "Lưu CV thất bại !!!"); 
        } else {
            model.addAttribute("success", "Lưu CV thành công");
        }
        return "redirect:/profilecompany/showprofile_company";
    }
    @PostMapping("deleteCV")
    public String xoacv(@RequestParam("idcv") int id,HttpSession session)
    {
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
        if(user.getCvId()==id)account__service.updateCVdefault(user, 0);
        account__service.deletecv(id);
        return "redirect:/profilecompany/showprofile_company";
    }
    @PostMapping("updateCVdefault")
    public String updatecvdefault(@RequestParam("idcv")int id,@ModelAttribute("user")User user,HttpSession session)
    {
    	String gmail = (String) session.getAttribute("userEmail");
        System.out.println("userEmail in profile_company_controller: " + gmail); 
        if (gmail == null) {
            System.out.println("userEmail is null, redirecting to login page");
            return "redirect:/account/show_form_dangnhap";
        }
        User user2=account__service.timaccountbygmail(gmail);
        if (user == null) {
            return "error: Không tìm thấy người dùng!";
        }
        else account__service.updateCVdefault(user2, id);
        return "redirect:/profilecompany/showprofile_company";
    }
}