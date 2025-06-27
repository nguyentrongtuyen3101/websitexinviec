<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Tin Công Ty - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            margin-bottom: 1.25rem;
            color: #006241;
            border-bottom: 2px solid #00676B;
            padding-bottom: 0.5rem;
        }
        .profile-header {
            background-color: #006241;
            padding: 2rem 0;
            text-align: center;
            border-bottom: 1px solid #00676B;
            animation: fadeIn 0.5s ease-in-out;
        }
        .avatar-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin: 0 auto;
            position: relative;
            transition: transform 0.3s ease;
        }
        .avatar-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .upload-btn {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            opacity: 0;
            transition: opacity 0.3s ease, background-color 0.3s ease;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            border-radius: 5px;
            background-color: #F1AF00;
            color: #006241;
            border: none;
        }
        .avatar-preview:hover .upload-btn {
            opacity: 1;
        }
        .upload-btn:hover {
            background-color: #d89b00;
        }
        .company-logo-upload {
            width: 120px;
            height: 120px;
            border-radius: 10%;
            overflow: hidden;
            margin: 0 auto 1rem;
            border: 1px solid #00676B;
            position: relative;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        .company-logo-upload img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .company-logo-upload:hover .upload-btn {
            opacity: 1;
        }
        .company-logo-upload:hover {
            transform: scale(1.05);
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            font-weight: 600;
            color: #006241;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border: 1px solid #00676B;
            border-radius: 6px;
            background-color: #f5f7f5;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-control:focus {
            border-color: #006241;
            box-shadow: 0 0 0 0.25rem rgba(0, 98, 65, 0.25);
        }
        .file-upload {
            margin-top: 0.75rem;
        }
        .file-status {
            color: #00676B;
            font-size: 1rem;
            margin-top: 0.75rem;
            animation: fadeIn 0.5s ease-in-out;
        }
        .file-preview img {
            max-width: 40px;
            max-height: 40px;
            margin-right: 0.5rem;
            vertical-align: middle;
            border-radius: 5px;
            transition: transform 0.3s ease;
        }
        .file-preview img:hover {
            transform: scale(1.1);
        }
        .file-link {
            color: #006241;
            text-decoration: none;
            transition: color 0.3s ease;
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: inline-block;
            vertical-align: middle;
        }
        .file-link:hover {
            color: #00676B;
            text-overflow: clip;
            max-width: none;
        }
        .editable {
            transition: border-color 0.3s ease, background-color 0.3s ease;
        }
        .editable-active {
            border-color: #F1AF00;
            background-color: #fff3cd;
            animation: blink 1s infinite;
        }
        .edit-btn, .save-btn {
            margin-top: 1.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            background-color: #F1AF00;
            border: none;
            color: #006241;
            font-weight: 500;
            transition: background-color 0.2s;
        }
        .edit-btn:hover, .save-btn:hover {
            background-color: #d89b00;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .error-message {
            color: #b91c1c;
            font-size: 0.9rem;
            display: none;
            animation: fadeIn 0.5s ease-in-out;
        }
        .save-btn-container {
            text-align: center;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes blink {
            50% { border-color: #ffeb3b; background-color: #fff9e6; }
        }
        @media (max-width: 768px) {
            .profile-container {
                padding: 1rem;
                margin: 1rem;
            }
            .avatar-preview {
                width: 120px;
                height: 120px;
            }
            .company-logo-upload {
                width: 100px;
                height: 100px;
            }
            .section-title {
                font-size: 1.3rem;
            }
            .form-group {
                margin-bottom: 1rem;
            }
            .edit-btn, .save-btn {
                margin-top: 1rem;
                padding: 0.5rem 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="profile-header">
        <div class="avatar-upload">
            <div class="avatar-preview position-relative">
                <c:if test="${not empty user.image}">
                    <img src="${pageContext.request.contextPath}/uploads/${user.image}" alt="Ảnh đại diện" id="avatarPreview">
                </c:if>
                <c:if test="${empty user.image}">
                    <img src="${pageContext.request.contextPath}/resources/images/default-avatar.jpg" alt="Ảnh đại diện" id="avatarPreview">
                </c:if>
                <button type="button" class="btn upload-btn" id="uploadTrigger">Upload</button>
                <form action="${pageContext.request.contextPath}/profilecompany/uploadimage" method="post" enctype="multipart/form-data" id="avatarUploadForm" style="display:none;">
                    <input type="file" id="avatarUpload" name="imageFile" accept="image/*" onchange="previewImage(event)">
                </form>
            </div>
            <button type="submit" class="btn save-btn" id="saveBtn" form="avatarUploadForm" style="display:none;">Save</button>
            <c:if test="${not empty success}">
                <p style="color:green;">${success}</p>
            </c:if>
            <c:if test="${not empty error}">
                <p style="color:red;">${error}</p>
            </c:if>
        </div>
    </div>

    <div class="profile-container">
        <div class="row">
            <div class="col-md-6">
                <div class="section-title">Thông Tin Cá Nhân</div>
                <form id="personalInfoForm" action="${pageContext.request.contextPath}/profilecompany/updateacount" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="personalEmail" class="form-label">Email</label>
                        <input type="email" class="form-control editable" id="personalEmail" name="email" value="${not empty user.email ? user.email : ''}" readonly pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Email không hợp lệ">
                        <div id="personalEmailError" class="error-message">Email không hợp lệ.</div>
                    </div>
                    <div class="form-group">
                        <label for="fullName" class="form-label">Họ và Tên</label>
                        <input type="text" class="form-control editable" id="fullName" name="fullName" value="${not empty user.fullName ? user.fullName : ''}" readonly pattern="[A-Za-zÀ-ỹ\s]+" title="Họ và tên chỉ chứa chữ cái và khoảng trắng">
                        <div id="fullNameError" class="error-message">Họ và tên không hợp lệ. Chỉ chứa chữ cái và khoảng trắng.</div>
                    </div>
                    <div class="form-group">
                        <label for="address" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control editable" id="address" name="address" value="${not empty user.address ? user.address : ''}" readonly pattern="[^<>]+" title="Địa chỉ không được chứa ký tự đặc biệt như < hoặc >">
                        <div id="addressError" class="error-message">Địa chỉ không hợp lệ. Không chứa ký tự đặc biệt như < hoặc >.</div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control editable" id="phone" name="phoneNumber" value="${not empty user.phoneNumber ? user.phoneNumber : ''}" readonly pattern="[0-9]{10,11}" title="Số điện thoại phải có 10-11 chữ số">
                        <div id="phoneError" class="error-message">Số điện thoại không hợp lệ. Phải có 10-11 chữ số.</div>
                    </div>
                    <div class="form-group">
                        <label for="personalDescriptionFile" class="form-label">Mô tả bản thân (Đính kèm tệp)</label>
                        <div class="file-status" id="personalFileStatus">
                            <c:choose>
                                <c:when test="${not empty user.description}">
                                    <c:set var="fileName" value="${user.description}"/>
                                    <c:set var="fileExt" value="${fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase()}"/>
                                    <c:choose>
                                        <c:when test="${fileExt == 'png' || fileExt == 'jpg' || fileExt == 'jpeg'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/uploads/${fileName}" alt="File preview" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:when test="${fileExt == 'pdf'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/pdf-icon.png" alt="PDF icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:when test="${fileExt == 'doc' || fileExt == 'docx'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/word-icon.png" alt="Word icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <span class="file-preview">
                                        <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon" class="file-icon">
                                    </span>
                                    Chưa có tệp đính kèm
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <input type="file" class="form-control file-upload editable d-none" id="personalDescriptionFile" name="personalDescriptionFile" accept=".pdf,.doc,.docx,image/*" onchange="updateFileStatus('personalFileStatus', this)">
                        <input type="hidden" id="existingPersonalDescription" name="description" value="${not empty user.description ? user.description : ''}">
                    </div>
                    <div class="save-btn-container">
                        <button type="button" class="btn edit-btn" onclick="toggleEditPersonalInfo()">Chỉnh sửa</button>
                        <button type="submit" class="btn save-btn d-none">Lưu</button>
                    </div>
                </form>
            </div>

            <div class="col-md-6">
                <div class="section-title">Thông Tin Công Ty</div>
                <div class="company-logo-upload position-relative mb-4">
                    <c:if test="${not empty company.logo}">
                        <img src="${pageContext.request.contextPath}/uploads/${company.logo}" alt="Logo công ty" id="companyLogoPreview">
                    </c:if>
                    <c:if test="${empty company.logo}">
                        <img src="${pageContext.request.contextPath}/resources/images/default-logo.jpg" alt="Logo công ty" id="companyLogoPreview">
                    </c:if>
                    <button type="button" class="btn upload-btn" id="companyLogoTrigger">Upload</button>
                    <form action="${pageContext.request.contextPath}/profilecompany/uploadlogo" method="post" enctype="multipart/form-data" id="companyLogoUploadForm" style="display:none;">
                        <input type="file" id="companyLogoUpload" name="logoFile" accept="image/*" onchange="previewCompanyLogo(event)">
                    </form>
                </div>
                <button type="submit" class="btn save-btn" id="companyLogoSaveBtn" form="companyLogoUploadForm" style="display:none;">Save</button>
                <c:if test="${not empty successlogo}">
                    <p style="color:green;">${success}</p>
                </c:if>
                <c:if test="${not empty errorlogo}">
                    <p style="color:red;">${error}</p>
                </c:if>

                <form id="companyInfoForm" action="${pageContext.request.contextPath}/profilecompany/updatecompany" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="companyEmail" class="form-label">Email</label>
                        <input type="email" class="form-control editable" id="companyEmail" name="email" value="${not empty company.email ? company.email : ''}" readonly pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Email không hợp lệ">
                        <div id="companyEmailError" class="error-message">Email không hợp lệ.</div>
                    </div>
                    <div class="form-group">
                        <label for="companyName" class="form-label">Tên công ty</label>
                        <input type="text" class="form-control editable" id="companyName" name="nameCompany" value="${not empty company.nameCompany ? company.nameCompany : ''}" readonly pattern="[A-Za-zÀ-ỹ\s]+" title="Tên công ty chỉ chứa chữ cái và khoảng trắng">
                        <div id="companyNameError" class="error-message">Tên công ty không hợp lệ. Chỉ chứa chữ cái và khoảng trắng.</div>
                    </div>
                    <div class="form-group">
                        <label for="companyAddress" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control editable" id="companyAddress" name="address" value="${not empty company.address ? company.address : ''}" readonly pattern="[^<>]+" title="Địa chỉ không được chứa ký tự đặc biệt như < hoặc >">
                        <div id="companyAddressError" class="error-message">Địa chỉ không hợp lệ. Không chứa ký tự đặc biệt như < hoặc >.</div>
                    </div>
                    <div class="form-group">
                        <label for="companyPhone" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control editable" id="companyPhone" name="phoneNumber" value="${not empty company.phoneNumber ? company.phoneNumber : ''}" readonly pattern="[0-9]{10,11}" title="Số điện thoại phải có 10-11 chữ số">
                        <div id="companyPhoneError" class="error-message">Số điện thoại không hợp lệ. Phải có 10-11 chữ số.</div>
                    </div>
                    <div class="form-group">
                        <label for="companyDescriptionFile" class="form-label">Mô tả công ty (Đính kèm tệp)</label>
                        <div class="file-status" id="companyFileStatus">
                            <c:choose>
                                <c:when test="${not empty company.companyDescription}">
                                    <c:set var="fileName" value="${company.companyDescription}"/>
                                    <c:set var="fileExt" value="${fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase()}"/>
                                    <c:choose>
                                        <c:when test="${fileExt == 'png' || fileExt == 'jpg' || fileExt == 'jpeg'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/uploads/${fileName}" alt="File preview" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:when test="${fileExt == 'pdf'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/pdf-icon.png" alt="PDF icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:when test="${fileExt == 'doc' || fileExt == 'docx'}">
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/word-icon.png" alt="Word icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="file-preview">
                                                <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon" class="file-icon">
                                            </span>
                                            <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <span class="file-preview">
                                        <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon" class="file-icon">
                                    </span>
                                    Chưa có tệp đính kèm
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <input type="file" class="form-control file-upload editable d-none" id="companyDescriptionFile" name="companyDescriptionFile" accept=".pdf,.doc,.docx,image/*" onchange="updateFileStatus('companyFileStatus', this)">
                        <input type="hidden" id="existingCompanyDescription" name="companyDescription" value="${not empty company.companyDescription ? company.companyDescription : ''}">
                    </div>
                    <div class="save-btn-container">
                        <button type="button" class="btn edit-btn" onclick="toggleEditCompanyInfo()">Chỉnh sửa</button>
                        <button type="submit" class="btn save-btn d-none">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleEditPersonalInfo() {
            console.log("Toggling edit for personalInfoForm");
            const form = document.getElementById('personalInfoForm');
            if (!form) {
                console.error("Form personalInfoForm not found!");
                return;
            }

            const inputs = form.querySelectorAll('.editable');
            const editBtn = form.querySelector('.edit-btn');
            const saveBtn = form.querySelector('.save-btn');

            console.log(`Found ${inputs.length} editable inputs`);
            console.log(`Edit button found:`, editBtn);
            console.log(`Save button found:`, saveBtn);

            if (!editBtn || !saveBtn) {
                console.error('Edit or Save button not found!');
                return;
            }

            inputs.forEach(input => {
                console.log(`Toggling readonly for input: ${input.id}`);
                if (input.type === 'file') {
                    input.classList.toggle('d-none');
                } else {
                    input.readOnly = !input.readOnly;
                    if (!input.readOnly) {
                        input.classList.add('editable-active');
                    } else {
                        input.classList.remove('editable-active');
                    }
                }
            });

            editBtn.classList.toggle('d-none');
            saveBtn.classList.toggle('d-none');
        }

        function toggleEditCompanyInfo() {
            console.log("Toggling edit for companyInfoForm");
            const form = document.getElementById('companyInfoForm');
            if (!form) {
                console.error("Form companyInfoForm not found!");
                return;
            }

            const inputs = form.querySelectorAll('.editable');
            const editBtn = form.querySelector('.edit-btn');
            const saveBtn = form.querySelector('.save-btn');

            console.log(`Found ${inputs.length} editable inputs`);
            console.log(`Edit button found:`, editBtn);
            console.log(`Save button found:`, saveBtn);

            if (!editBtn || !saveBtn) {
                console.error('Edit or Save button not found!');
                return;
            }

            inputs.forEach(input => {
                console.log(`Toggling readonly for input: ${input.id}`);
                if (input.type === 'file') {
                    input.classList.toggle('d-none');
                } else {
                    input.readOnly = !input.readOnly;
                    if (!input.readOnly) {
                        input.classList.add('editable-active');
                    } else {
                        input.classList.remove('editable-active');
                    }
                }
            });

            editBtn.classList.toggle('d-none');
            saveBtn.classList.toggle('d-none');
        }

        function validatePersonalInfo() {
            let valid = true;
            const personalEmail = document.getElementById('personalEmail').value;
            const fullName = document.getElementById('fullName').value;
            const address = document.getElementById('address').value;
            const phone = document.getElementById('phone').value;

            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(personalEmail)) {
                document.getElementById('personalEmailError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('personalEmailError').style.display = 'none';
            }

            const fullNamePattern = /^[A-Za-zÀ-ỹ\s]+$/;
            if (!fullNamePattern.test(fullName)) {
                document.getElementById('fullNameError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('fullNameError').style.display = 'none';
            }

            const addressPattern = /^[^<>]+$/;
            if (!addressPattern.test(address)) {
                document.getElementById('addressError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('addressError').style.display = 'none';
            }

            const phonePattern = /^[0-9]{10,11}$/;
            if (!phonePattern.test(phone)) {
                document.getElementById('phoneError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('phoneError').style.display = 'none';
            }

            return valid;
        }

        function validateCompanyInfo() {
            let valid = true;
            const companyEmail = document.getElementById('companyEmail').value;
            const companyName = document.getElementById('companyName').value;
            const companyAddress = document.getElementById('companyAddress').value;
            const companyPhone = document.getElementById('companyPhone').value;

            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(companyEmail)) {
                document.getElementById('companyEmailError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('companyEmailError').style.display = 'none';
            }

            const namePattern = /^[A-Za-zÀ-ỹ\s]+$/;
            if (!namePattern.test(companyName)) {
                document.getElementById('companyNameError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('companyNameError').style.display = 'none';
            }

            const addressPattern = /^[^<>]+$/;
            if (!addressPattern.test(companyAddress)) {
                document.getElementById('companyAddressError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('companyAddressError').style.display = 'none';
            }

            const phonePattern = /^[0-9]{10,11}$/;
            if (!phonePattern.test(companyPhone)) {
                document.getElementById('companyPhoneError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('companyPhoneError').style.display = 'none';
            }

            return valid;
        }

        function previewCompanyLogo(event) {
            const file = event.target.files[0];
            if (file) {
                const preview = document.getElementById('companyLogoPreview');
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                };
                reader.readAsDataURL(file);
                document.getElementById('companyLogoSaveBtn').style.display = 'block';
            }
        }

        function updateFileStatus(statusId, input) {
            const file = input.files[0];
            const statusDiv = document.getElementById(statusId);
            if (file) {
                const fileName = file.name;
                const fileExt = fileName.split('.').pop().toLowerCase();
                const fileUrl = URL.createObjectURL(file);
                let iconSrc = '';
                if (['png', 'jpg', 'jpeg'].includes(fileExt)) {
                    iconSrc = fileUrl;
                } else if (fileExt === 'pdf') {
                    iconSrc = '${pageContext.request.contextPath}/resources/images/pdf-icon.png';
                } else if (fileExt === 'doc' || fileExt === 'docx') {
                    iconSrc = '${pageContext.request.contextPath}/resources/images/word-icon.png';
                } else {
                    iconSrc = '${pageContext.request.contextPath}/resources/images/default-file-icon.png';
                }
                statusDiv.innerHTML = `<span class="file-preview"><img src="${iconSrc}" alt="File icon" class="file-icon"></span><a href="${fileUrl}" class="file-link" target="_blank">${fileName}</a>`;
            }
        }

        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const preview = document.getElementById('avatarPreview');
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                };
                reader.readAsDataURL(file);
                document.getElementById('saveBtn').style.display = 'block';
            }
        }

        document.getElementById('uploadTrigger').addEventListener('click', function() {
            document.getElementById('avatarUpload').click();
        });

        document.getElementById('companyLogoTrigger').addEventListener('click', function() {
            document.getElementById('companyLogoUpload').click();
        });

        <c:if test="${not empty success}">
            document.getElementById('saveBtn').style.display = 'none';
            document.getElementById('avatarUpload').value = '';
            document.getElementById('companyLogoSaveBtn').style.display = 'none';
            document.getElementById('companyLogoUpload').value = '';
        </c:if>

        document.getElementById('personalInfoForm').addEventListener('submit', function(event) {
            if (!validatePersonalInfo()) {
                event.preventDefault();
            }
        });

        document.getElementById('companyInfoForm').addEventListener('submit', function(event) {
            if (!validateCompanyInfo()) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>