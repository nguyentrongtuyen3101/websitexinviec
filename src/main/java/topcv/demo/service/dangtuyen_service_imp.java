package topcv.demo.service;

import java.util.List;

import topcv.demo.entity.ApplyPost;
import topcv.demo.entity.Category;
import topcv.demo.entity.Company;
import topcv.demo.entity.FollowCompany;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import topcv.demo.dao.dangtuyen_dao;
import topcv.demo.entity.Recruitment;
import topcv.demo.entity.SaveJob;
import topcv.demo.entity.User;

@Repository
public class dangtuyen_service_imp implements dangtuyen_service{
	@Autowired
	private dangtuyen_dao dangtuyen_dao;
	@Override
	@Transactional
	public void cereatebaidang(Recruitment recruitment)
	{
		dangtuyen_dao.cereatebaidang(recruitment);
	}
	@Override
	@Transactional
	public List<Category> getcategory()
	{
		return dangtuyen_dao.getcategory();
	}
	@Override
	@Transactional
	public Category getCategory(int id)
	{
		return dangtuyen_dao.getCategory(id);
	}
	@Override
	@Transactional
	public void deletebaidang(int id)
	{
		dangtuyen_dao.deletebaidang(id);
	}
	@Override
	@Transactional
	public List<Recruitment> getRecruitments(User user,int page, int size)
	{
		return dangtuyen_dao.getRecruitments(user,page,size);
	}
	@Override
	@Transactional
	public long getTotalRecruitments(User user)
	{
		return dangtuyen_dao.getTotalRecruitments(user);
	}
	@Override
	@Transactional
	public Recruitment timRecruitmentbyid(int id)
	{
		return dangtuyen_dao.timRecruitmentbyid(id);
	}
	@Override
	@Transactional
	public void updatenumberChoose(int id,int numberChoose)
	{
		dangtuyen_dao.updatenumberChoose(id, numberChoose);
	}
	@Override
	@Transactional
	public List<Recruitment> getlisstRecruitments(String keyword,int page, int size,String type,Category category,String giatritimkiem,Company company)
	{
		return dangtuyen_dao.getlisstRecruitments(keyword, page, size, type, category,giatritimkiem,company);
	}
	@Override
	@Transactional
	public long getTotalRecruitmentsdk(String keyword,String type,Category category,String giatritimkiem,Company company)
	{
		return dangtuyen_dao.getTotalRecruitmentsdk(keyword, type, category,giatritimkiem,company);
	}
	@Override
	@Transactional
	public Company timCompanybynamecompany(String namecompany)
	{
		return dangtuyen_dao.timCompanybynamecompany(namecompany);
	}
	@Override
	@Transactional
	public String createApplyPost(ApplyPost applyPost)
	{
		 return dangtuyen_dao.createApplyPost(applyPost);
	}
	@Override
	@Transactional
	public ApplyPost timApplyPostbybyuserandrecruirement(User user,int idrecruirement)
	{
		return dangtuyen_dao.timApplyPostbybyuserandrecruirement(user, idrecruirement);
	}
	@Override
	@Transactional
	public void deleteapplypost(User user,int recuirementid)
	{
		dangtuyen_dao.deleteapplypost(user, recuirementid);
	}
	@Override
	@Transactional
	public List<ApplyPost> getlisstapplipostbyrecruirement(int recuirementid)
	{
		return dangtuyen_dao.getlisstapplipostbyrecruirement(recuirementid);
	}
	@Override
	@Transactional
	public void savejob(SaveJob saveJob)
	{
		dangtuyen_dao.savejob(saveJob);
	}
	@Override
	@Transactional
	public SaveJob timjobbyuserandidrecruirement(User user,int idrecruirement)
	{
		return dangtuyen_dao.timjobbyuserandidrecruirement(user, idrecruirement);
	}
	public void deleteSaveJob(User user, int recruitmentId)
	{
		dangtuyen_dao.deleteSaveJob(user, recruitmentId);
	}
	@Override
	@Transactional
	public void folowcompany(FollowCompany followCompany)
	{
		dangtuyen_dao.folowcompany(followCompany);
	}
	@Override
	@Transactional
	public FollowCompany timFollowCompanybyuserandidrecruirement(User user,int companyId)
	{
		return dangtuyen_dao.timFollowCompanybyuserandidrecruirement(user, companyId);
	}
	@Override
	@Transactional
	public void deleteFollowCompany(User user, int companyId)
	{
		dangtuyen_dao.deleteFollowCompany(user, companyId);
	}
}
