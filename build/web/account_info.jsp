<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Information</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-2xl">
        <h1 class="text-2xl font-bold mb-6">THÔNG TIN TÀI KHOẢN</h1>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
            <!-- Update Account Info Link -->
            <div class="flex flex-col items-center p-6 border rounded-lg">
                <a href="${pageContext.request.contextPath}/update-account-info" class="text-center">
                    <i class="fas fa-pencil-alt text-4xl text-gray-500 mb-4"></i>
                    <span class="text-gray-700">Sửa thông tin tài khoản</span>
                </a>
            </div>

            <!-- Change Password Link -->
            <div class="flex flex-col items-center p-6 border rounded-lg">
                <a href="${pageContext.request.contextPath}/update-account-password" class="text-center">
                    <i class="fas fa-lock text-4xl text-gray-500 mb-4"></i>
                    <span class="text-gray-700">Thay đổi mật khẩu</span>
                </a>
            </div>

            <!-- Change Address Link -->
            <div class="flex flex-col items-center p-6 border rounded-lg">
                <a href="${pageContext.request.contextPath}/update-account-address" class="text-center">
                    <i class="fas fa-id-card text-4xl text-gray-500 mb-4"></i>
                    <span class="text-gray-700">Thay đổi số địa chỉ</span>
                </a>
            </div>
        </div>
        <h2 class="text-xl font-bold mb-6">ĐƠN HÀNG CỦA TÔI</h2>
        <div class="flex flex-col items-center p-6 border rounded-lg">
            <a href="${pageContext.request.contextPath}/transaction-history" class="text-center">
                <i class="fas fa-list-alt text-4xl text-gray-500 mb-4"></i>
                <span class="text-gray-700">Xem lịch sử đơn hàng</span>
            </a>
        </div>
    </div>
</body>
</html>
