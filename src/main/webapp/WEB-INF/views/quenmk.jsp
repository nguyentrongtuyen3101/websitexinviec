<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .forgot-container {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }
        .forgot-container h2 {
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
        .alert-error {
            margin-bottom: 1rem;
            text-align: center;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            width: 300px;
            text-align: center;
        }
        .close {
            float: right;
            font-size: 1.5rem;
            cursor: pointer;
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
        .success-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .success-modal-content {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            width: 300px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <h2>Quên Mật Khẩu</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-success">${success}</div>
        </c:if>

        <form id="forgotForm" action="${pageContext.request.contextPath}/account/send_otp" method="POST">
            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email của bạn" required>
                <div id="emailError" class="error-message">Email không hợp lệ</div>
            </div>

            <!-- Mật khẩu mới -->
            <div class="mb-3">
                <label for="mkmoi" class="form-label">Mật khẩu mới</label>
                <input type="password" class="form-control" id="mkmoi" name="mkmoi" placeholder="Nhập mật khẩu mới" required>
                <div id="newPasswordError" class="error-message">Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ cái và số</div>
            </div>

            <!-- Xác nhận mật khẩu mới -->
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                <div id="confirmPasswordError" class="error-message">Mật khẩu nhập lại không khớp</div>
            </div>

            <!-- Nút xác nhận -->
            <button type="submit" class="btn btn-primary mb-2" id="submitBtn">Xác nhận</button>

            <!-- Liên kết quay lại đăng nhập -->
            <div class="login-link">
                <p>Quay lại <a href="${pageContext.request.contextPath}/account/show_form_dangnhap">Đăng nhập</a></p>
            </div>
        </form>
    </div>

    <!-- Modal OTP -->
    <c:if test="${not empty success || showOtpModal}">
        <div id="otpModal" class="modal" style="display: flex;">
    </c:if>
    <c:if test="${empty success && !showOtpModal}">
        <div id="otpModal" class="modal">
    </c:if>
        <div class="modal-content">
        <c:if test="${not empty errorotp}">
            <div class="alert alert-danger alert-error">${errorotp}</div>
    	 </c:if>
            <span class="close">×</span>
            <h3>Nhập mã OTP</h3>
            <p>Mã OTP đã được gửi đến email của bạn.</p>
            <form id="otpForm" action="${pageContext.request.contextPath}/account/quenmk" method="POST">
                <input type="text" class="form-control mb-3" id="otp" name="otp" placeholder="Nhập mã OTP" required>
                <div id="otpError" class="error-message">Mã OTP không hợp lệ</div>
                <button type="submit" class="btn btn-primary">Xác nhận OTP</button>
            </form>
        </div>
    </div>

    <!-- Success Modal -->
    <c:if test="${not empty success}">
        <div id="successModal" class="success-modal" style="display: flex;">
            <div class="success-modal-content">
                <h3>Thành công</h3>
                <p>${success}</p>
                <button id="confirmRedirect" class="btn btn-primary">OK</button>
            </div>
        </div>
    </c:if>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Biểu thức chính quy
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$/; // Cho phép ký tự đặc biệt

        // Xử lý form trước khi submit
        document.getElementById('forgotForm').addEventListener('submit', function(event) {
            let isValid = true;

            const email = document.getElementById('email').value;
            const emailError = document.getElementById('emailError');
            if (!emailRegex.test(email)) {
                emailError.style.display = 'block';
                isValid = false;
            } else {
                emailError.style.display = 'none';
            }

            const newPassword = document.getElementById('mkmoi').value;
            const newPasswordError = document.getElementById('newPasswordError');
            if (!passwordRegex.test(newPassword)) {
                newPasswordError.style.display = 'block';
                isValid = false;
            } else {
                newPasswordError.style.display = 'none';
            }

            const confirmPassword = document.getElementById('confirmPassword').value;
            const confirmPasswordError = document.getElementById('confirmPasswordError');
            if (newPassword !== confirmPassword) {
                confirmPasswordError.style.display = 'block';
                isValid = false;
            } else {
                confirmPasswordError.style.display = 'none';
            }

            if (!isValid) {
                event.preventDefault();
            }

            console.log("Email:", email);
            console.log("New Password:", newPassword);
            console.log("Confirm Password:", confirmPassword);
            console.log("Is Valid:", isValid);
        });

        // Đóng modal OTP
        document.querySelector('.close').addEventListener('click', function() {
            document.getElementById('otpModal').style.display = 'none';
        });

        // Ngăn đóng modal OTP khi click ngoài
        window.addEventListener('click', function(event) {
            const modal = document.getElementById('otpModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // Xử lý nút OK trong success modal
        const confirmRedirect = document.getElementById('confirmRedirect');
        if (confirmRedirect) {
            confirmRedirect.addEventListener('click', function() {
                window.location.href = "${pageContext.request.contextPath}/account/show_form_dangnhap";
            });
        }
    </script>
</body>
</html>