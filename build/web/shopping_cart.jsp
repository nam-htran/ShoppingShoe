<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.CartItemDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    // Lấy giỏ hàng từ session
    List<CartItemDTO> cartItems = (List<CartItemDTO>) session.getAttribute("cart");

    // Khởi tạo giỏ hàng nếu chưa có
    if (cartItems == null) {
        cartItems = new ArrayList<>();
    }

    // Tính tổng tiền
    double totalAmount = 0;
    for (CartItemDTO item : cartItems) {
        totalAmount += item.getPrice() * item.getQuantity();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Giỏ Hàng</title>
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
            max-width: 600px;
            flex-grow: 1;
        }

        #search-input {
            width: 100%;
            padding: 10px;
            border: none;
        }

        .container {
            gap: 1rem;
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

<!-- Phần giỏ hàng -->
<main class="container mx-auto my-8">
    <div class="bg-white p-6 rounded shadow">
        <h2 class="text-xl font-semibold mb-4">Giỏ Hàng Của Bạn</h2>
        <c:choose>
            <c:when test="${not empty sessionScope.cart}">
                <div class="overflow-x-auto">
                    <table class="min-w-full bg-white">
                        <thead>
                            <tr>
                                <th class="px-4 py-2 border">Hình ảnh</th>
                                <th class="px-4 py-2 border">Tên sản phẩm</th>
                                <th class="px-4 py-2 border">Mã</th>
                                <th class="px-4 py-2 border">Số lượng</th>
                                <th class="px-4 py-2 border">Đơn giá</th>
                                <th class="px-4 py-2 border">Thành tiền</th>
                                <th class="px-4 py-2 border">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <tr>
                                    <td class="px-4 py-2 border">
                                        <img alt="${item.productName}" class="h-16" src="${item.imageUrl}" width="100"/>
                                    </td>
                                    <td class="px-4 py-2 border">${item.productName}</td>
                                    <td class="px-4 py-2 border">${item.productCode}</td>
                                    <td class="px-4 py-2 border">
                                        <form action="${pageContext.request.contextPath}/shopping" method="post">
                                            <input type="hidden" name="action" value="updateQuantity"/>
                                            <input type="hidden" name="productId" value="${item.productId}"/>
                                            <input type="number" name="quantity" value="${item.quantity}" class="w-16 border px-2 py-1" min="1"/>
                                            <button type="submit" class="text-blue-500 hover:text-blue-700 ml-2">Cập nhật</button>
                                        </form>
                                    </td>
                                    <td class="px-4 py-2 border">${item.price}₫</td>
                                    <td class="px-4 py-2 border">${item.price * item.quantity}₫</td>
                                    <td class="px-4 py-2 border">
                                        <form action="${pageContext.request.contextPath}/shopping" method="post">
                                            <input type="hidden" name="action" value="removeFromCart"/>
                                            <input type="hidden" name="productId" value="${item.productId}"/>
                                            <button type="submit" class="text-red-500 hover:text-red-700">Xóa</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-gray-600">Giỏ hàng của bạn đang trống.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Phần thanh toán -->
    <div class="flex justify-end mt-4">
        <div class="bg-white p-6 rounded shadow w-1/3">
            <div class="flex justify-between mb-2">
                <span>Tổng tiền:</span>
                <span class="font-semibold">${totalAmount}₫</span>
            </div>
            <div class="flex justify-between mb-2">
                <span>Phí vận chuyển:</span>
                <span>Miễn phí</span>
            </div>
            <div class="flex justify-between font-semibold mb-4">
                <span>Tổng cộng:</span>
                <span>${totalAmount}₫</span>
            </div>

         <!-- Form thanh toán -->
        <form action="${pageContext.request.contextPath}/shopping" method="post">
            <input type="hidden" name="action" value="updateAddressAndCheckout"/>
            <input type="text" name="address" class="w-full border px-4 py-2 rounded mb-4" placeholder="Nhập địa chỉ giao hàng" required />
            <button class="w-full bg-green-600 text-white py-2 px-4 rounded">Thanh Toán</button>
        </form>
        </div>
    </div>
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
</main>
</body>
</html>
