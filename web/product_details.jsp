<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Product Details - My Shoes</title>
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

<!-- Product Details Section -->
<main class="container mx-auto py-8">
    <div class="flex flex-col lg:flex-row">
        <!-- Left Section: Images -->
        <div class="w-full lg:w-1/2 flex flex-col items-center">
            <!-- Main Product Image -->
            <img alt="Main product image" class="w-full mb-4" height="400" src="${product.img}" width="600"/>
            <div class="flex flex-col space-y-2">
                <!-- Thumbnail Images (if available, else use the main image) -->
                <img alt="Product thumbnail" class="w-20 h-20" height="100" src="${product.img}" width="100"/>
            </div>
        </div>

        <!-- Right Section: Product Details -->
        <div class="w-full lg:w-1/2 p-4">
            <!-- Product Title -->
            <h1 class="text-xl font-bold">${product.productName}</h1>
            <div class="flex items-center mt-2">
                <div class="flex space-x-1">
                    <i class="far fa-star text-gray-400"></i>
                    <i class="far fa-star text-gray-400"></i>
                    <i class="far fa-star text-gray-400"></i>
                    <i class="far fa-star text-gray-400"></i>
                    <i class="far fa-star text-gray-400"></i>
                </div>
            </div>

            <div class="mt-4">
                <span class="text-red-600 text-2xl font-bold">${product.price}</span>
                <span class="text-gray-500 line-through ml-2">${product.price}</span>
                <span class="bg-red-600 text-white text-xs px-2 py-1 ml-2">-23%</span>
            </div>

            <div class="mt-4">
                <span class="text-green-600">${product.isAvailable ? 'In stock' : 'Out of stock'}</span>
            </div>

            <div class="mt-4">
                <span class="text-gray-500">Product Code: ${product.productId}</span>
            </div>

            <div class="mt-4">
                <span class="text-gray-500">Select Size</span>
                <div class="flex flex-wrap mt-2">
                    Size: ${product.sizes}
                </div>
            </div>

        <div class="mt-4 flex space-x-4">
            <!-- Add to Cart -->
            <form method="POST" action="${pageContext.request.contextPath}/shopping">
                <input type="hidden" name="action" value="addToCart" />
                <input type="hidden" name="productId" value="${product.productId}" />
                <input type="hidden" name="productName" value="${product.productName}" />
                <input type="hidden" name="imageUrl" value="${product.img}" />
                <input type="hidden" name="productCode" value="${product.productId}" />
                <input type="hidden" name="quantity" value="1" />
                <input type="hidden" name="price" value="${product.price}" />
                <input type="hidden" name="size" value="7" />
                <button type="submit" class="bg-blue-600 text-white px-4 py-2">Add to Cart</button>
            </form>

            <!-- Buy Now -->
            <form method="POST" action="${pageContext.request.contextPath}/shopping">
                <input type="hidden" name="action" value="buyNow" />
                <input type="hidden" name="productId" value="${product.productId}" />
                <input type="hidden" name="productName" value="${product.productName}" />
                <input type="hidden" name="imageUrl" value="${product.img}" />
                <input type="hidden" name="productCode" value="${product.productId}" />
                <input type="hidden" name="quantity" value="1" />
                <input type="hidden" name="price" value="${product.price}" />
                <input type="hidden" name="size" value="7" />
                <button type="submit" class="bg-red-600 text-white px-4 py-2">Buy Now</button>
            </form>
        </div>

        </div>
    </div>
</main>

    <script>
    function toggleDropdown() {
        const dropdown = document.getElementById('dropdown');
        if (dropdown) {
            dropdown.classList.toggle('show');
        }
    }

    // Close dropdown on clicking elsewhere
    document.addEventListener("click", function (event) {
        const dropdown = document.getElementById('dropdown');
        const accountSection = document.querySelector(".relative");

        if (dropdown && !accountSection.contains(event.target)) {
            dropdown.classList.remove('show');
        }
    });
</script>

</body>
</html>
