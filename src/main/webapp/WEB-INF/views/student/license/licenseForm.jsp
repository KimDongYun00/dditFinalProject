<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<meta id="_csrf" name="_csrf" content="${_csrf.token }">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <div class="container-xxl flex-grow-1 container-p-y">
        <div class="card bg-white">
            <h5 class="card-header">자격증 > 자격증 등록</h5>
            <hr class="mb-0">
            <div class="card-body">
                <form id="licenseForm" action="/student/insertLicense" method="post" enctype="multipart/form-data">
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <div class="card mb-4">
                                <sec:csrfInput/>
                                <div class="card-body">
                                    <div class="mb-3 row">
                                        <label for="stuNo" class="col-md-2 col-form-label"><font size="4">학번</font></label>
                                        <div class="col-md-10">
                                            <input class="form-control" type="text" id="stuNo" name="stuNo" value="${stuVO.stuNo }" readonly="readonly">
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <label for="licName" class="col-md-2 col-form-label"><font size="4">자격증명</font></label>
                                        <div class="col-md-10" id="select">
                                                <input class="form-check-input" type="radio" name="licName" id="TOEIC" value="TOEIC">
                                                <label class="form-check-label" for="TOEIC">TOEIC</label> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                                <input class="form-check-input" type="radio" name="licName" id="TOEFL" value="TOEFL">
                                                <label class="form-check-label" for="TOEFL">TOEFL</label> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                                <input class="form-check-input" type="radio" name="licName" id="HSK" value="HSK">
                                                <label class="form-check-label" for="HSK">HSK</label> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                                <input class="form-check-input" type="radio" name="licName" id="JLPT" value="JLPT">
                                                <label class="form-check-label" for="JLPT">JLPT</label> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <label for="licContent" class="col-md-2 col-form-label"><font size="4">자격증 내용</font></label>
                                        <div class="col-md-10">
                                            <input class="form-control" type="text" id="licContent" name="licContent">
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <label for="licDate" class="col-md-2 col-form-label"><font size="4">발급날짜</font></label>
                                        <div class="col-md-10">
                                            <input class="form-control" type="date" id="licDate" name="licDate">
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <label for="licLimit" class="col-md-2 col-form-label"><font size="4">유효기간</font></label>
                                        <div class="col-md-10">
                                            <input class="form-control" type="date" id="licLimit" name="licLimit">
                                        </div>
                                    </div>

                                    <label for="file" class="col-md-2 col-form-label"><font size="4">자격증 파일 첨부</font></label>
                                    <div class="col-sm-10">
                                        <input type="file" class="form-control" id="licFile" name="licFile">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
               <hr class="my-0">
                <div class="card-footer">
                    <!-- 목록 버튼 -->
                	<input type="button" id="insertBtn" value="신청" class="btn btn-primary">
                	<input type="button" id="fastBtn" value="시연용" class="btn btn-primary" style="float:right;">
                </div>

            </div>
        </div>
    </div>

    <script>
        $(function() {
        	
        	$("#fastBtn").click(function(){
        		$("input[name='licName']:radio[value='TOEIC']").prop('checked', true);
        		$("#licContent").val("토익 710점");
        		$("#licDate").val("2024-02-02");
        		$("#licLimit").val("2026-02-02");
        	});
        	
            // 자격증 등록 성공 메시지 확인 및 알림창 표시
            var successMessage = "${successMessage}";
            var errorMessage = "${errorMessage}";
            if (successMessage) {
                Swal.fire({
                    title: '자격증 등록 성공',
                    text: '원하시는 작업을 선택하세요.',
                    icon: 'success',
                    showCancelButton: true,
                    confirmButtonText: '자격증 추가 등록하기',
                    cancelButtonText: '자격증 신청 내역 보기'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.href = '/student/licenseForm'; // 자격증 추가 등록 페이지
                    } else if (result.dismiss === Swal.DismissReason.cancel) {
                        location.href = '/student/myLicenseList'; // 자격증 신청 내역 보기 페이지
                    }
                });
            } else if (errorMessage) {
                Swal.fire({
                    title: '자격증 등록 실패',
                    text: errorMessage,
                    icon: 'error',
                    confirmButtonText: '확인'
                });
            }
        
            $('#insertBtn').click(function() {
                // 입력값 검증
                var licName = $("input[name='licName']:checked").val();
                var licContent = $("#licContent").val();
                var licLimit = $("#licLimit").val();
                var licDate = $("#licDate").val();
                var licFile = $("#licFile").val();
        
                if (!licName) {
                    alert("자격증명을 선택해 주세요.");
                    return;
                }
                if (!licContent) {
                    alert("자격증 내용을 입력해 주세요.");
                    return;
                }
                if (!licLimit) {
                    alert("유효기간을 선택해 주세요.");
                    return;
                }
                if (!licDate) {
                    alert("발급날짜를 선택해 주세요.");
                    return;
                }
                if (!licFile) {
                    alert("자격증 파일을 첨부해주세요.");
                    return;
                }
        
                if(confirm("< " + licName + " > 자격증을 등록하시겠습니까?")) {
                    $('#licenseForm').submit();
                }
            });
        });
    </script>
