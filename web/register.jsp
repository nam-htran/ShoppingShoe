<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng Ký</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container mt-5">
    <h2 class="text-center mb-4">THÔNG TIN ĐĂNG KÝ</h2>
    <!-- Registration form -->
    <form action="${pageContext.request.contextPath}/Register" method="POST">
      <div class="mb-3">
        <label for="fullname" class="form-label">Họ và tên:</label>
        <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Nhập họ và tên" 
               value="${requestScope.fullname}" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">Email:</label>
        <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email" 
               value="${requestScope.email}" required>
      </div>
      <div class="mb-3">
        <label for="phone" class="form-label">Số điện thoại:</label>
        <input type="text" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại" 
               value="${requestScope.phone}" required>
      </div>
      <div class="mb-3">
        <label for="username" class="form-label">Tên đăng nhập:</label>
        <input type="text" class="form-control" id="username" name="username" placeholder="Nhập tên đăng nhập" 
               value="${requestScope.username}" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Mật khẩu:</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
      </div>
      <div class="mb-3">
        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu:</label>
        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
      </div>
      <div class="text-center">
        <input type="submit" value="Đăng ký" class="btn btn-primary">
        <a href="login.jsp" class="btn btn-link">Đã có tài khoản? Đăng nhập</a>
      </div>
      <div class="mt-3 text-danger text-center">
        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty error}">
          ${error}
        </c:if>
        <!-- Hiển thị thông báo thành công nếu có -->
        <c:if test="${not empty success}">
          <span class="text-success">${success}</span>
        </c:if>
      </div>
    </form>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    // Check if success message is set and then redirect after 2 seconds
    <%
      if(request.getAttribute("success") != null) {
    %>
      setTimeout(function() {
        window.location.href = "${pageContext.request.contextPath}/";
      }, 2000);
    <%
      }
    %>
  </script>
</body>
</html>
