<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Edit Product</title>
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
          <li class="p-4 bg-green-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_order_management" class="block">Order Manage</a></li>
          <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_product_management" class="block">Product Manage</a></li>
          <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_user_management" class="block">User Manage</a></li>
          <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/Logout" class="block">Logout</a></li>
        </ul>
      </div>

      <!-- Main Content -->
      <div class="w-4/5 p-4">
        <div class="flex justify-between items-center mb-4">
          <div class="text-lg font-bold">Edit Product</div>
          <div class="flex items-center">
            <div class="mr-4 text-right">
              <p class="text-sm">Welcome admin</p>
              <p class="text-lg font-bold">Yae Miko</p>
            </div>
            <img alt="Admin Avatar" class="rounded-full" height="50" src="https://storage.googleapis.com/a1aa/image/jt28cfiWmDW6PKLtqPNapRke0mz6PniJjsQfiDwCXg6KfhjPB.jpg" width="50" />
          </div>
        </div>

        <div class="p-4 bg-white shadow-md rounded-md">
          <form action="${pageContext.request.contextPath}/admin_product_management" method="POST">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="productId" value="${product.productId}" />

            <label for="productName" class="block text-sm font-medium">Product Name</label>
            <input type="text" name="productName" value="${product.productName}" required class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="price" class="block text-sm font-medium">Price</label>
            <input type="text" name="price" value="${product.price}" class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="quantity" class="block text-sm font-medium">Quantity</label>
            <input type="text" name="quantity" value="${product.quantity}" class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="color" class="block text-sm font-medium">Color</label>
            <input type="text" name="color" value="${product.color}" class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="img" class="block text-sm font-medium">Image URL</label>
            <input type="text" name="img" value="${product.img}" class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="categoryId" class="block text-sm font-medium">Category ID</label>
            <input type="text" name="categoryId" value="${product.categoryId}" class="border border-gray-300 rounded p-2 w-full mb-4" />

            <label for="isAvailable" class="block text-sm font-medium">Available</label>
            <select name="isAvailable" class="border border-gray-300 rounded p-2 w-full mb-4">
              <option value="true" ${product.isAvailable ? 'selected' : ''}>Yes</option>
              <option value="false" ${!product.isAvailable ? 'selected' : ''}>No</option>
            </select>

            <label for="sizes" class="block text-sm font-medium">Sizes (comma-separated)</label>
            <input type="text" name="sizes" value="${product.sizes}" class="border border-gray-300 rounded p-2 w-full mb-4" />

            <div class="flex justify-between">
              <button type="submit" class="bg-green-700 text-white px-4 py-2 rounded">Save Changes</button>
              <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/admin_product_management'" class="bg-red-600 text-white px-4 py-2 rounded">Cancel</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
