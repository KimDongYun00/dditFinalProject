<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="py-3 mb-4" style="font-weight:bold;">자유게시판</h4>
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">게시글 정보</h5>
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
                            <span id="spnFreeContent">${freeboard.freeContent}</span>
                            <input type="text" name="freeContent" id="freeContent" class="form-control"
                                   value="${freeboard.freeContent}" aria-describedby="defaultFormControlHelp"
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
                    <a href="${pageContext.request.contextPath}/admin/freeList" class="btn btn-primary">목록으로</a>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <span id="spnGen">
                            <form id="deleteForm" action="${pageContext.request.contextPath}/admin/freeDelete" method="post">
                                <input type="hidden" name="freeNo" value="${freeboard.freeNo}">
                                <sec:csrfInput />
                            </form>
                        </span>
                        <span id="spnEdit" style="display:none;">
                            <button id="saveBtn" class="btn btn-primary" onclick="saveFreeBoard()">저장</button>
                            <button id="cancelBtn" type="button" class="btn btn-secondary" onclick="cancelFreeBoard()">취소</button>
                        </span>
                    </sec:authorize>
                </div>
            </div>

            <div class="card mb-4 bg-white">
                <h5 class="card-header">댓글</h5>
                <div class="card-body">
                    <!-- 댓글 목록 -->
                    <c:forEach var="comment" items="${commentList}">
                        <div class="border">
                            <strong>${comment.fcWriter}</strong> (${comment.fcDate})
                            <p id="commentContent-${comment.fcNo}">${comment.fcContent}</p>
                            
                            <div id="commentForm-${comment.fcNo}" style="display: none;">
                                <form action="${pageContext.request.contextPath}/admin/freeCommentUpdate" method="post">
                                    <input type="hidden" name="fcNo" value="${comment.fcNo}">
                                    <input type="hidden" name="freeNo" value="${freeboard.freeNo}">
                                    <div class="form-group">
                                        <label for="fcContent-${comment.fcNo}">내용</label>
                                        <textarea class="form-control" id="fcContent-${comment.fcNo}" name="fcContent" rows="3">${comment.fcContent}</textarea>
                                    </div>
                                    <button type="button" class="btn btn-secondary" onclick="commentCancel(${comment.fcNo})">취소</button>
                                    <sec:csrfInput />
                                </form>
                            </div>
                            
                            <form id="deleteForm-${comment.fcNo}" action="${pageContext.request.contextPath}/admin/freeCommentDelete" method="post" style="display: inline;">
                                <input type="hidden" name="fcNo" value="${comment.fcNo}">
                                <input type="hidden" name="freeNo" value="${freeboard.freeNo}">
                                <button type="submit" class="btn btn-link btn-sm">삭제</button>
                                <sec:csrfInput />
                            </form>
                        </div>
                    </c:forEach>
                    
                    <!-- 댓글 작성 폼 -->
                    <form action="${pageContext.request.contextPath}/admin/freeCommentInsert" method="post">
                        <input type="hidden" name="freeNo" value="${freeboard.freeNo}">
                        <input type="hidden" name="userNo" value="${user.username}">
                        <input type="hidden" name="fcWriter" value="${user.username}">
                        <div class="form-group">
                            <label for="fcContent">내용</label>
                            <textarea class="form-control" id="fc_content" name="fcContent" rows="3"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">등록</button>
                        <sec:csrfInput/>
                    </form>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function saveFreeBoard(){
        let freeNo = "${freeboard.freeNo}";
        let freeTitle = $("#freeTitle").val();
        let freeContent = $("#freeContent").val();
        
        //json오브젝트
        let data = {
            "freeNo":freeNo,    
            "freeTitle":freeTitle,    
            "freeContent":freeContent
        };
        
        $.ajax({
            url:"/admin/freeUpdate",
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
</script>
</body>
</html>
