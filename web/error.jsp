<%-- 
    Document   : error.jsp
    Created on : Dec 10, 2024, 12:23:57 AM
    Author     : An
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h1 class="text-2xl font-semibold text-red-600 text-center mb-4">Something Went Wrong</h1>
        <p class="text-gray-700 text-center mb-6">
            <c:out value="${errorMessage}" default="An unexpected error occurred. Please try again later." />
        </p>
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/" class="text-blue-600 hover:text-blue-800 font-medium">Return to Home</a>
        </div>
    </div>
</body>
</html>
