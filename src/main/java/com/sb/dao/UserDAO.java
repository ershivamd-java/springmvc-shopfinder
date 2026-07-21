package com.sb.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.sb.model.UserLogin;
import java.util.List;

@Repository
public class UserDAO {
    
    @Autowired
    private HibernateTemplate hibernateTemplate;

    // 1. Save User (Hibernate automatic table/columns handle karega)
    @Transactional
    public int save(UserLogin u) {
        // save() method ID return karta hai
        return (Integer) this.hibernateTemplate.save(u);
    }

    // 2. Check Login (Using HQL - Hibernate Query Language)
    public UserLogin checkLogin(String email, String password) {
        String hql = "FROM UserLogin WHERE email = :e AND password = :p";
        List<UserLogin> list = (List<UserLogin>) this.hibernateTemplate.findByNamedParam(hql, 
                                new String[]{"e", "p"}, 
                                new Object[]{email, password});
        
        if (list != null && !list.isEmpty()) {
            return list.get(0);
        }
        return null;
    }

    // 3. Email check karne ke liye (Forgot Password ke liye)
    public boolean checkUserByEmail(String email) {
        String hql = "FROM UserLogin WHERE email = :e";
        List<UserLogin> list = (List<UserLogin>) this.hibernateTemplate.findByNamedParam(hql, "e", email);
        return list != null && !list.isEmpty();
    }

    // 4. Password update karne ke liye
    @Transactional
    public void updatePasswordByEmail(String email, String newPass) {
        String hql = "FROM UserLogin WHERE email = :e";
        List<UserLogin> list = (List<UserLogin>) this.hibernateTemplate.findByNamedParam(hql, "e", email);
        
        if (list != null && !list.isEmpty()) {
            UserLogin user = list.get(0);
            user.setPassword(newPass); // Hibernate automatic update query chala dega transaction ke baad
            this.hibernateTemplate.update(user);
        }
    }
}