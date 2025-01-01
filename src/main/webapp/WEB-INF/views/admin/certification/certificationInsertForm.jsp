<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="card mb-4 bg-white">
            <h5 class="card-header">증명서 관리 > 증명서 등록</h5>
            <hr class="my-0">
            <div class="card-body">
                <div class="table-responsive text-nowrap">
                    <form id="certificationForm" action="/admin/certificationInsert" method="post" enctype="multipart/form-data">
                        <sec:csrfInput/>
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label" for="cerName"><font size="4">증명서명</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="cerName" id="cerName" required>
                            </div>

                            <label class="col-sm-2 col-form-label" for="cerContent"><font size="4">내용</font></label>
                            <div class="col-sm-10">
                                <textarea rows="8" cols="8" class="form-control" name="cerContent" id="cerContent" required></textarea>
                            </div>

                            <label class="col-sm-2 col-form-label" for="cerCharge"><font size="4">수수료</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="cerCharge" id="cerCharge" required>
                            </div>
                            
                            <label class="col-sm-2 col-form-label" for="file"><font size="4">파일 업로드</font></label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" name="cerFile" id="cerFile" required multiple="multiple">
                            </div>
                        </div>

                        <input type="button" id="insertBtn" value="등록" class="btn btn-primary">
                        <button type="button" class="btn btn-primary" id="listBtn">취소</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
    	
    	// 증명서 등록 성공 메시지 확인 및 알림창 표시
        <c:if test="${not empty msg}">
            alert("${msg}");
        </c:if>

    	
    	
        $('#insertBtn').click(function(){
            if(confirm("신규 증명서를 등록하시겠습니까?")) {
                $('#certificationForm').submit();
            }
        });

        $("#listBtn").click(function(){
            location.href="/admin/certificationList";
        })
    });
</script>
