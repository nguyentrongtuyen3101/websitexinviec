<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - JobVN</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- CSS tùy chỉnh -->
    <style>
        body {
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .login-container {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.1);
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            border: none;
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .form-label {
            font-weight: 500;
            color: #555;
        }
        .error-message {
            color: red;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }
        .login-link {
            text-align: center;
            margin-top: 1rem;
        }
        .login-link a {
            color: #007bff;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
        .alert-error {
            margin-bottom: 1rem;
            text-align: center;
        }
        .forgot-password {
            text-align: right;
            margin-bottom: 1rem;
        }
        .forgot-password a {
            color: #007bff;
            font-size: 0.875rem;
        }
        .forgot-password a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Đăng nhập</h2>
        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-error">${error}</div>
        </c:if>

        <form id="loginForm" action="${pageContext.request.contextPath}/account/dangnhap" method="POST">
            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${user.email}" placeholder="Nhập email của bạn" required>
                <div id="emailError" class="error-message">Email không hợp lệ</div>
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                <div id="passwordError" class="error-message">Mật khẩu không được để trống</div>
            </div>

            <!-- Nút quên mật khẩu -->
            <div class="forgot-password">
                <a href="${pageContext.request.contextPath}/account/show_form_quenmk">Quên mật khẩu?</a>
            </div>

            <!-- Nút đăng nhập -->
            <button type="submit" class="btn btn-primary mb-2">Đăng nhập</button>
        </form>

        <!-- Liên kết đăng ký -->
        <div class="login-link">
            <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/account/show_form_dangky">Đăng ký</a></p>
        </div>
    </div>

    <!-- Bootstrap JS và JavaScript tùy chỉnh để validate form -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('loginForm').addEventListener('submit', function(event) {
            let isValid = true;

            // Validate email
            const email = document.getElementById('email').value;
            const emailError = document.getElementById('emailError');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                emailError.style.display = 'block';
                isValid = false;
            } else {
                emailError.style.display = 'none';
            }

            // Validate mật khẩu
            const password = document.getElementById('password').value;
            const passwordError = document.getElementById('passwordError');
            if (password.trim() === '') {
                passwordError.style.display = 'block';
                isValid = false;
            } else {
                passwordError.style.display = 'none';
            }

            if (!isValid) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>