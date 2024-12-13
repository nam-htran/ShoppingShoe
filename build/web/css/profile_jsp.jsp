<%-- 
    Document   : profile_jsp
    Created on : Dec 9, 2024, 4:32:33 AM
    Author     : An
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-lg rounded-lg">
        <h1 class="text-2xl font-semibold mb-6">Profile Information</h1>

        <!-- Display Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="bg-green-500 text-white p-4 rounded-md mb-4">
                <p>${successMessage}</p>
            </div>
        </c:if>

        <!-- Profile Information (Example) -->
        <div>
            <p><strong>Full Name:</strong> ${user.fullname}</p>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Phone:</strong> ${user.phone}</p>
            <p><strong>Username:</strong> ${user.username}</p>
        </div>

        <!-- Edit Profile Button (Example) -->
        <div class="mt-4 text-center">
            <a href="edit_account.jsp" class="text-blue-600 hover:text-blue-800">Edit Profile</a>
        </div>
    </div>
</body>
</html>
