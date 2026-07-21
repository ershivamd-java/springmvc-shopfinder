package com.sb.controller;

import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession; 
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sb.dao.ShopDao;
import com.sb.model.UsershopRegistration;
import com.sb.model.UserLogin; 
import com.sb.service.ShopRegistrationService;

@Controller 
public class ShopController {

    @Autowired 
    private ShopRegistrationService shopService;
    
    @Autowired
    private ShopDao shopDao; 

    // 1. SHOP REGISTRATION FORM (With Strict Session Validation)
    @GetMapping("/shopRegistration")
    public String showShopForm(Model model, HttpSession session) { 
        System.out.println("==== Checking User Validation Before Registration ====");
        
        // 🔒 SECURITY CHECK: Jab tak user login nahi hai, form khulega hi nahi!
        UserLogin loggedInUser = (UserLogin) session.getAttribute("userSession");
        if (loggedInUser == null) {
            System.out.println("Unauthorized Access Attempt! Redirecting to Login.");
            return "redirect:/login"; 
        }
        
        // Anti-Duplicate Check: Agar is user ki dukan pehle se hai, to use dobara form mat bharne do
        UsershopRegistration existingShop = this.shopDao.getShopByUserId(loggedInUser.getUserId());
        if (existingShop != null) {
            System.out.println("User already has a shop. Redirecting to Profile Dashboard.");
            return "redirect:/yourProfile";
        }
        
        UsershopRegistration newShop = new UsershopRegistration();
        // Dynamic User ID setting taaki Hibernate me Foreign Key Null na jaye!
        newShop.setUserId(loggedInUser.getUserId()); 
        
        model.addAttribute("shopUser", newShop); 
        model.addAttribute("formAction", "saveShop");
        model.addAttribute("buttonText", "Register Shop");
        return "shopRegistration"; 
    }

    // 2. SAVE SHOP DETAILS (With Data Validation & Session Hardening)
    @PostMapping("/saveShop")
    public String saveShopDetails(@Valid @ModelAttribute("shopUser") UsershopRegistration shopUser, 
                                  BindingResult result, 
                                  @RequestParam("shopPhoto") MultipartFile file,
                                  HttpServletRequest request,
                                  Model model,
                                  HttpSession session) { 
        
        System.out.println("====== SAVE SHOP VALIDATION PROCESS HIT ======");

        // 🔒 STRICT VALIDATION: Form me agar koi bhi galti (null/empty) hai to aage nahi badhega
        if (result.hasErrors()) {
            System.out.println("Form Validation Failed! Reloading Form with Error Messages.");
            model.addAttribute("formAction", "saveShop");
            model.addAttribute("buttonText", "Register Shop");
            return "shopRegistration";
        }

        // Double Security Check for Session
        UserLogin loggedInUser = (UserLogin) session.getAttribute("userSession");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        try {
            // Ensure naye user ki ID har haal me object me set ho taaki database NULL reject kare
            shopUser.setUserId(loggedInUser.getUserId());

            // 📸 PHOTO UPLOAD LOGIC
            if (!file.isEmpty()) {
                String originalFilename = file.getOriginalFilename();
                String uniqueFileName = System.currentTimeMillis() + "_" + originalFilename;
                
                String savePath = request.getServletContext().getRealPath("/") + "resources" + File.separator + "images";
                File folder = new File(savePath);
                if (!folder.exists()) {
                    folder.mkdirs(); 
                }
                
                file.transferTo(new File(savePath + File.separator + uniqueFileName));
                shopUser.setShopImage(uniqueFileName); 
            } else {
                shopUser.setShopImage("default_shop.jpg"); 
            }

            // Database me save karo
            int id = this.shopDao.saveShop(shopUser);
            
            // 🎯 LIVE SESSION COUPLING: Session state ko turant freeze karo
            session.setAttribute("isRegistered", true);
            session.setAttribute("registeredShopId", id);
            
            System.out.println("Shop Successfully Saved & Linked with User ID: " + loggedInUser.getUserId());
            return "redirect:/home"; 
            
        } catch (Exception e) {
            System.out.println("CRITICAL DB SAVE ERROR: " + e.getMessage());
            e.printStackTrace(); 
            model.addAttribute("errorMessage", "Database Error: " + e.getMessage());
            model.addAttribute("formAction", "saveShop");
            model.addAttribute("buttonText", "Register Shop");
            return "shopRegistration"; 
        }
    }

    // 3. EDIT SHOP PROFILE
    @GetMapping("/editShopProfile")
    public String editShopProfile(Model model, HttpSession session) {
        UserLogin loggedInUser = (UserLogin) session.getAttribute("userSession");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Integer currentShopId = (Integer) session.getAttribute("registeredShopId");
        if (currentShopId == null) {
            return "redirect:/shopRegistration";
        }
        
        UsershopRegistration existingShop = this.shopDao.getShopById(currentShopId);
        
        if (existingShop != null) {
            model.addAttribute("shopUser", existingShop); 
            model.addAttribute("formAction", "updateShop"); 
            model.addAttribute("buttonText", "Update Profile");
            return "shopRegistration"; 
        } else {
            return "redirect:/shopRegistration";
        }
    }

    // 4. UPDATE SHOP ACTION
    @PostMapping("/updateShop")
    public String updateShopDetails(@ModelAttribute("shopUser") UsershopRegistration shopUser,
                                    @RequestParam("shopPhoto") MultipartFile file,
                                    HttpServletRequest request,
                                    HttpSession session) {
        System.out.println("====== UPDATE SHOP PROCESS START ======");
        
        UserLogin loggedInUser = (UserLogin) session.getAttribute("userSession");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        try {
            // Binding verification for User FK
            shopUser.setUserId(loggedInUser.getUserId());

            if (!file.isEmpty()) {
                String originalFilename = file.getOriginalFilename();
                String uniqueFileName = System.currentTimeMillis() + "_" + originalFilename;
                String savePath = request.getServletContext().getRealPath("/") + "resources" + File.separator + "images";
                
                File folder = new File(savePath);
                if (!folder.exists()) { folder.mkdirs(); }
                
                file.transferTo(new File(savePath + File.separator + uniqueFileName));
                shopUser.setShopImage(uniqueFileName);
            } else {
                UsershopRegistration oldShop = this.shopDao.getShopById(shopUser.getShopId());
                shopUser.setShopImage(oldShop.getShopImage());
            }
            
            this.shopDao.updateShop(shopUser);
            System.out.println("Shop Updated Successfully!");
            
        } catch(Exception e) {
            System.out.println("Error while updating shop: " + e.getMessage());
        }
        
        return "redirect:/home"; 
    }
}