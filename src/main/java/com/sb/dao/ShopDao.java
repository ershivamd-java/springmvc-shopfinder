package com.sb.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional; // YEH IMPORT HONA ZAROORI HAI

import com.sb.model.UsershopRegistration;

@Repository
public class ShopDao {

    @Autowired
    private HibernateTemplate hibernateTemplate;

    @Transactional // Iske bina database me physically data write nahi hota
    public int saveShop(UsershopRegistration shop) {
        System.out.println("DAO Layer: Saving shop into database via Hibernate...");
        Integer id = (Integer) this.hibernateTemplate.save(shop);
        System.out.println("DAO Layer: Successfully saved! Generated ID is: " + id);
        return id;
        
    }
 // 1. Shop ka purana data ID ke hisaab se fetch karne ke liye
    public UsershopRegistration getShopById(int id) {
        return this.hibernateTemplate.get(UsershopRegistration.class, id);
    }

    // 2. Data badal kar save (Update) karne ke liye
    @Transactional
    public void updateShop(UsershopRegistration shop) {
        this.hibernateTemplate.update(shop);
    }
    public UsershopRegistration getShopByUserId(int loggedInUserId) {
        String query = "from UsershopRegistration where userId = :uid";
        try {
            return this.hibernateTemplate.execute(session -> {
                return session.createQuery(query, UsershopRegistration.class)
                              .setParameter("uid", loggedInUserId)
                              .uniqueResult();
            });
        } catch (Exception e) {
            System.out.println("DAO Log: No shop registered for userId " + loggedInUserId);
            return null;
        }
    }
 // ShopDao.java ke andar sabse neeche add karein

    @Transactional
    public List<UsershopRegistration> getAllShops() {
        System.out.println("====== HIBERNATE: FETCHING ALL REGISTERED SHOPS ======");
        List<UsershopRegistration> shopList = null;
        try {
            // HQL Query: UsershopRegistration table se saara data nikalne ke liye
            shopList = this.hibernateTemplate.loadAll(UsershopRegistration.class);
            System.out.println("Hibernate DAO: Total shops found -> " + (shopList != null ? shopList.size() : 0));
        } catch (Exception e) {
            System.out.println("ShopDao Error in getAllShops: " + e.getMessage());
            e.printStackTrace();
        }
        return shopList;
    }
    
    
}