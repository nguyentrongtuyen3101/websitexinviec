<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Bài Đăng Tuyển Dụng - JobVN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #C9E4D6;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #006241;
            line-height: 1.6;
        }
        .form-container {
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
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            font-weight: 600;
            color: #006241;
            margin-bottom: 0.5rem;
        }
        .form-control, .form-select {
            border: 1px solid #00676B;
            border-radius: 6px;
            background-color: #f5f7f5;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #006241;
            box-shadow: 0 0 0 0.25rem rgba(0, 98, 65, 0.25);
        }
        .error-message {
            color: #b91c1c;
            font-size: 0.9rem;
            display: none;
            margin-top: 0.5rem;
        }
        .save-btn-container {
            text-align: center;
            margin-top: 2rem;
        }
        .btn-primary {
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            background-color: #F1AF00;
            border: none;
            color: #006241;
            font-weight: 500;
            transition: background-color 0.2s;
        }
        .btn-primary:hover {
            background-color: #d89b00;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        @media (max-width: 768px) {
            .form-container {
                margin: 1rem;
                padding: 1rem;
            }
            .section-title {
                font-size: 1.3rem;
            }
            .form-group {
                margin-bottom: 1rem;
            }
            .btn-primary {
                padding: 0.5rem 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="form-container">
        <div class="section-title">Tạo Bài Đăng Tuyển Dụng</div>
        <form:form id="recruitmentForm" modelAttribute="recruitment" action="${pageContext.request.contextPath}/dangtuyen/taodangtuyen" method="post">
            <form:hidden path="id" />
            <div class="form-group">
                <label for="title" class="form-label">Tiêu đề <span style="color: #b91c1c;">*</span></label>
                <input type="text" class="form-control" id="title" name="title" value="${recruitment.title}" required>
                <div id="titleError" class="error-message">Tiêu đề không được để trống.</div>
            </div>
            <div class="form-group">
                <label for="description" class="form-label">Mô tả công việc <span style="color: #b91c1c;">*</span></label>
                <textarea class="form-control" id="description" name="description" rows="5" required>${recruitment.description}</textarea>
                <div id="descriptionError" class="error-message">Mô tả không được để trống.</div>
            </div>
            <div class="form-group">
                <label for="experience" class="form-label">Yêu cầu kinh nghiệm <span style="color: #b91c1c;">*</span></label>
                <input type="text" class="form-control" id="experience" name="experience" value="${recruitment.experience}" required>
                <div id="experienceError" class="error-message">Kinh nghiệm không được để trống.</div>
            </div>
            <div class="form-group">
                <label for="quantity" class="form-label">Số lượng tuyển <span style="color: #b91c1c;">*</span></label>
                <input type="number" class="form-control" id="quantity" name="quantity" value="${recruitment.quantity}" min="1" required>
                <div id="quantityError" class="error-message">Số lượng phải lớn hơn 0.</div>
            </div>
            <div class="form-group">
                <label for="address" class="form-label">Địa chỉ <span style="color: #b91c1c;">*</span></label>
                <input type="text" class="form-control" id="address" name="address" value="${recruitment.address}" required>
                <div id="addressError" class="error-message">Địa chỉ không được để trống.</div>
            </div>
            <div class="form-group">
                <label for="deadline" class="form-label">Hạn nộp hồ sơ <span style="color: #b91c1c;">*</span></label>
                <input type="date" class="form-control" id="deadline" name="deadline" value="${recruitment.deadline}" required>
                <div id="deadlineError" class="error-message">Hạn nộp hồ sơ phải lớn hơn ngày hiện tại.</div>
            </div>
            <div class="form-group">
                <label for="salary" class="form-label">Mức lương (USD) <span style="color: #b91c1c;">*</span></label>
                <input type="text" class="form-control" id="salary" name="salary" value="${recruitment.salary}" required>
                <div id="salaryError" class="error-message">Mức lương không được để trống.</div>
            </div>
            <div class="form-group">
                <label for="position" class="form-label">Vị trí <span style="color: #b91c1c;">*</span></label>
                <input type="text" class="form-control" id="position" name="position" value="${recruitment.position}" required>
                <div id="rankError" class="error-message">Vị trí không được để trống.</div>
            </div>
            <div class="form-group">
                <label for="type" class="form-label">Loại công việc <span style="color: #b91c1c;">*</span></label>
                <select class="form-select" id="type" name="type" required>
                    <option value="" disabled ${empty recruitment.type ? 'selected' : ''}>Chọn loại công việc</option>
                    <option value="Toàn thời gian" ${recruitment.type == 'Toàn thời gian' ? 'selected' : ''}>Toàn thời gian</option>
                    <option value="Bán thời gian" ${recruitment.type == 'Bán thời gian' ? 'selected' : ''}>Bán thời gian</option>
                    <option value="Thực tập" ${recruitment.type == 'Thực tập' ? 'selected' : ''}>Thực tập</option>
                    <option value="Khác" ${recruitment.type == 'Khác' ? 'selected' : ''}>Khác</option>
                </select>
                <div id="typeError" class="error-message">Vui lòng chọn loại công việc.</div>
            </div>
            <div class="form-group">
                <label for="categoryid" class="form-label">Danh mục <span style="color: #b91c1c;">*</span></label>
                <select class="form-select" id="categoryid" name="categoryid" required>
                    <option value="" disabled selected>Chọn danh mục</option>
                    <c:forEach var="category" items="${listcCategories}">
                        <option value="${category.id}" ${recruitment.category.id == category.id ? 'selected' : ''}>${category.name}</option>
                    </c:forEach>
                </select>
                <div id="categoryError" class="error-message">Vui lòng chọn danh mục.</div>
            </div>
            <div class="save-btn-container">
                <button type="submit" class="btn btn-primary">Tạo bài đăng</button>
            </div>
        </form:form>
        <c:if test="${not empty error}">
            <p style="color: #b91c1c; text-align: center; margin-top: 1rem;">${error}</p>
        </c:if>
        <c:if test="${not empty success}">
            <p style="color: green; text-align: center; margin-top: 1rem;">${success}</p>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function validateForm() {
            let valid = true;

            const title = document.getElementById('title').value;
            if (!title.trim()) {
                document.getElementById('titleError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('titleError').style.display = 'none';
            }

            const description = document.getElementById('description').value;
            if (!description.trim()) {
                document.getElementById('descriptionError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('descriptionError').style.display = 'none';
            }

            const experience = document.getElementById('experience').value;
            if (!experience.trim()) {
                document.getElementById('experienceError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('experienceError').style.display = 'none';
            }

            const quantity = document.getElementById('quantity').value;
            if (quantity <= 0) {
                document.getElementById('quantityError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('quantityError').style.display = 'none';
            }

            const address = document.getElementById('address').value;
            if (!address.trim()) {
                document.getElementById('addressError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('addressError').style.display = 'none';
            }

            const deadline = document.getElementById('deadline').value;
            const today = new Date('2025-06-16');
            const selectedDate = new Date(deadline);
            if (!deadline || selectedDate <= today) {
                document.getElementById('deadlineError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('deadlineError').style.display = 'none';
            }

            const salary = document.getElementById('salary').value;
            if (!salary.trim()) {
                document.getElementById('salaryError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('salaryError').style.display = 'none';
            }

            const position = document.getElementById('position').value;
            if (!position.trim()) {
                document.getElementById('rankError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('rankError').style.display = 'none';
            }

            const type = document.getElementById('type').value;
            if (!type) {
                document.getElementById('typeError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('typeError').style.display = 'none';
            }

            const category = document.getElementById('categoryid').value;
            if (!category) {
                document.getElementById('categoryError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('categoryError').style.display = 'none';
            }

            return valid;
        }

        document.getElementById('recruitmentForm').addEventListener('submit', function(event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>