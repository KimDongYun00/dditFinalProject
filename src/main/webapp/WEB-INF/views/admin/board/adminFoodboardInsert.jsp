<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">맛집 게시판</h4>
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4 bg-white">
                    <h5 class="card-header">게시글 정보</h5>
                    <hr class="my-0">
                    <div class="card-body">
                        <form id="foodForm" action="${pageContext.request.contextPath}/admin/foodInsert" method="post">
                            <sec:csrfInput />
                            <input type="hidden" name="foodNo" value="${foodboard.foodNo}" />
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label" for="foodTitle"><font size="4">제목</font></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="foodTitle" name="foodTitle" value="${foodboard.foodTitle}" required>
                                </div>

                                <label class="col-sm-2 col-form-label" for="foodContent"><font size="4">내용</font></label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" id="foodContent" name="foodContent" required>${foodboard.foodContent}</textarea>
                                </div>

                                <label class="col-sm-2 col-form-label" for="foodMapx"><font size="4">X 좌표</font></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="foodMapx" name="foodMapx" value="${foodboard.foodMapx}" required>
                                </div>

                                <label class="col-sm-2 col-form-label" for="foodMapy"><font size="4">Y 좌표</font></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="foodMapy" name="foodMapy" value="${foodboard.foodMapy}" required>
                                </div>
                            </div>
                        </form>
                    </div>
                    <hr class="my-0">
                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary" id="saveButton">저장</button>
                        <a href="${pageContext.request.contextPath}/admin/foodList" class="btn btn-secondary">취소</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('saveButton').addEventListener('click', function(event) {
            event.preventDefault();
            var form = document.getElementById('foodForm');
            var formData = new FormData(form);

            fetch(form.action, {
                method: 'POST',
                body: formData,
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('input[name="_csrf"]').value
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    alert(data.message);
                    window.location.href = '${pageContext.request.contextPath}/admin/foodList';
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                alert('등록에 실패했습니다.');
                console.error('Error:', error);
            });
        });
    </script>
</body>
</html>
