package topcv.demo.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import topcv.demo.entity.CV;
import topcv.demo.entity.Company;
import topcv.demo.entity.User;

public interface account__service {
	public boolean checkFirstacc();
	public void saveorupdate(User user);
    public User timaccountbygmail(String gmail);
	public String dangkytaikhoan(User user);
	String encryptPassword(String password);
	public User login(String email, String password);
	public void updatemk( String gmail, String mkmoi);
	public String sendOtp(String email);
	public void updateaccount( User user);
	public String capnhatthongtintaikhoan( User user,MultipartFile descriptionFile);
	public void uploadanh(User user);
	public String updateanhvaodb( User user);
	public String uploadFile(MultipartFile file, User user, String fileType,Company company);
	public String uploadDescriptionFile(MultipartFile file, String fileType);
	public void saveorupdatecompany(Company company);
	public Company timcompanybyuserid(User user);
	public void updatecompany( Company company);
	public String capnhatthongtincongty( Company company,MultipartFile descriptionFile);
	public void uploadlogo(Company company);
	public String updatelogovaodb( Company company);
	public void createCV(CV cv);
	public String luucvvaodb(CV cv,MultipartFile descriptionFile);
	public List<CV> getCV(User user);
	public void deletecv(int id);
	public void updateCVdefault(User user,int id);
}
