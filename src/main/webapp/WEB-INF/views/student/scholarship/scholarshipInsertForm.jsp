<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
    <div class="col-xl-12">
        <div class="card mb-4 bg-white">
            <h5 class="card-header">장학  > 장학금 신청</h5>
            <hr class="my-0">
            <div class="card-body">
                <div class="table-responsive text-nowrap">
                    <form id="requestForm" action="/student/insertScholarshipRequest" method="post" enctype="multipart/form-data">
                        <sec:csrfInput/>
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label" for="schName"><font size="4">장학금명</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="schName" id="schName" value="${schName}" readonly>
                                <input type="hidden" name="schNo" value="${schNo}">
                            </div>

                            <label class="col-sm-2 col-form-label" for="stuNo"><font size="4">신청인</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="stuNo" id="stuNo" value="${stuNo}" readonly>
                            </div>

                            <label class="col-sm-2 col-form-label" for="year"><font size="4">년도</font></label>
                            <div class="col-sm-10">
                                <input type="number" placeholder="2024" min="2020" max="2024" class="form-control" name="year" id="year" value="">
                            </div>

                            <label class="col-sm-2 col-form-label" for="semester"><font size="4">학기</font></label>
                            <div class="col-sm-10">
                                <select class="form-select" name="semester" id="semester">
                                    <option value="1">1학기</option>
                                    <option value="2">2학기</option>
                                </select>
                            </div>
                            <label for="file" class="col-md-2 col-form-label"><font size="4">장학금 파일 첨부</font></label>
                                    <div class="col-sm-10">
                                        <input type="file" class="form-control" id="schFile" name="schFile">
                                    </div>
                        </div>
                         <hr class="my-0">
                         <div class="card-footer" style="align-items: center;">
                             <input type="button" id="requestBtn" value="신청" class="btn btn-primary">
                             <input type="button" id="listBtn" value="목록" class="btn btn-dark">
                        </div>  
                    </form>
                </div>
            </div>
        </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $("#requestBtn").click(function(e){
            var scholarshipName = $("#schName").val();
            var year = $("#year").val();
            var semester = $("#semester").val();
            var schFile = $("#schFile").val();
            
            if (!year) {
                alert("연도를 입력해 주세요.");
                return false;
            }
            if (!semester) {
                alert("학기를 선택해 주세요.");
                return false;
            }
            
            if(!schFile){
                alert("첨부파일을 선택해주세요.");
                return false;
            }
            
            if (confirm(scholarshipName + "을 신청하시겠습니까?")) {
                // Submit the form using AJAX
                var formData = new FormData($('#requestForm')[0]);
                
                $.ajax({
                    type: 'POST',
                    url: '/student/insertScholarshipRequest',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        alert(scholarshipName + " 신청이 완료되었습니다.");
                        window.location.href = "/student/myScholarshipList";
                    },
                    error: function(response) {
                        alert("장학금 신청에 실패했습니다. 다시 시도해주세요.");
                    }
                });
            } else {
                e.preventDefault();
            }
        });
        
        // 목록으로 돌아가기 버튼
        $("#listBtn").on("click", function(){
            location.href= "/student/myScholarshipList";
        });
    });
</script>
