<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<style>
  .card-header {
    text-align: left;
  }
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
  .card-footer {
    text-align: left;
  }
</style>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">자격증 관리 > 자격증 신청 > 상세 조회</h5>
                <hr class="my-0">
                <div class="card-body">
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
                            <p class="form-control-plaintext">${licenseVO.licDate}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">유효기간</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${licenseVO.licLimit}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">처리 현황</font></label>
                        <div class="col-sm-10">
                            <c:choose>
                                <c:when test="${licenseVO.comdetCNo == 'C0201'}">승인완료</c:when>
                                <c:when test="${licenseVO.comdetCNo == 'C0202'}">미승인</c:when>
                                <c:when test="${licenseVO.comdetCNo == 'C0203'}">반려</c:when>
                            </c:choose>
                        </div>
                        
                        <c:if test="${not empty licenseVO.rejContent}">
                        <label class="col-sm-2 col-form-label"><font size="4">반려 사유</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${licenseVO.rejContent}</p>
                        </div>
                        </c:if>
                        <c:set value="${licenseVO.licFileList}" var="file" />
                        <c:url
                            value="/common/fileDownload.do?${_csrf.parameterName}=${_csrf.token}"
                            var="downloadUrl">
                            <c:param name="fileGroupNo" value="${file.fileGroupNo}" />
                            <c:param name="fileNo" value="${file.fileNo}" />
                        </c:url>
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
                    </div>
                </div>
                <hr class="my-0">
                <div class="card-footer">
                    <c:if test="${licenseVO.comdetCNo == 'C0202'}">
                        <button type="button" class="btn btn-success approveBtn" id="approveBtn" style="display: inline-block; margin-left: 10px;">승인 처리</button>
                        <button type="button" class="btn btn-info waitBtn" style="display: inline-block; margin-left: 10px;" data-bs-toggle="modal" data-bs-target="#rejectReasonModal">반려 처리</button>
                    </c:if>
                    <button type="button" class="btn btn-dark" id="listBtn">목록</button>
                    <c:if test="${licenseVO.comdetCNo == 'C0203'}">
                        <button type="button" class="btn btn-success approveBtn" id="approveBtn" style="display: inline-block; margin-left: 10px;">승인 처리</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <sec:csrfInput/>
</div>

<div class="modal fade" id="rejectReasonModal" tabindex="-1" aria-labelledby="rejectReasonModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="rejectReasonModalLabel">반려 사유 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <textarea id="rejectReason" class="form-control" rows="4" placeholder="반려 사유를 입력하세요"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="confirmRejectBtn">반려 처리</button>
      </div>
    </div>
  </div>
</div>

<form id="rejectForm" action="/admin/licenseRequestWait" method="post">
    <sec:csrfInput />
    <input type="hidden" name="licNo" id="rejectLicNo">
    <input type="hidden" name="rejContent" id="rejectRejContent">
</form>

<script>
$(function() {
    var licNo = '${licenseVO.licNo}';
    
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    
    // 목록 버튼 클릭 이벤트
    $("#listBtn").click(function() {
        location.href = "/admin/licenseList";
    });

    // 승인 버튼 클릭 이벤트
    $("#approveBtn").click(function() {
        if(confirm("해당 자격증 신청을 승인 처리하시겠습니까?")) {
            $.ajax({
                url: "/admin/licenseRequestApprove",
                type: "POST",
                beforeSend: function(xhr) {   // 데이터 전송 전, 헤더에 csrf 값 설정
                    xhr.setRequestHeader(header, token);
                },
                data: { licNo: licNo },
                success: function(response) {
                    alert("해당 자격증 신청에 대한 승인이 처리되었습니다.");
                    location.reload(true);
                },
                error: function(xhr) {
                    alert("승인 처리 중 오류가 발생했습니다.");
                }
            });
        }
    });

    // 반려 버튼 클릭 이벤트
    $("#confirmRejectBtn").click(function() {
        var rejectReason = $("#rejectReason").val();
        
        if(rejectReason.trim() === "") {
            alert("반려 사유를 입력해주세요.");
            return;
        }

        if(confirm("해당 자격증 신청을 반려 처리하시겠습니까?")) {
            $.ajax({
                url: "/admin/licenseRequestWait",
                type: "POST",
                beforeSend: function(xhr) {   // 데이터 전송 전, 헤더에 csrf 값 설정
                    xhr.setRequestHeader(header, token);
                },
                data: {
                    licNo: licNo,
                    rejContent: rejectReason
                },
                success: function(response) {
                    alert("반려 처리되었습니다.");
                    location.reload(true);
                },
                error: function(xhr) {
                    alert("반려 처리 중 오류가 발생했습니다.");
                }
            });
        }
    });
});
</script>
