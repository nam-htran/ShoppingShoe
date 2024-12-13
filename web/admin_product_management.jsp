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
            <li class="p-4 bg-green-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_product_management" class="block">Product Manage</a></li>
            <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/admin_user_management" class="block">User Manage</a></li>
            <li class="p-4 hover:bg-gray-200 cursor-pointer"><a href="${pageContext.request.contextPath}/Logout" class="block">Logout</a></li>
        </ul>
      </div>

      <!-- Main Content -->
      <div class="w-4/5 p-4">
        <div class="flex justify-between items-center mb-4">
          <!-- Open the Add Product Form on Click -->
          <button class="bg-green-700 text-white px-4 py-2 rounded" onclick="document.getElementById('addProductForm').style.display = 'block';">
            ADD
          </button>
          <div class="flex items-center">
            <div class="mr-4 text-right">
            <p class="text-lg font-bold">Welcome admin</p>
            </div>
          </div>
        </div>

            <!-- Add Product Form -->
            <div id="addProductForm" class="hidden p-4 bg-white shadow-md rounded-md">
                <h3 class="text-xl font-bold mb-4">Add Product</h3>
                <form action="${pageContext.request.contextPath}/admin_product_management" method="POST">
                    <input type="hidden" name="action" value="add" />

                    <label for="productName" class="block text-sm font-medium">Product Name</label>
                    <input type="text" name="productName" required class="border border-gray-300 rounded p-2 w-full mb-4" />

                    <label for="price" class="block text-sm font-medium">Price</label>
                    <input type="number" step="0.01" name="price" required class="border border-gray-300 rounded p-2 w-full mb-4" />

                    <label for="quantity" class="block text-sm font-medium">Quantity</label>
                    <input type="number" name="quantity" required class="border border-gray-300 rounded p-2 w-full mb-4" />

                    <label for="color" class="block text-sm font-medium">Color</label>
                    <input type="text" name="color" class="border border-gray-300 rounded p-2 w-full mb-4" />

                    <label for="img" class="block text-sm font-medium">Image URL</label>
                    <input type="text" name="img" class="border border-gray-300 rounded p-2 w-full mb-4" />

                    <label for="categoryId" class="block text-sm font-medium">Category</label>
                    <select name="categoryId" required class="border border-gray-300 rounded p-2 w-full mb-4">
                        <!-- Dynamically generated categories from the database -->
                        <option value="1">Running Shoes</option>
                        <option value="2">Casual Sneakers</option>
                        <option value="3">Formal Shoes</option>
                        <option value="4">Boots</option>
                        <option value="5">Sandals</option>
                        <option value="6">Slippers</option>
                        <option value="7">Basketball Shoes</option>
                        <option value="8">Tennis Shoes</option>
                        <option value="9">Soccer Cleats</option>
                        <option value="10">Hiking Boots</option>
                    </select>
                    <label for="sizes" class="block text-sm font-medium">Sizes</label>
                    <input type="text" name="sizes" class="border border-gray-300 rounded p-2 w-full mb-4" placeholder="Comma-separated sizes (e.g., 7,8,9)" />

                    <label for="isAvailable" class="block text-sm font-medium">Available</label>
                    <select name="isAvailable" class="border border-gray-300 rounded p-2 w-full mb-4">
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                    

                    <button type="submit" class="bg-green-700 text-white px-4 py-2 rounded">
                        Add Product
                    </button>
                </form>
                <button class="mt-4 text-red-600" onclick="document.getElementById('addProductForm').style.display = 'none';">Cancel</button>
            </div>

            <div class="flex items-center mb-4">
                <form action="${pageContext.request.contextPath}/admin_product_management" method="GET" class="flex w-full">
                    <input class="border border-gray-300 rounded-l px-4 py-2 w-full" placeholder="Search" type="text" name="search" value="${param.search}" />
                    <button class="bg-green-700 text-white px-4 py-2 rounded-r" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
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
            <!-- Dynamically render products here -->
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
                  <!-- Delete Button -->
                <form action="admin_product_management" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" value="${product.productId}"/>
                    <button class="bg-red-600 text-white px-2 py-1 rounded "type="submit" onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
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