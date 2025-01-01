<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>장학 신청 목록</title>
<style>
    .container-xxl {
        margin: auto;
        width: 80%;
        padding: 20px;
    }
    .card-header {
        font-size: 24px;
        text-align: center;
    }
    .table-responsive {
        overflow-x: auto;
    }
    .table-hover th, .table-hover td {
        text-align: center;
    }
    .btn-register {
        display: block;
        margin: 20px 0;
        margin-left: 77%;
        width: 150px;
        float: right;
    }
    .form-select, .form-control {
        margin-bottom: 20px;
        height: 38px;
        padding: 6px 12px;
    }
    .filter-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .filter-item {
        display: flex;
        align-items: center;
        margin-right: 10px;
    }
    .input-group-text {
        height: 38px;
    }
    .pagination {
        justify-content: center;
    }
</style>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="filter-container">
                <form id="filterForm" method="GET" action="/student/scholarshipList">
                    <div class="filter-item">
                        <select class="form-select" id="typeSelect" name="type" style="width: 150px;">
                            <option value="전체" ${selectedType == '전체' ? 'selected' : ''}>전체</option>
                            <option value="선차감" ${selectedType == '선차감' ? 'selected' : ''}>선차감</option>
                            <option value="후지급" ${selectedType == '후지급' ? 'selected' : ''}>후지급</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <div class="input-group input-group-merge">
                            <span class="input-group-text" id="basic-addon-search31"><i class="bx bx-search"></i></span>
                            <input type="text" class="form-control" placeholder="장학금명 검색" aria-label="Search..." aria-describedby="basic-addon-search31" id="searchName" name="searchName" value="${searchName}">
                        </div>
                    </div>
                    <div class="filter-item">
                        <button type="submit" class="btn btn-primary">검색</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">장학금 종류</h5>
                <hr class="my-0">
                <div class="table-responsive text-nowrap">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>장학금명</th>
                                <th>장학종류</th>
                                <th>장학금액</th>
                                <th>상세보기</th>
                            </tr>
                        </thead>
                        <tbody class="table-border-bottom-0" id="scholarshipTable">
                            <c:forEach var="scholarship" items="${scholarshipList}">
                                <tr>
                                    <td>${scholarship.schName}</td>
                                    <td>${scholarship.schType}</td>
                                    <td>${scholarship.schAmount}원</td>
                                    <td>
                                        <a class='btn btn-outline-primary detailBtn' href='/student/scholarshipDetail?schNo=${scholarship.schNo}'>상세보기</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
    $("#typeSelect").on("change", function(){
        var typeValue = $("#typeSelect").val();
        var searchName = $("#searchName").val();
        
        if(typeValue == "선차감"){
            location.href = "/student/preScholarshipList";
        } else if(typeValue == "후지급"){
            location.href = "/student/postScholarshipList";
        } else {
            $("#filterForm").submit();
        }
    });
});
</script>
