<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% System.out.println("sessionScope.userEmail in header.jsp: " + session.getAttribute("userEmail")); %>
<% System.out.println("user in header.jsp: " + request.getAttribute("user")); %>
<style>
    .navbar {
        background-color: #007bff;
        padding: 1rem 2rem;
    }
    .navbar-brand img {
        height: 40px;
        width: auto;
    }
    .navbar-nav .nav-link {
        color: white !important;
        font-weight: 500;
        margin-right: 1rem;
    }
    .navbar-nav .nav-link:hover {
        color: #e0e0e0 !important;
    }
    .user-label {
        color: white;
        font-weight: 500;
        margin-left: 1rem;
        display: flex;
        align-items: center;
    }
    .dropdown {
        position: relative;
    }
    .dropdown-menu {
        background-color: #007bff;
        display: none; /* Ẩn dropdown mặc định */
        position: absolute;
        top: 100%;
        right: 0;
        z-index: 1000;
    }
    .dropdown:hover .dropdown-menu {
        display: block; /* Hiển thị dropdown khi hover */
    }
    .dropdown-item {
        color: white !important;
    }
    .dropdown-item:hover {
        background-color: #0056b3 !important;
        color: #e0e0e0 !important;
    }
    @media (max-width: 991px) {
        .navbar-nav .nav-link {
            margin-right: 0;
            padding: 0.5rem 1rem;
        }
        .user-label {
            margin-left: 0;
            padding: 0.5rem 1rem;
        }
        .dropdown-menu {
            position: static !important;
            float: none;
            width: 100%;
        }
    }
</style>

<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/resources/images/logowweb.jpg" alt="JobVN Logo">
        </a>

        <!-- Toggle button for mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu điều hướng -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home/show_home">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobs">Công việc</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/candidates">Ứng cử viên</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/post-job">Đăng tuyển</a>
                </li>
            </ul>

            <!-- Dropdown menu cho người dùng đã đăng nhập -->
            <span class="user-label">${user.fullName}</span>
            <c:if test="${not empty sessionScope.userEmail}">
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="userDropdown">
                        <span class="navbar-toggler-icon"></span> <!-- Sử dụng icon 3 gạch -->
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profilecompany/showprofile_company">Hồ sơ</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/posted-jobs">Danh sách bài đăng</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account/logout">Đăng xuất</a></li>
                    </ul>
                </div>
            </c:if>
        </div>
    </div>
</nav>