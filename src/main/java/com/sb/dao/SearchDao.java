package com.sb.dao;

import java.util.List;

import com.sb.model.ShopReview;
import com.sb.model.UsershopRegistration;

public interface SearchDao {
    public List<UsershopRegistration> searchShopsByName(String query);
    public void saveReview(ShopReview review);
}