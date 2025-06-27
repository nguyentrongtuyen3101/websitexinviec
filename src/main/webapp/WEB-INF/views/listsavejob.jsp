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
            background-color: #C9E4D6;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #006241;
            line-height: 1.6;
        }
        .job-list-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.1);
            border: 1px solid #00676B;
        }
        .job-item {
            display: flex;
            align-items: center;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            background-color: #f5f7f5;
            border: 1px solid #00676B;
            transition: all 0.2s ease;
        }
        .job-item:hover {
            background-color: #C9E4D6;
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.15);
        }
        .job-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #006241;
            margin-bottom: 0.5rem;
        }
        .job-details {
            font-size: 0.9rem;
            color: #00676B;
            line-height: 1.5;
        }
        .job-details span {
            display: block;
            margin-bottom: 0.25rem;
        }
        .company-logo {
            width: 56px;
            height: 56px;
            border-radius: 8px;
            overflow: hidden;
            margin-right: 1rem;
            border: 1px solid #00676B;
        }
        .company-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .job-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-grow: 1;
        }
        .job-actions {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .apply-btn {
            font-size: 0.9rem;
            padding: 0.4rem 1rem;
            border-radius: 6px;
            background-color: #F1AF00;
            border: none;
            color: #006241;
            font-weight: 500;
            transition: background-color 0.2s;
        }
        .apply-btn:hover {
            background-color: #d89b00;
        }
        .expired-text {
            color: #b91c1c;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .save-icon {
            font-size: 1.1rem;
            cursor: pointer;
            transition: color 0.2s;
        }
        .saved {
            color: #F1AF00;
        }
        .not-saved {
            color: #00676B;
        }
        .pagination {
            margin-top: 1.5rem;
            justify-content: center;
        }
        .page-link {
            border-radius: 6px;
            margin: 0 0.25rem;
            color: #006241;
            border: 1px solid #00676B;
        }
        .page-item.active .page-link {
            background-color: #006241;
            border-color: #00676B;
            color: #ffffff;
        }
        .no-data {
            text-align: center;
            color: #00676B;
            font-size: 0.95rem;
            padding: 1.5rem;
            font-weight: 500;
        }
        .header-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: #006241;
            text-align: center;
            margin: 2rem 0;
            letter-spacing: -0.025em;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <h1 class="header-title">${title}</h1>

    <div class="job-list-container">
        <c:if test="${not empty recruitments}">
            <c:if test="${not empty error}">
                <p class="text-danger">${error}</p>
            </c:if>
            <c:forEach var="recruitment" items="${recruitments}">
                <div class="job-item">
                    <div class="d-flex align-items-center w-100">
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
                        <div class="job-content">
                            <div>
                                <div class="job-title">${recruitment.title}</div>
                                <div class="job-details">
                                    <span><i class="fas fa-briefcase me-1"></i> ${recruitment.type}</span>
                                    <span><i class="fas fa-building me-1"></i> ${recruitment.company.nameCompany}</span>
                                    <span><i class="fas fa-map-marker-alt me-1"></i> ${recruitment.address}</span>
                                </div>
                            </div>
                            <c:set var="currentDate" value="<%= new java.util.Date() %>" />
                            <c:choose>
                                <c:when test="${recruitment.deadline != null && recruitment.deadline.time <= currentDate.time}">
                                    <div class="job-actions">
                                        <p class="expired-text">Hết hạn</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="job-actions">
                                        <a href="${pageContext.request.contextPath}/dangtuyen/showformapplyspost?recruitmentsId=${recruitment.id}" class="btn btn-primary apply-btn">Apply</a>
                                        <i class="fas fa-bookmark save-icon saved" 
                                           onclick="window.location.href='${pageContext.request.contextPath}/dangtuyen/luucongviec?recruitmentsId=${recruitment.id}&page=${currentPage}&source=listsavejob'"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
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