<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
</head>
<body>
    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">공지사항 상세보기</h4>
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4 bg-white">
                    <h5 class="card-header">공지사항 상세 정보</h5>
                    <div class="card-body">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label"><font size="4">제목</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" value="${board.boTitle}" readonly="readonly">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label"><font size="4">작성자</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" value="${board.empNo}" readonly="readonly">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label"><font size="4">내용</font></label>
                            <div class="col-sm-10">
                                <textarea rows="10" class="form-control" readonly="readonly">${board.boContent}</textarea>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label"><font size="4">조회수</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" value="${board.boCnt}" readonly="readonly">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label"><font size="4">작성일</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" value="${board.boDate}" readonly="readonly">
                            </div>
                        </div>
                         <div class="form-group row">
                            <label class="col-sm-2 col-form-label"><font size="4">첨부 파일</font></label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${not empty board.fileGroupNo}">
                                        <span id="fileGroupNoSpan">${board.fileGroupNo}</span>
                                        <a href="${pageContext.request.contextPath}/professor/downloadFile?fileGroupNo=${board.fileGroupNo}" class="btn btn-primary" id="downloadBtn">다운로드</a>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="form-control" value="첨부된 파일이 없습니다." readonly="readonly">
                                    </c:otherwise>
                                </c:choose>
                                <input type="file" class="form-control d-none" id="fileInput" name="file">
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/professor/notificationList" class="btn btn-primary">목록으로</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        $(function(){
            $("#listBtn").on('click', function(){
                location.href="${pageContext.request.contextPath}/professor/notificationList";
            });
        });
    </script>
</body>
</html>
