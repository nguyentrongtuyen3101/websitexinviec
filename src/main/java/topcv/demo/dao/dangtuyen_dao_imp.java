package topcv.demo.dao;

import java.util.Collections;
import java.util.List;
import topcv.demo.entity.Category;
import topcv.demo.entity.Company;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import topcv.demo.entity.CV;
import topcv.demo.entity.Recruitment;
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
}
