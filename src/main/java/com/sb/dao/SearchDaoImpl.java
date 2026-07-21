package com.sb.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sb.model.ShopReview;
import com.sb.model.UsershopRegistration;

@Repository
public class SearchDaoImpl implements SearchDao {

    @Autowired
    private HibernateTemplate hibernateTemplate;

    @Override
    @Transactional
    public List<UsershopRegistration> searchShopsByName(String query) {
        
        String hql = "from UsershopRegistration s where " +
                     "lower(s.shopName) like lower(:searchQuery) or " +
                     "lower(s.category) like lower(:searchQuery) or " +
                     "lower(s.ownerName) like lower(:searchQuery) or " +
                     "lower(s.address) like lower(:searchQuery) or " +
                     "s.shopId in (select p.shopId from Product p where lower(p.productName) like lower(:searchQuery))";
                     
        try {
            return this.hibernateTemplate.execute(session -> {
                // 1. Pehle shops ki list nikalen
                List<UsershopRegistration> shops = session.createQuery(hql, UsershopRegistration.class)
                              .setParameter("searchQuery", "%" + query + "%")
                              .list();
                
                // 2. 🎯 Ab Har Shop ke liye loop chala kar Average Rating yahi session ke andar set karein
                for (UsershopRegistration shop : shops) {
                    try {
                        String reviewHql = "select avg(r.ratingStars), count(r.reviewId) from ShopReview r where r.shopId = :sid";
                        Object[] result = (Object[]) session.createQuery(reviewHql)
                                                            .setParameter("sid", shop.getShopId())
                                                            .uniqueResult();
                        
                        if (result != null && result[0] != null) {
                            shop.setAverageRating((Double) result[0]);
                            shop.setTotalReviews(((Long) result[1]).intValue());
                        } else {
                            shop.setAverageRating(0.0);
                            shop.setTotalReviews(0);
                        }
                    } catch (Exception ex) {
                        shop.setAverageRating(0.0);
                        shop.setTotalReviews(0);
                    }
                }
                
                return shops;
            });
        } catch (Exception e) {
            System.out.println("DAO Search Error: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    @Override
    @Transactional
    public void saveReview(ShopReview review) {
        try {
            this.hibernateTemplate.save(review);
            System.out.println("✅ Review successfully saved in Database!");
        } catch (Exception e) {
            System.out.println("❌ Error while saving review: " + e.getMessage());
            e.printStackTrace();
        }
    }
}