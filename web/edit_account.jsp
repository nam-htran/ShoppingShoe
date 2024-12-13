<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sửa thông tin tài khoản</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container mt-5">
    <h2 class="text-center mb-4">CẬP NHẬT THÔNG TIN</h2>
    
    <!-- Update Account Form -->
    <form action="${pageContext.request.contextPath}/update-account-info" method="POST">
      <div class="mb-3">
        <label for="fullname" class="form-label">Họ và tên:</label>
        <input type="text" class="form-control" id="fullname" name="fullname" 
               value="${requestScope.fullname}" placeholder="Nhập họ và tên" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">Email:</label>
        <input type="email" class="form-control" id="email" name="email" 
               value="${requestScope.email}" placeholder="Nhập email" required>
      </div>
      <div class="mb-3">
        <label for="phone" class="form-label">Số điện thoại:</label>
        <input type="tel" class="form-control" id="phone" name="phone" 
               value="${requestScope.phone}" placeholder="Nhập số điện thoại" required>
      </div>
      <div class="mb-3">
        <label for="username" class="form-label">Tên đăng nhập:</label>
        <input type="text" class="form-control" id="username" name="username" 
               value="${requestScope.username}" placeholder="Nhập tên đăng nhập" required>
      </div>

      <!-- Submit Button -->
      <div class="d-flex justify-content-center">
        <button type="submit" class="btn btn-primary">Cập nhật thông tin</button>
      </div>
    </form>

    <!-- Back to Account Info Button -->
    <form action="${pageContext.request.contextPath}/user-info" method="GET" class="mt-3 text-center">
      <button type="submit" class="btn btn-secondary">Quay lại thông tin tài khoản</button>
    </form>

    <!-- Error and Success messages -->
    <div class="mt-3 text-center">
      <c:if test="${not empty error}">
        <div class="text-danger">${error}</div>
      </c:if>
      <c:if test="${not empty success}">
        <div class="text-success">${success}</div>
      </c:if>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
