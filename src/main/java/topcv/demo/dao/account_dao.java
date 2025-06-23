package topcv.demo.dao;

import java.awt.desktop.UserSessionEvent;
import java.util.List;

import javax.swing.table.TableStringConverter;

import org.springframework.stereotype.Repository;

import topcv.demo.entity.CV;
import topcv.demo.entity.Company;
import topcv.demo.entity.User;

@Repository
public interface account_dao {
	public boolean checkFirstacc();
	public void saveorupdate(User user);
	public User timaccountbygmail(String gmail);
	public void updatemk( String gmail, String mkmoi);
	public void updateaccount( User user);
	public void uploadanh(User user);
	public void uploadlogo(Company company);
	public void saveorupdatecompany(Company company);
	public Company timcompanybyuserid(User user);
	public void updatecompany( Company company);
	public void createCV(CV cv);
	public List<CV> getCV(User user);
	public void deletecv(int id);
	public void updateCVdefault(User user,CV cv);
	public CV timCvbyid(Integer id);
	public CV getidcvmoinhat(User user);
	public CV timcvbyfilenamr(String fileName);
}
