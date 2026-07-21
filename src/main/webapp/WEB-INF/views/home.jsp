<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="hi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopFinder Home - Premium Dashboard</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<nav class="navbar">
    <div class="nav-left">
        <i class="fas fa-bars menu-icon"></i>
        <a href="home" class="logo">GG<span style="font-size:14px; font-weight:500; color:#6b7280; margin-left:5px;">ShopFinder</span></a>
    </div>

    <div class="search-container">
        <input type="text" id="searchInput" class="search-bar" placeholder="Dukan ka naam ya item search karein...">
        <button type="button" class="search-btn" onclick="performSearch()">
            <i class="fas fa-search"></i>
        </button>
    </div>

<div class="nav-right">
    <a href="home" class="nav-link"><i class="fas fa-home"></i> Home</a>
    
    <c:choose>
        <%-- Agar User Login hai (Bhale hi dukan ho ya na ho) --%>
        <c:when test="${not empty sessionScope.userSession}">
            <div class="profile-nav">
                <span class="profile-text">Hi, ${sessionScope.userSession.firstName}</span>
                
                <a href="yourProfile" class="insta-profile-icon" title="My Profile">
                    <div class="insta-profile-icon-inner">
                        <img src="https://ui-avatars.com/api/?name=${sessionScope.userSession.firstName}&background=e1306c&color=fff&size=40" 
                             style="width:100%; height:100%; border-radius:50%;">
                    </div>
                </a>
            </div>
        </c:when>
        
        <c:otherwise>
            <a href="shopRegistration" class="btn-orange"><i class="fas fa-store"></i> Register Your Shop</a>
        </c:otherwise>
    </c:choose>
    
    
</div>
</nav>

<div class="dashboard-layout">
    
    <main>
        <div class="section-title">
            <i class="fas fa-location-crosshairs" style="color: #2563eb;"></i> 
            Shops In Your Location Market
        </div>
        
        <c:choose>
            <c:when test="${empty shops}">
                <div style="background: white; padding: 40px; text-radius:16px; border:1px solid #e5e7eb; text-align:center;">
                    <i class="fas fa-shop-slash" style="font-size: 40px; color:#9ca3af; margin-bottom:15px;"></i>
                    <p style="color: #6b7280; font-weight:500; margin:0;">Aapke aas-paas abhi koi dukan registered nahi hai.</p>
                </div>
            </c:when>
            <c:otherwise>
<c:forEach var="shop" items="${shops}">
    <div class="shop-feed-card" style="background: white; border: 1px solid #dbdbdb; border-radius: 12px; margin-bottom: 30px; box-shadow: 0 1px 2px rgba(0,0,0,0.05); display: flex; flex-direction: column; overflow: hidden;">
        
        <div class="card-header" style="display: flex; align-items: center; justify-content: space-between; padding: 14px; border-bottom: 1px solid #efefef;">
            <div class="card-owner-info" style="display: flex; align-items: center; gap: 12px;">
                <div class="shop-avatar" style="width: 40px; height: 40px; border-radius: 50%; background: #0095f6; color: white; display: flex; align-items: center; justify-content: center; font-size: 16px;">
                    <i class="fas fa-store"></i>
                </div>
                <div class="shop-name-meta">
                    <h4 style="margin: 0; font-size: 15px; font-weight: 600; color: #262626;">${shop.shopName}</h4>
                    <span style="font-size: 12px; color: #8e8e8e; display: block; margin-top: 2px;">Owner: ${shop.ownerName}</span>
                </div>
            </div>
            <span class="badge-tag" style="background: #f3f4f6; color: #374151; font-size: 12px; padding: 4px 10px; border-radius: 20px; font-weight: 600;">${shop.category}</span>
        </div>
        
        <div class="card-banner" onclick="openProductsModal(${shop.shopId}, '${shop.shopName}')" style="cursor: pointer; position: relative; width: 100%; aspect-ratio: 1/1; background-color: #efefef;">
            <img src="${pageContext.request.contextPath}/resources/images/${shop.shopImage}" 
                 onerror="this.src='${pageContext.request.contextPath}/resources/images/default_shop.jpg';" 
                 style="width: 100%; height: 100%; object-fit: cover;">
            <div style="position: absolute; bottom: 15px; right: 15px; background: rgba(0, 0, 0, 0.7); color: white; padding: 6px 12px; border-radius: 6px; font-size: 12px; font-weight: 600; display: flex; align-items: center; gap: 6px;">
                <i class="fas fa-images"></i> View Products
            </div>
        </div>
        
        <div class="card-body" style="padding: 15px;">
            
            <div class="card-action-bar" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; border-bottom: 1px solid #f3f4f6; padding-bottom: 12px; flex-wrap:wrap; gap:10px;">

    <!-- Rating -->
    <div class="rating-box" style="color: #fbbf24; font-size: 16px; display: flex; align-items: center; gap: 3px;">
        <i class="fas fa-star"></i>
        <i class="fas fa-star"></i>
        <i class="fas fa-star"></i>
        <i class="fas fa-star"></i>
        <i class="far fa-star"></i>

       <div class="rating-box" style="display: flex; align-items: center; gap: 4px; color: #fbbf24; font-size: 14px;">
    
    <c:choose>
        <c:when test="${shop.totalReviews == 0}">
            <span style="color: #9ca3af; font-size: 12px; font-weight: 500;">No ratings yet</span>
        </c:when>
        <c:otherwise>
            <c:forEach var="i" begin="1" end="5">
                <c:choose>
                    <c:when test="${i <= shop.averageRating}">
                        <i class="fas fa-star"></i> 
                 
                        <i class="far fa-star"></i> </c:when>
                </c:choose>
            </c:forEach>
            <span style="color: #6b7280; font-size: 12px; margin-left: 4px; font-weight: 600;">
                (${String.format("%.1f", shop.averageRating)})
            </span>
        </c:otherwise>
    </c:choose>
    
</div>
    </div>

    <!-- Buttons -->
    <div style="display:flex; gap:8px;">

        <!-- Rasta Dekhein -->
        <button type="button" 
        onclick="openGoogleMaps('${userLat}', '${userLng}', '${shop.latitude}', '${shop.longitude}', '${shop.address} ${shop.shopName}')"
        style="background-color: #2563eb; color: white; border: none; padding: 8px 14px; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 6px; transition: 0.2s;">
    <i class="fas fa-paper-plane"></i> Find Path
</button>

        <!-- View Products -->
        <button type="button"
                onclick="openProductsModal(${shop.shopId}, '${shop.shopName}')"
                style="background-color: #111827;
                       color: white;
                       border: none;
                       padding: 8px 14px;
                       border-radius: 6px;
                       font-size: 13px;
                       font-weight: 600;
                       cursor: pointer;
                       display: inline-flex;
                       align-items: center;
                       gap: 6px;
                       transition: 0.2s;">

            <i class="fas fa-tags"></i>
            View Products
        </button>

    </div>
</div>
            <div class="address" style="font-size: 14px; line-height: 1.5; color: #262626;">
                <p style="margin: 4px 0;"><i class="fas fa-location-dot" style="color: #ef4444; margin-right: 6px;"></i> <strong>Address:</strong> ${shop.address}</p>
            </div>
            <div style="font-size: 12px; color: #737373; display: flex; gap: 15px; margin-top: 10px; border-top: 1px solid #f5f5f5; padding-top: 8px;">
                <span><i class="fas fa-phone"></i> ${shop.contactNumber}</span>
                <span><i class="fas fa-envelope"></i> ${shop.email}</span>
            </div>
        </div>
    </div>
</c:forEach>

            </c:otherwise>
        </c:choose>
    </main>
    
    <aside>
        <div class="widget-box">
            <h3><i class="fas fa-tags" style="color: #f97316;"></i> Top Categories</h3>
            <div style="margin-top: 10px;">
                <div class="category-pill" onclick="filterCategory('Grocery')">🛒 Grocery</div>
                <div class="category-pill" onclick="filterCategory('Clothing')">👕 Clothing</div>
                <div class="category-pill" onclick="filterCategory('Electronics')">💻 Electronics</div>
                <div class="category-pill" onclick="filterCategory('Medical')">💊 Medical Store</div>
                <div class="category-pill" onclick="filterCategory('Bakery')">🍰 Bakery & Sweets</div>
            </div>
        </div>
        
        <div class="widget-box" style="background: linear-gradient(135deg, #eff6ff, #dbeafe); border-color:#bfdbfe;">
            <h3 style="color:#1e40af;"><i class="fas fa-circle-info"></i> Quick Guide</h3>
            <p style="font-size: 13px; color: #1e3a8a; line-height: 1.5; margin: 5px 0 0 0;">
                Aap upar diye gaye search bar se kisi bhi item ka naam daal kar check kar sakte hain ki wo kis dukan par kitne daam mein uplabdha hai.
            </p>
        </div>
    </aside>
</div>

<div id="aiChatDrawer" class="ai-chat-drawer">
    <div class="ai-chat-header">
        <h4><i class="fas fa-wand-magic-sparkles"></i> ShopFinder Local AI AI</h4>
        <span class="ai-chat-close" onclick="toggleAiDrawer()">×</span>
    </div>
    <div id="aiChatMessages" class="ai-chat-messages">
        <div class="chat-bubble ai">
            Namaste! Main aapka Local Market AI assistant hoon. Aap mujhse pooch sakte hain ki kaun si cheez kis dukan par milti hai!
        </div>
    </div>
    <div class="ai-chat-input-container">
        <input type="text" id="aiChatInput" placeholder="Ask anything about the market..." onkeypress="handleAiKeyPress(event)" />
        <button class="ai-send-btn" onclick="processAiChat()"><i class="fas fa-paper-plane"></i></button>
    </div>
</div>


<script>
// Geolocation Search Query Routing
function performSearch() {
    var query = document.getElementById('searchInput').value;
    if(query.trim() === "") {
        alert('Plese Serch!');
        return;
    }
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            window.location.href = "searchShops?query=" + encodeURIComponent(query) + "&lat=" + position.coords.latitude + "&lng=" + position.coords.longitude;
        }, function(error) {
            window.location.href = "searchShops?query=" + encodeURIComponent(query) + "&lat=0.0&lng=0.0";
        });
    } else {
        window.location.href = "searchShops?query=" + encodeURIComponent(query) + "&lat=0.0&lng=0.0";
    }
}

document.getElementById('searchInput').addEventListener('keypress', function (e) {
    if (e.key === 'Enter') { performSearch(); }
});

function filterCategory(catName) {
    document.getElementById('searchInput').value = catName;
    performSearch();
}

// AI Drawer Toggle Logic
function toggleAiDrawer() {
    var drawer = document.getElementById('aiChatDrawer');
    drawer.style.display = (drawer.style.display === 'none' || drawer.style.display === '') ? 'flex' : 'none';
}

function processAiChat() {
    var input = document.getElementById('aiChatInput');
    var txt = input.value.trim();
    if(!txt) return;
    
    var container = document.getElementById('aiChatMessages');
    
    // Append User Prompt
    var uBubb = document.createElement('div');
    uBubb.className = "chat-bubble user";
    uBubb.innerText = txt;
    container.appendChild(uBubb);
    
    input.value = "";
    container.scrollTop = container.scrollHeight;
    
    // Smart Preset Parsing Delay
    setTimeout(function() {
        var aiBubb = document.createElement('div');
        aiBubb.className = "chat-bubble ai";
        
        var q = txt.toLowerCase();
        if(q.includes('cloth') || q.includes('kapde') || q.includes('jeans')) {
            aiBubb.innerHTML = "👔 Kapdo ke liye aap top timeline par category section me click karke browse karein. Vahan sabse kam daam wale options mil jayenge.";
        } else if(q.includes('medical') || q.includes('dawa')) {
            aiBubb.innerHTML = "💊 Medical items ke liye 'Medical Store' category select karein, jo aapko sabse paas ki emergency pharmacy tak le jayegi.";
        } else {
            aiBubb.innerHTML = "✨ Maine aapki request check ki hai! Isko sateek dekhne ke liye aap upar diye gaye global panel par item ka naam likh kar search dabayein.";
        }
        container.appendChild(aiBubb);
        container.scrollTop = container.scrollHeight;
    }, 700);
}

function handleAiKeyPress(e) {
    if(e.key === 'Enter') { processAiChat(); }
}
</script>

<div id="productModal" class="modal" style="display: none; position: fixed; z-index: 3000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.8); backdrop-filter: blur(5px); align-items: center; justify-content: center;">
    <div class="modal-content" style="background: white; padding: 25px; border-radius: 16px; width: 90%; max-width: 480px; max-height: 75vh; overflow-y: auto; position: relative;">
        <span class="close-modal" onclick="closeProductsModal()" style="position: absolute; right: 20px; top: 15px; font-size: 26px; cursor: pointer; color: #737373;">×</span>
        <h3 id="modalShopName" style="margin: 0 0 12px 0; font-size: 16px; color: #262626; border-bottom: 1px solid #efefef; padding-bottom: 8px;"></h3>
        <div id="productContainer" class="product-grid" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; margin-top: 15px;"></div>
    </div>
</div>

<script>
function openProductsModal(shopId, shopName) {
    // Modal header me dukan ka naam set karna
    document.getElementById('modalShopName').innerText = shopName + " - Catalogue";
    var container = document.getElementById('productContainer');
    container.innerHTML = "<p style='grid-column: span 2; text-align:center; font-size:14px; color:#737373;'>Loading Products...</p>";
    
    // Modal ko screen par show karna
    document.getElementById('productModal').style.display = "flex";
    
    // AJAX Request initiate karna
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
                
                // Binding safely without backslash conflicts
                var card = '<div class="product-card" style="border: 1px solid #efefef; border-radius: 10px; overflow: hidden; background: #fff;">' +
                           '  <img src="' + '${pageContext.request.contextPath}/resources/images/' + prod.productImage + '" onerror="this.src=\'' + '${pageContext.request.contextPath}/resources/images/default_product.jpg' + '\';" style="width: 100%; aspect-ratio: 1/1; object-fit: cover; border-bottom: 1px solid #f5f5f5;">' +
                           '  <div class="product-info" style="padding: 10px;">' +
                           '    <h4 style="margin: 0 0 4px 0; font-size: 13px; color: #262626; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' + prod.productName + '</h4>' +
                           '    <p style="margin: 0; font-size: 14px; color: #10b981; font-weight: 700;">' + priceDisplay + '</p>' +
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



//🌍 Global variables user ki location store karne ke liye
var globalUserLat = "0.0";
var globalUserLng = "0.0";

// Page load hote hi user ki current location pucho
window.addEventListener('DOMContentLoaded', (event) => {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            globalUserLat = position.coords.latitude;
            globalUserLng = position.coords.longitude;
            // ✅ Java ka System.out hata kar JavaScript ka console.log lagaya
            console.log("Home page location fetched: " + globalUserLat + ", " + globalUserLng);
        }, function(error) {
            console.log("Location access denied or error occurred.");
        });
    }
});

// Purana openGoogleMaps function hata kar ye naya update karein
function openGoogleMaps(userLat, userLng, shopLat, shopLng, shopAddress) {
    var mapsUrl = "";
    
    // Agar Backend se lat/lng nahi aaya (jaise home page par), toh browser wale global variables use karo
    var currentLat = (userLat && userLat !== 'null' && userLat !== '0.0') ? userLat : globalUserLat;
    var currentLng = (userLng && userLng !== 'null' && userLng !== '0.0') ? userLng : globalUserLng;

    // 🎯 Ab rasta check karne ka secure routing path
    if (currentLat !== "0.0" && currentLng !== "0.0" && shopLat && shopLng && shopLat !== '0.0') {
        mapsUrl = "https://www.google.com/maps/dir/?api=1&origin=" + currentLat + "," + currentLng + "&destination=" + shopLat + "," + shopLng + "&travelmode=driving";
    } 
    else if (shopLat && shopLng && shopLat !== '0.0') {
        mapsUrl = "https://www.google.com/maps/search/?api=1&query=" + shopLat + "," + shopLng;
    } 
    else {
        mapsUrl = "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent(shopAddress);
    }

    window.open(mapsUrl, '_blank');
}
</script>

</body>
</html>