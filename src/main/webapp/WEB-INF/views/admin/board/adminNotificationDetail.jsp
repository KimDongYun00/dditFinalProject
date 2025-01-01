<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
    <title>게시글 상세보기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="py-3 mb-4" style="font-weight:bold;">게시글 상세보기</h4>
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">게시글 정보</h5>
                <div class="card-body">
                    <form id="boardForm" method="post" enctype="multipart/form-data">
                        <sec:csrfInput />
                        <input type="hidden" name="boNo" value="${board.boNo}" />
                        <input type="hidden" name="fileGroupNo" id="fileGroupNoInput" value="${board.fileGroupNo}" />
                        <table class="table table-bordered">
                            <tr>
                                <th style="width: 20%">제목</th>
                                <td>
                                    <span id="boTitleSpan">${board.boTitle}</span>
                                    <input type="text" class="form-control d-none" id="boTitleInput" name="boTitle" value="${board.boTitle}">
                                </td>
                            </tr>
                            <tr>
                                <th>내용</th>
<!--                                 <td> --> 
<%--    									 <span id="boContentSpan">${board.boContent}</span> --%>
<%--    									 <textarea class="form-control d-none" id="boContentInput" name="boContent">${board.boContent}</textarea> --%>
<!-- 								</td> -->
								<td>
					                <span id="boContentSpan">${board.boContent}</span>
					                <textarea class="form-control d-none" id="boContentInput" name="boContent" rows="10">${board.boContent}</textarea>
					            </td>
													
                                
                            </tr>
                            <tr>
                                <th>조회수</th>
                                <td>${board.boCnt}</td>
                            </tr>
                            <tr>
                                <th>작성일</th>
                                <td>${board.boDate}</td>
                            </tr>
                           <tr>
                                <th>첨부 파일</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty board.fileGroupNo}">
                                            <span id="fileGroupNoSpan">${board.fileGroupNo}</span>
                                            <a href="${pageContext.request.contextPath}/admin/downloadFile?fileGroupNo=${board.fileGroupNo}" class="btn btn-info" id="downloadBtn">다운로드</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span>첨부된 파일이 없습니다.</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <input type="file" class="form-control d-none" id="fileInput" name="file">
                                </td>
                            </tr>
                        </table>
                        <div class="text-right">
                            <a href="${pageContext.request.contextPath}/admin/list" class="btn btn-primary">목록으로</a>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <button type="button" id="editBtn" class="btn btn-primary">수정</button>
                                <button type="button" id="saveBtn" class="btn btn-success d-none">저장</button>
                                <button type="button" id="cancelBtn" class="btn btn-secondary d-none">취소</button>
                            </sec:authorize>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    $('#editBtn').click(function() {
        $('#boTitleSpan, #boContentSpan, #fileGroupNoSpan').addClass('d-none');
        $('#boTitleInput, #boContentInput, #fileInput, #saveBtn, #cancelBtn').removeClass('d-none');
        $('#editBtn').addClass('d-none');
        $('.btn-primary').addClass('d-none'); 
        $('#downloadBtn').addClass('d-none'); 
    });

    $('#cancelBtn').click(function() {
        $('#boTitleSpan, #boContentSpan, #fileGroupNoSpan').removeClass('d-none');
        $('#boTitleInput, #boContentInput, #fileInput, #saveBtn, #cancelBtn').addClass('d-none');
        $('#editBtn').removeClass('d-none');
        $('.btn-primary').removeClass('d-none'); 
        $('#downloadBtn').removeClass('d-none'); 
    });

    $('#saveBtn').click(function() {
        var formData = new FormData($('#boardForm')[0]);

        $.ajax({
            url: '${pageContext.request.contextPath}/admin/updateAjax',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token); 
            },
            success: function(response) {
                if (response === 'success') {
                    alert('게시글 수정이 완료되었습니다!');
                    window.location.href = '${pageContext.request.contextPath}/admin/list';
                } else {
                    alert('게시글 수정에 실패했습니다.');
                }
            }
        });
    });
});
</script>
</body>
</html>
