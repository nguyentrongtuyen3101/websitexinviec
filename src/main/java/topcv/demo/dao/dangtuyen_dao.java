package topcv.demo.dao;

import java.util.List;

import topcv.demo.entity.ApplyPost;
import topcv.demo.entity.Category;
import topcv.demo.entity.Company;
import topcv.demo.entity.FollowCompany;

import org.springframework.stereotype.Repository;

import topcv.demo.entity.Recruitment;
import topcv.demo.entity.SaveJob;
import topcv.demo.entity.User;

@Repository
public interface dangtuyen_dao {
	public void cereatebaidang(Recruitment recruitment);
	public List<Category> getcategory();
	public Category getCategory(int id);
	public void deletebaidang(int id);
	public List<Recruitment> getRecruitments(User user,int page, int size);
	public long getTotalRecruitments(User user);
	public Recruitment timRecruitmentbyid(int id);
	public void updatenumberChoose(int id,int numberChoose);
	public List<Recruitment> getlisstRecruitments(String keyword,int page, int size,String type,Category category,String giatritimkiem,Company company);
	public long getTotalRecruitmentsdk(String keyword,String type,Category category,String giatritimkiem,Company company);
	public Company timCompanybynamecompany(String namecompany);
	public String createApplyPost(ApplyPost applyPost);
	public ApplyPost timApplyPostbybyuserandrecruirement(User user,Recruitment recruirement);
	public void deleteapplypost(User user,Recruitment recuirement);
	public List<ApplyPost> getlisstapplipostbyrecruirement(Recruitment recuirement);
	public void savejob(SaveJob saveJob);
	public SaveJob timjobbyuserandidrecruirement(User user,int idrecruirement);
	public void deleteSaveJob(User user, int recruitmentId);
	public void folowcompany(FollowCompany followCompany);
	public FollowCompany timFollowCompanybyuserandidrecruirement(User user,int companyId);
	public void deleteFollowCompany(User user, int companyId);
	public long getTotalSavedRecruitments(User user);
	public List<Recruitment> getSavedRecruitmentsByUser(User user, int page, int size);
	public List<FollowCompany> getlistFollowCompanies(User user,int page,int size);
	public Long gettotalFollowCompanies(User user);
	public List<Recruitment> getRecruitmentsbycompany(Company company,int page, int size);
	public long getTotalRecruitmentsbycompany(Company company );
	public SaveJob timjobbyrecruirement(int idrecruirement);
	public void deleteSaveJobbyecruiment( int recruitmentId);
	public ApplyPost timApplyPostbybyrecruirement(Recruitment recruitment);
	public void deleteapplypostbycruiment(Recruitment recruitment);
	public List<ApplyPost> getlistApplyPosts(User user);
	public List<Recruitment> getnewlistRecruitments();
	public List<Category> getTop4CategoriesByJobCount();
}
