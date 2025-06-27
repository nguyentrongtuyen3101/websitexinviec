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
            background-color: #C9E4D6;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #006241;
            line-height: 1.6;
        }
        .category-container, .new-jobs-container, .job-list-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.1);
            border: 1px solid #00676B;
        }
        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #006241;
            margin-bottom: 1.25rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #00676B;
        }
        .category-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        .category-item {
            background-color: #C9E4D6;
            border-radius: 8px;
            padding: 1.25rem;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 1px solid #00676B;
        }
        .category-item:hover {
            background-color: #006241;
            color: #ffffff;
            transform: translateY(-4px);
            box-shadow: 0 3px 10px rgba(0, 98, 65, 0.2);
        }
        .category-item p {
            margin: 0;
            font-size: 1rem;
            font-weight: 600;
        }
        .job-item {
            display: flex;
            align-items: center;
            padding: 1rem;
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
            font-size: 1.2rem;
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
        .search-form {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
            background-color: #ffffff;
            padding: 1.25rem;
            border-radius: 10px;
            border: 1px solid #00676B;
        }
        .search-tabs {
            display: flex;
            gap: 0.5rem;
        }
        .search-tab {
            padding: 0.4rem 1rem;
            border: 1px solid #00676B;
            border-radius: 6px;
            background-color: #C9E4D6;
            color: #006241;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        .search-tab.active {
            background-color: #006241;
            color: #ffffff;
        }
        .search-tab:hover {
            background-color: #00676B;
            color: #ffffff;
        }
        .search-form .form-control, .search-form .form-select {
            font-size: 0.9rem;
            border-radius: 6px;
            border: 1px solid #00676B;
            padding: 0.4rem 0.75rem;
            background-color: #f5f7f5;
        }
        .search-form .btn-primary {
            font-size: 0.9rem;
            padding: 0.4rem 1.25rem;
            border-radius: 6px;
            background-color: #F1AF00;
            border: none;
            color: #006241;
            font-weight: 500;
        }
        .search-form .btn-primary:hover {
            background-color: #d89b00;
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
    <h1 class="header-title">Chào mừng đến với JobVN</h1>

    <!-- Top Categories -->
    <div class="category-container">
        <div class="section-title">Top Danh Mục Tuyển Dụng</div>
        <div class="category-row">
            <c:forEach var="category" items="${categories}">
                <div class="category-item">
                    <p>${category.name}</p>
                </div>
            </c:forEach>
            <c:if test="${empty categories}">
                <div class="no-data">Không có danh mục nào.</div>
            </c:if>
        </div>
    </div>

    <!-- Latest Jobs -->
    <div class="new-jobs-container">
        <div class="section-title">Công Việc Mới Nhất</div>
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
                        <fmt:formatDate var="formattedDeadline" value="${recruitment.deadline}" pattern="dd/MM/yyyy" />
                        <fmt:formatDate var="formattedCurrentDate" value="${currentDate}" pattern="dd/MM/yyyy" />
                        <c:choose>
                            <c:when test="${recruitment.deadline != null && recruitment.deadline.time <= currentDate.time}">
                                <div class="job-actions">
                                    <p class="expired-text">Hết hạn</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="job-actions">
                                    <a href="${pageContext.request.contextPath}/dangtuyen/showformapplyspost?recruitmentsId=${recruitment.id}" class="btn btn-primary apply-btn">Ứng tuyển</a>
                                    <c:set var="isSaved" value="${saveStatusMap[recruitment.id]}" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty recruitments}">
            <div class="no-data">Không có công việc mới nào.</div>
        </c:if>
    </div>

    <!-- Search Form and Results -->
    <div class="job-list-container">
        <form action="${pageContext.request.contextPath}/home/timkiemlob" method="get" class="search-form">
            <div class="search-tabs">
                <input type="hidden" name="chouse" id="chouse" value="${chouse != null ? chouse : 1}">
                <button type="button" class="search-tab ${chouse == 1 ? 'active' : ''}" onclick="setChouse(1)">Theo tiêu đề</button>
                <button type="button" class="search-tab ${chouse == 2 ? 'active' : ''}" onclick="setChouse(2)">Theo địa chỉ</button>
                <button type="button" class="search-tab ${chouse == 3 ? 'active' : ''}" onclick="setChouse(3)">Theo công ty</button>
            </div>
            <input type="text" name="textinput" class="form-control" value="${not empty textinput ? textinput : ''}" placeholder="Nhập từ khóa tìm kiếm">
            <select name="categoryid" class="form-select">
                <option value="0" ${empty categoryid || categoryid == 0 ? 'selected' : ''}>Tất cả danh mục</option>
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
                <option value="" ${empty typeselect ? 'selected' : ''}>Tất cả loại hình</option>
                <option value="Toàn thời gian" ${typeselect == 'Toàn thời gian' ? 'selected' : ''}>Toàn thời gian</option>
                <option value="Bán thời gian" ${typeselect == 'Bán thời gian' ? 'selected' : ''}>Bán thời gian</option>
                <option value="Thực tập" ${typeselect == 'Thực tập' ? 'selected' : ''}>Thực tập</option>
            </select>
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </form>

        <c:if test="${not empty listrecruitments}">
            <c:if test="${not empty error}">
                <p class="text-danger">${error}</p>
            </c:if>
            <c:forEach var="recruitment" items="${listrecruitments}">
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
                            <fmt:formatDate var="formattedDeadline" value="${recruitment.deadline}" pattern="dd/MM/yyyy" />
                            <fmt:formatDate var="formattedCurrentDate" value="${currentDate}" pattern="dd/MM/yyyy" />
                            <c:choose>
                                <c:when test="${recruitment.deadline != null && recruitment.deadline.time <= currentDate.time}">
                                    <div class="job-actions">
                                        <p class="expired-text">Hết hạn</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="job-actions">
                                        <a href="${pageContext.request.contextPath}/dangtuyen/showformapplyspost?recruitmentsId=${recruitment.id}" class="btn btn-primary apply-btn">Ứng tuyển</a>
                                        <c:set var="isSaved" value="${saveStatusMap[recruitment.id]}" />
                                        <i class="fas fa-bookmark save-icon ${isSaved ? 'saved' : 'not-saved'}" 
                                           onclick="window.location.href='${pageContext.request.contextPath}/dangtuyen/luucongviec?recruitmentsId=${recruitment.id}&page=${currentPage}&chouse=${chouse}&textinput=${textinput}&categoryid=${categoryid}&typeselect=${typeselect}&source=home'"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
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
    <script>
        function setChouse(value) {
            document.getElementById('chouse').value = value;
            document.querySelectorAll('.search-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelector(`.search-tab[onclick="setChouse(${value})"]`).classList.add('active');
        }
    </script>
</body>
</html>