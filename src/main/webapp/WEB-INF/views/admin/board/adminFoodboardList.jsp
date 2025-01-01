<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}">
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .table-hover tbody tr:hover {
            background-color: #f5f5f5;
        }

        .input-group {
            display: flex;
            width: 300px;
        }

        .input-group .form-control {
            flex: 1;
        }

        .input-group .btn {
            flex: 0 0 auto;
        }
    </style>
</head>
<body>
<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="py-3 mb-4" style="font-weight:bold;">맛집 게시판</h4>
    <div class="row">
        <div class="col-xl-12">
            <form id="searchForm" class="input-group input-group-sm mb-3">
                <input type="hidden" name="page" value="${param.page}" id="page">
                <input type="text" name="keyword" class="form-control" value="${param.keyword}" placeholder="Search">
                <div class="input-group-append">
                    <button type="button" id="btnSearch" class="btn btn-default">검색</button>
                </div>
                <sec:csrfInput />
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card mb-4 bg-white">
                <div class="card-body">
                    <sec:authorize access="isAuthenticated()">
                    </sec:authorize>
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="selectAll" /></th>
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
                                    <td><input type="checkbox" name="foodNo" value="${food.foodNo}" /></td>
                                    <td>${food.rnum}</td>
                                    <td><a href="${pageContext.request.contextPath}/admin/foodDetail/${food.foodNo}"><c:out value="${food.foodTitle}" /></a></td>
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
                        <a href="${pageContext.request.contextPath}/admin/foodInsert" class="btn btn-primary">등록</a>
                        <button type="button" class="btn btn-primary" onclick="deleteSelectedPosts()">삭제</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function() {
        $(".page-link").on("click", function(event) {
            event.preventDefault();
            let page = $(this).data("page");
            $("#page").val(page);
            $("#searchForm").submit();
        });

        $("#btnSearch").on("click", function() {
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
            url: contextPath + '/admin/recommend/' + foodNo,
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

    function deleteSelectedPosts() {
        var selectedFoodNos = [];
        $('input[name="foodNo"]:checked').each(function() {
            selectedFoodNos.push($(this).val());
        });

        if (selectedFoodNos.length === 0) {
            alert("삭제할 게시글을 선택해주세요.");
            return;
        }

        if (!confirm("선택한 게시글을 삭제하시겠습니까?")) {
            return;
        }

        $.ajax({
            type: 'POST',
            url: contextPath + '/admin/foodBoardDeleteMulti',
            data: { foodNos: selectedFoodNos },
            traditional: true,
            headers: {
                'X-CSRF-TOKEN': getCsrfToken()
            },
            success: function(response) {
                if (response.status === 'success') {
                    alert(response.message);
                    location.reload();
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert("삭제에 실패하였습니다.");
            }
        });
    }

    $(function() {
        $("#selectAll").click(function() {
            $('input[name="foodNo"]').prop('checked', this.checked);
        });
    });

    var contextPath = '${pageContext.request.contextPath}';
</script>
</body>
</html>
