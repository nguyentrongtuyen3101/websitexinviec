<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Công Việc - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
        }
        .job-list-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .job-item {
            padding: 1.5rem;
            border-bottom: 1px solid #dee2e6;
            transition: all 0.3s ease;
        }
        .job-item:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .job-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
        }
        .job-details {
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
        .apply-btn {
            margin-top: 1rem;
        }
        .expired-text {
            color: #dc3545;
            font-weight: 500;
            margin-top: 1rem;
        }
        .pagination {
            margin-top: 1.5rem;
        }
        .no-data {
            text-align: center;
            color: #666;
            padding: 2rem;
        }
        .save-icon {
            font-size: 1.2rem;
            cursor: pointer;
            margin-left: 0.5rem;
        }
        .saved {
            color: #28a745; /* Màu đậm khi đã lưu */
        }
        .not-saved {
            color: #6c757d; /* Màu nhạt khi chưa lưu */
        }
    </style>
</head>
<body>
    <!-- Nhúng header -->
    <jsp:include page="header.jsp" />
    <h1>${title}</h1>

    <!-- Danh sách công việc đã lưu -->
    <div class="job-list-container">
        <c:if test="${not empty recruitments}">
            <c:if test="${not empty error}">
                <p class="text-danger">${error}</p>
            </c:if>
            <c:forEach var="recruitment" items="${recruitments}">
                <div class="job-item">
                    <div class="d-flex align-items-center">
                        <c:if test="${not empty recruitment.company.logo}">
                            <div class="company-logo">
                                <img src="${pageContext.request.contextPath}/uploads/${recruitment.company.logo}" alt="Logo công ty">
                            </div>
                        </c:if>
                        <c:if test="${empty recruitment.company.logo}">
                            <div class="company-logo">
                                <img src="${pageContext.request.contextPath}/resources/images/default-logo.jpg" alt="Logo công ty">
                            </div>
                        </c:if>
                        <div>
                            <div class="job-title">${recruitment.title}</div>
                            <div class="job-details">
                                <span>Type: ${recruitment.type}</span><br>
                                <span>Company: ${recruitment.company.nameCompany}</span><br>
                                <span>Address: ${recruitment.address}</span>
                            </div>
                            <c:set var="currentDate" value="<%= new java.util.Date() %>" />
                            <c:choose>
                                <c:when test="${recruitment.deadline != null && recruitment.deadline.time <= currentDate.time}">
                                    <p class="expired-text">Hết hạn</p>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/dangtuyen/showformapplyspost?recruitmentsId=${recruitment.id}" class="btn btn-primary apply-btn">Apply</a>
                                    <i class="fas fa-bookmark save-icon saved" 
                                       onclick="window.location.href='${pageContext.request.contextPath}/dangtuyen/luucongviec?recruitmentsId=${recruitment.id}&page=${currentPage}'"></i>
                                </c:otherwise>
                            </c:choose>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/dangtuyen/showformlistsavejob?page=${i}${company != null ? '&companyID=' : ''}${company != null ? company.id : ''}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </c:if>
        <c:if test="${empty recruitments}">
            <div class="no-data">Bạn chưa lưu công việc nào.</div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>