<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}">
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}">
    <title>학생 일괄 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .table-responsive {
            overflow-x: auto;
        }
        .table-hover th, .table-hover td {
            text-align: center;
        }
        .btn-register, .btn-apply {
            display: block;
            margin: 20px 0;
            width: 150px;
            float: right;
        }
        .form-select, .form-control {
            height: 38px;
            padding: 6px 12px;
        }
        .searchHeader {
            background: #dddddd;
            padding: 1% 2% 0% 2%;
            border-radius: 10px;
            margin-bottom: 0;
        }
        .input-group-text {
            height: 38px;
        }
        #searchBtn {
            font-weight: bold;
            background: skyblue;
            height: 38px;
            border-radius: 5px; /* 둥근 모서리 적용 */
            border: 1px solid #007bff; /* 버튼 테두리 색상 */
        }
        .info-table th, .info-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .info-table th {
            background-color: #f2f2f2;
        }
        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .info-container {
            display: flex;
            justify-content: space-between;
        }
        .info-container > div {
            flex: 0 0 48%; /* 두 테이블을 나란히 배치하고, 양쪽에 약간의 여백을 줌 */
        }
        .btn-upload {
            display: block;
            margin: 20px auto;
            width: 150px;
        }
        .btn-back {
            display: block;
            margin: 20px auto;
            width: 150px;
        }
    </style>
</head>
<body>
<div class="container-xxl flex-grow-1 container-p-y">
    <!-- 주의사항 섹션 -->
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align: left;">일괄 등록 유의사항</h5>
                <hr class="my-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="info-table">
                            <tbody>
                                <tr>
                                    <th>1</th>
                                    <td>엑셀 파일은 지정된 양식을 사용해야 합니다.</td>
                                </tr>
                                <tr>
                                    <th>2</th>
                                    <td>데이터의 정확성을 확인한 후 업로드하시기 바랍니다.</td>
                                </tr>
                                <tr>
                                    <th>3</th>
                                    <td>업로드된 데이터는 즉시 반영됩니다.</td>
                                </tr>
                                <tr>
                                    <th>4</th>
                                    <td>문제가 발생할 경우 관리자에게 문의하시기 바랍니다. (연락처: 042-123-4567)</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <hr class="my-0">
            </div>
        </div>
    </div>

    <!-- 학생 일괄 등록 섹션 -->
    <div class="row justify-content-center">
        <div class="col-md-12">
		  <div class="card mb-4 bg-white">
                     <h4 class="card-header" style="text-align: left;">학생 일괄 등록</h4>
                      <hr class="my-0">
                <div class="card-body">
                    <form id="uploadForm" action="${pageContext.request.contextPath}/admin/stuInsertAll" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="mb-3">
                            <label for="file" class="form-label">엑셀 파일 선택</label>
                            <input type="file" class="form-control" id="file" name="file"/>
                        </div>
                        <button type="submit" class="btn btn-primary btn-upload" id="uploadBtn">업로드</button>
                    </form>
                </div>
                 <hr class="my-0">
            </div>
        </div>
     </div>   

    <!-- 목록으로 돌아가기 버튼 -->
    <div class="row justify-content-center">
        <div class="col-md-12">
            <br>
            <input type="button" class="btn btn-dark" id="listBtn" value="목록으로 돌아가기">
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    var listBtn = $("#listBtn");
    var uploadBtn = $("#uploadBtn");

    uploadBtn.on("click", function(event) {
        var file = $("#file").val();
        if (!file) {
            event.preventDefault(); // 폼 제출을 막음
            alert("첨부파일을 선택해주세요.");
        }
    });

    listBtn.on("click", function() {
        location.href = "/admin/stuList";    	
    });

    // 서버에서 성공 여부를 전달받아 처리
    var msg = "${msg}";
    if (msg) {
        console.log("msg:", msg); // 디버깅을 위해 추가
        if (msg === "success") {
            Swal.fire({
                icon: "success",
                title: "학생 일괄 등록을 완료하였습니다!",
                showConfirmButton: true
            });
        } else if (msg === "fail") {
            Swal.fire({
                icon: "error",
                title: "일괄 등록에 실패했습니다. 다시 시도해주세요.",
                showConfirmButton: true
            });
        }
    }
});
</script>
</body>
</html>
