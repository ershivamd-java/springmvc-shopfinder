package com.sb.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.sb.model.Product;

@Repository
public class ProductDao {

    @Autowired
    private HibernateTemplate hibernateTemplate;

    // 1. Product ko save karne ke liye
    @Transactional
    public int saveProduct(Product product) {
        System.out.println("====== HIBERNATE: SAVING PRODUCT ======");
        return (Integer) this.hibernateTemplate.save(product);
    }

    // 2. Click karne par specific Shop Id ke saare products load karne ke liye
    public List<Product> getProductsByShopId(int shopId) {
        System.out.println("====== HIBERNATE: FETCHING PRODUCTS FOR SHOP ID: " + shopId + " ======");
        String hql = "from Product where shopId = :sid";
        try {
            return this.hibernateTemplate.execute(session -> {
                return session.createQuery(hql, Product.class)
                              .setParameter("sid", shopId)
                              .list();
            });
        } catch (Exception e) {
            System.out.println("Hibernate Product Fetch Error: " + e.getMessage());
            return new ArrayList<>();
        }
    }
 // ProductDao.java ke andar sabse neeche add karein
    @Transactional
    public void deleteProductById(int productId) {
        System.out.println("====== HIBERNATE: DELETING PRODUCT ID: " + productId + " ======");
        Product prod = this.hibernateTemplate.get(Product.class, productId);
        if (prod != null) {
            this.hibernateTemplate.delete(prod);
            System.out.println("Hibernate DAO: Product deleted successfully!");
        }
    }
}