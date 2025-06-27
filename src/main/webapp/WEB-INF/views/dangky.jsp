
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - JobVN</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- CSS tùy chỉnh -->
    <style>
        body {
            background-color: #C9E4D6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #006241;
        }
        .register-container {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.1);
            max-width: 400px;
            width: 100%;
            border: 1px solid #00676B;
            animation: slideUp 0.5s ease-out;
        }
        .register-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: #006241;
        }
        .form-control {
            border: 1px solid #00676B;
            border-radius: 6px;
            font-size: 0.9rem;
            color: #00676B;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(0, 103, 107, 0.1);
            border-color: #00676B;
        }
        .form-select {
            border: 1px solid #00676B;
            border-radius: 6px;
            font-size: 0.9rem;
            color: #00676B;
        }
        .form-select:focus {
            box-shadow: 0 0 0 0.25rem rgba(0, 103, 107, 0.1);
            border-color: #00676B;
        }
        .btn-primary {
            background-color: #F1AF00;
            border: none;
            width: 100%;
            padding: 0.75rem;
            font-size: 0.9rem;
            color: #006241;
            transition: all 0.2s ease;
        }
        .btn-primary:hover {
            background-color: #d89b00;
            transform: translateY(-2px);
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.15);
        }
        .btn-secondary {
            background-color: #006241;
            border: none;
            width: 100%;
            padding: 0.75rem;
            font-size: 0.9rem;
            color: #ffffff;
            transition: all 0.2s ease;
        }
        .btn-secondary:hover {
            background-color: #00676B;
            transform: translateY(-2px);
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.15);
        }
        .form-label {
            font-weight: 600;
            color: #006241;
            font-size: 0.9rem;
        }
        .error-message {
            color: #b91c1c;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }
        .login-link {
            text-align: center;
            margin-top: 1rem;
        }
        .login-link a {
            color: #006241;
            text-decoration: none;
            font-size: 0.9rem;
        }
        .login-link a:hover {
            color: #00676B;
            text-decoration: underline;
        }
        .alert-error {
            margin-bottom: 1rem;
            text-align: center;
            background-color: #f5f7f5;
            border: 1px solid #b91c1c;
            color: #b91c1c;
            border-radius: 6px;
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 768px) {
            .register-container {
                padding: 1rem;
                margin: 1rem;
            }
            .register-container h2 {
                font-size: 1.3rem;
            }
            .form-control, .form-select {
                font-size: 0.8rem;
            }
            .btn-primary, .btn-secondary {
                padding: 0.5rem;
                font-size: 0.8rem;
            }
            .form-label {
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Đăng ký tài khoản</h2>
        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-error">${error}</div>
        </c:if>

        <form id="registerForm" action="${pageContext.request.contextPath}/account/dangky" method="POST">
            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${user.email}" placeholder="Nhập email của bạn" required>
                <div id="emailError" class="error-message">Email không hợp lệ</div>
            </div>

            <!-- Họ tên -->
            <div class="mb-3">
                <label for="fullName" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" placeholder="Nhập họ và tên" required>
                <div id="fullNameError" class="error-message">Họ tên không được để trống</div>
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                <div id="passwordError" class="error-message">Mật khẩu phải dài ít nhất 6 ký tự</div>
            </div>

            <!-- Nhập lại mật khẩu -->
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Nhập lại mật khẩu</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                <div id="confirmPasswordError" class="error-message">Mật khẩu không khớp</div>
            </div>

            <!-- Vai trò -->
            <div class="mb-3">
                <label for="role" class="form-label">Vai trò</label>
                <select class="form-select" id="role" name="role" required>
                    <option value="" disabled ${empty user.roleName ? 'selected' : ''}>Chọn vai trò</option>
                    <option value="USER" ${user.roleName == 'USER' ? 'selected' : ''}>User</option>
                    <option value="COMPANY" ${user.roleName == 'COMPANY' ? 'selected' : ''}>Company</option>
                </select>
                <div id="roleError" class="error-message">Vui lòng chọn vai trò</div>
            </div>

            <!-- Nút đăng ký và quay lại -->
            <button type="submit" class="btn btn-primary mb-2">Đăng ký</button>
            <a href="${pageContext.request.contextPath}/home/show_home" class="btn btn-secondary">Back to Home</a>
        </form>

        <!-- Liên kết đăng nhập -->
        <div class="login-link">
            <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/account/show_form_dangnhap">Đăng nhập</a></p>
        </div>
    </div>

    <!-- Bootstrap JS và JavaScript tùy chỉnh để validate form -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('registerForm').addEventListener('submit', function(event) {
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

            // Validate họ tên
            const fullName = document.getElementById('fullName').value;
            const fullNameError = document.getElementById('fullNameError');
            if (fullName.trim() === '') {
                fullNameError.style.display = 'block';
                isValid = false;
            } else {
                fullNameError.style.display = 'none';
            }

            // Validate mật khẩu
            const password = document.getElementById('password').value;
            const passwordError = document.getElementById('passwordError');
            if (password.length < 6) {
                passwordError.style.display = 'block';
                isValid = false;
            } else {
                passwordError.style.display = 'none';
            }

            // Validate nhập lại mật khẩu
            const confirmPassword = document.getElementById('confirmPassword').value;
            const confirmPasswordError = document.getElementById('confirmPasswordError');
            if (confirmPassword !== password) {
                confirmPasswordError.style.display = 'block';
                isValid = false;
            } else {
                confirmPasswordError.style.display = 'none';
            }

            // Validate vai trò
            const role = document.getElementById('role').value;
            const roleError = document.getElementById('roleError');
            if (role === '') {
                roleError.style.display = 'block';
                isValid = false;
            } else {
                roleError.style.display = 'none';
            }

            if (!isValid) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>
