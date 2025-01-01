<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h3>자유게시판</h3>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right"></ol>
                    </div>
                </div>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card mb-4 bg-white">
                            <h5 class="card-header">게시글 목록</h5>
                            <div class="card-body">
                                <div class="card-tools">
                                    <form class="input-group input-group-sm mb-3"
                                        action="${pageContext.request.contextPath}/student/freeList"
                                        method="get" id="searchForm" style="width: 440px;">
                                        <input type="hidden" name="page" value="${param.page}" id="page" /> 
                                        <input type="text" name="keyword" class="form-control" value="${param.keyword}" placeholder="Search" />
                                        <div class="input-group-append">
                                            <button type="button" id="btnSearch" class="btn btn-default">
                                                검색
                                            </button>
                                        </div>
                                        <sec:csrfInput />
                                    </form>
                                </div>
                                <sec:authorize access="isAuthenticated()">
                                </sec:authorize>
                                <form id="deleteMultipleForm" action="${pageContext.request.contextPath}/admin/freeDeleteMultiple" method="post">
                                    <sec:csrfInput />
                                    <div class="table-responsive text-nowrap">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th style="width: 4%"><input type="checkbox" id="checkAll"></th>
                                                    <th style="width: 6%">번호</th>
                                                    <th style="width: 50%">제목</th>
                                                    <th style="width: 12%">작성자</th>
                                                    <th style="width: 12%">조회수</th>
                                                    <th style="width: 10%">작성일</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="board" items="${freeboardList}" varStatus="status">
                                                    <tr>
                                                        <td><input type="checkbox" name="freeNoList" value="${board.freeNo}"></td>
                                                        <td>${board.rnum}</td>
                                                        <td><a href="${pageContext.request.contextPath}/student/freeDetail/${board.freeNo}"><c:out value="${board.freeTitle}" /></a></td>
                                                        <td><c:out value="${board.freeWriter}" /></td>
                                                        <td><c:out value="${board.freeCnt}" /></td>
                                                        <td><c:out value="${board.freeDate}" /></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="card-footer clearfix" align="right">
                                        ${paginationInfoVO.pagingHTML}
                                    </div>
                                    <div class="text-right mt-2">
                                        <a href="${pageContext.request.contextPath}/student/freeWrite" class="btn btn-primary">새 글 등록</a>
                                        <button type="submit" class="btn btn-secondary">삭제</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function(){
        $("#checkAll").click(function(){
            $('input[name="freeNoList"]').prop('checked', this.checked);
        });

        $('input[name="freeNoList"]').click(function(){
            if ($('input[name="freeNoList"]:checked').length == $('input[name="freeNoList"]').length) {
                $('#checkAll').prop('checked', true);
            } else {
                $('#checkAll').prop('checked', false);
            }
        });

        $(".page-link").on("click",function(event){
            event.preventDefault();
            let page = $(this).data("page");
            $("#page").val(page);
            $("#searchForm").submit();
        });
        
        $("#btnSearch").on("click",function(){
            $("#page").val(1);
            $("#searchForm").submit();
        });
    });
</script>

