<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Your Address</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-100">
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-lg rounded-lg">
      <h2 class="text-center text-2xl font-semibold mb-6">Update Your Address</h2>

      <!-- Address Change Form -->
      <form action="${pageContext.request.contextPath}/update-account-address" method="post">

        <div class="mb-4">
          <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
          <input 
            type="text" 
            id="address" 
            name="address" 
            class="w-full px-4 py-2 mt-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600"
            value="${fn:escapeXml(user.address != null ? user.address : '')}"
            required>
        </div>

        <div class="flex justify-between items-center">
          <!-- Update Address Button -->
          <button type="submit" class="w-full py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none">Update Address</button>
        </div>
      </form>

      <!-- Back to Homepage Button -->
      <div class="mt-4 text-center">
        <a href="${pageContext.request.contextPath}/user-info" 
           class="w-full py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 focus:outline-none block text-center">Quay lại thông tin tài khoản</a>
      </div>

      <div class="mt-4 text-center text-green-600">
        <c:if test="${not empty success}">
          <p>${success}</p>
        </c:if>
      </div>

      <div class="mt-4 text-center text-red-600">
        <c:if test="${not empty error}">
          <p>${error}</p>
        </c:if>
      </div>
    </div>
  </body>
</html>
