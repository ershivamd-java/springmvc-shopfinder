package com.sb.model;

import javax.persistence.*;

@Entity
@Table(name = "shop_reviews")
public class ShopReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int reviewId;

    private int shopId;
    private int userId;
    private int ratingStars;
    private String reviewMessage;

    // Getters and Setters
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }
    public int getShopId() { return shopId; }
    public void setShopId(int shopId) { this.shopId = shopId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getRatingStars() { return ratingStars; }
    public void setRatingStars(int ratingStars) { this.ratingStars = ratingStars; }
    public String getReviewMessage() { return reviewMessage; }
    public void setReviewMessage(String reviewMessage) { this.reviewMessage = reviewMessage; }
}