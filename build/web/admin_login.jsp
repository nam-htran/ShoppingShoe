<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin Login</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container mt-5">
    <h2 class="text-center mb-4">Admin Login</h2>
    <!-- Login form -->
    <form action="${pageContext.request.contextPath}/admin" method="POST">
      <div class="mb-3">
        <label for="username" class="form-label">Username:</label>
        <input type="text" class="form-control" id="username" name="username" placeholder="Enter Username" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Password:</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
      </div>
      <div class="mb-3">
        <button type="submit" class="btn btn-primary w-100">Login</button>
      </div>

      <!-- Success Message -->
      <div class="mt-4 text-center text-success">
        <c:if test="${not empty success}">
          <p>${success}</p>
        </c:if>
      </div>

      <!-- Error Message -->
      <div class="mt-4 text-center text-danger">
        <c:if test="${not empty error}">
          <p>${error}</p>
        </c:if>
      </div>
    </form>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
