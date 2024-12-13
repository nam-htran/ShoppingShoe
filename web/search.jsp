<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>My Shoes</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <style>
        /* Dropdown menu default behavior */
        .dropdown-menu {
            display: none;
            position: absolute;
            background-color: white;
            color: black;
            z-index: 1000;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 150px;
            top: 100%;
            left: 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .dropdown-menu.show {
            display: block;
        }

        /* Style for dropdown items */
        .dropdown-item {
            padding: 8px 12px;
            color: black;
            text-decoration: none;
            display: block;
        }

        .dropdown-item:hover {
            background-color: #f1f1f1;
        }

        /* Account Section */
        .account-container {
            position: relative;
        }
        form#search-form {
        max-width: 600px; /* Đặt max-width để không search box quá lớn */
        flex-grow: 1; /* Search box sẽ chiếm phần còn lại nếu không gian đủ */
    }

    #search-input {
        width: 100%; /* Search box sẽ chiếm 100% chiều rộng của form */
        padding: 10px; /* Thêm padding để dễ nhìn */
        border: none;
    }

    .container {
        gap: 1rem; /* Tạo khoảng cách giữa các phần tử khác */
    }

    </style>
</head>
<body class="bg-gray-100">
<header class="bg-blue-900 text-white">
    <div class="container mx-auto flex justify-between items-center py-2 space-x-4"> <!-- Reduced padding (py-2) -->
        
        <!-- Logo Section -->
        <div class="flex items-center">
            <a href="${pageContext.request.contextPath}/">
                <img alt="My Shoes Logo"
                     class="mr-4"
                     height="40" 
                     src="https://assets.zenn.com/strapi_assets/large_shoe_brand_logo_73b4fa7129.png"
                     width="50"/>
            </a>
        <span class="text-xl font-bold">TuanShoe</span> <!-- This will be the name next to the logo -->     
        </div>

        <!-- Search bar -->
        <form id="search-form" method="get" action="${pageContext.request.contextPath}/SearchController" class="flex-1 max-w-lg">
            <input id="search-input"
                   name="searchTerm"
                   class="w-full p-2 rounded bg-black text-white"
                   placeholder="Tìm kiếm sản phẩm..." 
                   type="text" />
            <button id="search-button" class="hidden" type="submit"></button>
        </form>

        <!-- Account Dropdown Logic -->
        <div class="relative account-container cursor-pointer" onclick="toggleDropdown()">
            <i class="fas fa-user text-gray-700"></i>
            <% if (session.getAttribute("user") != null) { %>
                <span class="ml-2">Tài khoản</span>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/Login" class="ml-2">Đăng nhập</a> /
                <a href="${pageContext.request.contextPath}/Register" class="ml-2">Đăng ký</a>
            <% } %>
            
            <!-- Dropdown Menu -->
            <% if (session.getAttribute("user") != null) { %>
                <div id="dropdown" class="dropdown-menu">
                    <a href="${pageContext.request.contextPath}/user-info" class="dropdown-item">Thông tin</a>
                    <a href="${pageContext.request.contextPath}/Logout" class="dropdown-item">Đăng xuất</a>
                </div>
            <% } %>
        </div>
    </div>
</header>
        <!-- Products Section -->
    <main class="container mx-auto py-8">
        <!-- Product Listings Section -->
        <h1 class="text-3xl font-bold text-center mb-6">Search Results</h1>
        <div class="grid grid-cols-5 gap-4">
            <c:forEach var="product" items="${searchResults}">
            <div class="bg-white p-4 rounded shadow hover:shadow-lg transition-shadow duration-300">
                <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}">
                    <img alt="${product.productName}"
                         class="w-full h-48 object-cover mb-4"
                         src="${product.img}" />
                    <h3 class="text-sm mb-2">${product.productName}</h3>
                    <p class="text-red-500 font-bold">${product.price}</p>
                </a>
            </div>
            </c:forEach>

            <!-- If no results -->
            <c:if test="${empty searchResults}">
                <p class="text-center text-gray-600">No results found for your search.</p>
            </c:if>
        </div> 
    </main>
        
<script>
    function toggleDropdown() {
        const dropdown = document.getElementById('dropdown');
        if (dropdown) {
            dropdown.classList.toggle('show');
        }
    }

    // Close dropdown menu when clicking elsewhere
    document.addEventListener("click", function (event) {
        const dropdown = document.getElementById('dropdown');
        const accountSection = document.querySelector(".account-container");

        if (dropdown && !accountSection.contains(event.target)) {
            dropdown.classList.remove('show');
        }
    });
</script>
</body>
</html>