<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thay đổi mật khẩu</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100">
  <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-lg rounded-lg">
    <h2 class="text-center text-2xl font-semibold mb-6">Change Your Password</h2>

    <!-- Password Change Form -->
    <form action="${pageContext.request.contextPath}/update-account-password" method="post">
      <!-- Input for Old Password -->
      <div class="mb-4">
        <label for="oldPassword" class="block text-sm font-medium text-gray-700">Old Password</label>
        <input type="password" id="oldPassword" name="oldPassword"
               class="w-full px-4 py-2 mt-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600"
               placeholder="Enter old password" required>
      </div>

      <!-- Input for New Password -->
      <div class="mb-4">
        <label for="newPassword" class="block text-sm font-medium text-gray-700">New Password</label>
        <input type="password" id="newPassword" name="newPassword"
               class="w-full px-4 py-2 mt-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600"
               placeholder="Enter new password" required>
      </div>

      <!-- Input for Confirm New Password -->
      <div class="mb-4">
        <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm New Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword"
               class="w-full px-4 py-2 mt-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600"
               placeholder="Confirm new password" required>
      </div>

      <!-- Submit Button -->
      <div class="flex justify-between items-center">
        <button type="submit"
                class="w-full py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none">Change Password</button>
      </div>
    </form>

    <div class="mt-4 text-center">
      <a href="${pageContext.request.contextPath}/Logout" class="text-blue-600 hover:text-blue-800">Logout</a>
    </div>
    <div class="mt-4 text-center">
        <a href="${pageContext.request.contextPath}/user-info" 
           class="w-full py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 focus:outline-none block text-center">Quay lại thông tin tài khoản</a>
    </div>
    

    <!-- Display error message if any -->
    <div class="mt-4 text-center text-red-600">
      <c:if test="${not empty error}">
        <p>${error}</p>
      </c:if>
    </div>

    <!-- Display success message if any -->
    <div class="mt-4 text-center text-green-600">
      <c:if test="${not empty success}">
        <p>${success}</p>
      </c:if>
    </div>
  </div>
</body>

</html>
