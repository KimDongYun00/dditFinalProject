<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h3>공지게시판</h3>
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
                        <div class="card card-dark card-outline">
                            <div class="card-header">
                                <div class="card-tools">
                                    <form class="input-group input-group-sm"
                                        action="${pageContext.request.contextPath}/admin/list"
                                        method="get" id="searchForm" style="width: 440px;">
                                        <input type="hidden" name="page" value="${param.page}" id="page" /> 
                                        <input type="text" name="keyword" class="form-control float-right" value="${param.keyword}" placeholder="Search" />
                                        <div class="input-group-append">
                                            <button type="button" id="btnSearch" class="btn btn-default">
                                                <i class="fas fa-search"></i> 검색
                                            </button>
                                        </div>
                                        <sec:csrfInput />
                                    </form>
                                </div>
                            </div>
                            <div class="card-body">
                                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/delete" method="post">
                                    <table class="table table-bordered">
                                        <thead class="table-white">
                                            <tr>
                                                <th style="width: 5%"><input type="checkbox" id="selectAll"></th>
                                                <th style="width: 6%">번호</th>
                                                <th style="width: 50%">제목</th>
<!--                                                 <th style="width: 12%">작성자</th> -->
                                                <th style="width: 12%">조회수</th>
                                                <th style="width: 10%">작성일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="board" items="${boardList}" varStatus="status">
                                                <tr>
                                                    <td><input type="checkbox" name="selectedIds" value="${board.boNo}"></td>
                                                    <td>${board.rnum}</td>
                                                    <td><a href="${pageContext.request.contextPath}/admin/detail/${board.boNo}"><c:out value="${board.boTitle}" /></a></td>
<%--                                                     <td><c:out value="${board.empNo}" /></td> --%>
                                                    <td><c:out value="${board.boCnt}" /></td>
                                                    <td><c:out value="${board.boDate}" /></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="text-right mt-2">
                                        <button type="submit" class="btn btn-primary">삭제</button>
                                        <sec:csrfInput />
<!--                                     </div> -->
<!--                                     <div class="text-right mt-2"> -->
                                   		<a href="${pageContext.request.contextPath}/admin/insert" class="btn btn-primary">등록</a>
<%--                                    		 ${paginationInfoVO.pagingHTML} --%>
                                	</div>
                                </form>
                                <div class="text-right">
                                    ${paginationInfoVO.pagingHTML}
                                </div>
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

        // 일괄 선택 체크박스
        $("#selectAll").on("click", function() {
            $('input[name="selectedIds"]').prop('checked', this.checked);
        });

        $('input[name="selectedIds"]').on("click", function() {
            if ($('input[name="selectedIds"]:checked').length == $('input[name="selectedIds"]').length) {
                $('#selectAll').prop('checked', true);
            } else {
                $('#selectAll').prop('checked', false);
            }
        });

        // 선택 삭제 버튼 클릭
        $("#deleteForm").on("submit", function(event) {
            if ($('input[name="selectedIds"]:checked').length == 0) {
                event.preventDefault();
                alert("삭제할 게시글을 선택해주세요.");
            }
        });
    });
</script>
