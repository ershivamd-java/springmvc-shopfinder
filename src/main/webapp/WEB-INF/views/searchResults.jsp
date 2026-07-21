<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="hi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - ShopFinder</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', sans-serif; 
            background-color: #fafafa; 
            margin: 0; 
            padding: 20px; 
            color: #262626;
        }
        .container { max-width: 600px; margin: 30px auto; } 
        
        .back-btn { 
            text-decoration: none; 
            color: #0095f6; 
            font-weight: 600; 
            display: inline-flex; 
            align-items: center; 
            gap: 8px; 
            margin-bottom: 25px; 
            font-size: 15px;
        }
        
        h2 { 
            color: #262626; 
            font-size: 22px; 
            font-weight: 400; 
            margin-bottom: 25px; 
            border-bottom: 1px solid #dbdbdb;
            padding-bottom: 15px;
        }

        .shop-card {
            background: white;
            border: 1px solid #dbdbdb;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column; 
            overflow: hidden;
        }
        
        .post-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px;
            border-bottom: 1px solid #efefef;
        }
        .post-header-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .profile-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%);
            padding: 2px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .profile-avatar-inner {
            width: 100%;
            height: 100%;
            background: #cbd5e1;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            border: 2px solid white;
        }
        .shop-title-section h3 {
            margin: 0;
            font-size: 15px;
            font-weight: 600;
            color: #262626;
        }
        .shop-title-section .category-badge {
            font-size: 12px;
            color: #8e8e8e;
            display: block;
            margin-top: 2px;
        }
        
        .distance-tag {
            background-color: #eaf5ff; 
            color: #0095f6; 
            padding: 6px 12px; 
            border-radius: 20px;
            font-weight: 700; 
            font-size: 12px;
        }

        .shop-image-container {
            width: 100%;
            position: relative;
            background-color: #efefef;
            display: flex;
            align-items: center;
            justify-content: center;
            aspect-ratio: 1 / 1; 
            cursor: pointer;
        }
        .shop-image-container img { 
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
        }
        .view-products-overlay {
            position: absolute;
            bottom: 15px;
            right: 15px;
            background: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .post-footer { padding: 15px; }

        /* 🎯 Rating Row Layout */
        .rating-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .rating-display {
            display: flex;
            align-items: center;
            gap: 4px;
            color: #fbbf24;
            font-size: 18px;
        }
        .rating-text {
            color: #6b7280;
            font-size: 13px;
            font-weight: 600;
            margin-left: 5px;
        }
        
        /* Buttons Individual Layout Formatting */
        .direction-btn {
            background-color: #0095f6; 
            color: white; 
            text-decoration: none; 
            padding: 8px 16px;
            border-radius: 8px; 
            font-size: 13px; 
            font-weight: 600; 
            display: inline-flex;
            align-items: center; 
            justify-content: center;
            gap: 6px; 
            border: none;
        }

        .action-view-btn {
            background-color: #262626;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: background-color 0.2s;
        }
        .action-view-btn:hover {
            background-color: #404040;
        }

        /* 🎯 Address Grid Row Layout */
        .address-row-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-top: 4px;
        }

        .shop-details-text { 
            font-size: 14px; 
            line-height: 1.4;
            flex: 1;
            padding-right: 15px;
        }
        .shop-details-text p { margin: 4px 0; }
        
        .no-results { 
            background: white; padding: 50px; text-align: center; border-radius: 12px; border: 1px solid #dbdbdb;
        }

        .modal {
            display: none; 
            position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.8); backdrop-filter: blur(5px);
            align-items: center; justify-content: center;
        }
        .modal-content {
            background: white; padding: 25px; border-radius: 16px; width: 90%; max-width: 480px;
            max-height: 75vh; overflow-y: auto; text-align: left; position: relative;
        }
        .close-modal {
            position: absolute; right: 20px; top: 15px; font-size: 26px; cursor: pointer; color: #737373;
        }
        .close-modal:hover { color: #000; }

        .product-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; margin-top: 15px; }
        .product-card { border: 1px solid #efefef; border-radius: 10px; overflow: hidden; background: #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.03); }
        .product-card img { width: 100%; aspect-ratio: 1/1; object-fit: cover; border-bottom: 1px solid #f5f5f5; }
        .product-info { padding: 10px; }
        .product-info h4 { margin: 0 0 4px 0; font-size: 13px; color: #262626; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;}
        .product-info p { margin: 0; font-size: 14px; color: #10b981; font-weight: 700; }
    </style>
</head>
<body>

<div class="container">
    <a href="home" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Home Page</a>
    <h2><i class="fas fa-search"></i> Search Results for: "<span style="color: #0095f6; font-weight: 600;">${searchQuery}</span>"</h2>
    
    <c:choose>
        <c:when test="${empty shops}">
            <div class="no-results">
                <i class="fas fa-store-slash" style="font-size: 54px; color: #dbdbdb; margin-bottom: 20px;"></i>
                <p style="font-size: 16px; font-weight: 600;">Shop Not Found.</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="shop" items="${shops}">
                <c:set var="addressParts" value="${fn:split(shop.address, '##')}" />
                
                <div class="shop-card">
                    <div class="post-header">
                        <div class="post-header-left">
                            <div class="profile-avatar">
                                <div class="profile-avatar-inner"><i class="fas fa-store"></i></div>
                            </div>
                            <div class="shop-title-section">
                                <h3>${shop.shopName}</h3>
                                <span class="category-badge">${shop.category}</span>
                            </div>
                        </div>
                        <div>
                            <span class="distance-tag"><i class="fas fa-location-dot"></i> ${addressParts[1]}</span>
                        </div>
                    </div>
                    
                    <div class="shop-image-container" onclick="openProductsModal(${shop.shopId}, '${fn:escapeXml(shop.shopName)}')">
                        <img src="${pageContext.request.contextPath}/resources/images/${shop.shopImage}" 
                             alt="${shop.shopName}" 
                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default_shop.jpg';">
                        <div class="view-products-overlay">
                            <i class="fas fa-images"></i> View Products
                        </div>
                    </div>
                    
                    <div class="post-footer">
                        <div class="rating-row">
                            <div class="rating-display">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                                <span class="rating-text">4.0</span>
                            </div>
                            <a href="#" onclick="openGoogleMaps(${userLat}, ${userLng}, ${shop.latitude}, ${shop.longitude}); return false;" class="direction-btn">
                                <i class="fas fa-paper-plane"></i> Find Path
                            </a>
                        </div>
                        
                        <div class="address-row-container">
                            <div class="shop-details-text">
                                <p><strong>${shop.ownerName}</strong> <span style="color: #8e8e8e; font-size: 12px;">(Owner)</span></p>
                                <p><strong>Address:</strong> ${addressParts[0]}</p>
                                <p style="color: #737373; font-size: 12px; margin-top: 6px;">
                                    <i class="fas fa-phone"></i> ${shop.contactNumber} | <i class="fas fa-envelope"></i> ${shop.email}
                                </p>
                            </div>
                            <button type="button" class="action-view-btn" onclick="openProductsModal(${shop.shopId}, '${fn:escapeXml(shop.shopName)}')">
                                <i class="fas fa-bag-shopping"></i> View Products
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<div id="productModal" class="modal">
    <div class="modal-content">
        <span class="close-modal" onclick="closeProductsModal()">×</span>
        <h3 id="modalShopName" style="margin: 0 0 12px 0; font-size: 16px; color: #262626; border-bottom: 1px solid #efefef; padding-bottom: 8px;"></h3>
        <div id="productContainer" class="product-grid"></div>
    </div>
</div>

<script>
function openGoogleMaps(userLat, userLng, shopLat, shopLng) {
    var mapsUrl = "https://www.google.com/maps/dir/?api=1&origin=" + userLat + "," + userLng + "&destination=" + shopLat + "," + shopLng + "&travelmode=driving";
    window.open(mapsUrl, '_blank');
}

function openProductsModal(shopId, shopName) {
    document.getElementById('modalShopName').innerText = shopName + " - Catalogue";
    var container = document.getElementById('productContainer');
    container.innerHTML = "<p style='grid-column: span 2; text-align:center; font-size:14px; color:#737373;'>Loading Products...</p>";
    
    document.getElementById('productModal').style.display = "flex";
    
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "${pageContext.request.contextPath}/getShopProducts?shopId=" + shopId, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var products = JSON.parse(xhr.responseText);
            container.innerHTML = ""; 
            
            if(products.length === 0) {
                container.innerHTML = "<p style='grid-column: span 2; text-align:center; color:#737373; font-size:14px; padding: 20px 0;'>Is dukan ne abhi tak koi product nahi dala hai.</p>";
                return;
            }
            
            products.forEach(function(prod) {
                var priceDisplay = prod.productPrice ? "₹" + prod.productPrice : "Price N/A";
                var imgPath = "${pageContext.request.contextPath}/resources/images/" + prod.productImage;
                var defaultImg = "${pageContext.request.contextPath}/resources/images/default_product.jpg";
                
                var card = '<div class="product-card">' +
                           '  <img src="' + imgPath + '" onclick="void(0)" onerror="this.src=\'' + defaultImg + '\';">' +
                           '  <div class="product-info">' +
                           '    <h4>' + prod.productName + '</h4>' +
                           '    <p>' + priceDisplay + '</p>' +
                           '  </div>' +
                           '</div>';
                container.innerHTML += card;
            });
        }
    };
    xhr.send();
}

function closeProductsModal() {
    document.getElementById('productModal').style.display = "none";
}

window.onclick = function(event) {
    var modal = document.getElementById('productModal');
    if (event.target == modal) { modal.style.display = "none"; }
}
</script>
</body>
</html>