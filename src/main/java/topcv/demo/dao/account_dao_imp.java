package topcv.demo.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import topcv.demo.entity.Company;
import topcv.demo.entity.User;

@Repository
public class account_dao_imp implements account_dao{
	@Autowired
	private SessionFactory sessionFactory;
	@Override
	@Transactional
	public boolean checkFirstacc()
	{
		Session currentSession = sessionFactory.getCurrentSession();
        Query<Long> query = currentSession.createQuery("SELECT COUNT(*) FROM User", Long.class);
        Long count = query.uniqueResult();
        return count > 0;
	}
	@Override
	@Transactional
	public void saveorupdate(User user)
	{
		Session cuSession=sessionFactory.getCurrentSession();
		cuSession.saveOrUpdate(user);
	}
	@Override
	@Transactional
	public User timaccountbygmail(String gmail)
	{
		try {
    		Session session = sessionFactory.getCurrentSession();
            Query<User> query = session.createQuery("FROM User WHERE email = :gmail", User.class);
            query.setParameter("gmail", gmail);
            return query.uniqueResult();
		} catch (Exception e) {
			 return null;
		}  
	}
	 @Override
	 @Transactional
	    public void updatemk( String gmail, String mkmoi) {
	        Session session = sessionFactory.getCurrentSession();
	        Query query = session.createQuery("UPDATE User SET password = :matkhaumoi WHERE email = :gmail");
	        query.setParameter("gmail", gmail);
	        query.setParameter("matkhaumoi", mkmoi);
	        query.executeUpdate(); 
	    }
	 @Override
	 @Transactional
	 public void updateaccount( User user)
	 {
		 Session session = sessionFactory.getCurrentSession();
	        Query query = session.createQuery("UPDATE User SET address=:address, description=:description, email=:email, fullName=:fullName, phoneNumber=:phoneNumber WHERE email = :gmail");
	        query.setParameter("address", user.getAddress());
	        query.setParameter("description", user.getDescription());
	        query.setParameter("email", user.getEmail());
	        query.setParameter("fullName", user.getFullName());
	        query.setParameter("phoneNumber", user.getPhoneNumber());
	        query.setParameter("gmail", user.getEmail());
	        query.executeUpdate(); 
	 }
	 @Override
	 @Transactional
	 public void uploadanh(User user)
	 {
		 Session session = sessionFactory.getCurrentSession();
	        Query query = session.createQuery("UPDATE User SET image=:image WHERE email = :gmail");
	        query.setParameter("image", user.getImage());  
	        query.setParameter("gmail", user.getEmail());
	        query.executeUpdate(); 
	 }
	 @Override
	 @Transactional
	 public void saveorupdatecompany(Company company)
	 {
		 Session session=sessionFactory.getCurrentSession();
		 session.saveOrUpdate(company);
	 }
	 @Override
	 @Transactional
	 public Company timcompanybyuserid(User user)
	 {
		 try {
	    		Session session = sessionFactory.getCurrentSession();
	            Query<Company> query = session.createQuery("FROM Company WHERE user = :user", Company.class);
	            query.setParameter("user", user);
	            return query.uniqueResult();
			} catch (Exception e) {
				 return null;
			}  
	 }
	 public void updatecompany( Company company)
	 {
		 Session session = sessionFactory.getCurrentSession();
	        Query query = session.createQuery("UPDATE Company SET address=:address, companyDescription=:description, email=:email, nameCompany=:fullName, phoneNumber=:phoneNumber WHERE user = :user");
	        query.setParameter("address", company.getAddress());
	        query.setParameter("description", company.getcompanyDescription());
	        query.setParameter("email", company.getEmail());
	        query.setParameter("fullName", company.getNameCompany());
	        query.setParameter("phoneNumber", company.getPhoneNumber());
	        query.setParameter("user", company.getUser());
	        query.executeUpdate(); 
	 }
}
