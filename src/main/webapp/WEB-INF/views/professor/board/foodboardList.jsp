<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h3>맛집 게시판 > 목록</h3>
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
                                        action="${pageContext.request.contextPath}/professor/foodList"
                                        method="get" id="searchForm" style="width: 440px;">
                                        <input type="hidden" name="page" value="${param.page}" id="page" /> 
                                        <input type="text" name="keyword" class="form-control float-right" value="${param.keyword}" placeholder="Search" />
                                        <div class="input-group-append">
                                            <button type="button" id="btnSearch" class="btn btn-default">
                                                검색
                                            </button>
                                        </div>
                                        <sec:csrfInput />
                                    </form>
                                </div>
                            </div>
                            <div class="card-body"> 
                                <sec:authorize access="isAuthenticated()">
                                </sec:authorize>
                                <table class="table table-bordered">
                                    <thead class="table-white">
                                        <tr>
                                            <th style="width: 6%">번호</th>
                                            <th style="width: 50%">제목</th>
                                            <th style="width: 12%">작성자</th>
                                            <th style="width: 12%">작성일</th>
                                            <th style="width: 10%">추천</th>
                                            <th style="width: 10%">추천수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="food" items="${foodboardList}" varStatus="status">
                                            <tr>
                                                <td>${food.rnum}</td>
                                                <td><a href="${pageContext.request.contextPath}/professor/foodDetail/${food.foodNo}"><c:out value="${food.foodTitle}" /></a></td>
                                                <td><c:out value="${food.foodWriter}" /></td>
                                                <td><c:out value="${food.foodDate}" /></td>
                                                <td>
                                                    <button class="btn btn-primary" onclick="recommendFood('${food.foodNo}')">추천</button>
                                                </td>
                                                <td id="recommendCount_${food.foodNo}"><c:out value="${food.recommendCount}" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="text-right">
                                    ${paginationInfoVO.getPagingHTML()}
                                </div>
                                <div class="text-right">
                                    <a href="${pageContext.request.contextPath}/professor/foodInsert" class="btn btn-primary">새 글 등록</a>
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
    });

    function getCsrfToken() {
        return $('meta[name="_csrf"]').attr('content');
    }

    function recommendFood(foodNo) {
        $.ajax({
            type: 'POST',
            url: contextPath + '/professor/recommend/' + foodNo,
            headers: {
                'X-CSRF-TOKEN': getCsrfToken()
            },
            success: function(response) {
                if (response.status === 'success') {
                    alert(response.message); 
                    $('#recommendCount_' + foodNo).text(response.recommendCount); 
                } else {
                    alert(response.message); 
                }
            },
            error: function() {
                alert("추천에 실패하였습니다.");
            }
        });
    }

    var contextPath = '${pageContext.request.contextPath}';
</script>
