<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đăng Nhập</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container mt-5">
    <h2 class="text-center mb-4">KHÁCH HÀNG THÂN THIẾT ĐĂNG NHẬP</h2>
    <!-- Login form -->
    <form action="${pageContext.request.contextPath}/Login" method="POST">
      <div class="mb-3">
        <label for="phone" class="form-label">Số điện thoại:</label>
        <input type="number" class="form-control" id="phone" name="phone" placeholder="Số điện thoại" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Mật khẩu:</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
      </div>
      <div class="d-flex justify-content-between">
          <input type="submit" value="Login" name="action" />
        <a href="register.jsp" class="btn btn-link">Đăng ký</a>
      </div>
      <div class="mt-3">
        <span class="text-danger">
          <!-- Display error messages here if any -->
          <c:if test="${not empty error}">
            ${error}
          </c:if>
        </span>
      </div>
    </form>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
