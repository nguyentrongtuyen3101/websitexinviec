
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Công Ty - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #C9E4D6;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #006241;
            line-height: 1.6;
        }
        .profile-header {
            background-color: #006241;
            padding: 2rem 0;
            text-align: center;
            border-bottom: 1px solid #00676B;
            animation: fadeIn 0.5s ease-in-out;
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
            color: #006241;
            margin-bottom: 1.25rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #00676B;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            font-weight: 600;
            color: #006241;
            margin-bottom: 0.5rem;
        }
        .company-info {
            background-color: #f5f7f5;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            border: 1px solid #00676B;
        }
        .company-info p {
            margin-bottom: 0.75rem;
            font-size: 1rem;
            color: #00676B;
        }
        .company-info p strong {
            color: #006241;
        }
        .company-logo {
            width: 120px;
            height: 120px;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 1rem;
            border: 1px solid #00676B;
        }
        .company-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .save-btn-container {
            text-align: center;
        }
        .back-btn {
            padding: 0.4rem 1rem;
            border-radius: 6px;
            font-size: 0.9rem;
            background-color: #F1AF00;
            color: #006241;
            border: none;
            transition: all 0.2s ease;
        }
        .back-btn:hover {
            background-color: #d89b00;
            transform: translateY(-4px);
            box-shadow: 0 2px 6px rgba(0, 98, 65, 0.15);
        }
        .error-message {
            color: #b91c1c;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }
        .file-icon {
            width: 40px;
            height: 40px;
            margin-right: 0.5rem;
            vertical-align: middle;
        }
        .file-link {
            color: #006241;
            text-decoration: none;
        }
        .file-link:hover {
            color: #00676B;
            text-decoration: underline;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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
            .form-group {
                margin-bottom: 1rem;
            }
            .back-btn {
                padding: 0.3rem 0.75rem;
                font-size: 0.8rem;
            }
            .company-info {
                padding: 1rem;
            }
            .file-icon {
                width: 30px;
                height: 30px;
            }
        }
        .follow{
        background-color: #006241;
        margin-bottom: 20px;
        }
        .unfollow{
        background-color: #B6292B;
        margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <!-- Phần nội dung chính -->
    <div class="profile-container">
        <div class="row">
            <!-- Thông tin công ty -->
            <div class="col-12">
                <div class="section-title">Thông Tin Công Ty</div>
                <div class="company-logo">
                    <c:if test="${not empty company.logo}">
                        <img src="${pageContext.request.contextPath}/uploads/${company.logo}" alt="Logo công ty">
                    </c:if>
                    <c:if test="${empty company.logo}">
                        <img src="${pageContext.request.contextPath}/resources/images/default-logo.jpg" alt="Logo công ty">
                    </c:if>
                </div>
                <c:if test="${isfollow}">
                	<form id="formfollow" action="${pageContext.request.contextPath}/dangtuyen/deletefollow?source=chitietcompany" method="post" enctype="multipart/form-data" >
                		<input type="hidden" name="companyID" value="${company.id}">
                		<button type="submit" class="btn btn-primary apply-btn unfollow">Unfollow</button>
                	</form>
                </c:if>
                <c:if test="${!isfollow}">
                	<form id="formfollow" action="${pageContext.request.contextPath}/dangtuyen/followcompany?source=chitietcompany" method="post" enctype="multipart/form-data" >
                		<input type="hidden" name="companyID" value="${company.id}">
                		<button type="submit" class="btn btn-primary apply-btn follow">follow</button>
                	</form>
                </c:if>
                <div class="company-info">
                    <p><strong>Tên Công Ty:</strong> ${company.nameCompany}</p>
                    <p><strong>Địa Chỉ:</strong> ${company.address}</p>
                    <p><strong>Email:</strong> ${company.email}</p>
                    <p><strong>Số Điện Thoại:</strong> ${company.phoneNumber}</p>
                    <p><strong>Mô Tả:</strong> <c:choose>
                                <c:when test="${not empty company.companyDescription}">
                                    <c:set var="fileName" value="${company.companyDescription}"/>
                                    <c:set var="fileExt" value="${fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase()}"/>
                                    <c:choose>
                                        <c:when test="${fileExt == 'png' || fileExt == 'jpg' || fileExt == 'jpeg'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/Uploads/${fileName}" alt="File preview" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/Uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:when test="${fileExt == 'pdf'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/pdf-icon.png" alt="PDF icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/Uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:when test="${fileExt == 'doc' || fileExt == 'docx'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/word-icon.png" alt="Word icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/Uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/Uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <span class="file-preview">
                                        <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon" class="file-icon">
                                    </span>
                                    Chưa có tệp đính kèm
                                </c:otherwise>
                            </c:choose></p>
                </div>
                <div class="save-btn-container">
                    <a href="${pageContext.request.contextPath}/home/show_home" class="btn back-btn">Quay Về Trang Chủ</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>