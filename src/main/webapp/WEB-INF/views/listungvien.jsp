<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Ứng Viên - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        <style>
    .profile-container {
        max-width: 1200px;
        margin: 20px auto;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .section-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #333;
        text-align: center;
    }

    .applicant-table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .applicant-table th,
    .applicant-table td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    .applicant-table th {
        background-color: #007bff;
        color: white;
        font-weight: bold;
    }

    .applicant-table tr:nth-child(even) {
        background-color: #f8f9fa;
    }

    .applicant-table tr:hover {
        background-color: #e9ecef;
    }

    .avatar-img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        object-fit: cover;
    }

    .file-icon {
        width: 30px;
        height: 30px;
        margin-right: 10px;
        vertical-align: middle;
    }

    .cv-link {
        color: #007bff;
        text-decoration: none;
        vertical-align: middle;
    }

    .cv-link:hover {
        text-decoration: underline;
    }

    .title-link {
        color: #007bff;
        text-decoration: none;
    }

    .title-link:hover {
        text-decoration: underline;
    }

    .file-status {
        text-align: center;
        color: #666;
        font-style: italic;
        margin-top: 20px;
    }

    /* Responsive design */
    @media (max-width: 768px) {
        .applicant-table {
            display: block;
            overflow-x: auto;
        }

        .applicant-table th,
        .applicant-table td {
            min-width: 150px;
        }

        .avatar-img {
            width: 40px;
            height: 40px;
        }

        .file-icon {
            width: 25px;
            height: 25px;
        }
    }
</style>
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="profile-container">
        <div class="section-title">Danh Sách Ứng Viên</div>

        <c:choose>
            <c:when test="${not empty applyPosts}">
                <table class="applicant-table">
                    <thead>
                        <tr>
                            <th>Ảnh Đại Diện</th>
                            <th>Tên</th>
                            <th>Gmail</th>
                            <th>CV</th>
                            <th>Tiêu Đề Công Việc</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="applyPost" items="${applyPosts}">
                            <tr>
                                <!-- Ảnh đại diện -->
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty applyPost.user.image}">
                                            <img src="${pageContext.request.contextPath}/uploads/${applyPost.user.image}" alt="Avatar" class="avatar-img">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/images/default-avatar.jpg" alt="Avatar" class="avatar-img">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <!-- Tên -->
                                <td><c:out value="${applyPost.user.fullName}" /></td>
                                <!-- Gmail -->
                                <td><c:out value="${applyPost.user.email}" /></td>
                                <!-- CV -->
                                <td>
                                    <c:set var="fileName" value="${applyPost.nameCv}" />
                                    <c:set var="fileExt" value="${fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase()}" />
                                    <span class="file-preview">
                                        <c:choose>
                                            <c:when test="${fileExt == 'png' || fileExt == 'jpg' || fileExt == 'jpeg'}">
                                                <img src="${pageContext.request.contextPath}/uploads/${fileName}" alt="File preview" class="file-icon">
                                            </c:when>
                                            <c:when test="${fileExt == 'pdf'}">
                                                <img src="${pageContext.request.contextPath}/resources/images/pdf-icon.png" alt="PDF icon" class="file-icon">
                                            </c:when>
                                            <c:when test="${fileExt == 'doc' || fileExt == 'docx'}">
                                                <img src="${pageContext.request.contextPath}/resources/images/word-icon.png" alt="Word icon" class="file-icon">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon" class="file-icon">
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="cv-link" target="_blank">${fileName}</a>
                                </td>
                                <!-- Tiêu đề công việc -->
                                <td>
                                    <a href="${pageContext.request.contextPath}/dangtuyen/showformchitietbaidang?recruitmentsId=${applyPost.recruitment.id}" class="title-link">
                                        <c:out value="${applyPost.recruitment.title}" />
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="file-status">Chưa có ứng viên nào.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>