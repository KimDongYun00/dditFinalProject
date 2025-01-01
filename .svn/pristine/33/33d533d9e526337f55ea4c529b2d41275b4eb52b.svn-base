<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장학 신청 및 수혜 내역 상세 조회</title>
<style>
  .table-responsive {
    overflow-x: auto;
  }
  .table-hover th, .table-hover td {
    text-align: center;
  }
  .form-label {
    font-size: 16px;
  }
  .row.mb-3 {
    margin-bottom: 1rem;
  }
  .col-sm-2 {
    font-weight: bold;
  }
</style>
</head>
<body>
<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">장학 신청 및 수혜 내역 상세 조회</h5>
                <hr class="my-0">
                <div class="card-body">
                   <form action="/student/scholarshipRequestUpdate" method="post" id="formData" enctype="multipart/form-data">
                   <sec:csrfInput/>
                   <input type="hidden" name="schRecNo" value="${scholarshipVO.schRecNo}">
                   <input type="hidden" name="fileGroupNo" value="${scholarshipVO.fileGroupNo}">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label"><font size="4">장학금명</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.schName}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">장학금액</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext"><fmt:formatNumber value="${scholarshipVO.schAmount}" pattern="#,###" />원</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">장학유형</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.schType}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">장학내용</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.schContent}</p>
                        </div>
                        <c:if test="${scholarshipVO.comDetCNo != 'C0201'}"> <!-- 처리 상태가 승인완료가 아닌 경우 -->
                            <label class="col-sm-2 col-form-label"><font size="4">년도</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="year" value="${scholarshipVO.year}">
                            </div>
                            <label class="col-sm-2 col-form-label"><font size="4">학기</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="semester" value="${scholarshipVO.semester}">
                            </div>
                            <label class="col-sm-2 col-form-label"><font size="4">첨부파일</font></label>
                            <div class="col-sm-5">
                                <input type="file" class="form-control" name="schFile" id="file">
                            </div>
                            <div class="col-sm-5">
                                <c:if test="${not empty fileList}">
                                    <c:forEach var="file" items="${fileList}">
                                        <label class="col-sm-12 col-form-label" id="fileLabel">
                                            첨부파일 : 
                                            <a class="link-primary" href="/common/fileDownload.do?fileGroupNo=${file.fileGroupNo }&fileNo=${file.fileNo}&${_csrf.parameterName}=${_csrf.token}">
                                                ${file.fileName}
                                            </a>
                                        </label><br/>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty fileList}">
                                    <label class="col-sm-12 col-form-label" id="fileLabel">
                                        <span class="col-sm-4" style="font-size: 1.1rem;">첨부파일 없음</span>
                                    </label>
                                </c:if>
                            </div>
                        </c:if>
                        <c:if test="${not empty scholarshipVO.rejContent}">
                            <label class="col-sm-2 col-form-label"><font size="4">반려 사유</font></label>
                            <div class="col-sm-10">
                                <p class="form-control-plaintext">${scholarshipVO.rejContent}</p>
                            </div>
                        </c:if>
                    </div>
                </div>
                <hr class="my-0">
                <div class="card-footer">
                    <!-- 목록 버튼 -->
                    <button type="button" class="btn btn-dark" id="listBtn">목록</button>
                    <c:if test="${scholarshipVO.comDetCNo != 'C0201'}"> <!-- 처리 상태가 승인완료가 아닌 경우 -->
                        <!-- 수정 버튼 -->
                        <button type="button" class="btn btn-primary" id="modifyBtn">수정</button>
                    </c:if>
                    <c:if test="${scholarshipVO.comDetCNo == 'C0202'}"> <!-- 처리 상태가 미승인인 경우 -->
                    	<input type="button" class="btn btn-danger" value="삭제" id="deleteBtn">
                    </c:if>
                </div>
                </form>
            </div>
        </div>
    </div>
    <sec:csrfInput/>
</div>
<form method="post" action="/student/scholarshipRequestDelete" id="deleteForm">
	<sec:csrfInput/>
	<input type="hidden" value="${scholarshipVO.schRecNo}" name="schRecNo">
</form>

<script>
$(function(){
    // 목록 버튼 클릭 이벤트
    $("#listBtn").click(function(){
        location.href="/student/myScholarshipList";
    });

    // 수정 버튼 클릭 이벤트
    $("#modifyBtn").click(function(){
        $("#formData").submit();
    });

    // 파일 첨부변경시 보이는 태그 다르게 하기 위해
    var fileLabel = $("#fileLabel");
    
    
    // 파일 첨부파일 변경시
    $("#file").on("change", function(){
        fileName = $("#file").val();
        fileNameLen = fileName.length;
        realFileName = fileName.substring(12, fileNameLen);
        fileLabel.find("a:eq(0)").html(realFileName);
        
        // 수정시에 다운로드 못하게
        fileLabel.find("a:eq(0)").attr("href", "#");
    });
    
 	// 미승인된거 삭제 처리
	$("#deleteBtn").click(function(){
		if(confirm('정말 해당 장학금 신청을 삭제 하시겠습니까?')){
			$("#deleteForm").submit();
		}
	});
    
})
</script>
</body>
</html>
