
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Bài Đăng - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #C9E4D6;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #006241;
            overflow-x: hidden;
        }
        .profile-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.1);
            border: 1px solid #00676B;
            animation: slideUp 0.5s ease-out;
        }
        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: #006241;
            border-bottom: 2px solid #00676B;
            padding-bottom: 0.5rem;
            animation: fadeInDown 0.5s ease-in-out;
        }
        .apply-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            background-color: #f5f7f5;
            border-radius: 8px;
            border: 1px solid #00676B;
        }
        .apply-table th, .apply-table td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #00676B;
            vertical-align: middle;
        }
        .apply-table th {
            background-color: #C9E4D6;
            font-weight: 600;
            color: #006241;
        }
        .apply-table td {
            white-space: nowrap;
            color: #00676B;
        }
        .apply-table tr:hover {
            background-color: #C9E4D6;
        }
        .avatar-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid #00676B;
        }
        .file-preview img {
            max-width: 40px;
            max-height: 40px;
            margin-right: 0.5rem;
            vertical-align: middle;
            border-radius: 5px;
            border: 1px solid #00676B;
            transition: transform 0.2s ease;
        }
        .file-preview img:hover {
            transform: scale(1.1);
        }
        .file-link {
            color: #006241;
            text-decoration: none;
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: inline-block;
            vertical-align: middle;
        }
        .file-link:hover {
            color: #00676B;
            text-decoration: underline;
        }
        .company-logo {
            width: 120px;
            height: 120px;
            border-radius: 10%;
            overflow: hidden;
            margin-bottom: 1rem;
            border: 1px solid #00676B;
        }
        .company-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .job-info {
            background-color: #f5f7f5;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            border: 1px solid #00676B;
        }
        .job-info p {
            margin-bottom: 0.75rem;
            font-size: 1rem;
            color: #00676B;
        }
        .job-info p strong {
            color: #006241;
            display: inline-block;
        }
        .badge.bg-success {
            background-color: #006241 !important;
            color: #ffffff;
        }
        .badge.bg-danger {
            background-color: #b91c1c !important;
            color: #ffffff;
        }
        .file-status {
            text-align: center;
            color: #00676B;
            font-size: 0.95rem;
            padding: 1.5rem;
            font-weight: 500;
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
                font-size: 1.3rem;
            }
            .apply-table th, .apply-table td {
                font-size: 0.8rem;
                padding: 0.5rem;
            }
            .avatar-img {
                width: 40px;
                height: 40px;
            }
            .file-preview img {
                max-width: 30px;
                max-height: 30px;
            }
            .company-logo {
                width: 100px;
                height: 100px;
            }
            .job-info {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <!-- Phần nội dung chính -->
    <div class="profile-container">
        <!-- Mục 1: Danh sách ApplyPost -->
        <div class="section-title">Danh Sách Đơn Ứng Tuyển</div>
        <c:choose>
            <c:when test="${not empty listaApplyPosts}">
                <table class="apply-table">
                    <thead>
                        <tr>
                            <th>Ảnh Đại Diện</th>
                            <th>Tên Người Dùng</th>
                            <th>Email</th>
                            <th>File CV</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="applyPost" items="${listaApplyPosts}">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty applyPost.user.image}">                                       	
                                            <img src="${pageContext.request.contextPath}/uploads/${applyPost.user.image}" alt="Ảnh đại diện" class="avatar-img">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/images/default-avatar.jpg" alt="Ảnh đại diện" class="avatar-img">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><c:out value="${applyPost.user.fullName}" /></td>
                                <td><c:out value="${applyPost.user.email}" /></td>
                                <td>
                                    <c:set var="fileName" value="${applyPost.user.cv.fileName}"/>
                                    <c:set var="fileExt" value="${fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase()}"/>
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
                                    <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="file-status">Chưa có đơn ứng tuyển nào.</p>
            </c:otherwise>
        </c:choose>

        <!-- Mục 2: Thông tin bài đăng -->
        <div class="section-title">Thông Tin Bài Đăng</div>
        <c:if test="${not empty recruitment}">
            <div class="row">
                <div class="col-md-3">
                    <div class="company-logo">
                        <c:choose>
                            <c:when test="${not empty recruitment.company.logo}">
                                <img src="${pageContext.request.contextPath}/uploads/${recruitment.company.logo}" alt="Logo công ty">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/resources/images/default-logo.jpg" alt="Logo công ty">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="job-info">
                        <p><strong>Tiêu đề:</strong> <c:out value="${recruitment.title}" /></p>
                        <p><strong>Mô tả:</strong> <c:out value="${recruitment.description}" /></p>
                        <p><strong>Lương:</strong> <c:out value="${recruitment.salary}" /></p>
                        <p><strong>Vị trí:</strong> <c:out value="${recruitment.position}" /></p>
                        <p><strong>Số lượng:</strong> <c:out value="${recruitment.quantity}" /></p>
                        <p><strong>Địa chỉ:</strong> <c:out value="${recruitment.address}" /></p>
                        <p><strong>Loại hình:</strong> <c:out value="${recruitment.type}" /></p>
                        <p><strong>Kinh nghiệm:</strong> <c:out value="${recruitment.experience}" /></p>
                        <p><strong>Hạn nộp:</strong> <fmt:formatDate value="${recruitment.deadline}" pattern="dd-MM-yyyy" /></p>
                        <p><strong>Trạng thái:</strong>
                            <c:choose>
                                <c:when test="${recruitment.status == 0}">
                                    <span class="badge bg-success">Đang mở</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger">Đã đóng</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${empty recruitment}">
            <p class="file-status">Không tìm thấy bài đăng.</p>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
