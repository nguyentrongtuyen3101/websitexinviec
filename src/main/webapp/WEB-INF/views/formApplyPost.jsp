<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ứng tuyển công việc - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #C9E4D6;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #006241;
            line-height: 1.6;
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
        }
        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #006241;
            margin-bottom: 1.5rem;
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
        .form-control, .form-check-input {
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
        }
        .company-logo {
            width: 56px;
            height: 56px;
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
        .job-info {
            background-color: #f5f7f5;
            padding: 1.5rem;
            border-radius: 10px;
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
        }
        .save-btn-container {
            text-align: center;
        }
        .apply-btn, .follow-btn, .unfollow-btn {
            font-size: 0.9rem;
            padding: 0.4rem 1rem;
            border-radius: 6px;
            font-weight: 500;
            transition: background-color 0.2s, transform 0.2s;
        }
        .apply-btn, .follow-btn {
            background-color: #F1AF00;
            border: none;
            color: #006241;
        }
        .apply-btn:hover, .follow-btn:hover {
            background-color: #d89b00;
            transform: translateY(-2px);
        }
        .unfollow-btn {
            background-color: #00676B;
            border: none;
            color: #ffffff;
            margin-bottom: 20px;
        }
        .follow-btn{
        	margin-bottom: 20px;
        }
        .unfollow-btn:hover {
            background-color: #005558;
            transform: translateY(-2px);
        }
        .error-message {
            color: #b91c1c;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }
        .success-message {
            color: #006241;
            font-size: 0.9rem;
            margin-top: 0.5rem;
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
                font-size: 1.5rem;
            }
            .form-group {
                margin-bottom: 1rem;
            }
            .apply-btn, .follow-btn, .unfollow-btn {
                padding: 0.5rem 1rem;
            }
            .job-info {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="profile-container">
        <div class="row">
            <div class="col-md-6">
                <div class="section-title">Thông tin công việc</div>
                <div class="company-logo">
                    <c:if test="${not empty recruitments.company.logo}">
                        <img src="${pageContext.request.contextPath}/uploads/${recruitments.company.logo}" alt="Logo công ty">
                    </c:if>
                    <c:if test="${empty recruitments.company.logo}">
                        <img src="${pageContext.request.contextPath}/resources/images/default-logo.jpg" alt="Logo công ty">
                    </c:if>
                </div>
                <c:if test="${isfollow}">
                    <form id="formfollow" action="${pageContext.request.contextPath}/dangtuyen/deletefollow?source=applipost" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="recruitmentsId" value="${recruitments.id}">
                        <button type="submit" class="btn unfollow-btn">Unfollow</button>
                    </form>
                </c:if>
                <c:if test="${!isfollow}">
                    <form id="formfollow" action="${pageContext.request.contextPath}/dangtuyen/followcompany?source=applipost" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="recruitmentsId" value="${recruitments.id}">
                        <button type="submit" class="btn follow-btn">Follow</button>
                    </form>
                </c:if>
                <div class="job-info">
                    <p><strong>Tiêu đề:</strong> ${recruitments.title}</p>
                    <p><strong>Mô tả:</strong> ${recruitments.description}</p>
                    <p><strong>Lương:</strong> ${recruitments.salary}</p>
                    <p><strong>Địa chỉ:</strong> ${recruitments.address}</p>
                    <p><strong>Hạn nộp:</strong> ${recruitments.deadline}</p>
                    <p><strong>Vị trí:</strong> ${recruitments.position}</p>
                    <p><strong>Kinh nghiệm:</strong> ${recruitments.experience}</p>
                    <p><strong>Số lượng:</strong> ${recruitments.quantity}</p>
                    <p><strong>Loại hình:</strong> ${recruitments.type}</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="section-title">Form ứng tuyển</div>
                <c:if test="${not empty failCV}">
                    <p class="error-message">${failCV}</p>
                </c:if>
                <c:if test="${not empty welldone}">
                    <p class="success-message">${welldone}</p>
                </c:if>
                <c:if test="${not empty fail}">
                    <p class="error-message">${fail}</p>
                </c:if>
                <c:if test="${!hasApplied}">
                    <form id="applyPostForm" action="${pageContext.request.contextPath}/dangtuyen/applypostaction" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="recruitmentsId" value="${recruitments.id}">
                        <div class="form-group">
                            <label class="form-label">Chọn CV</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="chouseCV" id="defaultCV" value="true" checked onclick="toggleCVUpload()">
                                <label class="form-check-label" for="defaultCV">Sử dụng CV mặc định</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="chouseCV" id="newCV" value="false" onclick="toggleCVUpload()">
                                <label class="form-check-label" for="newCV">Upload CV mới</label>
                            </div>
                        </div>
                        <div class="form-group" id="cvUploadSection" style="display: none;">
                            <label for="fileName" class="form-label">Upload CV mới</label>
                            <input type="file" class="form-control file-upload" id="fileName" name="fileName" accept=".pdf,.doc,.docx,image/*">
                            <div id="fileNameError" class="error-message"></div>
                        </div>
                        <div class="form-group">
                            <label for="textIntroduction" class="form-label">Giới thiệu bản thân</label>
                            <textarea class="form-control" id="textIntroduction" name="text" rows="5" placeholder="Viết vài dòng giới thiệu về bản thân..."></textarea>
                            <div id="textIntroductionError" class="error-message"></div>
                        </div>
                        <div class="save-btn-container">
                            <button type="submit" class="btn apply-btn">Apply</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${hasApplied}">
                    <p class="success-message">Bạn đã ứng tuyển công việc này</p>
                    <form id="formdelete" action="${pageContext.request.contextPath}/dangtuyen/deleteapplypost" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="recruitmentsId" value="${recruitments.id}">
                        <button type="submit" class="btn unfollow-btn">Hủy ứng tuyển</button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleCVUpload() {
            const newCV = document.getElementById('newCV');
            const cvUploadSection = document.getElementById('cvUploadSection');
            cvUploadSection.style.display = newCV.checked ? 'block' : 'none';
        }

        document.getElementById('applyPostForm')?.addEventListener('submit', function(e) {
            const fileInput = document.getElementById('fileName');
            const textInput = document.getElementById('textIntroduction');
            const newCV = document.getElementById('newCV');
            let valid = true;

            document.getElementById('fileNameError').style.display = 'none';
            document.getElementById('textIntroductionError').style.display = 'none';

            if (newCV.checked) {
                if (!fileInput.files.length) {
                    document.getElementById('fileNameError').textContent = 'Vui lòng chọn một tệp CV!';
                    document.getElementById('fileNameError').style.display = 'block';
                    valid = false;
                } else {
                    const fileName = fileInput.files[0].name;
                    const fileExt = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
                    const validExts = ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'];
                    if (!validExts.includes(fileExt)) {
                        document.getElementById('fileNameError').textContent = 'Định dạng tệp không hợp lệ! Chỉ chấp nhận .pdf, .doc, .docx, .png, .jpg, .jpeg.';
                        document.getElementById('fileNameError').style.display = 'block';
                        valid = false;
                    }
                }
            }

            if (!textInput.value.trim()) {
                document.getElementById('textIntroductionError').textContent = 'Vui lòng nhập giới thiệu bản thân!';
                document.getElementById('textIntroductionError').style.display = 'block';
                valid = false;
            }

            if (!valid) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>