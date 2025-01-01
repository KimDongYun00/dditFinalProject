<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
    <title>새 글 쓰기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="py-3 mb-4" style="font-weight:bold;">새 글 쓰기</h4>
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">게시글 작성</h5>
                <div class="card-body">
                    <form name="frm" action="/admin/freeWrite" method="post" onsubmit="event.preventDefault(); insertAlert();">
                        <sec:csrfInput/>
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label" for="title"><font size="4">제목</font></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="title" name="freeTitle" required>
                            </div>
                            <input type="hidden" id="writer" name="freeWriter" value="${user.username}">
                            <input type="hidden" id="userNo" name="userNo" value="${user.username}">
                            <label class="col-sm-2 col-form-label" for="content"><font size="4">내용</font></label>
                            <div class="col-sm-10">
                                <textarea class="form-control" id="content" name="freeContent" rows="10" required></textarea>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary">저장</button>
                            <a href="${pageContext.request.contextPath}/admin/freeList" class="btn btn-secondary">취소</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
 <script>
        function insertAlert() {
            alert("등록이 완료되었습니다!");
            document.frm.submit();
        }
    </script>
</body>
</html>
