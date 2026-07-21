<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile | ShopFinder</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin:0; }
        .profile-card { max-width: 450px; background: white; margin: 80px auto; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); padding: 30px; text-align: center; }
        
        /* 🔴 GMAIL STYLE AVATAR LOGIC */
        .profile-img { 
            width: 100px; height: 100px; border-radius: 50%; 
            margin-bottom: 15px; border: 3px solid #2563eb; padding: 3px;
        }
        
        .link-container {
    display: flex;            /* दोनों को एक लाइन (row) में लाएगा */
    justify-content: space-between;   /* दोनों को बीच (center) में रखेगा */
    align-items: center; 
    width:100%;
    margin-top:20px;
    padding:0 15px;
    gap: 40px;                 /* दोनों लिंक्स के बीच 20px की दूरी बनाएगा */
}
        
        .user-name { font-size: 22px; color: #1c1e21; margin: 10px 0; font-weight: bold; }
        .user-info { color: #606770; font-size: 14px; margin-bottom: 20px; }
        .details-table { width: 100%; text-align: left; margin-top: 20px; border-top: 1px solid #ddd; padding-top: 20px; }
        .details-table td { padding: 8px 0; font-size: 14px; }
        .label { color: #888; font-weight: 500; }
        
        .btn-register { background: #f97316; color: white; padding: 10px 20px; border-radius: 20px; text-decoration: none; display: inline-block; margin-top: 25px; font-weight: 600; }
        .btn-home { color: #2563eb; text-decoration: none; font-size: 14px; display: block; margin-top: 15px; }
    </style>
</head>
<body>

<div class="profile-card">
    <img src="https://ui-avatars.com/api/?name=${currentUser.firstName}+${currentUser.lastName}&background=2563eb&color=fff&size=128&bold=true" 
         class="profile-img" alt="User Image">

    <div class="user-name">${currentUser.firstName} ${currentUser.lastName}</div>
    <div class="user-info"><i class="fas fa-envelope"></i> ${currentUser.email}</div>

    <table class="details-table">
        <tr>
            <td class="label">Mobile Number:</td>
            <td><strong>${currentUser.contactNumber}</strong></td>
        </tr>
        <tr>
            <td class="label">Account Status:</td>
            <td><span style="color: green; font-weight: bold;">● Active User</span></td>
        </tr>
    </table>

    <div style="background: #eff6ff; padding: 15px; border-radius: 10px; margin-top: 20px;">
        <p style="font-size: 12px; color: #1e40af; margin: 0;">Aapne abhi tak apni dukan register nahi ki hai.</p>
        <a href="shopRegistration" class="btn-register"><i class="fas fa-store"></i> Register Your Shop Now</a>
    </div>
   <div class="link-container">
    <a href="home" class="btn-home"><i class="fas fa-arrow-left"></i> Wapas Home par jayein</a>
    
            <a href="userLogout" class="nav-link" style="color: red;"><i class="fas fa-sign-out-alt"></i> Logout</a>

   </div>
</div>

</body>
</html>