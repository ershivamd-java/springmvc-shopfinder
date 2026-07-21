package com.sb.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sb.dao.UserDAO;

@Controller
public class ForgotPasswordController {

    @Autowired
    private UserDAO userDao; // Aapka purana DAO

    @Autowired
    private JavaMailSender mailSender;

    // 1. Forgot Password Page kholne ke liye
    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password"; // forgot-password.jsp return karega
    }

    // 2. Email check karke OTP bhejna
    @PostMapping("/sendResetOtp")
    @ResponseBody
    public String sendResetOtp(@RequestParam("email") String email, HttpSession session) {
        // UserDAO mein ek method chahiye jo email check kare
        boolean userExists = userDao.checkUserByEmail(email); 
        
        if (userExists) {
            String otp = String.valueOf((int)((Math.random() * 900000) + 100000));
            session.setAttribute("resetOtp", otp);
            session.setAttribute("resetEmail", email);

            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Password Reset OTP");
            message.setText("Aapka password reset OTP hai: " + otp);
            mailSender.send(message);
            
            return "success";
        } else {
            return "not_found"; // Agar user database mein nahi hai
        }
    }

    // 3. OTP Verify karne ke liye (Signup wale logic jaisa hi)
    @PostMapping("/verifyResetOtp")
    @ResponseBody
    public String verifyResetOtp(@RequestParam("otp") String userOtp, HttpSession session) {
        String sessionOtp = (String) session.getAttribute("resetOtp");
        if (sessionOtp != null && sessionOtp.equals(userOtp)) {
            return "MATCH";
        }
        return "MISMATCH";
    }

    // 4. Final Password Update
    @PostMapping("/updatePassword")
    @ResponseBody
    public String updatePassword(@RequestParam("newPass") String newPass, HttpSession session) {
        String email = (String) session.getAttribute("resetEmail");
        if (email != null) {
            userDao.updatePasswordByEmail(email, newPass); // SQL: update table set pass=? where email=?
            session.invalidate(); // Kaam hone ke baad session clear
            return "success";
        }
        return "error";
    }
}