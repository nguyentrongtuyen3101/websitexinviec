<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Công Ty Đã Theo Dõi - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
        }
        .company-list-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .company-item {
            padding: 1.5rem;
            border-bottom: 1px solid #dee2e6;
            transition: all 0.3s ease;
        }
        .company-item:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .company-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
        }
        .company-details {
            color: #555;
            margin-top: 0.5rem;
        }
        .company-logo {
            width: 80px;
            height: 80px;
            border-radius: 10%;
            overflow: hidden;
            margin-right: 1rem;
            border: 2px solid #DCDCDC;
        }
        .company-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .action-btn {
            margin-top: 1rem;
            margin-right: 0.5rem;
        }
        .pagination {
            margin-top: 1.5rem;
        }
        .no-data {
            text-align: center;
            color: #666;
            padding: 2rem;
        }
        .follow-icon {
            font-size: 1.2rem;
            cursor: pointer;
            margin-left: 0.5rem;
        }
        .followed {
            color: #28a745; /* Màu đậm khi đã theo dõi */
        }
    </style>
</head>
<body>
    <!-- Nhúng header -->
    <jsp:include page="header.jsp" />
    <h1>Danh Sách Công Ty Đã Theo Dõi</h1>

    <!-- Danh sách công ty đã theo dõi -->
    <div class="company-list-container">
        <c:if test="${not empty followCompanies}">
            <c:if test="${not empty error}">
                <p class="text-danger">${error}</p>
            </c:if>
            <c:forEach var="followCompany" items="${followCompanies}">
                <div class="company-item">
                    <div class="d-flex align-items-center">
                        <c:if test="${not empty followCompany.company.logo}">
                            <div class="company-logo">
                                <img src="${pageContext.request.contextPath}/uploads/${followCompany.company.logo}" alt="Logo công ty">
                            </div>
                        </c:if>
                        <c:if test="${empty followCompany.company.logo}">
                            <div class="company-logo">
                                <img src="${pageContext.request.contextPath}/resources/images/default-logo.jpg" alt="Logo công ty">
                            </div>
                        </c:if>
                        <div>
                            <div class="company-title">${followCompany.company.nameCompany}</div>
                            <div class="company-details">
                                <span>Email: ${followCompany.company.email}</span><br>
                                <span>Địa điểm: ${followCompany.company.address}</span><br>
                                <span>Số điện thoại: ${followCompany.company.phoneNumber}</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/dangtuyen/showformlistsavejob?companyID=${followCompany.company.id}" class="btn btn-primary action-btn">Danh sách bài đăng</a>
                            <a href="${pageContext.request.contextPath}/dangtuyen/showcompanybyid?companyID=${followCompany.company.id}" class="btn btn-info action-btn">Chi tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Phân trang -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/dangtuyen/showlistfollowcompany?page=${i}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </c:if>
        <c:if test="${empty followCompanies}">
            <div class="no-data">Bạn chưa theo dõi công ty nào.</div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>