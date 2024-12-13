<%-- 
    Document   : checkout_failure
    Created on : Dec 12, 2024, 6:37:16 PM
    Author     : An
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán Thất Bại</title>
    <!-- Tailwind CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-12">
        <div class="bg-white p-8 rounded-lg shadow-lg max-w-md mx-auto">
            <h1 class="text-3xl font-semibold text-red-600">Thanh Toán Thất Bại</h1>
            <p class="mt-4 text-gray-700">Rất tiếc, đã xảy ra sự cố trong quá trình xử lý đơn hàng của bạn.</p>
            
            <div class="mt-6">
                <p class="text-sm text-gray-600">Vui lòng thử lại sau hoặc liên hệ với đội ngũ hỗ trợ của chúng tôi để được trợ giúp.</p>
            </div>
            
            <div class="mt-6 text-center">
                <a href="${pageContext.request.contextPath}/shopping" class="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600">Quay lại giỏ hàng</a>
            </div>
        </div>
    </div>
</body>
</html>
