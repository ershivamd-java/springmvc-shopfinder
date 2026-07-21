<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Forgot Password</title>
    <style>
        /* Aapke Signup Page ki wahi CSS */
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
            border-radius: 20px; padding: 40px; width: 450px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3); color: white; text-align: center;
        }
        input {
            width: 100%; background: transparent; border: none;
            border-bottom: 2px solid rgba(255, 255, 255, 0.5);
            padding: 12px 5px; color: white; outline: none; margin-bottom: 15px;
        }
        .row-box { display: flex; gap: 10px; align-items: center; margin-bottom: 15px; }
        .btn-action { background: #27ae60; color: white; border: none; padding: 8px 12px; border-radius: 5px; cursor: pointer; white-space: nowrap; }
        .submit-btn { background: white; color: #1a2a6c; border: none; padding: 15px; width: 100%; border-radius: 8px; font-weight: bold; cursor: pointer; text-transform: uppercase; margin-top: 10px; }
        
        /* Orange for OTP sent, Blue for Verified */
        .sent { background-color: #ff9800 !important; }
        .verified { background-color: blue !important; }
    </style>
</head>
<body>

<div class="glass-container">
    <h2>RESET PASSWORD</h2>
    
    <!-- Step 1: Email Row -->
    <div class="row-box">
        <input type="email" id="email" placeholder="Registered Email Address" style="margin-bottom:0;" />
        <button type="button" id="sendOtpBtn" class="btn-action" onclick="sendResetOTP()">Send OTP</button>
    </div>

    <!-- Step 2: OTP Section (Hidden initially) -->
    <div id="otpSection" style="display:none;">
        <div class="row-box">
            <input type="text" id="otpBox" placeholder="Enter OTP" style="margin-bottom:0;" />
            <button type="button" id="verifyBtn" class="btn-action" onclick="verifyResetOTP()">Verify</button>
        </div>
    </div>

    <!-- Step 3: New Password Section (Hidden initially) -->
    <div id="passwordSection" style="display:none;">
        <input type="password" id="newPass" placeholder="Enter New Password" />
        <input type="password" id="confirmPass" placeholder="Confirm New Password" />
        <button type="button" class="submit-btn" onclick="finalUpdate()">Update Password</button>
    </div>
    
    <div style="margin-top: 15px;">
        <a href="login" style="color: white; font-size: 14px;">Back to Login</a>
    </div>
</div>

<script>
// 1. Email check karke OTP bhejna
function sendResetOTP() {
    var email = $("#email").val();
    if(email === "") { alert("Email bhariye"); return; }

    $.post("${pageContext.request.contextPath}/sendResetOtp", { email: email }, function(data) {
        if(data === "success") {
            alert("OTP Send Succesfully.");
            $("#sendOtpBtn").addClass("sent").text("Resend");
            $("#otpSection").fadeIn();
        } else if(data === "not_found") {
            alert("Email not found!");
        }
    });
}

// 2. OTP Verify karna
function verifyResetOTP() {
    var otp = $("#otpBox").val();
    $.post("${pageContext.request.contextPath}/verifyResetOtp", { otp: otp }, function(data) {
        if(data === "MATCH") {
            alert("OTP Match ho gaya! Naya password daalein.");
            $("#verifyBtn").addClass("verified").text("Verified ✅").prop("disabled", true);
            $("#otpBox").prop("readonly", true);
            $("#passwordSection").fadeIn();
        } else {
            alert("Galat OTP!");
        }
    });
}

// 3. Final Password Update
function finalUpdate() {
    var pass1 = $("#newPass").val();
    var pass2 = $("#confirmPass").val();

    if(pass1 !== pass2) { alert("Passwords not match!"); return; }
    if(pass1.length < 4) { alert("Plese Enter Long Password!"); return; }

    $.post("${pageContext.request.contextPath}/updatePassword", { newPass: pass1 }, function(data) {
        if(data === "success") {
            alert("Password Update Succesfully");
            window.location.href = "login"; // Login page par bhej do
        } else {
            alert("Try Again.");
        }
    });
}
</script>

</body>
</html>