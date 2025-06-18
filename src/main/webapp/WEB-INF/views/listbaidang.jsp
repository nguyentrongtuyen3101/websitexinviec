<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Bài Đăng - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
            overflow-x: hidden;
        }
        .profile-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            animation: slideUp 0.5s ease-out;
        }
        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: #333;
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 0.5rem;
            animation: fadeInDown 0.5s ease-in-out;
        }
        .recruitment-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
        .recruitment-table th, .recruitment-table td {
            padding: 0.5rem;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
        }
        .recruitment-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        .recruitment-table td {
            white-space: nowrap;
        }
        .action-btn {
            padding: 0.25rem 0.75rem;
            margin-right: 0.25rem;
            border-radius: 5px;
            font-size: 0.8rem;
            transition: all 0.3s ease;
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .detail-btn {
            background-color: #007bff;
            color: #ffffff;
            border: none;
        }
        .update-btn {
            background-color: #ffc107;
            color: #333;
            border: none;
        }
        .delete-btn {
            background-color: #dc3545;
            color: #ffffff;
            border: none;
        }
        .pagination {
            margin-top: 1.5rem;
            text-align: center;
        }
        .pagination a {
            margin: 0 0.25rem;
            padding: 0.5rem 1rem;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            text-decoration: none;
            color: #007bff;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .pagination a:hover {
            background-color: #007bff;
            color: #ffffff;
        }
        .pagination .active {
            background-color: #007bff;
            color: #ffffff;
            border-color: #007bff;
        }
        .pagination .disabled {
            color: #6c757d;
            pointer-events: none;
            border-color: #dee2e6;
        }
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 768px) {
            .profile-container {
                padding: 1rem;
                margin: 1rem;
            }
            .section-title {
                font-size: 1.5rem;
            }
            .recruitment-table th, .recruitment-table td {
                font-size: 0.8rem;
                padding: 0.3rem;
            }
            .action-btn {
                padding: 0.2rem 0.5rem;
                font-size: 0.7rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <!-- Phần nội dung chính -->
    <div class="profile-container">
        <div class="section-title">Danh Sách Bài Đăng</div>

        <!-- Thông tin công ty -->
        <c:if test="${not empty company}">
            <div class="mb-3">
                <h5>Tên công ty: <c:out value="${company.nameCompany}" /></h5>
            </div>
        </c:if>

        <!-- Bảng danh sách bài đăng -->
        <c:choose>
            <c:when test="${not empty recruitments}">
                <table class="recruitment-table">
                    <thead>
                        <tr>
                            <th>Tiêu đề</th>
                            <th>Loại</th>
                            <th>Tên công ty</th>
                            <th>Địa chỉ</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="recruitment" items="${recruitments}">
                            <tr>
                                <td><c:out value="${recruitment.title}" /></td>
                                <td><c:out value="${recruitment.type}" /></td>
                                <td><c:out value="${company.nameCompany}" /></td>
                                <td><c:out value="${recruitment.address}" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${recruitment.deadline lt now}">
                                            <span class="badge bg-danger">Đã đóng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success">Đang mở</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/dangtuyen/chitietbaidang?id=${recruitment.id}" class="btn action-btn detail-btn">Chi tiết</a>
                                    <a href="${pageContext.request.contextPath}/dangtuyen/showformupdate?idbaidang=${recruitment.id}" class="btn action-btn update-btn">Cập nhật</a>
                                    <form action="${pageContext.request.contextPath}/dangtuyen/deletebaidang" method="post" style="display:inline;">
                                        <input type="hidden" name="idbaidang" value="${recruitment.id}">
                                        <input type="hidden" name="user" value="${user}">
                                        <input type="hidden" name="page" value="${currentPage}">
                                        <button type="submit" class="btn action-btn delete-btn" onclick="return confirm('Bạn có chắc chắn muốn xóa bài đăng này?')">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="file-status">Chưa có bài đăng nào.</p>
            </c:otherwise>
        </c:choose>

        <!-- Phân trang -->
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <!-- Trang trước -->
                <c:choose>
                    <c:when test="${currentPage > 0}">
                        <a href="${pageContext.request.contextPath}/dangtuyen/showformlistbaidang?page=${currentPage - 1}">Trang trước</a>
                    </c:when>
                    <c:otherwise>
                        <a class="disabled">Trang trước</a>
                    </c:otherwise>
                </c:choose>

                <!-- Số trang -->
                <c:forEach var="i" begin="0" end="${totalPages - 1}">
                    <a href="${pageContext.request.contextPath}/dangtuyen/showformlistbaidang?page=${i}"
                       class="${i == currentPage ? 'active' : ''}">${i + 1}</a>
                </c:forEach>

                <!-- Trang sau -->
                <c:choose>
                    <c:when test="${currentPage < totalPages - 1}">
                        <a href="${pageContext.request.contextPath}/dangtuyen/showformlistbaidang?page=${currentPage + 1}">Trang sau</a>
                    </c:when>
                    <c:otherwise>
                        <a class="disabled">Trang sau</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>