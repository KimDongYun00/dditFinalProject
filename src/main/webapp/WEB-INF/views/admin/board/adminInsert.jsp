<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="py-3 mb-4" style="font-weight:bold;">게시글 등록</h4>
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">게시글 정보</h5>
                <div class="card-body">
                    <form id="boardForm" method="post" action="${pageContext.request.contextPath}/admin/insert" enctype="multipart/form-data">
                        <sec:csrfInput/>
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label" for="boTitle"><font size="4">제목</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="boTitle" name="boTitle" required>
                            </div>
<!--                             <label class="col-sm-2 col-form-label" for="empNo"><font size="4">작성자</font></label> -->
<!--                             <div class="col-sm-10"> -->
<!--                                 <input type="text" class="form-control" id="empNo" name="empNo" required> -->
<!--                             </div> -->
                            <label class="col-sm-2 col-form-label" for="boContent"><font size="4">내용</font></label>
                            <div class="col-sm-10">
                                <textarea class="form-control" id="boContent" name="boContent" rows="10" required></textarea>
                            </div>
                            <label class="col-sm-2 col-form-label" for="file"><font size="4">첨부 파일</font></label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" id="file" name="file">
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/admin/list" class="btn btn-secondary">취소</a>
                            <button type="button" id="fastBtn" class="btn btn-primary">시연용</button>
                            <button type="submit" class="btn btn-primary">저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
$(function(){
	$("#fastBtn").click(function(){
		$("#boTitle").val("문과의 꽃 경영학과가 개설되었습니다.");
		var html = "문과의 꽃 경영학과가 개설되었습니다.\n";
		html += "경영학과는 각종 여러 회사들과 연계가 되어있는 과입니다.";
		html += "취업에도 많은 도움이 되니 많은 관심 부탁드립니다.";
		$("#boContent").html(html);
	});
});
</script>
</html>
