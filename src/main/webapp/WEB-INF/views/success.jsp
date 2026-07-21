<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Successful</title>
    <style>
    
    body {
    font-family: 'Segoe UI', sans-serif;
    background-color: #e9ecef;
    display: flex;
    justify-content: center;
    margin-top: 50px;
}

.container {
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    text-align: center;
    max-width: 500px;
    border-top: 5px solid #28a745;
}

h1 { color: #28a745; }

.data-box {
    text-align: left;
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin: 20px 0;
}

.data-box p {
    margin: 8px 0;
    color: #444;
}

.data {
    font-weight: bold;
    color: #007bff;
}
.btn {
    display: inline-block;
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
}
.btn:hover { background-color: #0056b3; }


a {
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    color: #007bff;
    font-weight: 600;
}

a:hover { text-decoration: underline; }
    
        .container { text-align: center; margin-top: 50px; font-family: Arial, sans-serif; }
        .data { color: green; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Shivam Project! 🎉</h1>
        <p>User Registration Successfully Complete ho gaya hai.</p>
        
        <hr>
        
        <h3>Aapki Details:</h3>
        <p>User Name: <span class="data">${savedUser.userName}</span></p>
        <p>Email: <span class="data">${savedUser.email}</span></p>
        <p>User ID: <span class="data">${savedUser.userId}</span></p>
        
        <br>
        <a href="shopRegistration">Shop Registration</a>
    </div>
</body>
</html>
