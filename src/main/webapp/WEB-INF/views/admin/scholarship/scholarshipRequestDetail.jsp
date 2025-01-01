<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
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
    .card-footer {
        text-align: left;
    }
</style>
<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">장학 관리 > 장학 신청 및 수혜 내역 > 상세조회</h5>
                <hr class="my-0">
                <div class="card-body">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label"><font size="4">장학금명</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.schName}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">신청인</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.stuNo}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">장학종류</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.schType}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">장학조건</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.schReq}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">장학금액</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext"> <fmt:formatNumber value="${scholarshipVO.schAmount}" pattern="#,###" />원</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">년도</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.year}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">학기</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.semester}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">신청일자</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">${scholarshipVO.schAplDate}</p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">수혜일자</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">
                                <c:choose>
                                    <c:when test="${scholarshipVO.schRecDate == null || ''}"><font>미지급</font></c:when>
                                    <c:when test="${scholarshipVO.schRecDate != null}">${scholarshipVO.schRecDate}</c:when>
                                </c:choose>
                            </p>
                        </div>
                        <label class="col-sm-2 col-form-label"><font size="4">처리 현황</font></label>
                        <div class="col-sm-10">
                            <p class="form-control-plaintext">
                                <c:choose>
                                    <c:when test="${scholarshipVO.comDetCNo == 'C0201'}">승인완료</c:when>
                                    <c:when test="${scholarshipVO.comDetCNo == 'C0202'}">미승인</c:when>
                                    <c:when test="${scholarshipVO.comDetCNo == 'C0203'}">반려</c:when>
                                </c:choose>
                            </p>
                        </div>
                        <c:choose>
                            <c:when test="${scholarshipVO.rejContent != null && !scholarshipVO.rejContent.isEmpty()}">
                                <label class="col-sm-2 col-form-label"><font size="4">반려사유</font></label>
                                <div class="col-sm-10">
                                    <p class="form-control-plaintext">${scholarshipVO.rejContent}</p>
                                </div>
                            </c:when>
                        </c:choose>
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
                    <c:if test="${scholarshipVO.comDetCNo == 'C0202'}">
                        <form action="/admin/scholarshipRequestApprove" method="post" style="display: inline-block; margin-left: 10px;">
                            <sec:csrfInput />
                            <input type="hidden" name="schRecNo" value="${scholarshipVO.schRecNo}">
                            <button type="submit" class="btn btn-success">승인 처리</button>
                        </form>
                        <button type="button" class="btn btn-info" id="waitBtn" style="display: inline-block; margin-left: 10px;">반려 처리</button>
                    </c:if>
                    <c:if test="${scholarshipVO.comDetCNo == 'C0203'}">
                        <form action="/admin/scholarshipRequestApprove" method="post" style="display: inline-block; margin-left: 10px;">
                            <sec:csrfInput />
                            <input type="hidden" name="schRecNo" value="${scholarshipVO.schRecNo}">
                            <button type="submit" class="btn btn-success">승인 처리</button>
                        </form>
                    </c:if>
                    <button type="button" class="btn btn-dark" id="listBtn">목록</button>
                </div>
            </div>
        </div>
    </div>
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
                <button type="button" class="btn btn-primary" id="confirmRejectBtn">반려 처리</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<form id="rejectForm" action="/admin/scholarshipRequestWait" method="post">
    <sec:csrfInput />
    <input type="hidden" name="schRecNo" id="rejectSchRecNo" value="${scholarshipVO.schRecNo}">
    <input type="hidden" name="rejContent" id="rejectRejContent">
</form>

<script>
$(function(){
    $("#listBtn").click(function(){
        location.href="/admin/scholarshipRequestList";
    });

    $("#waitBtn").click(function(){
        $("#rejectReasonModal").modal("show");
    });

    $("#confirmRejectBtn").click(function(){
        var rejectReason = $("#rejectReason").val();

        if(rejectReason.trim() === "") {
            alert("반려 사유를 입력해주세요.");
            return;
        }

        if(confirm("해당 장학금 신청을 반려 처리하시겠습니까?")){
            $("#rejectRejContent").val(rejectReason);
            $("#rejectForm").submit();
        }
    });
});
</script>
