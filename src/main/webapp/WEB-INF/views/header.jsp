<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% System.out.println("sessionScope.userEmail in header.jsp: " + session.getAttribute("userEmail")); %>
<% System.out.println("user in header.jsp: " + request.getAttribute("user")); %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/resources/images/logowweb.jpg" alt="JobVN Logo" height="50" class="d-inline-block align-text-top rounded-circle" style="transition: transform 0.3s ease;">
        </a>

        <!-- Toggle button for mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu điều hướng -->
        <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI eq '/home/show_home' ? 'active' : ''}" href="${pageContext.request.contextPath}/home/show_home">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI eq '/jobs' ? 'active' : ''}" href="${pageContext.request.contextPath}/jobs">Công việc</a>
                </li>
                <c:if test="${user.roleName== 'COMPANY'}">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI eq '/candidates' ? 'active' : ''}" href="${pageContext.request.contextPath}/dangtuyen/listungvien">Ứng cử viên</a>
                </li>
                </c:if>
                <c:if test="${user.roleName== 'COMPANY'}">
                    <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI eq '/post-job' ? 'active' : ''}" href="${pageContext.request.contextPath}/dangtuyen/show_page_dangtuyen">Đăng tuyển</a>
                </li>
                </c:if>
                <c:if test="${user.roleName== 'USER'}">
                    <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI eq '/post-job' ? 'active' : ''}" href="${pageContext.request.contextPath}/dangtuyen/showformlistsavejob">savejob</a>
                </li>
                 <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI eq '/post-job' ? 'active' : ''}" href="${pageContext.request.contextPath}/dangtuyen/showlistfollowcompany">followcompany</a>
                </li>
                </c:if>
            </ul>

            <!-- Phần người dùng hoặc đăng nhập/đăng ký -->
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${empty sessionScope.userEmail}">
                        <!-- Chưa đăng nhập, hiển thị nút Đăng nhập và Đăng ký -->
                        <a href="${pageContext.request.contextPath}/account/show_form_dangnhap" class="btn btn-outline-light me-3">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/account/show_form_dangky" class="btn btn-outline-light">Đăng ký</a>
                    </c:when>
                    <c:otherwise>
                        <!-- Đã đăng nhập, hiển thị tên và dropdown -->
                        <span class="navbar-text text-light me-3 fw-bold">${user.fullName}</span>
                        <div class="dropdown">
                            <button class="btn btn-outline-light dropdown-toggle" type="button" id="userDropdown">
                                <i class="bi bi-three-dots-vertical"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item ${pageContext.request.requestURI eq '/profilecompany/showprofile_company' ? 'active' : ''}" href="${pageContext.request.contextPath}/profilecompany/showprofile_company">Hồ sơ</a></li>
                                <c:if test="${user.roleName== 'COMPANY'}">
                                	<li><a class="dropdown-item ${pageContext.request.requestURI eq '/posted-jobs' ? 'active' : ''}" href="${pageContext.request.contextPath}/dangtuyen/showformlistbaidang">Danh sách bài đăng</a></li>
                                </c:if>
                                <li><a class="dropdown-item ${pageContext.request.requestURI eq '/account/logout' ? 'active' : ''}" href="${pageContext.request.contextPath}/account/logout">Đăng xuất</a></li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"></script>
<script>
    // Đảm bảo DOM đã sẵn sàng trước khi gắn sự kiện
    document.addEventListener('DOMContentLoaded', function () {
        // Xử lý toggle navbar
        const navbarToggler = document.querySelector('.navbar-toggler');
        const navbarCollapse = document.querySelector('#navbarNav');

        if (navbarToggler && navbarCollapse) {
            navbarToggler.addEventListener('click', function () {
                navbarCollapse.classList.toggle('show');
            });
        }

        // Thêm logic để cập nhật class active và màu nền khi nhấp vào mục navbar
        const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
        const dropdownItems = document.querySelectorAll('.dropdown-item');

        // Xử lý cho các mục trong navbar
        navLinks.forEach(link => {
            link.addEventListener('click', function (e) {
                navLinks.forEach(l => {
                    l.classList.remove('active');
                    l.style.backgroundColor = '';
                    l.style.color = '';
                });
                this.classList.add('active');
                this.style.backgroundColor = '#343a40';
                this.style.color = '#ffffff';
                // Ẩn navbar collapse trên mobile sau khi chọn
                if (window.innerWidth <= 991) {
                    navbarCollapse.classList.remove('show');
                }
                // Ngăn chặn chuyển hướng nếu không cần thiết
                if (this.getAttribute('href') === window.location.pathname) e.preventDefault();
            });
        });

        // Xử lý cho các mục trong dropdown
        dropdownItems.forEach(item => {
            item.addEventListener('click', function (e) {
                dropdownItems.forEach(i => {
                    i.classList.remove('active');
                    i.style.backgroundColor = '';
                    i.style.color = '';
                });
                this.classList.add('active');
                this.style.backgroundColor = '#343a40';
                this.style.color = '#ffffff';
                // Ngăn chặn chuyển hướng nếu không cần thiết
                if (this.getAttribute('href') === window.location.pathname) e.preventDefault();
            });
        });

        // Đặt active ban đầu dựa trên URL
        const currentPath = window.location.pathname;
        navLinks.forEach(link => {
            if (link.getAttribute('href') === currentPath || (currentPath.startsWith(link.getAttribute('href')) && link.getAttribute('href') !== '/')) {
                link.classList.add('active');
                link.style.backgroundColor = '#343a40';
                link.style.color = '#ffffff';
            }
        });
        dropdownItems.forEach(item => {
            if (item.getAttribute('href') === currentPath || (currentPath.startsWith(item.getAttribute('href')) && item.getAttribute('href') !== '/')) {
                item.classList.add('active');
                item.style.backgroundColor = '#343a40';
                item.style.color = '#ffffff';
            }
        });
    });

    // Hiệu ứng hover cho logo
    document.querySelector('.navbar-brand').addEventListener('mouseover', function () {
        this.querySelector('img').style.transform = 'scale(1.1)';
    });
    document.querySelector('.navbar-brand').addEventListener('mouseout', function () {
        this.querySelector('img').style.transform = 'scale(1)';
    });
</script>

<style>
    /* Tùy chỉnh CSS để cân đối và đẹp hơn */
    .navbar {
        padding: 1rem 3rem; /* Tăng padding để cân đối */
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3); /* Đổ bóng nhẹ */
    }
    .navbar-brand img {
        border: 2px solid #ffffff; /* Viền trắng cho logo */
        padding: 2px;
    }
    .navbar-nav .nav-link {
        font-size: 1.1rem; /* Tăng kích thước font */
        padding: 0.5rem 1.2rem; /* Cân đối padding */
        border-radius: 8px; /* Bo góc mềm mại */
        transition: all 0.3s ease; /* Hiệu ứng mượt mà */
    }
    .navbar-nav .nav-link:hover,
    .navbar-dark .dropdown-menu .dropdown-item:hover {
        background-color: #495057; /* Màu nền nhạt hơn khi hover */
        color: #ffffff !important;
    }
    .navbar-dark .navbar-nav .nav-link.active,
    .navbar-dark .dropdown-menu .dropdown-item.active {
        background-color: #343a40; /* Màu nền đậm hơn khi active */
        color: #ffffff !important;
        font-weight: 600; /* Đậm hơn khi active */
    }
    .navbar-text {
        font-size: 1.1rem; /* Tăng kích thước tên người dùng */
        padding: 0.25rem 1rem; /* Cân đối padding */
        border-radius: 5px;
        transition: all 0.3s ease;
    }
    .navbar-text:hover {
        background-color: #495057; /* Hiệu ứng hover cho tên */
        color: #ffffff;
    }
    .dropdown-toggle {
        padding: 0.4rem 1rem; /* Cân đối padding cho nút dropdown */
        border-radius: 5px;
    }
    .dropdown {
        position: relative;
    }
    .dropdown-menu {
        border: 1px solid #dee2e6; /* Viền nhẹ cho dropdown */
        border-radius: 8px; /* Bo góc mềm mại */
        min-width: 180px; /* Tăng chiều rộng dropdown */
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
        font-size: 1rem; /* Tăng kích thước font */
        padding: 0.6rem 1.2rem; /* Cân đối padding */
        transition: all 0.3s ease;
    }
    .btn-outline-light {
        font-size: 1rem; /* Tăng kích thước font cho nút */
        padding: 0.4rem 1.2rem; /* Cân đối padding */
        border-width: 2px; /* Viền đậm hơn */
    }
    .btn-outline-light:hover {
        background-color: #495057; /* Màu nền khi hover */
        color: #ffffff;
        border-color: #495057;
    }
    @media (max-width: 991px) {
        .navbar {
            padding: 1rem 1rem; /* Giảm padding trên mobile */
        }
        .navbar-nav {
            margin-top: 1rem; /* Khoảng cách trên mobile */
        }
        .navbar-nav .nav-link {
            padding: 0.75rem 1rem;
            text-align: center;
        }
        .navbar-text, .btn-outline-light {
            margin: 0.5rem 0;
            width: 100%;
            text-align: center;
        }
        .dropdown-menu {
            border: none; /* Loại bỏ viền trên mobile */
            border-radius: 0;
        }
        .dropdown:hover .dropdown-menu {
            display: none; /* Vô hiệu hóa hover trên mobile */
        }
        .dropdown .dropdown-menu.show {
            display: block; /* Hiển thị dropdown khi click trên mobile */
        }
    }
</style>