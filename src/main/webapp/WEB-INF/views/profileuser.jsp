<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Tin Công Ty - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
        }
        .profile-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .avatar-upload {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 1.5rem;
            border: 2px solid #007bff;
        }
        .avatar-upload img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .avatar-upload input[type="file"] {
            display: block;
            margin-top: 0.5rem;
            text-align: center;
        }
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #333;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .form-label {
            font-weight: 500;
            color: #555;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.1);
        }
        .file-upload {
            margin-top: 0.5rem;
        }
        .company-logo-upload {
            width: 100px;
            height: 100px;
            border-radius: 10%;
            overflow: hidden;
            margin: 0 auto 1rem;
            border: 2px solid #007bff;
        }
        .company-logo-upload img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .company-logo-upload input[type="file"] {
            display: block;
            margin-top: 0.5rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Nhúng header -->
    <jsp:include page="header.jsp" />
	<h1>chao mung den voi trang ca nhan cua may</h1>
</body>
</html>