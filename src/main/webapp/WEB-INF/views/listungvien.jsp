
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
        body {
            background-color: #C9E4D6;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #006241;
            line-height: 1.6;
        }
        .profile-container {
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
            text-align: center;
        }
        .applicant-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #f5f7f5;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.1);
            border: 1px solid #00676B;
        }
        .applicant-table th,
        .applicant-table td {
            padding: 0.75rem;
            text-align: center;
            border-bottom: 1px solid #00676B;
        }
        .applicant-table th {
            background-color: #C9E4D6;
            color: #006241;
            font-weight: 600;
        }
        .applicant-table td {
            color: #00676B;
        }
        .applicant-table tr:nth-child(even) {
            background-color: #f5f7f5;
        }
        .applicant-table tr:hover {
            background-color: #C9E4D6;
        }
        .avatar-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid #00676B;
        }
        .file-icon {
            width: 30px;
            height: 30px;
            margin-right: 0.5rem;
            vertical-align: middle;
        }
        .cv-link, .title-link {
            color: #006241;
            text-decoration: none;
        }
        .cv-link:hover, .title-link:hover {
            color: #C82E31;
            text-decoration: underline;
        }
        .file-status {
            text-align: center;
            color: #00676B;
            font-size: 0.95rem;
            padding: 1.5rem;
            font-weight: 500;
        }
        @media (max-width: 768px) {
            .applicant-table {
                display: block;
                overflow-x: auto;
            }
            .applicant-table th,
            .applicant-table td {
                min-width: 150px;
                font-size: 0.8rem;
                padding: 0.5rem;
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
                                                <img src="${pageContext.request.contextPath}/Uploads/${fileName}" alt="File preview" class="file-icon">
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
