<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="hi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop Profile - Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #fafafa;
            margin: 0;
            padding: 0;
            color: #262626;
        }
        .navbar {
            background: white;
            border-bottom: 1px solid #dbdbdb;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a { text-decoration: none; color: #0095f6; font-weight: 600; font-size: 14px; }
        
        .main-container { max-width: 935px; margin: 30px auto; padding: 0 20px; }

        /* 🏪 SHOP HEADER SECTION (Instagram Style) */
        .shop-header {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #dbdbdb;
            padding-bottom: 44px;
            margin-bottom: 28px;
            gap: 60px;
        }
        
        /* Left: Circle Image with Insta Ring */
        .profile-photo-container { flex-shrink: 0; }
        .circle-profile-pic {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%);
            padding: 3px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .circle-profile-pic img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid white;
            background-color: #cbd5e1;
        }

        /* Right: Details & Edit Link */
        .shop-info-container { flex-grow: 1; }
        .shop-title-row {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }
        .shop-title-row h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 300;
        }
        .edit-profile-btn {
            background-color: #0095f6;
            color: white;
            text-decoration: none;
            padding: 6px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            transition: background 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .edit-profile-btn:hover { background-color: #1877f2; }

        .shop-stats { display: flex; gap: 40px; margin-bottom: 20px; list-style: none; padding: 0; }
        .shop-stats li { font-size: 16px; color: #262626; }
        .shop-stats strong { font-weight: 600; }

        .shop-bio { font-size: 15px; line-height: 1.5; }
        .shop-bio p { margin: 4px 0; }
        .shop-bio .category { color: #8e8e8e; font-weight: 600; text-transform: uppercase; font-size: 12px; letter-spacing: 1px; }

        /* ➕ PRODUCT UPLOAD FORM SECTION */
        .upload-section {
            background: white;
            border: 1px solid #dbdbdb;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 40px;
        }
        .upload-section h3 { margin-top: 0; font-weight: 600; color: #262626; font-size: 18px; margin-bottom: 20px;}
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: flex-end;
        }
        .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; align-items: flex-end; }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        .form-group label { font-size: 12px; font-weight: 600; color: #737373; }
        .form-group input {
            padding: 10px;
            border: 1px solid #dbdbdb;
            border-radius: 6px;
            outline: none;
            font-size: 14px;
            background: #fafafa;
        }
        .form-group input:focus { border-color: #a8a8a8; }
        .submit-btn {
            background-color: #22c55e;
            color: white;
            border: none;
            padding: 11px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.2s;
        }
        .submit-btn:hover { background-color: #16a34a; }

        /* 🛍️ PRODUCT GRID / DISPLAY & DELETE */
        .tabs-header {
            border-top: 1px solid #dbdbdb;
            display: flex;
            justify-content: center;
            gap: 60px;
            margin-bottom: 20px;
        }
        .tab-item {
            border-top: 1px solid #262626;
            margin-top: -1px;
            padding: 12px 0;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            display: flex;
            align-items: center;
            gap: 6px;
            color: #262626;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 28px;
        }
        .product-item {
            position: relative;
            aspect-ratio: 1 / 1;
            background-color: #efefef;
            border-radius: 4px;
            overflow: hidden;
        }
        .product-item img { width: 100%; height: 100%; object-fit: cover; }
        
        .product-overlay {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.6);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            opacity: 0;
            transition: opacity 0.2s ease;
            color: white;
            text-align: center;
            padding: 15px;
            box-sizing: border-box;
        }
        .product-item:hover .product-overlay { opacity: 1; }
        
        .product-overlay h4 { margin: 0 0 5px 0; font-size: 16px; font-weight: 600; }
        .product-overlay p { margin: 0 0 15px 0; font-size: 15px; color: #4ade80; font-weight: 700; }
        
        .delete-btn {
            background-color: #ef4444;
            color: white;
            text-decoration: none;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            transition: background 0.2s;
        }
        .delete-btn:hover { background-color: #dc2626; }
        
        @media (max-width: 735px) {
            .shop-header { flex-direction: column; text-align: center; gap: 20px; }
            .shop-title-row { flex-direction: column; gap: 10px; }
            .products-grid { grid-template-columns: repeat(2, 1fr); gap: 10px; }
            .form-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="navbar">
    <div style="font-weight: 700; font-size: 18px; color: #262626;"><i class="fas fa-bag-shopping"></i> Vendor Dashboard</div>
    <div style="display: flex; gap: 20px; align-items: center;">
        <a href="${pageContext.request.contextPath}/home"><i class="fas fa-house"></i> Home Par Jayein</a>
        <a href="${pageContext.request.contextPath}/userLogout" style="color:#ef4444; border: 1px solid #ef4444; padding: 4px 12px; border-radius: 6px;"><i class="fas fa-right-from-bracket"></i> Logout</a>
    </div>
</div>

<div class="main-container">

    <header class="shop-header">
        <div class="profile-photo-container">
            <div class="circle-profile-pic">
                <img src="${pageContext.request.contextPath}/resources/images/${shopDetails.shopImage}" 
                     alt="${shopDetails.shopName}" 
                     onerror="this.src='${pageContext.request.contextPath}/resources/images/default_shop.jpg';">
            </div>
        </div>
        
        <div class="shop-info-container">
            <div class="shop-title-row">
                <h1>${shopDetails.shopName}</h1>
                <a href="${pageContext.request.contextPath}/editShopProfile" class="edit-profile-btn">
                    <i class="fas fa-gear"></i> Update Shop Details
                </a>
            </div>
            
            <ul class="shop-stats">
                <li><strong><c:out value="${products != null ? products.size() : 0}"/></strong> products</li>
                <li>Owner: <strong>${shopDetails.ownerName}</strong></li>
            </ul>
            
            <div class="shop-bio">
                <span class="category">${shopDetails.category}</span>
                <p style="margin-top: 8px;"><i class="fas fa-location-dot" style="color: #737373;"></i> ${shopDetails.address}</p>
                <p style="color: #737373; font-size: 13px;"><i class="fas fa-phone"></i> ${shopDetails.contactNumber} | <i class="fas fa-envelope"></i> ${shopDetails.email}</p>
            </div>
        </div>
    </header>

    <section class="upload-section">
        <h3><i class="fas fa-cloud-arrow-up" style="color: #0095f6;"></i> Naya Product Upload Karein</h3>
        <form action="${pageContext.request.contextPath}/saveProduct" method="post" enctype="multipart/form-data">
            
            <input type="hidden" name="shopId" value="${shopDetails.shopId}" />
            
            <div class="form-grid">
                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text" name="productName" placeholder="e.g. Red Shoes" required />
                </div>
                
                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" step="0.01" name="productPrice" placeholder="e.g. 499" required />
                </div>
                
                <div class="form-group">
                    <label>Product Image</label>
                    <input type="file" name="productPhoto" accept="image/*" required style="border: none; background: transparent; padding: 5px 0;"/>
                </div>
                
                <button type="submit" class="submit-btn">
                    <i class="fas fa-plus"></i> Upload Item
                </button>
            </div>
        </form>
    </section>

    <div class="tabs-header">
        <div class="tab-item"><i class="fas fa-table-cells"></i> Uploaded Products</div>
    </div>

    <c:choose>
        <c:when test="${empty products}">
            <p style="text-align: center; color: #737373; font-size: 15px; margin-top: 40px;">
                Aapki dukan me abhi koi product nahi hai. Upar wale form se pehla product add karein!
            </p>
        </c:when>
        <c:otherwise>
            <div class="products-grid">
                <c:forEach var="prod" items="${products}">
                    <div class="product-item">
                        <img src="${pageContext.request.contextPath}/resources/images/${prod.productImage}" 
                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default_product.jpg';">
                        
                        <div class="product-overlay">
                            <h4>${prod.productName}</h4>
                            <p>₹${prod.productPrice}</p>
                            <a href="${pageContext.request.contextPath}/deleteProduct?productId=${prod.productId}" 
                               class="delete-btn" 
                               onclick="return confirm('Kya aap sachme is product ko dukan se hatana chahte hain?');">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

</body>
</html>