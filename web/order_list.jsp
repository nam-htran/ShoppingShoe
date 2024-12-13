<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đơn Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-6">Lịch Sử Đơn Hàng</h1>
        
        <!-- Transaction Table -->
        <div class="bg-white shadow-md rounded-lg p-6 mb-8">
            <h2 class="text-2xl font-semibold mb-4">Thông Tin Đơn Hàng</h2>
            <table class="min-w-full">
                <thead>
                    <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                        <th class="py-3 px-6 text-left">Mã Đơn Hàng</th>
                        <th class="py-3 px-6 text-left">Mã Người Dùng</th>
                        <th class="py-3 px-6 text-left">Ngày Đặt Hàng</th>
                        <th class="py-3 px-6 text-left">Tổng Tiền</th>
                        <th class="py-3 px-6 text-left">Địa Chỉ</th>
                        <th class="py-3 px-6 text-left">Trạng Thái</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <!-- Dynamically Render Data from Server -->
                    <c:forEach var="order" items="${transactionHistory}">
                        <tr class="border-b border-gray-200 hover:bg-gray-100">
                            <td class="py-3 px-6">${order.orderId}</td>
                            <td class="py-3 px-6">${order.userId}</td>
                            <td class="py-3 px-6">${order.orderDate}</td>
                            <td class="py-3 px-6">$${order.totalPrice}</td>
                            <td class="py-3 px-6">${order.address}</td>
                            <td class="py-3 px-6">${order.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
