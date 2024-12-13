<%-- 
    Document   : order_confirmation
    Created on : Dec 12, 2024, 6:36:29 PM
    Author     : An
--%>

<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Đơn Hàng</title>
    <!-- Tailwind CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-12">
        <div class="bg-white p-8 rounded-lg shadow-lg max-w-md mx-auto">
            <h1 class="text-3xl font-semibold text-green-600">Xác Nhận Đơn Hàng</h1>
            <p class="mt-4 text-gray-700">Cảm ơn bạn đã đặt hàng! Đơn hàng của bạn đã được xử lý thành công.</p>
            
            <div class="mt-6 text-center">
                <a href="${pageContext.request.contextPath}/shopping" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Quay lại cửa hàng</a>
            </div>
        </div>
    </div>
</body>
</html>
