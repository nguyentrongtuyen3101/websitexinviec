package topcv.demo.dao;

import java.util.List;
import topcv.demo.entity.Category;

import org.springframework.stereotype.Repository;

import topcv.demo.entity.Recruitment;
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
}
