package topcv.demo.service;

import java.beans.Transient;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import topcv.demo.dao.account_dao;
import topcv.demo.entity.CV;
import topcv.demo.entity.Company;
import topcv.demo.entity.User;
import topcv.demo.entity.User.Role;

@Service
public class account_service_imp implements account__service{
	@Autowired
	private account_dao account_dao;
	@Autowired
	private JavaMailSender mailSender;
	 private static final String UPLOAD_DIR = "/uploads"; 
	    @Autowired
	    private ServletContext servletContext;

	@Override
	@Transactional
	public boolean checkFirstacc()
	{
		return account_dao.checkFirstacc();
	}
	@Override
	@Transactional
	public void saveorupdate(User user)
	{
		account_dao.saveorupdate(user);
	}
	@Override
	@Transactional
    public User timaccountbygmail(String gmail)
    {
		return account_dao.timaccountbygmail(gmail);
    }
	@Override
	@Transactional
	public String encryptPassword(String password)
	{
		return BCrypt.hashpw(password, BCrypt.gensalt(12));
	}
	@Override
	@Transactional
	public String dangkytaikhoan(User user)
	{
		User user2=timaccountbygmail(user.getEmail());
		if(user2!=null)
		{
			return"error: Tai khoan nay da duoc dang ky !!!";
		}
		boolean isThefirstuserUser=!checkFirstacc();
		if(isThefirstuserUser)
		{
			user.setRoleName(User.Role.ADMIN);
		}
		String encryptedPassword = encryptPassword(user.getPassword());
        user.setPassword(encryptedPassword);
		saveorupdate(user);
		return"success: Dang ky tia khoan thanh cong !!!";
	}
	@Override
    @Transactional
    public User login(String email, String password) {
        User user = timaccountbygmail(email); // Sử dụng timaccountbygmail để lấy thông tin
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user; // Trả về user nếu mật khẩu khớp
        }
        return null; // Trả về null nếu không khớp
    }
	@Override
	@Transactional
	public void updatemk( String gmail, String mkmoi)
	{
		String encryptedPassword = encryptPassword(mkmoi);
		account_dao.updatemk(gmail, encryptedPassword);
	}
	 @Override
	  public String sendOtp(String email) {
	       String otp = String.valueOf((int) (Math.random() * 900000) + 100000); // OTP 6 chữ số

	       // Gửi email trực tiếp
	       SimpleMailMessage message = new SimpleMailMessage();
	       message.setTo(email);
	       message.setSubject("Your OTP for Password Reset");
	       message.setText("Your OTP to reset your password is: " + otp + "\nThis OTP is valid for 5 minutes.");
	       message.setFrom("tinhluc2@gmail.com"); // Thay bằng email của bạn

	       mailSender.send(message);

	       return otp; // Trả về OTP để frontend lưu
	   }
	 @Override
	 @Transactional
	 public void updateaccount( User user)
	 {
		 account_dao.updateaccount(user);
	 }
	 @Override
	 @Transactional
	 public String capnhatthongtintaikhoan( User user,MultipartFile descriptionFile)
	 {
		 User user2=timaccountbygmail(user.getEmail());
			if(user2==null)
			{
				return"error";
			}
			if (descriptionFile != null && !descriptionFile.isEmpty()) {
	            String uploadResult = uploadDescriptionFile(descriptionFile, "description");
	            if (uploadResult.startsWith("error:")) {
	                return uploadResult; // Trả về lỗi từ uploadDescriptionFile
	            }
	            user.setDescription(uploadResult); // Gán tên file vào description
	        }
			updateaccount(user);
			return"success";
	 }
	 @Override
	 @Transactional
	 public void uploadanh(User user) {
		 account_dao.uploadanh(user);
	 }
	 @Override
	 @Transactional
	 public String updateanhvaodb( User user)
	 {
		 User user2=timaccountbygmail(user.getEmail());
			if(user2==null)
			{
				return"error";
			}
			uploadanh(user);
			return"success";
	 }
	 @Override
	 @Transactional
	 public String uploadFile(MultipartFile file, User user, String fileType, Company company) {
	     if (file == null || file.isEmpty()) {
	         return "error: Vui lòng chọn một file ảnh!";
	     }

	     try {
	         // Lấy đường dẫn thực tế của thư mục uploads từ ServletContext
	         String realPath = servletContext.getRealPath(UPLOAD_DIR);
	         Path uploadPath = Paths.get(realPath);
	         if (!Files.exists(uploadPath)) {
	             Files.createDirectories(uploadPath);
	         }

	         // Lấy phần mở rộng và tên file gốc
	         String originalFileName = file.getOriginalFilename();
	         String fileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();
	         // Danh sách các định dạng ảnh hợp lệ
	         Set<String> validImageExtensions = new HashSet<>(Arrays.asList(".jpg", ".jpeg", ".png", ".gif", ".bmp"));
	         if (!validImageExtensions.contains(fileExtension)) {
	             return "error: File không phải là ảnh! Vui lòng chọn file có định dạng .jpg, .jpeg, .png, .gif hoặc .bmp.";
	         }

	         // Kiểm tra thêm loại MIME để đảm bảo là ảnh (tùy chọn)
	         String mimeType = file.getContentType();
	         if (!mimeType.startsWith("image/")) {
	             return "error: File không phải là ảnh! Vui lòng chọn file ảnh hợp lệ.";
	         }

	         // Tạo tên file duy nhất
	         String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

	         Path filePath = uploadPath.resolve(uniqueFileName);
	         Files.write(filePath, file.getBytes());

	         // Cập nhật trường tương ứng trong user hoặc company
	         if ("image".equals(fileType)) {
	             user.setImage(uniqueFileName);
	         } else if ("logo".equals(fileType)) {
	             company.setLogo(uniqueFileName);
	         } else {
	             return "error: Loại file không hợp lệ!";
	         }

	         return "success";
	     } catch (IOException e) {
	         return "error: Lỗi khi upload ảnh: " + e.getMessage();
	     } catch (Exception e) {
	         return "error: Lỗi không mong muốn: " + e.getMessage();
	     }
	 }
	 @Override
	 @Transactional
	 public String uploadDescriptionFile(MultipartFile file, String fileType) {
	     if (file == null || file.isEmpty()) {
	         return "error: Vui lòng chọn một file!";
	     }
	     try {
	         String realPath = servletContext.getRealPath(UPLOAD_DIR);
	         Path uploadPath = Paths.get(realPath);
	         if (!Files.exists(uploadPath)) {
	             Files.createDirectories(uploadPath);
	         }
	         String originalFileName = file.getOriginalFilename();
	         String shortId = generateShortId(6);
	         String uniqueFileName = shortId + "_" + originalFileName;
	         Path filePath = uploadPath.resolve(uniqueFileName);
	         if (Files.exists(filePath)) {
	             // Nếu file tồn tại, thử tạo mã mới
	             shortId = generateShortId(6);
	             uniqueFileName = shortId + "_" + originalFileName;
	             filePath = uploadPath.resolve(uniqueFileName);
	         }
	         Files.write(filePath, file.getBytes());
	         return uniqueFileName;
	     } catch (IOException e) {
	         return "error: Lỗi khi upload file: " + e.getMessage();
	     } catch (Exception e) {
	         return "error: Lỗi không mong muốn: " + e.getMessage();
	     }
	 }
	 private static final String BASE62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	 private String generateShortId(int length) {
	     Random random = new Random();
	     StringBuilder sb = new StringBuilder(length);
	     for (int i = 0; i < length; i++) {
	         sb.append(BASE62.charAt(random.nextInt(BASE62.length())));
	     }
	     return sb.toString();
	 }

	 @Override
	 @Transactional
	 public void saveorupdatecompany(Company company)
	 {
		 account_dao.saveorupdatecompany(company);
	 }
	 @Override
	 @Transactional
	 public Company timcompanybyuserid(User user)
	 {
		 return account_dao.timcompanybyuserid(user);
	 }
	 @Override
	 @Transactional
	 public void updatecompany( Company company)
	 {
		 account_dao.updatecompany(company);
	 }
	 @Override
	 @Transactional
	 public String capnhatthongtincongty(Company company,MultipartFile descriptionFile)
	 {
		 Company company2=timcompanybyuserid(company.getUser());
			if(company2==null)
			{
				return"error";
			}
			if (descriptionFile != null && !descriptionFile.isEmpty()) {
	            String uploadResult = uploadDescriptionFile(descriptionFile, "companyDescription");
	            if (uploadResult.startsWith("error:")) {
	                return uploadResult; // Trả về lỗi từ uploadDescriptionFile
	            }
	            company.setcompanyDescription(uploadResult);
	        }
			updatecompany(company);
			return"success";
	 }
	 @Override
	 @Transactional
	 public void uploadlogo(Company company)
	 {
		 account_dao.uploadlogo(company);
	 }
	 @Override
	 @Transactional
	 public String updatelogovaodb(Company company)
	 {
		 try {
			 uploadlogo(company);
			 return"success";
		} catch (Exception e) {
			return"error";
		}	
	 }
	 @Override
	 @Transactional
	 public void createCV(CV cv)
	 {
		 account_dao.createCV(cv);
	 }
	 @Override
	 @Transactional
	 public String luucvvaodb(CV cv,MultipartFile descriptionFile)
	 {
		 if (descriptionFile != null && !descriptionFile.isEmpty()) {
	            String uploadResult = uploadDescriptionFile(descriptionFile, "fileName");
	            if (uploadResult.startsWith("error:")) {
	                return uploadResult; 
	            }
	            cv.setFileName(uploadResult);
	        }
		 try {
			createCV(cv);
			return"success";
		} catch (Exception e) {
			return"error";
		}
	 }
	 public List<CV> getCV(User user)
	 {
		 return account_dao.getCV(user);
	 }
}


