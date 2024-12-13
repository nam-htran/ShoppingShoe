<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
  </head>
  <body class="bg-gray-100">
    <div class="flex">
      <!-- Sidebar -->
      <div class="w-1/5 bg-white h-screen shadow-md">
        <div class="p-4 flex items-center">
          <img alt="Logo" class="mr-2" height="50" src="https://assets.zenn.com/strapi_assets/large_shoe_brand_logo_73b4fa7129.png" width="50" />
          <span class="text-2xl font-bold text-black-700">ADMIN MANAGEMENT</span>
        </div>
        <ul class="mt-4">
          <li class="p-4 mt-4 mb-2 cursor-pointer bg-gradient-to-r from-blue-500 to-indigo-600 text-white font-bold text-center shadow-lg transform transition duration-30 hover:from-blue-600 hover:to-indigo-700">
                <a href="${pageContext.request.contextPath}/" class="block py-2 px-4">Go To Homepage</a>
          </li>   
          <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_order_management" class="block">Order Manage</a></li>
          <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_product_management" class="block">Product Manage</a></li>
          <li class="p-4 bg-green-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_user_management" class="block">User Manage</a></li>
          <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/Logout" class="block">Logout</a></li>
        </ul>
      </div>

      <!-- Main Content -->
      <div class="w-4/5 p-4">
        <div class="flex justify-between items-center mb-4">
          <!-- Open the Add User Form on Click -->
          <button class="bg-green-700 text-white px-4 py-2 rounded" onclick="document.getElementById('addUserForm').style.display = 'block';">
            ADD USER
          </button>
          <div class="flex items-center">
            <div class="mr-4 text-right">
              <p class="text-lg font-bold">Welcome admin</p>
            </div>
          </div>
        </div>

        <!-- Add User Form -->
        <div id="addUserForm" class="hidden p-4 bg-white shadow-md rounded-md">
          <h3 class="text-xl font-bold mb-4">Add User</h3>
          <form action="${pageContext.request.contextPath}/admin_user_management" method="POST">
            <input type="hidden" name="action" value="add" />
            <label for="fullname" class="block text-sm font-medium">Full Name</label>
            <input type="text" name="fullname" required class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="phone" class="block text-sm font-medium">Phone</label>
            <input type="text" name="phone" required class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="email" class="block text-sm font-medium">Email</label>
            <input type="email" name="email" required class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="username" class="block text-sm font-medium">Username</label>
            <input type="text" name="username" required class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="password" class="block text-sm font-medium">Password</label>
            <input type="password" name="password" required class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="address" class="block text-sm font-medium">Address</label>
            <input type="text" name="address" class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="role" class="block text-sm font-medium">Role</label>
            <select name="role" class="border border-gray-300 rounded p-2 w-full mb-4">
              <option value="admin">Admin</option>
              <option value="user">User</option>
            </select>

            <button type="submit" class="bg-green-700 text-white px-4 py-2 rounded">Add User</button>
          </form>
          <button class="mt-4 text-red-600" onclick="document.getElementById('addUserForm').style.display = 'none';">Cancel</button>
        </div>

        <div class="flex items-center mb-4">
          <input class="border border-gray-300 rounded-l px-4 py-2 w-full" placeholder="Search" type="text" />
          <button class="bg-green-700 text-white px-4 py-2 rounded-r">
            <i class="fas fa-search"></i>
          </button>
        </div>

        <!-- User Table -->
        <table class="min-w-full bg-white">
          <thead>
            <tr>
              <th class="py-2 px-4 border-b">User ID</th>
              <th class="py-2 px-4 border-b">Name</th>
              <th class="py-2 px-4 border-b">Phone</th>
              <th class="py-2 px-4 border-b">Email</th>
              <th class="py-2 px-4 border-b">Username</th>
              <th class="py-2 px-4 border-b">Password</th>
              <th class="py-2 px-4 border-b">Address</th>
              <th class="py-2 px-4 border-b">Role</th>
              <th class="py-2 px-4 border-b">Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="user" items="${users}">
              <tr>
                <td class="border p-2">${user.userId}</td>
                <td class="border p-2">${user.fullname}</td>
                <td class="border p-2">${user.phone}</td>
                <td class="border p-2">${user.email}</td>
                <td class="border p-2">${user.username}</td>
                <td class="border p-2">${user.password}</td>
                <td class="border p-2">${user.address}</td>
                <td class="border p-2">${user.role}</td>
                <td class="py-2 px-4 border-b">
                <button onclick="window.location.href='${pageContext.request.contextPath}/admin_user_management?action=edit&id=${user.userId}'" class="bg-blue-600 text-white px-2 py-1 rounded">Edit</button>
                <form action="${pageContext.request.contextPath}/admin_user_management" method="POST">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="${user.userId}">
                    <button type="submit" class="bg-red-600 text-white px-2 py-1 rounded">Delete</button>
                </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </body>
</html>
