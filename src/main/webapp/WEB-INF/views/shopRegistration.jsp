<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop Registration</title>
    <style>
        body {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
        }
        .glass-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 30px;
            width: 450px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.5);
            color: white;
            text-align: center;
        }
        h2 { font-weight: 300; letter-spacing: 2px; margin-bottom: 25px; border-bottom: 1px solid rgba(255,255,255,0.2); padding-bottom: 10px; }
        input, select, textarea {
            width: 100%;
            background: transparent;
            border: none;
            border-bottom: 2px solid rgba(255, 255, 255, 0.5);
            padding: 10px 5px;
            color: white;
            outline: none;
            font-size: 14px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }
        select option { background: #2c5364; color: white; }
        input::placeholder, textarea::placeholder { color: rgba(255, 255, 255, 0.7); }
        .gender-section { text-align: left; margin-bottom: 15px; }
        .gender-label { font-size: 14px; color: rgba(255,255,255,0.8); margin-bottom: 8px; display: block; }
        .radio-group { display: flex; gap: 20px; }
        .radio-group label { cursor: pointer; font-size: 14px; }
        input[type="radio"] { width: auto; margin-right: 5px; accent-color: #3498db; }
        .register-btn {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 2px solid white;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            text-transform: uppercase;
            margin-top: 10px;
        }
        .register-btn:hover { background: white; color: #203a43; }
        .footer-link { margin-top: 20px; font-size: 11px; color: rgba(255,255,255,0.5); }
        .file-label { font-size: 14px; color: rgba(255,255,255,0.8); text-align: left; display: block; margin-bottom: 5px; }
    </style>
</head>
<body>

<div class="glass-container">
    <h2>${shopUser.shopId == 0 ? 'SHOP REGISTRATION' : 'YOUR PROFILE'}</h2>
    
    <form:form action="${formAction}" modelAttribute="shopUser" method="post" id="shopForm" enctype="multipart/form-data">
        
        <form:hidden path="shopId" />   
        <form:hidden path="userId" />             
        <form:input path="shopName" placeholder="Shop Name" required="true" />
        <form:errors path="shopName" cssStyle="color: red; display: block;" />
        
        <form:input path="ownerName" placeholder="Owner Name" required="true" />
        
        <form:input path="category" list="categoryOptions" placeholder="Select or Type Category" autocomplete="off" required="true" />
        <datalist id="categoryOptions">
            <option value="Electronics" />
            <option value="Grocery" />
            <option value="Clothing" />
            <option value="Hardware" />
            <option value="MobileReparing" />
            <option value="Boot" />
            <option value="TeaStall" />
        </datalist>    

        <div style="display: flex; gap: 10px;">
            <form:input path="contactNumber" placeholder="Contact Number" />
            <form:input path="email" placeholder="Email Address" />
        </div>
        
        <div style="display: flex; gap: 10px; justify-content: space-between;">
            <form:errors path="contactNumber" cssStyle="color: red; font-size: 12px;" />
            <form:errors path="email" cssStyle="color: red; font-size: 12px;" />
        </div>

        <div class="gender-section">
            <span class="gender-label">Owner Gender:</span>
            <div class="radio-group">
                <label><form:radiobutton path="gender" value="Male" required="true" /> Male</label>
                <label><form:radiobutton path="gender" value="Female" /> Female</label>
            </div>
        </div>
        
        <form:hidden path="latitude" id="lat" />
        <form:hidden path="longitude" id="lng" />

        <form:textarea path="address" placeholder="Street Address & Landmark" rows="2"></form:textarea>
        
        <div style="text-align: left; margin-bottom: 20px;">
            <label class="file-label"><i class="fas fa-camera"></i> Apni Dukan Ki Photo Upload Karein:</label>
            <input type="file" name="shopPhoto" accept="image/*" style="border-bottom: none; padding: 5px 0;" />
        </div>

        <button type="button" onclick="getLocationAndSubmit()" class="register-btn">
            ${buttonText}
        </button>
        
    </form:form>
    
    <div class="footer-link">Powered by Java Spring MVC & MySQL</div>
</div>

<script>
function getLocationAndSubmit() {
    const btn = document.querySelector('.register-btn');
    btn.innerHTML = "Fetching Location..."; 
    
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            document.getElementById('lat').value = position.coords.latitude;
            document.getElementById('lng').value = position.coords.longitude;
            document.getElementById('shopForm').submit(); 
        }, function(error) {
            alert("Location access denied! Submitting form without coordinates.");
            document.getElementById('shopForm').submit();
        });
    } else {
        alert("Aapka browser location support nahi karta.");
        document.getElementById('shopForm').submit();
    }
}
</script>
</body>
</html>