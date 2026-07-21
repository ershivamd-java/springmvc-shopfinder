package com.sb.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sb.dao.UserDAO;
import com.sb.dao.ShopDao; // ✅ Added ShopDao import
import com.sb.model.UserLogin;
import com.sb.model.UsershopRegistration; // ✅ Added Model import
import com.sb.service.UserLoginService;
import com.sb.validator.UserLoginValidator;

@Controller
public class UserController {

    @Autowired
    private UserLoginValidator userloginValidator;
    
    @Autowired
    private UserDAO userDao;
    
    @Autowired
    private ShopDao shopDao; // ✅ Autowired ShopDao here safely
    
    @Autowired
    private UserLoginService userloginservice;
    
    @Autowired
    private JavaMailSender mailSender;
    
    @InitBinder("user") 
    protected void initBinder(WebDataBinder binder) {
        binder.addValidators(userloginValidator);
    }

    // 1. Show Signup Form
    @GetMapping({"/userLogin"})
    public String showForm(Model model) {
        model.addAttribute("user", new UserLogin());
        return "login-form";
    }

    // 2. Process Signup / Save User
    @PostMapping("/saveUser")
    public String saveStudent(@Valid @ModelAttribute("user") UserLogin user,
                              BindingResult result,
                              Model model,
                              HttpSession session) {

        if (result.hasErrors()) {
            return "login-form";
        }

        try {
            userloginservice.validateBusinessRules(user);
        } catch (Exception e) {
            result.rejectValue("email", "error.email", e.getMessage());
            return "login-form";
        }

        userDao.save(user); 
        
        System.out.println("Signup Success! Setting session for new User ID: " + user.getUserId());
        session.setAttribute("userSession", user); 
        
        model.addAttribute("savedUser", user); 
        return "redirect:/home";
    }
    
    // 3. Display Login Page
    @RequestMapping({"/","/login"})
    public String displayLogin() {
        return "login-page";
    }
    
    // 4. Process Login Validation
    @RequestMapping(value = "/loginUser", method = RequestMethod.POST)
    public String loginUser(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            HttpSession session, Model model) {
        UserLogin user = userDao.checkLogin(email, password);
        if (user != null) {
            session.setAttribute("userSession", user);
            return "redirect:/home";
        } else {
            model.addAttribute("error", "Please Enter Valid Email And Password!");
            return "login-page";
        }
    }
   
    // 🎯 5. THE CENTRAL HOME ROUTE (Merged From ShopController)
    @GetMapping("/home")
    public String showHomePage(HttpSession session, Model model) {
        System.out.println("====== HOME ACCESS WITH LIVE SESSION WORK ======");
        
        UserLogin loggedInUser = (UserLogin) session.getAttribute("userSession");
        
        if (loggedInUser == null) {
            System.out.println("Session Null! Redirecting to login page...");
            return "redirect:/login"; 
        }
        
        try {
            int loggedInUid = loggedInUser.getUserId();
            UsershopRegistration existingShop = this.shopDao.getShopByUserId(loggedInUid);
            
            if (existingShop != null) {
                session.setAttribute("isRegistered", true);
                session.setAttribute("registeredShopId", existingShop.getShopId());
            } else {
                session.setAttribute("isRegistered", false);
            }
            
            List<UsershopRegistration> allShops = this.shopDao.getAllShops(); 
            model.addAttribute("shops", allShops);
            
        } catch (Exception e) {
            System.out.println("Error in HomeController Session Logic: " + e.getMessage());
            e.printStackTrace();
        }
        
        return "home"; 
    }

    @Autowired
    private com.sb.dao.ProductDao productDao; // 👈 Yeh import aur autowire check kar lein UserController ke upar

    // 🎯 FIX: PROFILE WORKSPACE ROUTER WITH LIVE PRODUCT LOADING
    @GetMapping("/yourProfile")
    public String showProfile(HttpSession session, Model model) {
        System.out.println("====== PROFILE WORKSPACE ROUTER TRIGGERED ======");
        
        UserLogin user = (UserLogin) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("currentUser", user);

        try {
            UsershopRegistration shop = this.shopDao.getShopByUserId(user.getUserId());

            if (shop != null) {
                System.out.println("Shop found! Fetching products for Shop ID: " + shop.getShopId());
                
                // 🎯 FIXED: Database se is dukan ke saare products nikal kar JSP ko bhejna
                List<com.sb.model.Product> shopProducts = this.productDao.getProductsByShopId(shop.getShopId());
                
                model.addAttribute("shopDetails", shop);
                model.addAttribute("products", shopProducts); // 🔥 Yeh line products grid ko chalayege!
                
                return "shopProfile"; 
            } else {
                System.out.println("No shop found! Loading userProfile.jsp Personal Card.");
                return "userProfile"; 
            }
        } catch (Exception e) {
            System.out.println("Error inside yourProfile router: " + e.getMessage());
            e.printStackTrace();
            return "userProfile";
        }
    }
    // 7. OTP Email Dispatcher
    @PostMapping("/sendOtpToEmail")
    @ResponseBody
    public String sendOtp(@RequestParam("email") String email, HttpSession session) {
        try {
            String otp = String.valueOf((int)((Math.random() * 900000) + 100000));
            session.setAttribute("otp", otp);
            
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("OTP Verification - ShopFinder");
            message.setText("Aapka verification OTP hai: " + otp);
            
            mailSender.send(message);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    // 8. OTP Matcher
    @PostMapping("/verifyOtp")
    @ResponseBody
    public String verifyOtp(@RequestParam("otp") String userOtp, HttpSession session) {
        String sessionOtp = (String) session.getAttribute("otp");
        if (sessionOtp != null && sessionOtp.equals(userOtp)) {
            return "MATCH";
        } else {
            return "MISMATCH";
        }
    }

    // 🎯 9. GLOBAL USER LOGOUT (Case-Sensitive Fixed to 'userLogout')
    @GetMapping("/userLogout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate(); 
            System.out.println("User logged out successfully. Session destroyed.");
        }
        return "redirect:/login"; 
    }
}