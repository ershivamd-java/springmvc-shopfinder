<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>User Signup</title>
    <style>
        body {
            background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
            min-height: 100vh;
            display: flex; align-items: center; justify-content: center;
            font-family: 'Segoe UI', sans-serif; margin: 0;
        }
        .glass-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px; padding: 40px; width: 480px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3); color: white; text-align: center;
        }
        input {
            width: 100%; background: transparent; border: none;
            border-bottom: 2px solid rgba(255, 255, 255, 0.5);
            padding: 12px 5px; color: white; outline: none; margin-bottom: 15px;
        }
        .otp-row { display: flex; gap: 10px; align-items: center; margin-bottom: 15px; }
        
        /* Send OTP Button */
        .send-otp { background: #27ae60; color: white; border: none; padding: 8px 12px; border-radius: 5px; cursor: pointer; white-space: nowrap; }
        
        /* Registration Button */
        .register-btn { background: white; color: #1a2a6c; border: none; padding: 15px; width: 100%; border-radius: 8px; font-weight: bold; cursor: pointer; text-transform: uppercase; margin-top: 10px; }
        
        /* Click hone ke baad Orange color */
        .otp-sent-btn {
            background-color: #ff9800 !important;
            color: white;
        }

        /* Verify Button Style */
        #verifyBtn {
            background-color: #28a745;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            display: none; /* Shuru mein hidden */
            margin-left: 10px;
            cursor: pointer;
        }

        /* Verify hone ke baad Blue color */
        .verified-success {
            background-color: blue !important;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<div class="glass-container">
    <h2>USER SIGNUP</h2>
    <form:form action="saveUser" method="post" modelAttribute="user" onsubmit="return validateMyForm()">
        
        <div style="display: flex; gap: 15px;">
            <div style="width:100%">
                <form:input path="firstName" placeholder="First Name" />
                <form:errors path="firstName" style="color:red; font-size:12px; display:block; text-align:left;" />
            </div>
            <div style="width:100%">
                <form:input path="lastName" placeholder="Last Name" />
            </div>
        </div>

        <form:input path="contactNumber"  placeholder="Mobile Number" />
        
        <!-- Email Row with Send OTP Button -->
        <div class="otp-row">
            <form:input path="email" id="email" placeholder="Email Address" style="margin-bottom:0;" />
            <button type="button" id="sendOtpBtn" class="send-otp" onclick="sendOTP()">Send OTP</button>
        </div>

        <!-- OTP Input + Verify Button Side-by-Side (Hidden Initially) -->
        <div id="otpSection" style="display:none; margin-bottom: 15px; text-align: left;">
            <div style="display: flex; align-items: center;">
                <input type="text" id="otpBox" placeholder="Enter 6-Digit OTP" style="margin-bottom:0; flex: 1;" />
                <button type="button" id="verifyBtn" onclick="verifyOTPNow()">Verify OTP</button>
            </div>
        </div>

        <form:password path="password" placeholder="Create Password" />

        <button type="submit" id="registerBtn" class="register-btn">SIGNUP</button>
    </form:form>
</div>

<script>
var isOtpVerified = false; 

// 1. OTP Bhejne wala function
function sendOTP() {
    var email = document.getElementById("email").value;
    var sendBtn = document.getElementById("sendOtpBtn");
    
    if(email.includes("@") && email.length > 5) {
        $.post("${pageContext.request.contextPath}/sendOtpToEmail", { email: email }, function(data) {
            if(data === "success") {
                alert("OTP sent to " + email);
                
                // Color Change: Green to Orange
                sendBtn.classList.add("otp-sent-btn");
                sendBtn.innerText = "Resend";
                
                // Show OTP Box and Verify Button
                document.getElementById("otpSection").style.display = "block";
                document.getElementById("verifyBtn").style.display = "inline-block";
            } else {
                alert("Error: " + data);
            }
        });
    } else {
        alert("Enter Right Email");
    }
}

// 2. OTP Verify karne wala function
function verifyOTPNow() {
    var enteredOtp = document.getElementById("otpBox").value;
    var vBtn = document.getElementById("verifyBtn");

    if(enteredOtp === "") {
        alert("Please Enter OTP!");
        return;
    }
    
    $.post("${pageContext.request.contextPath}/verifyOtp", { otp: enteredOtp }, function(data) {
        if(data === "MATCH") {
            alert("OTP Verified Successfully!");
            isOtpVerified = true;
            
            // Color Change: Green to Blue
            vBtn.innerText = "Verified ✅";
            vBtn.classList.add("verified-success");
            vBtn.disabled = true;
            document.getElementById("otpBox").readOnly = true;
        } else {
            alert("Worng OTP.");
            isOtpVerified = false;
        }
    });
}

// 3. Form Submit hone se pehle check karega
function validateMyForm() {
    if(!isOtpVerified) {
        alert("Enter and Verify Otp!");
        return false; 
    }
    return true; 
}
</script>
</body>
</html>