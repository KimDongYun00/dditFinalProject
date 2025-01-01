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
                        <form name="frm" action="/student/freeWrite" method="post" onsubmit="event.preventDefault(); insertAlert();">
                            <sec:csrfInput/>
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input type="text" class="form-control" id="title" name="freeTitle" required>
                            </div>
                            <div class="form-group">
                                <label for="writer">작성자</label>
                                <input type="text" class="form-control" id="writer" name="freeWriter" required>
                            </div>
                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea class="form-control" id="content" name="freeContent" rows="10" required></textarea>
                            </div>
                            <div class="card-footer">
                                <button type="submit" class="btn btn-primary">저장</button>
                                <a href="${pageContext.request.contextPath}/student/freeList" class="btn btn-secondary">취소</a>
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
