<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - JobVN</title>
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
        .search-form {
            margin-bottom: 2rem;
        }
        .search-form .form-select, .search-form .form-control {
            margin-right: 1rem;
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
    <h1>Chào mừng đến với Trang Chủ</h1>

    <!-- Form tìm kiếm -->
    <div class="job-list-container">
        <form action="${pageContext.request.contextPath}/home/timkiemlob" method="get" class="search-form d-flex">
            <select name="chouse" class="form-select">
                <option value="1" ${chouse == 1 ? 'selected' : ''} selected>Tìm theo tiêu đề</option>
                <option value="2" ${chouse == 2 ? 'selected' : ''}>Tìm theo địa chỉ</option>
                <option value="3" ${chouse == 3 ? 'selected' : ''}>Tìm theo công ty</option>
            </select>
            <input type="text" name="textinput" class="form-control" value="${not empty textinput ? textinput : ''}" placeholder="Nhập từ khóa">
            <select name="categoryid" class="form-select">
                <option value="0" ${empty categoryid || categoryid == 0 ? 'selected' : ''}>Tất cả</option>
                <c:choose>
                    <c:when test="${empty listcCategories}">
                        <option value="1">Không có danh mục</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${listcCategories[0].id}" ${categoryid == listcCategories[0].id ? 'selected' : ''}>${listcCategories[0].name}</option>
                        <c:forEach var="cat" items="${listcCategories}" begin="1">
                            <option value="${cat.id}" ${cat.id == categoryid ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </select>
            <select name="typeselect" class="form-select">
                <option value="" ${empty typeselect ? 'selected' : ''}>Tất cả loại</option>
                <option value="Toàn thời gian" ${typeselect == 'FULL_TIME' ? 'selected' : ''}>Toàn thời gian</option>
                <option value="Bán thời gian" ${typeselect == 'PART_TIME' ? 'selected' : ''}>Bán thời gian</option>
                <option value="Thực tập" ${typeselect == 'INTERNSHIP' ? 'selected' : ''}>Thực tập</option>
            </select>
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </form>

        <!-- Hiển thị danh sách bài đăng chỉ khi có kết quả tìm kiếm -->
        <c:if test="${not empty listrecruitments}">
            <c:if test="${not empty error}">
                <p class="text-danger">${error}</p>
            </c:if>
            <c:forEach var="recruitment" items="${listrecruitments}">
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
                            <fmt:formatDate var="formattedDeadline" value="${recruitment.deadline}" pattern="dd/MM/yyyy" />
                            <fmt:formatDate var="formattedCurrentDate" value="${currentDate}" pattern="dd/MM/yyyy" />
                            
                            <c:choose>
                                <c:when test="${not empty formattedDeadline && formattedDeadline <= formattedCurrentDate}">
                                    <p class="expired-text">Hết hạn</p>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/dangtuyen/showformapplyspost?recruitmentsId=${recruitment.id}" class="btn btn-primary apply-btn">Apply</a>
                                    <c:set var="isSaved" value="${saveStatusMap[recruitment.id]}" />
                                    <i class="fas fa-bookmark save-icon ${isSaved ? 'saved' : 'not-saved'}" 
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
                                <a class="page-link" href="${pageContext.request.contextPath}/home/timkiemlob?chouse=${chouse}&textinput=${textinput}&categoryid=${categoryid}&typeselect=${typeselect}&page=${i}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </c:if>
        <c:if test="${empty listrecruitments && not empty textinput}">
            <div class="no-data">Không có bài đăng nào phù hợp.</div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>