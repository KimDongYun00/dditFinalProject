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
    .hidden-col {
        display: none;
    }
    .info-section {
        background-color: white;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    .info-section p {
        margin: 0;
        font-size: 16px;
        font-weight: bold;
        color: #555;
    }
</style>
<div class="container-xxl flex-grow-1 container-p-y">
   <div class="card mb-4 bg-white">
    	 <h5 class="card-header" style="text-align: left; color: red;">유의사항</h5>
    	 <hr class="my-0"><br>
    	<ul>
            <li>장학금 신청 승인/반려 건에 한해 신청 학기, 년도, 첨부 파일 수정이 가능합니다.</li>
            <li>승인 완료된 건에 대해서는 수정이 불가능합니다.</li>
            <li>관련 문의는 담당자(042-123-4567)에게 연락 바랍니다.</li>
        </ul>
    </div>
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align: left;">장학 신청 및 수혜 내역 조회</h5>
                <hr class="my-0">
                <div class="card-header searchHeader">
                    <form id="filterForm" method="GET" action="/student/myScholarshipList">
                        <div class="row mb-3" id="searchDiv">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <label class="input-group-text" for="typeSelect">처리현황</label>
                                    <select class="form-select" id="typeSelect" name="type">
                                        <option value="전체" ${selectedType == '전체' ? 'selected' : ''}>전체</option>
                                        <option value="승인" ${selectedType == '승인' ? 'selected' : ''}>승인</option>
                                        <option value="미승인" ${selectedType == '미승인' ? 'selected' : ''}>미승인</option>
                                        <option value="반려" ${selectedType == '반려' ? 'selected' : ''}>반려</option>
                                    </select>
                                    <label class="input-group-text" for="searchName">장학금명</label>
                                    <input type="text" class="form-control" placeholder="장학금명 검색" aria-label="Search..." aria-describedby="basic-addon-search31" id="searchName" name="searchName" value="${searchName}">
                                    <button class="btn btn-outline" id="searchBtn">검색</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <hr class="my-0">
                <div class="table-responsive text-nowrap">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th class="hidden-col">장학금 신청 번호</th>
                                <th>No</th>
                                <th>장학금명</th>
                                <th>장학종류</th>
                                <th style="text-align:right;">장학금액</th>
                                <th>신청희망학기</th>
                                <th>신청일자</th>
                                <th>수혜일자</th>
                                <th>처리현황</th>
                                <th>상세보기</th>
                            </tr>
                        </thead>
                        <tbody class="table-border-bottom-0" id="scholarshipTable">
                            <c:if test="${empty scholarshipList}">
                                <tr>
                                    <td colspan="10" style="text-align:center;">조회하실 데이터가 없습니다.</td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty scholarshipList}">
                                <c:forEach var="scholarship" items="${scholarshipList}">
                                    <tr>
                                        <td class="hidden-col">${scholarship.schRecNo}</td>
                                        <td>${scholarship.rnum }</td>
                                        <td>${scholarship.schName}</td>
                                        <td>${scholarship.schType}</td>
                                        <td style="text-align:right;"><fmt:formatNumber value="${scholarship.schAmount}" pattern="#,###" />원</td>
                                        <td>${scholarship.year}/${scholarship.semester}</td>
                                        <td>${scholarship.schAplDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty scholarship.schRecDate}">
                                                    <font>${scholarship.schRecDate}</font>
                                                </c:when>
                                                <c:otherwise>
                                                    <font>미지급</font>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${scholarship.comDetCNo == 'C0201'}">
                                                    <font style="color: green;">승인완료</font>
                                                </c:when>
                                                <c:when test="${scholarship.comDetCNo == 'C0202'}">
                                                    <font style="color: red;">미승인</font>
                                                </c:when>
                                                <c:when test="${scholarship.comDetCNo == 'C0203'}">
                                                    <font style="color: blue;">반려</font>
                                                </c:when>
                                                <c:otherwise>알 수 없음</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-secondary detailBtn" data-schrecno="${scholarship.schRecNo}">상세보기</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(document).ready(function() {
    $("#typeSelect").on("change", function(){
        $("#filterForm").submit();
    });

    $(".detailBtn").on("click", function(){
        var schRecNo = $(this).data("schrecno");
        location.href = "/student/myRequestDetail?schRecNo=" + schRecNo;
    });
});
</script>
