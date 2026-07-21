<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
   
    <style>
   body {
    background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); /* Blue gradient background */
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Segoe UI', sans-serif;
    margin: 0;
}

.login-container {
    background: rgba(255, 255, 255, 0.2); /* Transparent background */
    backdrop-filter: blur(15px); /* Glass blur effect */
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 20px;
    padding: 40px;
    width: 350px;
    box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
    color: white;
    text-align: center;
}

h2 { color:#ffffff; text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
margin-bottom: 25px; font-weight: 600; letter-spacing: 2px;
 }

input {
    width: 100%;
    background: transparent;
    border: none;
    border-bottom: 2px solid rgba(255, 255, 255, 0.5);
    padding: 10px 0;
    margin-bottom: 25px;
    color: white;
    outline: none;
    font-size: 16px;
}

input::placeholder { color: rgba(255, 255, 255, 0.7); }

.btn-submit {
    background: #34495e;
    color: white;
    border: none;
    padding: 12px 25px;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
    font-weight: bold;
    text-transform: uppercase;
}
.btn-submit:hover{
background-color:#0000ff !important;
transform:translateY(-2px);
box-shadow: 0 5px 15px rgba(0,0,0,0.3);
transition: 0.3s;
font-weight: bold;
letter-spachoing: 1px
}

.btn-register {
    background:#34495e;
    color: white;
    border: 1px solirgb(0, 64, 128);
    padding: 12px;
    display: block;
    text-decoration: none;
    border-radius: 5px;
    margin-top: 20px;
}
.btn-register:hover{
background-color:#0000ff !important;
transform:translateY(-2px);
box-shadow: 0 5px 15px rgba(0,0,0,0.3);
transition: 0.3s;
font-weight: bold;
letter-spachoing: 1px
}
.btn-link{
color: #ffffff !important;
text-decoration: none;
font-size:14px;
margin-top:10px;display: inline-block;
}
.btn-link:hover{
text-decoration: underline;
color:#ff7675
}

.error-msg { color: #ff7675; margin-bottom: 10px; font-weight: bold; }
    </style>
    </head>
    <body>
    <div class="login-container">
    <h2>Login Page</h2>
    <p class="error-msg">${error}</p>
    <form action="loginUser" method="post">
   <input type="text" name="email" placeholder="Email Address" required/>
   <input type="password" name="password"
   placeholder="password" required/>
   <button type="submit" class="btn btn-submit">login</button>
  
   <a href="forgot-password" style="color: white; font-size: 14px" class="btn-link">Forget Password?</a>
   <p style="font-size: 14px; color: #34495e;"> Account Not Found</p>
      <a href="userLogin" class="btn btn-register">Register Now/ new Form</a>
   
    </form>
    </div>
    </body>
    </html>
    
    
    
    
    