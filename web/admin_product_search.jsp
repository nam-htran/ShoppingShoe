<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Product Search Results</title>
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
            <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_user_management" class="block">User Manage</a></li>
            <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/Logout" class="block">Logout</a></li>
        </ul>
      </div>

      <!-- Main Content -->
      <div class="w-4/5 p-4">
        <div class="flex justify-between items-center mb-4">
            <div class="ml-auto text-right">
              <p class="text-lg font-bold">Welcome admin</p>
            </div>
        </div>
        <div class="flex justify-between items-center mb-4">
          <!-- Search Bar -->
          <div class="flex items-center">
            <form action="${pageContext.request.contextPath}/admin_product_management" method="GET" class="flex w-full">
              <input class="border border-gray-300 rounded-l px-4 py-2 w-full" placeholder="Search" type="text" name="search" value="${param.search}" />
              <button class="bg-green-700 text-white px-4 py-2 rounded-r" type="submit">
                <i class="fas fa-search"></i>
              </button>
            </form>
          </div>
        </div>

        <!-- Product Table -->
        <table class="min-w-full bg-white">
          <thead>
            <tr>
              <th class="py-2 px-4 border-b">Product ID</th>
              <th class="py-2 px-4 border-b">Product Name</th>
              <th class="py-2 px-4 border-b">Price</th>
              <th class="py-2 px-4 border-b">Color</th>
              <th class="py-2 px-4 border-b">Quantity</th>
              <th class="py-2 px-4 border-b">Category ID</th>
              <th class="py-2 px-4 border-b">Size</th>
              <th class="py-2 px-4 border-b">Available</th>
              <th class="py-2 px-4 border-b">Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="product" items="${products}">
              <tr>
                <td class="py-2 px-4 border-b">${product.productId}</td>
                <td class="py-2 px-4 border-b">${product.productName}</td>
                <td class="py-2 px-4 border-b">${product.price}</td>
                <td class="py-2 px-4 border-b">${product.color}</td>
                <td class="py-2 px-4 border-b">${product.quantity}</td>
                <td class="py-2 px-4 border-b">${product.categoryId}</td>
                <td class="py-2 px-4 border-b">${product.sizes}</td>
                <td class="py-2 px-4 border-b">${product.isAvailable ? 'Yes' : 'No'}</td>
                <td class="py-2 px-4 border-b">
                  <button onclick="window.location.href='${pageContext.request.contextPath}/admin_edit_product?productId=${product.productId}'"
                          class="bg-blue-600 text-white px-2 py-1 rounded">
                      Edit
                  </button>
                  <form action="admin_product_management" method="post" style="display:inline;">
                      <input type="hidden" name="action" value="delete"/>
                      <input type="hidden" name="id" value="${product.productId}"/>
                      <button class="bg-red-600 text-white px-2 py-1 rounded" type="submit" onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
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
