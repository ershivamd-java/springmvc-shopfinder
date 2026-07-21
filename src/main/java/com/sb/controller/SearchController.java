package com.sb.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sb.dao.SearchDao;
import com.sb.model.UsershopRegistration;
import com.sb.model.ShopReview;
import com.sb.model.UserLogin;

@Controller
public class SearchController {

    @Autowired
    private SearchDao searchDao;

    @GetMapping("/searchShops")
    public String searchShops(@RequestParam("query") String query,
                              @RequestParam("lat") double userLat,
                              @RequestParam("lng") double userLng,
                              Model model, HttpSession session) {
        
        System.out.println("====== 10 KM FILTER SHOP SEARCH ======");
        
        UserLogin loggedInUser = (UserLogin) session.getAttribute("userSession");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<UsershopRegistration> allShops = this.searchDao.searchShopsByName(query);
        List<UsershopRegistration> nearbyShops = new ArrayList<>();
        
        for (UsershopRegistration shop : allShops) {
            try {
                double shopLat = shop.getLatitude();
                double shopLng = shop.getLongitude();
                
                // --- Haversine Formula ---
                double earthRadius = 6371; 
                double dLat = Math.toRadians(shopLat - userLat);
                double dLng = Math.toRadians(shopLng - userLng);
                
                double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                           Math.cos(Math.toRadians(userLat)) * Math.cos(Math.toRadians(shopLat)) *
                           Math.sin(dLng / 2) * Math.sin(dLng / 2);
                
                double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                double distance = earthRadius * c; 
                
                if (distance <= 10.0) {
                    String formattedDistance = String.format("%.2f KM", distance);
                    shop.setAddress(shop.getAddress() + "##" + formattedDistance);
                    nearbyShops.add(shop);
                }
                
            } catch (Exception e) {
                System.out.println("Distance calculation error for shop: " + shop.getShopName());
            }
        }
        
        model.addAttribute("shops", nearbyShops);
        model.addAttribute("searchQuery", query);
        model.addAttribute("userLat", userLat);
        model.addAttribute("userLng", userLng);
        
        
        return "searchResults"; 
    }
    @PostMapping("/submitReview")
    public String submitReview(@RequestParam("shopId") int shopId,
                               @RequestParam("ratingStars") int stars,
                               @RequestParam("reviewMessage") String message,
                               HttpSession session) {
        
        UserLogin loggedInUser = (UserLogin) session.getAttribute("userSession");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        ShopReview review = new ShopReview();
        review.setShopId(shopId);
        review.setUserId(loggedInUser.getUserId()); // Manually trace user id
        review.setRatingStars(stars);
        review.setReviewMessage(message);

    
        this.searchDao.saveReview(review);

        return "redirect:/home";
    }
}