<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<style>
    .table-responsive {
        overflow-x: auto;
    }
    .table-hover th, .table-hover td {
        text-align: center;
    }
    .btn-register, .btn-apply {
        display: block;
        margin: 20px 0;
        width: 150px;
        float: right;
    }
    .form-select, .form-control {
        height: 38px;
        padding: 6px 12px;
    }
    .searchHeader {
        background: #dddddd;
        padding: 1% 2% 0% 2%;
        border-radius: 10px;
        margin-bottom: 0; /* 검색 섹션과 테이블 간의 여백 제거 */
    }
    .input-group-text {
        height: 38px;
    }
    #searchBtn {
        font-weight: bold;
        background: skyblue;
        height: 38px;
    }
    .pagination {
        justify-content: center;
    }
</style>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
           <div class="card mb-4 bg-white">
            <h5 class="card-header" style="text-align: left;">장학 > 장학 종류 </h5>
           	<hr class="my-0"> 
            <div class="card mb-4 bg-white">
                <div class="card-header searchHeader">
                    <form action="/student/scholarshipList" method="get" id="searchFrm">
                        <div class="row mb-3" id="searchDiv">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <label class="input-group-text" for="typeSelect">장학종류</label>
                                    <select class="form-select" id="typeSelect" name="type">
                                        <option value="전체" ${selectedType == '전체' ? 'selected' : ''}>전체</option>
                                        <option value="선차감" ${selectedType == '선차감' ? 'selected' : ''}>선차감</option>
                                        <option value="후지급" ${selectedType == '후지급' ? 'selected' : ''}>후지급</option>
                                    </select>
                                    <label class="input-group-text" for="searchName">장학금명</label>
                                    <input type="text" class="form-control" placeholder="장학금명 검색" id="searchName" name="searchName" value="${searchName}">
                                    <button class="btn btn-outline" id="searchBtn">검색</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <hr class="my-0">
                <div class="table-responsive text-nowrap">
                    <table class="table table-hover">
                        <thead class="thead">
                            <tr>
                            	<th width="10%">No</th>
                                <th width="30%">장학금명</th>
                                <th width="20%">장학종류</th>
                                <th width="10%" style="text-align: right;">장학금액</th>
                                <th width="20%">상세보기</th>
                                <th width="10%">신청</th>
                            </tr>
                        </thead>
                        <tbody class="table-border-bottom-0 tbody">
                            <c:forEach var="scholarship" items="${scholarshipList}">
                                <tr>
                                	<td width="10%">${scholarship.rnum}</td>
                                    <td width="30%">${scholarship.schName}</td>
                                    <td width="20%">${scholarship.schType}</td>
                                    <td width="10%" style="text-align: right;">
                                    <fmt:formatNumber value="${scholarship.schAmount}" pattern="#,###" />원</td>
                                    <td width="20%"><a class='btn btn-secondary detailBtn' href='/student/scholarshipDetail?schNo=${scholarship.schNo}'>상세보기</a></td>
                                    <td width="10%">
                                        <form method="get" action="/student/scholarshipRequestInsertForm">
                                            <input type="hidden" name="schNo" value="${scholarship.schNo}">
                                            <button type="submit" class="btn btn-primary">신청</button>
                                        </form>
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
</div>
<script>
$(function(){
    // 필터링 기능
    $("#typeSelect").on("change", function(){
        var typeValue = $("#typeSelect").val();
        var searchName = $("#searchName").val();
        var queryString = "?type=" + typeValue + "&searchName=" + searchName;
        location.href = "/student/scholarshipList" + queryString;
    });

    // 검색 기능
    $("#basic-addon-search31").on("click", function(){
        $("#filterForm").submit();
    });
});
</script>
