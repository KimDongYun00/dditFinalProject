<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
	/* 모달 스타일  */
.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
    justify-content: center;
    align-items: center;
}

.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 500px; 
    border-radius: 8px;
    position: relative;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
.text-right {
    text-align: right;
}

/* 신고 버튼 위치 */
.flex-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
</style>
</head>
<body>
    <section class="content-header">
        <div class="container-xxl">
        </div>
    </section>

    <section class="content">
        <div class="container-xxl">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">게시글 정보</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-group row">
                                <label for="freeTitle" class="col-sm-2 col-form-label">제목</label>
                                <div class="col-sm-10">
                                    <span id="spnFreeTitle">${freeboard.freeTitle}</span>
                                    <input type="text" name="freeTitle" id="freeTitle" class="form-control"
                                           value="${freeboard.freeTitle}" aria-describedby="defaultFormControlHelp"
                                           style="display:none;" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="freeWriter" class="col-sm-2 col-form-label">작성자</label>
                                <div class="col-sm-10">
                                    <p class="form-control-plaintext">${freeboard.freeWriter}</p>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="freeContent" class="col-sm-2 col-form-label">내용</label>
                                <div class="col-sm-10">
                                    <span id="spnFreeContent"><c:out value="${freeboard.freeContent}"></c:out></span>
                                    <input type="text" name="freeContent" id="freeContent" class="form-control"
                                           value="<c:out value="${freeboard.freeContent}"></c:out>" aria-describedby="defaultFormControlHelp"
                                           style="display:none;" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="freeCnt" class="col-sm-2 col-form-label">조회수</label>
                                <div class="col-sm-10">
                                    <p class="form-control-plaintext">${freeboard.freeCnt}</p>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="freeDate" class="col-sm-2 col-form-label">작성일</label>
                                <div class="col-sm-10">
                                    <p class="form-control-plaintext">${freeboard.freeDate}</p>
                                </div>
                            </div>
                            
                            <div class="flex-container">
                                <a href="${pageContext.request.contextPath}/student/freeList" class="btn btn-primary">목록으로</a>
                                <button id="reportBtn" class="btn btn-danger mt-4" onclick="document.getElementById('reportModal').style.display='flex'">신고</button>
                            </div>
                            
                            <sec:authorize access="hasRole('ROLE_STUDENT')">
                                <sec:authentication property="principal.user.userNo" var="userNo" />
                                <c:if test="${freeboard.userNo == userNo}">
                                    <span id="spnGen">
                                        <button id="editBtn" class="btn btn-primary" onclick="editFreeBoard()">수정</button>
                                        <form id="deleteForm" action="${pageContext.request.contextPath}/student/freeDelete" method="post">
                                            <input type="hidden" name="freeNo" value="${freeboard.freeNo}">
                                            <button type="submit" id="boardCancelBtn" class="btn btn-danger">삭제</button>
                                            <sec:csrfInput />
                                        </form>
                                    </span>
                                    <span id="spnEdit" style="display:none;">
                                        <button id="saveBtn" class="btn btn-primary" onclick="saveFreeBoard()">저장</button>
                                    </span>
                                </c:if>
                            </sec:authorize>
                        </div>
                    </div>

                    <div class="card mt-4">
                        <div class="card-header">
                            <h3 class="card-title">댓글</h3>
                        </div>
                        <div class="card-body">
                            <c:forEach var="comment" items="${commentList}">
                                <div class="border p-2 mb-2">
                                    <strong>${comment.fcWriter}</strong> (${comment.fcDate})
                                    <p id="commentContent-${comment.fcNo}">${comment.fcContent}</p>
                                    <div id="commentForm-${comment.fcNo}" style="display: none;">
                                        <form action="${pageContext.request.contextPath}/student/freeCommentUpdate" method="post">
                                            <input type="hidden" name="fcNo" value="${comment.fcNo}">
                                            <input type="hidden" name="freeNo" value="${freeboard.freeNo}">
                                            <div class="form-group mt-2">
                                                <label for="fcContent-${comment.fcNo}">내용</label>
                                                <textarea class="form-control" id="fcContent-${comment.fcNo}" name="fcContent" rows="3">${comment.fcContent}</textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary">댓글 수정</button>
                                            <button type="button" class="btn btn-secondary ml-2" onclick="commentCancel(${comment.fcNo})">취소</button>
                                            <sec:csrfInput />
                                        </form>
                                    </div>
                                    <button id="editBtn-${comment.fcNo}" type="button" class="btn btn-sm btn-link" onclick="commentUpdate('${comment.fcNo}')">수정</button>
                                    <form id="deleteForm-${comment.fcNo}" action="${pageContext.request.contextPath}/student/freeCommentDelete" method="post" style="display: inline;">
                                        <input type="hidden" name="fcNo" value="${comment.fcNo}">
                                        <input type="hidden" name="freeNo" value="${freeboard.freeNo}">
                                        <button type="submit" class="btn btn-sm btn-link">삭제</button>
                                        <sec:csrfInput />
                                    </form>
                                </div>
                            </c:forEach>
                            <form action="${pageContext.request.contextPath}/student/freeCommentInsert" method="post">
                                <input type="hidden" name="freeNo" value="${freeboard.freeNo}">
                                <div class="form-group mt-2">
                                    <label for="fcContent">내용</label>
                                    <textarea class="form-control" id="fc_content" name="fcContent" rows="3"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">등록</button>
                                <sec:csrfInput />
                            </form>
                        </div>
                    </div>
                    
                    <div id="reportModal" class="modal">
                        <div class="modal-content">
                            <span class="close" onclick="document.getElementById('reportModal').style.display='none'">&times;</span>
                            <form id="reportSubmitForm" action="${pageContext.request.contextPath}/student/report" method="post">
                                <input type="hidden" name="boardPkNo" value="${freeboard.freeNo}">
                                <div class="form-group">
                                    <label for="repReason">신고 사유</label>
                                    <textarea class="form-control" id="repReason" name="repReason" rows="5" required></textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" onclick="submitReport()">저장</button>
                                    <sec:csrfInput />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        function saveFreeBoard(){
            let freeNo = "${freeboard.freeNo}";
            let freeTitle = $("#freeTitle").val();
            let freeContent = $("#freeContent").val();
            
            let data = {
                "freeNo":freeNo,    
                "freeTitle":freeTitle,    
                "freeContent":freeContent
            };
            
            $.ajax({
                url:"/student/freeUpdate",
                contentType:"application/json;charset=utf-8",
                data:JSON.stringify(data),
                type:"post",
                dataType:"json",
                beforeSend:function(xhr){
                    xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                },
                success:function(result){
                    $("#freeTitle").css("display","none");
                    $("#spnFreeTitle").css("display","block");
                    $("#spnFreeTitle").html(result.freeTitle);
                    $("#freeContent").css("display","none");
                    $("#spnFreeContent").css("display","block");
                    $("#spnFreeContent").html(result.freeContent);
                    $("#spnGen").css("display","block");
                    $("#spnEdit").css("display","none");
                }
            });
        }

        function editFreeBoard(){
            $("#freeTitle").css("display","block");
            $("#spnFreeTitle").css("display","none");
            $("#freeContent").css("display","block");
            $("#spnFreeContent").css("display","none");
            $("#spnGen").css("display","none");
            $("#spnEdit").css("display","block");
        }

        function cancelFreeBoard(){
            $("#freeTitle").css("display","none");
            $("#spnFreeTitle").css("display","block");
            $("#freeContent").css("display","none");
            $("#spnFreeContent").css("display","block");
            $("#spnGen").css("display","block");
            $("#spnEdit").css("display","none");
        }

        function commentUpdate(fcNo) {
            document.getElementById('commentContent-' + fcNo).style.display = 'none';
            document.getElementById('commentForm-' + fcNo).style.display = 'block';
            document.getElementById('editBtn-' + fcNo).style.display = 'none';
        }

        function commentCancel(fcNo) {
            document.getElementById('commentContent-' + fcNo).style.display = 'block';
            document.getElementById('commentForm-' + fcNo).style.display = 'none';
            document.getElementById('editBtn-' + fcNo).style.display = 'inline';
        }

        function submitReport() {
            if (confirm('정말로 신고하시겠습니까?')) {
                document.getElementById('reportSubmitForm').submit();
                alert('신고가 정상적으로 되었습니다!');
            }
        }

        $('#boardCancelBtn').on('click', function() {
            if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
                $('#deleteForm').submit();
            }
        });
    </script>
</body>
</html>
