<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Tin Công Ty - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
        }
        .profile-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .avatar-upload {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .avatar-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto;
            border: 2px solid #007bff;
            position: relative;
            cursor: pointer;
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
            transition: opacity 0.3s ease;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }
        .avatar-preview:hover .upload-btn {
            opacity: 1;
        }
        .upload-btn:hover {
            background-color: #0056b3;
        }
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #333;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .form-label {
            font-weight: 500;
            color: #555;
        }
        .form-control {
            border: 1px solid #ced4da;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.1);
        }
        .file-upload {
            margin-top: 0.5rem;
        }
        .company-logo-upload {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 1rem;
            border: 2px solid #007bff;
            position: relative;
            cursor: pointer;
        }
        .company-logo-upload img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .company-logo-upload:hover .upload-btn {
            opacity: 1;
        }
        .edit-btn, .save-btn {
            margin-top: 1rem;
        }
        .error-message {
            color: red;
            font-size: 0.875rem;
            display: none;
        }
        .file-status {
            color: #666;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }
        .file-preview img {
            max-width: 50px;
            max-height: 50px;
            margin-right: 0.5rem;
            vertical-align: middle;
        }
        .file-link {
            color: #007bff;
            text-decoration: none;
        }
        .file-link:hover {
            text-decoration: underline;
        }
        .editable {
            transition: border-color 0.3s ease;
        }
        .editable-active {
            border-color: #ffcc00;
            animation: blink 1s infinite;
        }
        @keyframes blink {
            50% { border-color: #ffeb3b; }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="profile-container">
        <!-- Khung tròn upload ảnh đại diện -->
        <div class="avatar-upload">
            <div class="avatar-preview position-relative">
                <c:if test="${not empty user.image}">
                    <img src="${pageContext.request.contextPath}/uploads/${user.image}" alt="Ảnh đại diện" id="avatarPreview">
                </c:if>
                <c:if test="${empty user.image}">
                    <img src="${pageContext.request.contextPath}/resources/images/default-avatar.jpg" alt="Ảnh đại diện" id="avatarPreview">
                </c:if>
                <button type="button" class="btn btn-primary upload-btn" id="uploadTrigger">Upload</button>
                <form action="${pageContext.request.contextPath}/profilecompany/uploadimage" method="post" enctype="multipart/form-data" id="avatarUploadForm" style="display:none;">
                    <input type="file" id="avatarUpload" name="imageFile" accept="image/*" onchange="previewImage(event)">
                </form>
            </div>
            <button type="submit" class="btn btn-success save-btn" id="saveBtn" form="avatarUploadForm" style="display:none;">Save</button>
            <c:if test="${not empty success}">
                <p style="color:green;">${success}</p>
            </c:if>
            <c:if test="${not empty error}">
                <p style="color:red;">${error}</p>
            </c:if>
        </div>

        <!-- Phần 1: Thông tin cá nhân -->
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
                                        <img src="${pageContext.request.contextPath}/uploads/${fileName}" alt="File preview">
                                    </span>
                                    <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="file-preview">
                                        <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon">
                                    </span>
                                    <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <span class="file-preview">
                                <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon">
                            </span>
                            Chưa có tệp đính kèm
                        </c:otherwise>
                    </c:choose>
                </div>
                <input type="file" class="form-control file-upload editable d-none" id="personalDescriptionFile" name="personalDescriptionFile" accept=".pdf,.doc,.docx,image/*" onchange="updateFileStatus('personalFileStatus', this)">
                <input type="hidden" id="existingPersonalDescription" name="existingDescription" value="${not empty user.description ? user.description : ''}">
            </div>
            <button type="button" class="btn btn-secondary edit-btn" onclick="toggleEditPersonalInfo()">Chỉnh sửa</button>
            <button type="submit" class="btn btn-primary save-btn d-none">Lưu</button>
        </form>

        <!-- Phần 2: Thông tin công ty -->
        <div class="section-title">Thông Tin Công Ty</div>
        <!-- Form upload logo (riêng biệt) -->
        <div class="company-logo-upload position-relative">
            <c:if test="${not empty company.logo}">
                <img src="${pageContext.request.contextPath}/uploads/${company.logo}" alt="Logo công ty" id="companyLogoPreview">
            </c:if>
            <c:if test="${empty company.logo}">
                <img src="${pageContext.request.contextPath}/resources/images/default-logo.jpg" alt="Logo công ty" id="companyLogoPreview">
            </c:if>
            <button type="button" class="btn btn-primary upload-btn" id="companyLogoTrigger">Upload</button>
            <form action="${pageContext.request.contextPath}/profilecompany/uploadlogo" method="post" enctype="multipart/form-data" id="companyLogoUploadForm" style="display:none;">
                <input type="file" id="companyLogoUpload" name="logoFile" accept="image/*" onchange="previewCompanyLogo(event)">
            </form>
        </div>
        <button type="submit" class="btn btn-success save-btn" id="companyLogoSaveBtn" form="companyLogoUploadForm" style="display:none;">Save</button>
        <c:if test="${not empty success}">
            <p style="color:green;">${success}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p style="color:red;">${error}</p>
        </c:if>

        <!-- Form cập nhật thông tin công ty -->
        <form id="companyInfoForm" action="${pageContext.request.contextPath}/profilecompany/updatecompany" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="companyEmail" class="form-label">Email</label>
                <input type="email" class="form-control editable" id="companyEmail" name="email" value="${not empty company.email ? company.email : ''}" readonly pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Email không hợp lệ">
                <div id="companyEmailError" class="error-message">Email không hợp lệ.</div>
            </div>
            <div class="form-group">
                <label for="companyName" class="form-label">Tên công ty</label>
                <input type="text" class="form-control editable" id="companyName" name="name" value="${not empty company.nameCompany ? company.nameCompany : ''}" readonly pattern="[A-Za-zÀ-ỹ\s]+" title="Tên công ty chỉ chứa chữ cái và khoảng trắng">
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
                                        <img src="${pageContext.request.contextPath}/uploads/${fileName}" alt="File preview">
                                    </span>
                                    <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="file-preview">
                                        <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon">
                                    </span>
                                    <a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <span class="file-preview">
                                <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon">
                            </span>
                            Chưa có tệp đính kèm
                        </c:otherwise>
                    </c:choose>
                </div>
                <input type="file" class="form-control file-upload editable d-none" id="companyDescriptionFile" name="companyDescriptionFile" accept=".pdf,.doc,.docx,image/*" onchange="updateFileStatus('companyFileStatus', this)">
                <input type="hidden" id="existingCompanyDescription" name="existingDescription" value="${not empty company.companyDescription ? company.companyDescription : ''}">
            </div>
            <button type="button" class="btn btn-secondary edit-btn" onclick="toggleEditCompanyInfo()">Chỉnh sửa</button>
            <button type="submit" class="btn btn-primary save-btn d-none">Lưu</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hàm riêng cho Thông Tin Cá Nhân
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

            // Cập nhật file status khi chỉnh sửa
            if (!editBtn.classList.contains('d-none')) {
                const existingFile = document.getElementById('existingPersonalDescription').value;
                const statusDiv = document.getElementById('personalFileStatus');
                if (existingFile) {
                    const fileName = existingFile;
                    const fileExt = fileName.split('.').pop().toLowerCase();
                    let content = '';
                    if (['png', 'jpg', 'jpeg'].includes(fileExt)) {
                        content = `<span class="file-preview"><img src="${pageContext.request.contextPath}/uploads/${fileName}" alt="File preview"></span>`;
                    } else {
                        content = `<span class="file-preview"><img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon"></span>`;
                    }
                    content += `<a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>`;
                    statusDiv.innerHTML = content;
                }
            }

            editBtn.classList.toggle('d-none');
            saveBtn.classList.toggle('d-none');
        }

        // Hàm riêng cho Thông Tin Công Ty
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

            // Cập nhật file status khi chỉnh sửa
            if (!editBtn.classList.contains('d-none')) {
                const existingFile = document.getElementById('existingCompanyDescription').value;
                const statusDiv = document.getElementById('companyFileStatus');
                if (existingFile) {
                    const fileName = existingFile;
                    const fileExt = fileName.split('.').pop().toLowerCase();
                    let content = '';
                    if (['png', 'jpg', 'jpeg'].includes(fileExt)) {
                        content = `<span class="file-preview"><img src="${pageContext.request.contextPath}/uploads/${fileName}" alt="File preview"></span>`;
                    } else {
                        content = `<span class="file-preview"><img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon"></span>`;
                    }
                    content += `<a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>`;
                    statusDiv.innerHTML = content;
                }
            }

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
                let content = '';
                if (['png', 'jpg', 'jpeg'].includes(fileExt)) {
                    content = `<span class="file-preview"><img src="${fileUrl}" alt="File preview"></span>`;
                } else {
                    content = `<span class="file-preview"><img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon"></span>`;
                }
                content += `<a href="${fileUrl}" class="file-link" target="_blank">${fileName}</a>`;
                statusDiv.innerHTML = content;
            } else {
                const existingFile = document.getElementById(statusId === 'personalFileStatus' ? 'existingPersonalDescription' : 'existingCompanyDescription').value;
                if (existingFile) {
                    const fileName = existingFile;
                    const fileExt = fileName.split('.').pop().toLowerCase();
                    let content = '';
                    if (['png', 'jpg', 'jpeg'].includes(fileExt)) {
                        content = `<span class="file-preview"><img src="${pageContext.request.contextPath}/uploads/${fileName}" alt="File preview"></span>`;
                    } else {
                        content = `<span class="file-preview"><img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon"></span>`;
                    }
                    content += `<a href="${pageContext.request.contextPath}/uploads/${fileName}" class="file-link" target="_blank">${fileName}</a>`;
                    statusDiv.innerHTML = content;
                } else {
                    statusDiv.innerHTML = '<span class="file-preview"><img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon"></span> Chưa có tệp đính kèm';
                }
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

        // Validate submit cho personalInfoForm
        document.getElementById('personalInfoForm').addEventListener('submit', function(event) {
            if (!validatePersonalInfo()) {
                event.preventDefault();
            }
        });

        // Validate submit cho companyInfoForm
        document.getElementById('companyInfoForm').addEventListener('submit', function(event) {
            if (!validateCompanyInfo()) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>