<%@page import="dto.OrderDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <title>Admin Dashboard</title>
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
        <div class="ml-auto text-right">
          <p class="text-lg font-bold">Welcome admin</p>
        </div>
        </div>
        <table class="table-auto w-full border-collapse">
            <thead class="bg-gray-200">
                <tr>
                    <th class="px-4 py-2 border border-gray-300">Order ID</th>
                    <th class="px-4 py-2 border border-gray-300">User ID</th>
                    <th class="px-4 py-2 border border-gray-300">Order Date</th>
                    <th class="px-4 py-2 border border-gray-300">Total Price</th>
                    <th class="px-4 py-2 border border-gray-300">Address</th>
                    <th class="px-4 py-2 border border-gray-300">Status</th>
                    <th class="px-4 py-2 border border-gray-300">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<OrderDTO> orderList = (List<OrderDTO>) request.getAttribute("orderList");
                    if (orderList != null && !orderList.isEmpty()) {
                        for (OrderDTO order : orderList) {
                %>
                <tr class="odd:bg-white even:bg-gray-50">
                    <td class="border border-gray-300 px-4 py-2"><%= order.getOrderId() %></td>
                    <td class="border border-gray-300 px-4 py-2"><%= order.getUserId() %></td>
                    <td class="border border-gray-300 px-4 py-2"><%= order.getOrderDate() %></td>
                    <td class="border border-gray-300 px-4 py-2">$<%= order.getTotalPrice() %></td>
                    <td class="border border-gray-300 px-4 py-2"><%= order.getAddress() %></td>
                    <td class="border border-gray-300 px-4 py-2">
                        <form action="admin_order_management" method="get">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <select name="status" class="border rounded px-2 py-1">
                                <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Pending</option>
                                <option value="Shipped" <%= "Shipped".equals(order.getStatus()) ? "selected" : "" %>>Shipped</option>
                                <option value="Delivered" <%= "Delivered".equals(order.getStatus()) ? "selected" : "" %>>Delivered</option>
                                <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Cancelled</option>
                            </select>
                            <button type="submit"
                                    class="bg-green-500 text-white rounded px-3 py-1 mt-1 hover:bg-green-600 transition duration-200"
                                    name="action" value="updateStatus">Update Status</button>
                        </form>
                    </td>
                    <td class="border border-gray-300 px-4 py-2">
                        <form action="admin_order_management" method="get" onsubmit="return confirm('Are you sure you want to delete this order?');">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <button type="submit"
                                    class="bg-red-500 text-white rounded px-3 py-1 hover:bg-red-600 transition duration-200"
                                    name="action" value="deleteOrder">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td class="text-center py-4" colspan="7">No orders found in the system.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table> 
    </div>
  </div>
</div>

</body>
</html>