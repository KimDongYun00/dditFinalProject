<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보유 자격증 조회 > 자격증 신청 상세 조회</title>
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
                <h5 class="card-header">보유 자격증 조회 > 자격증 신청 상세 조회</h5>
                <hr class="my-0">
                <div class="card-body">
                   <form action="/student/licenseUpdate" method="post" id="formData" enctype="multipart/form-data">
                       <sec:csrfInput/>
                       <input type="hidden" name="licNo" value="${licenseVO.licNo}">
                       <input type="hidden" name="fileGroupNo" value="${licenseVO.fileGroupNo}">
                       <div class="row mb-3">
                            <label class="col-sm-2 col-form-label"><font size="4">자격증명</font></label>
                            <div class="col-sm-10">
                                <p class="form-control-plaintext">${licenseVO.licName}</p>
                            </div>
                            <label class="col-sm-2 col-form-label"><font size="4">자격내용</font></label>
                            <div class="col-sm-10">
                                <p class="form-control-plaintext">${licenseVO.licContent}</p>
                            </div>
                            <label class="col-sm-2 col-form-label"><font size="4">발급날짜</font></label>
                            <div class="col-sm-10">
                                <c:if test="${licenseVO.comdetCNo eq 'C0201'}">
                                    <p class="form-control-plaintext">${licenseVO.licDate}</p>
                                </c:if>
                                <c:if test="${licenseVO.comdetCNo != 'C0201'}">
                                    <input type="date" class="form-control" style="width: 170px;" name="licDate" value="${licenseVO.licDate}">
                                </c:if>
                            </div>
                            <label class="col-sm-2 col-form-label"><font size="4">유효기간</font></label>
                            <div class="col-sm-10">
                                <c:if test="${licenseVO.comdetCNo eq 'C0201'}">
                                    <p class="form-control-plaintext">${licenseVO.licLimit}</p>
                                </c:if>
                                <c:if test="${licenseVO.comdetCNo != 'C0201'}">
                                    <input type="date" class="form-control" style="width: 170px;" name="licLimit" value="${licenseVO.licLimit}">
                                </c:if>
                            </div>
                            <label class="col-sm-2 col-form-label"><font size="4">처리 현황</font></label>
                            <div class="col-sm-10">
                                <p class="form-control-plaintext">
                                    <c:choose>
                                        <c:when test="${licenseVO.comdetCNo eq 'C0201'}">승인</c:when>
                                        <c:when test="${licenseVO.comdetCNo eq 'C0202'}">미승인</c:when>
                                        <c:when test="${licenseVO.comdetCNo eq 'C0203'}">반려</c:when>
                                        <c:otherwise>알 수 없음</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <c:if test="${not empty licenseVO.rejContent}">
                                <label class="col-sm-2 col-form-label"><font size="4">반려 사유</font></label>
                                <div class="col-sm-10">
                                    <p class="form-control-plaintext">${licenseVO.rejContent}</p>
                                </div>
                            </c:if>
                            <c:choose>
                                <c:when test="${licenseVO.comdetCNo eq 'C0201'}">
                                    <label class="col-sm-2 col-form-label"><font size="4">첨부파일</font></label>
                                    <div class="col-sm-10">
                                        <c:if test="${not empty fileList}">
                                            <c:forEach var="file" items="${fileList}">
                                                <c:url value="/common/fileDownload.do?${_csrf.parameterName}=${_csrf.token}" var="downloadUrl">
                                                    <c:param name="fileGroupNo" value="${file.fileGroupNo}" />
                                                    <c:param name="fileNo" value="${file.fileNo}" />
                                                </c:url>
                                                <a class="col-sm-4" style="font-size: 1.1rem;" href="${downloadUrl}">${file.fileName}</a><br/>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty fileList}">
                                            <span class="col-sm-4" style="font-size: 1.1rem;">첨부파일 없음</span>
                                        </c:if>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <label class="col-sm-2 col-form-label"><font size="4">첨부파일</font></label>
                                    <div class="col-sm-5">
                                        <input type="file" class="form-control" name="licFile" id="file">
                                    </div>
                                    <div class="col-sm-5">
                                        <c:if test="${not empty fileList}">
                                            <c:forEach var="file" items="${fileList}">
                                                <label class="col-sm-12 col-form-label" id="fileLabel">
                                                    첨부파일 : 
                                                    <a class="link-primary" href="/common/fileDownload.do?fileGroupNo=${file.fileGroupNo}&fileNo=${file.fileNo}&${_csrf.parameterName}=${_csrf.token}">
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
                                </c:otherwise>
                            </c:choose>
                        </div>
                   </form>
                </div>
                <hr class="my-0">
                <div class="card-footer">
                    <!-- 목록 버튼 -->
                    <button type="button" class="btn btn-dark" id="listBtn">목록</button>
                    <c:if test="${licenseVO.comdetCNo eq 'C0202' || licenseVO.comdetCNo eq 'C0203'}">
                        <button type="button" class="btn btn-primary" id="modifyBtn">수정</button>
                    </c:if>
                    <c:if test="${licenseVO.comdetCNo eq 'C0202'}">
                        <button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <sec:csrfInput/>
</div>
<form method="post" action="/student/licenseDelete" id="deleteForm">
    <sec:csrfInput/>
    <input type="hidden" value="${licenseVO.licNo}" name="licNo">
</form>

<script>
$(function(){
    // 목록 버튼 클릭 이벤트
    $("#listBtn").click(function(){
        location.href="/student/myLicenseList";
    });

    // 미승인된거 삭제 처리
    $("#deleteBtn").click(function(){
        if(confirm('자격증 신청 내역을 삭제 하시겠습니까?')){
            $("#deleteForm").submit();
        }
    });

    // 수정 버튼 클릭 이벤트
    $("#modifyBtn").click(function(){
        $("#formData").submit();
    });

    // 파일 첨부변경시 보이는 태그 다르게 하기 위해
    var fileLabel = $("#fileLabel");
    
    // 파일 첨부파일 변경시
    $("#file").on("change", function(){
        var fileName = $("#file").val().split("\\").pop();
        fileLabel.find("a").html(fileName);
        fileLabel.find("a").attr("href", "#"); // 수정 시 다운로드 불가
    });
})
</script>
</body>
</html>
