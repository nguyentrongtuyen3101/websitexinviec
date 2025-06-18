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
            overflow-x: hidden;
        }
        .profile-header {
            background-color: #343a40;
            padding: 2rem 0;
            text-align: center;
            border-bottom: 1px solid #495057;
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
        }
        .avatar-preview:hover .upload-btn {
            opacity: 1;
        }
        .upload-btn:hover {
            background-color: #0056b3;
            color: #ffffff;
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
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            font-weight: 600;
            color: #444;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border: 2px solid #ced4da;
            border-radius: 8px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
        }
        .file-upload {
            margin-top: 0.75rem;
        }
        .file-status {
            color: #666;
            font-size: 1rem;
            margin-top: 0.75rem;
            animation: fadeIn 0.5s ease-in-out;
        }
        .file-preview img {
            max-width: 60px;
            max-height: 60px;
            margin-right: 0.75rem;
            vertical-align: middle;
            border-radius: 5px;
            transition: transform 0.3s ease;
        }
        .file-preview img:hover {
            transform: scale(1.1);
        }
        .file-link {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .file-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        .editable {
            transition: border-color 0.3s ease, background-color 0.3s ease;
        }
        .editable-active {
            border-color: #ffcc00;
            background-color: #fff3cd;
            animation: blink 1s infinite;
        }
        .edit-btn, .save-btn {
            margin-top: 1.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .edit-btn:hover, .save-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .error-message {
            color: #dc3545;
            font-size: 0.9rem;
            display: none;
            animation: fadeIn 0.5s ease-in-out;
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
            .section-title {
                font-size: 1.5rem;
            }
            .form-group {
                margin-bottom: 1rem;
            }
            .edit-btn, .save-btn {
                margin-top: 1rem;
                padding: 0.5rem 1rem;
            }
        }
        /* Căn giữa nút Save */
        .save-btn-container {
            text-align: center;
        }
        /* Tùy chỉnh icon file đính kèm */
        .file-icon {
            width: 40px;
            height: 40px;
            margin-right: 0.5rem;
            vertical-align: middle;
        }
        /* Style cho table quản lý CV */
        .cv-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1.5rem;
            font-size: 0.9rem; /* Giảm kích thước font để nội dung nhỏ hơn */
        }
        .cv-table th, .cv-table td {
            padding: 0.5rem; /* Giảm padding để tiết kiệm không gian */
            text-align: left;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle; /* Đảm bảo căn giữa theo chiều dọc */
        }
        .cv-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        .cv-table td {
            white-space: nowrap; /* Ngăn chặn ngắt dòng */
        }
        .file-preview img {
            max-width: 40px; /* Giảm kích thước ảnh xem trước */
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
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s ease;
            max-width: 150px; /* Giới hạn chiều rộng tối đa cho tên file */
            overflow: hidden; /* Ẩn phần vượt quá */
            text-overflow: ellipsis; /* Thêm dấu "..." khi tên file quá dài */
            display: inline-block; /* Đảm bảo hoạt động với max-width */
            vertical-align: middle;
        }
        .file-link:hover {
            color: #0056b3;
            text-overflow: clip; /* Hiển thị đầy đủ khi hover */
            max-width: none; /* Xóa giới hạn khi hover */
        }
        .action-btn {
            padding: 0.25rem 0.75rem; /* Giảm padding cho nút hành động */
            margin-right: 0.25rem;
            border-radius: 5px;
            font-size: 0.8rem; /* Giảm kích thước font của nút */
            transition: all 0.3s ease;
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Giảm độ đậm của bóng */
        }
        /* Đảm bảo nút hành động nằm trên một dòng */
        .cv-table td:last-child {
            white-space: nowrap; /* Ngăn ngắt dòng cho cột hành động */
            min-width: 120px; /* Đảm bảo cột hành động có đủ không gian */
        }
        .delete-btn {
            background-color: #dc3545;
            color: #ffffff;
            border: none;
        }
        .default-btn {
            background-color: #28a745;
            color: #ffffff;
            border: none;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <!-- Phần header phụ với ảnh đại diện -->
    <div class="profile-header">
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
    </div>

    <!-- Phần nội dung chính -->
    <div class="profile-container">
        <div class="row">
            <!-- Thông tin cá nhân -->
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
                        <button type="button" class="btn btn-secondary edit-btn" onclick="toggleEditPersonalInfo()">Chỉnh sửa</button>
                        <button type="submit" class="btn btn-primary save-btn d-none">Lưu</button>
                    </div>
                </form>
            </div>

            <!-- Quản lý CV -->
			<div class="col-md-6">
			    <div class="section-title">Quản Lý CV</div>
			    <c:if test="${not empty cvList}">
			        <table class="cv-table">
			            <thead>
			                <tr>
			                    <th>ID</th>
			                    <th>File CV</th>
			                    <th>Hành động</th>
			                </tr>
			            </thead>
			            <tbody>
			                <c:forEach var="cv" items="${cvList}">
			                    <tr>
			                        <td>${cv.id}</td>
			                        <td>
			                            <c:set var="fileName" value="${cv.fileName}"/>
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
			                        <td>
			                            <c:choose>
			                                <c:when test="${user.cvId != null && user.cvId == cv.id}">
			                                    <span style="color: #28a745; font-weight: bold;">Default</span>
			                                </c:when>
			                                <c:otherwise>
			                                    <form action="${pageContext.request.contextPath}/profilecompany/updateCVdefault" method="post" style="display:inline;">
			                                        <input type="hidden" name="idcv" value="${cv.id}">
			                                        <input type="hidden" name="email" value="${user.email}">
			                                        <button type="submit" class="btn action-btn default-btn">Set Default</button>
			                                    </form>
			                                </c:otherwise>
			                            </c:choose>
			                            <form action="${pageContext.request.contextPath}/profilecompany/deleteCV" method="post" style="display:inline;">
			                                <input type="hidden" name="idcv" value="${cv.id}">
			                                <button type="submit" class="btn action-btn delete-btn">Xóa</button>
			                            </form>
			                        </td>
			                    </tr>
			                </c:forEach>
			            </tbody>
			        </table>
			    </c:if>
			    <c:if test="${empty cvList}">
			        <p class="file-status">Chưa có CV nào được tải lên.</p>
			    </c:if>
			
			    <!-- Form upload CV mới -->
			    <div class="form-group">
			        <label for="cvFile" class="form-label">Tải lên CV mới</label>
			        <form id="cvUploadForm" action="${pageContext.request.contextPath}/profilecompany/uploadcv" method="post" enctype="multipart/form-data">
			            <input type="hidden" name="userEmail" value="${user.email}">
			            <input type="file" class="form-control file-upload" id="cvFile" name="fileName" accept=".pdf,.doc,.docx,image/*" onchange="updateFileStatus('cvFileStatus', this)" required>
			            <div class="file-status" id="cvFileStatus">
			                <span class="file-preview">
			                    <img src="${pageContext.request.contextPath}/resources/images/default-file-icon.png" alt="File icon" class="file-icon">
			                </span>
			                Chưa chọn tệp
			            </div>
			            <div class="save-btn-container">
			                <button type="submit" class="btn btn-primary save-btn">Tải lên</button>
			            </div>
			        </form>
			    </div>
			</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Giữ nguyên các hàm JavaScript hiện có
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

        document.getElementById('companyLogoTrigger')?.addEventListener('click', function() {
            document.getElementById('companyLogoUpload')?.click();
        });

        <c:if test="${not empty success}">
            document.getElementById('saveBtn').style.display = 'none';
            document.getElementById('avatarUpload').value = '';
            document.getElementById('companyLogoSaveBtn')?.style.display = 'none';
            document.getElementById('companyLogoUpload')?.value = '';
        </c:if>

        // Validate submit cho personalInfoForm
        document.getElementById('personalInfoForm').addEventListener('submit', function(event) {
            if (!validatePersonalInfo()) {
                event.preventDefault();
            }
        });

        // Validate submit cho cvUploadForm
        document.getElementById('cvUploadForm').addEventListener('submit', function(event) {
            const cvFile = document.getElementById('cvFile').value;
            if (!cvFile) {
                alert('Vui lòng chọn một tệp CV!');
                event.preventDefault();
                return;
            }
            const fileExt = cvFile.split('.').pop().toLowerCase();
            const validExts = ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'];
            if (!validExts.includes(fileExt)) {
                alert('Định dạng tệp không hợp lệ! Chỉ chấp nhận .pdf, .doc, .docx, .png, .jpg, .jpeg.');
                event.preventDefault();
            }
        });
    </script>
</body>
</html>