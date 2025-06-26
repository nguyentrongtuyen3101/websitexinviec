package topcv.demo.dao;

import java.sql.Savepoint;
import java.util.Collections;
import java.util.List;
import topcv.demo.entity.Category;
import topcv.demo.entity.Company;
import topcv.demo.entity.FollowCompany;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import topcv.demo.entity.ApplyPost;
import topcv.demo.entity.CV;
import topcv.demo.entity.Recruitment;
import topcv.demo.entity.SaveJob;
import topcv.demo.entity.User;

@Repository
public class dangtuyen_dao_imp implements dangtuyen_dao{
	@Autowired
	private SessionFactory sessionFactory;
	@Override
	@Transactional
	public void cereatebaidang(Recruitment recruitment)
	{
		Session session=sessionFactory.getCurrentSession();
		session.saveOrUpdate(recruitment);
	}
	 @Override
	 @Transactional
		public List<Category> getcategory()
		{
			 Session currentSession = sessionFactory.getCurrentSession();
		      Query<Category> theQuery = currentSession.createQuery("from Category", Category.class);
		      return theQuery.getResultList();
		}
	 @Override
	 @Transactional
	 public Category getCategory(int id)
	 {
		 Session currentSession = sessionFactory.getCurrentSession();
	      Query<Category> theQuery = currentSession.createQuery("from Category where id=:id", Category.class);
	      theQuery.setParameter("id", id);
	      return theQuery.uniqueResult();
	 }
	 @Override
	 @Transactional
	 public void deletebaidang(int id)
	 {
		 Session session=sessionFactory.getCurrentSession();
			Query query=session.createQuery("delete from Recruitment where id=:id");
			query.setParameter("id", id);
			query.executeUpdate();
	 }
	 @Override
	 @Transactional
		public List<Recruitment> getRecruitments(User user,int page, int size)
		{
			 Session currentSession = sessionFactory.getCurrentSession();
		      Query<Recruitment> theQuery = currentSession.createQuery("from Recruitment where user=:user ORDER BY id DESC", Recruitment.class);
		      theQuery.setParameter("user", user);
		      theQuery.setFirstResult(page*size);
		      theQuery.setMaxResults(size);
		      return theQuery.getResultList();
		}
	 @Override
	    @Transactional
	    public long getTotalRecruitments(User user) {
	        Session currentSession = sessionFactory.getCurrentSession();
	        Query<Long> theQuery = currentSession.createQuery("select count(*) from Recruitment where user=:user", Long.class);
	        theQuery.setParameter("user", user);
	        return theQuery.uniqueResult();
	    }
	 @Override
	 @Transactional
	 public Recruitment timRecruitmentbyid(int id)
	 {
		 Session session=sessionFactory.getCurrentSession();
		 Query<Recruitment> theQuery=session.createQuery("from Recruitment where id=:id", Recruitment.class);
		 theQuery.setParameter("id",id);
		 return theQuery.uniqueResult();
	 }
	 @Override
	 @Transactional
	 public void updatenumberChoose(int id,int numberChoose)
	 {
		 Session session = sessionFactory.getCurrentSession();
	        Query query = session.createQuery("UPDATE Category SET numberChoose = :numberChoose WHERE id = :id");
	        query.setParameter("id", id);
	        query.setParameter("numberChoose", numberChoose);
	        query.executeUpdate();
	 }
	 @Override
	 @Transactional
	public List<Recruitment> getlisstRecruitments(String keyword,int page, int size,String type,Category category,String giatritimkiem,Company company)
	{
		 Session currentSession = sessionFactory.getCurrentSession();
		 String truyvandefaultString="";
		 if(company==null)truyvandefaultString="FROM Recruitment WHERE "+ keyword +" LIKE :truongan ";
		 else truyvandefaultString="FROM Recruitment WHERE "+ keyword +" =:company ";
		 StringBuilder truyvanString = new StringBuilder(truyvandefaultString);
		 String truyvantype="AND type LIKE:type";
		 String truyvancategory="AND category=:Category";
		 if(type!=null&& !type.trim().isEmpty()) truyvanString.append(truyvantype);
         if(category !=null)truyvanString.append(truyvancategory);
	      Query<Recruitment> theQuery = currentSession.createQuery(truyvanString.toString()+" ORDER BY id DESC",Recruitment.class);
	      if(company==null)theQuery.setParameter("truongan", "%"+ giatritimkiem +"%");
	      else theQuery.setParameter("company", company);
	      if(category!=null)theQuery.setParameter("Category", category);
	      if(type!=null && !type.trim().isEmpty())theQuery.setParameter("type", type);
	      theQuery.setFirstResult(page*size);
	      theQuery.setMaxResults(size);
	      return theQuery.getResultList();
	}
	 @Override
	 @Transactional
	public long getTotalRecruitmentsdk(String keyword,String type,Category category,String giatritimkiem,Company company)
	{
		 Session currentSession = sessionFactory.getCurrentSession();
		 String truyvandefaultString="";
		 if(company==null)truyvandefaultString="select count(*) FROM Recruitment WHERE "+ keyword +" LIKE :truongan ";
		 else truyvandefaultString="select count(*) FROM Recruitment WHERE "+ keyword +" =:company ";
		 StringBuilder truyvanString = new StringBuilder(truyvandefaultString);
		 String truyvantype="AND type LIKE:type";
		 String truyvancategory="AND category=:Category";
		 if(type!=null&& !type.trim().isEmpty()) truyvanString.append(truyvantype);
         if(category !=null)truyvanString.append(truyvancategory);
	      Query<Long> theQuery = currentSession.createQuery(truyvanString.toString(),Long.class);
	      if(company==null)theQuery.setParameter("truongan", "%"+ giatritimkiem +"%");
	      else theQuery.setParameter("company", company);
	      if(category!=null)theQuery.setParameter("Category", category);
	      if(type!=null&&!type.trim().isEmpty())theQuery.setParameter("type", type);
	      return theQuery.uniqueResult();
	}
	 @Override
	 @Transactional
	 public Company timCompanybynamecompany(String namecompany)
	 {
		 Session session = sessionFactory.getCurrentSession();
         Query<Company> query = session.createQuery("FROM Company WHERE nameCompany LIKE :nameCompany", Company.class);
         query.setParameter("nameCompany", "%"+ namecompany +"%");
         return query.uniqueResult();
         
	 }
	 @Override
	 @Transactional
	 public String createApplyPost(ApplyPost applyPost)
	 {
		 
			 Session session =sessionFactory.getCurrentSession();
			 session.saveOrUpdate(applyPost);
			 return"welldone";
	 }
	 @Override
	 @Transactional
	 public ApplyPost timApplyPostbybyuserandrecruirement(User user,Recruitment recruitment)
	 {
		 Session session = sessionFactory.getCurrentSession();
         Query<ApplyPost> query = session.createQuery("FROM ApplyPost WHERE user=:user and recruitment=:recruitment", ApplyPost.class);
         query.setParameter("user",user);
         query.setParameter("recruitment", recruitment);
         return query.uniqueResult();
	 }
	 @Override
	 @Transactional
	 public void deleteapplypost(User user,Recruitment recruitment)
	 {
		 Session session=sessionFactory.getCurrentSession();
			Query query=session.createQuery("delete from ApplyPost where user=:user and recruitment=:recruitment");
			query.setParameter("user", user);
			query.setParameter("recruitment", recruitment);
			query.executeUpdate();
	 }
	 @Override
	 @Transactional
	 public List<ApplyPost> getlisstapplipostbyrecruirement(Recruitment recuirement)
		{
			 Session currentSession = sessionFactory.getCurrentSession();
		      Query<ApplyPost> theQuery = currentSession.createQuery("from ApplyPost where recruitment=:recruitment ORDER BY id DESC", ApplyPost.class);
		      theQuery.setParameter("recruitment", recuirement);
		      return theQuery.getResultList();
		}
	 @Override
	 @Transactional
	 public void savejob(SaveJob saveJob)
	 {
		 Session session=sessionFactory.getCurrentSession();
		 session.saveOrUpdate(saveJob);
	 }
	 @Override
	 @Transactional
	 public SaveJob timjobbyuserandidrecruirement(User user,int idrecruirement)
	 {
		 Session currentSession = sessionFactory.getCurrentSession();
	      Query<SaveJob> theQuery = currentSession.createQuery("from SaveJob where recruitmentId=:recruitmentId and user=:user", SaveJob.class);
	      theQuery.setParameter("recruitmentId", idrecruirement);
	      theQuery.setParameter("user", user);
	      return theQuery.uniqueResult();
	 }
	 @Override
	 @Transactional
	 public void deleteSaveJob(User user, int recruitmentId) {
	     Session session = sessionFactory.getCurrentSession();
	     Query query = session.createQuery("delete from SaveJob where user=:user and recruitmentId=:recruitmentId");
	     query.setParameter("user", user);
	     query.setParameter("recruitmentId", recruitmentId);
	     query.executeUpdate();
	 }
	 @Override
	 @Transactional
	 public void folowcompany(FollowCompany followCompany)
	 {
		 Session session=sessionFactory.getCurrentSession();
		 session.saveOrUpdate(followCompany);
	 }
	 @Override
	 @Transactional
	 public FollowCompany timFollowCompanybyuserandidrecruirement(User user,int companyId)
	 {
		 Session currentSession = sessionFactory.getCurrentSession();
	      Query<FollowCompany> theQuery = currentSession.createQuery("from FollowCompany where companyId=:companyId and user=:user", FollowCompany.class);
	      theQuery.setParameter("companyId", companyId);
	      theQuery.setParameter("user", user);
	      return theQuery.uniqueResult();
	 }
	 @Override
	 @Transactional
	public void deleteFollowCompany(User user, int companyId)
	{
		 Session session = sessionFactory.getCurrentSession();
	     Query query = session.createQuery("delete from FollowCompany where user=:user and companyId=:companyId");
	     query.setParameter("user", user);
	     query.setParameter("companyId", companyId);
	     query.executeUpdate();
	}
	 @Override
	 @Transactional
	 public List<Recruitment> getSavedRecruitmentsByUser(User user, int page, int size) {
	     Session currentSession = sessionFactory.getCurrentSession();
	     Query<Recruitment> theQuery = currentSession.createQuery(
	         "SELECT r FROM Recruitment r JOIN SaveJob sj ON r.id = sj.recruitmentId WHERE sj.user = :user ORDER BY r.id DESC",
	         Recruitment.class
	     );
	     theQuery.setParameter("user", user);
	     theQuery.setFirstResult(page * size);
	     theQuery.setMaxResults(size);
	     return theQuery.getResultList();
	 }
	 @Override
	 @Transactional
	 public long getTotalSavedRecruitments(User user) {
	     Session currentSession = sessionFactory.getCurrentSession();
	     Query<Long> theQuery = currentSession.createQuery(
	         "SELECT COUNT(r) FROM Recruitment r JOIN SaveJob sj ON r.id = sj.recruitmentId WHERE sj.user = :user",
	         Long.class
	     );
	     theQuery.setParameter("user", user);
	     return theQuery.uniqueResult();
	 }
	 @Override
	 @Transactional
	 public List<FollowCompany> getlistFollowCompanies(User user,int page,int size)
	 {
		 Session session=sessionFactory.getCurrentSession();
		 Query<FollowCompany> theQuery=session.createQuery("from FollowCompany where user=:user",FollowCompany.class);
		 theQuery.setParameter("user", user);
		 theQuery.setFirstResult(page*size);
		 theQuery.setMaxResults(size);
		 return theQuery.getResultList();
	 }
	 @Override
	 @Transactional
	 public Long gettotalFollowCompanies(User user)
	 {
		 Session session=sessionFactory.getCurrentSession();
		 Query<Long> theQuery=session.createQuery("select count(*) from FollowCompany where user=:user",Long.class);
		 theQuery.setParameter("user", user);
		 return theQuery.uniqueResult();
	 }
	 @Override
	 @Transactional
	 public List<Recruitment> getRecruitmentsbycompany(Company company,int page, int size)
	 {
		 Session currentSession = sessionFactory.getCurrentSession();
	      Query<Recruitment> theQuery = currentSession.createQuery("from Recruitment where company=:company ORDER BY id DESC", Recruitment.class);
	      theQuery.setParameter("company", company);
	      theQuery.setFirstResult(page*size);
	      theQuery.setMaxResults(size);
	      return theQuery.getResultList();
	 }
	 @Override
	 @Transactional
		public long getTotalRecruitmentsbycompany(Company company )
		{
		 Session currentSession = sessionFactory.getCurrentSession();
	        Query<Long> theQuery = currentSession.createQuery("select count(*) from Recruitment where company=:company", Long.class);
	        theQuery.setParameter("company", company);
	        return theQuery.uniqueResult();
		}
	 @Override
	 @Transactional
	 public SaveJob timjobbyrecruirement(int idrecruirement)
	 {
		 Session currentSession = sessionFactory.getCurrentSession();
	      Query<SaveJob> theQuery = currentSession.createQuery("from SaveJob where recruitmentId=:recruitmentId ", SaveJob.class);
	      theQuery.setParameter("recruitmentId", idrecruirement);    
	      theQuery.setMaxResults(1);
	      return theQuery.uniqueResult();
	 }
	 @Override
	 @Transactional
		public void deleteSaveJobbyecruiment( int recruitmentId)
		{
		 Session session = sessionFactory.getCurrentSession();
	     Query query = session.createQuery("delete from SaveJob where recruitmentId=:recruitmentId");
	     query.setParameter("recruitmentId", recruitmentId);
	     query.executeUpdate();
		}
	 @Override
	 @Transactional
		public ApplyPost timApplyPostbybyrecruirement(Recruitment recruitment)
		{
		 Session session = sessionFactory.getCurrentSession();
         Query<ApplyPost> query = session.createQuery("FROM ApplyPost where recruitment=:recruitment", ApplyPost.class);
         query.setParameter("recruitment", recruitment);
         query.setMaxResults(1);
         return query.uniqueResult();
		}
	 @Override
	 @Transactional
		public void deleteapplypostbycruiment(Recruitment recruitment)
		{
		 Session session=sessionFactory.getCurrentSession();
			Query query=session.createQuery("delete from ApplyPost where recruitment=:recruitment");
			query.setParameter("recruitment", recruitment);
			query.executeUpdate();
		}
	 @Override
	 @Transactional
	 public List<ApplyPost> getlistApplyPosts(User user)
	 {
		 Session currentSession = sessionFactory.getCurrentSession();
	     Query<ApplyPost> theQuery = currentSession.createQuery(
	         "SELECT a FROM ApplyPost a JOIN Recruitment r ON a.recruitment = r.id WHERE r.user = :user ORDER BY r.id DESC",
	         ApplyPost.class
	     );
	     theQuery.setParameter("user", user);
	     return theQuery.getResultList();
	 }
}
