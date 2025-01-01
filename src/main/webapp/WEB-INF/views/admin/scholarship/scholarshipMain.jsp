<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<meta id="_csrf" name="_csrf" content="${_csrf.token}">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}">

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
        margin-bottom: 0;
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
                <h5 class="card-header" style="text-align: left;">장학 관리 > 장학금 종류 </h5>
                <hr class="my-0">
                <div class="card mb-4 bg-white">
                    <div class="card-header searchHeader">
                        <form id="searchForm">
                            <input type="hidden" name="page" id="page">
                            <div class="row mb-3" id="searchDiv">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <label class="input-group-text" for="colSelect">장학종류</label>
                                        <select class="form-select" id="colSelect" name="searchType">
                                            <option value="99" <c:if test="${searchType eq '99' }">selected</c:if>>전체</option>
                                            <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>선차감</option>
                                            <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>후지급</option>
                                        </select>
                                        <label class="input-group-text" for="searchWord">장학금명</label>
                                        <input type="text" class="form-control" id="searchWord" name="searchWord" placeholder="장학금명 검색" value="${searchName}">
                                        <button type="submit" class="btn btn-outline" id="searchBtn">검색</button>
                                        <sec:csrfInput />
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
                                    <th>No</th>
                                    <th>장학금명</th>
                                    <th>장학종류</th>
                                    <th style="text-align:right; width:200px;">장학금액</th>
                                    <th>상세보기</th>
                                    <th style="width:130px;">삭제</th>
                                </tr>
                            </thead>
                            <tbody class="table-border-bottom-0" id="tbody">
                                <c:set value="${pagingVO.dataList }" var="scholarshipList" />
                                <c:forEach var="scholarship" items="${scholarshipList}" varStatus="status">
                                    <tr>
                                        <td>${scholarship.rnum }</td>
                                        <td>${scholarship.schName}</td>
                                        <td>${scholarship.schType}</td>
                                        <td style="text-align:right;"><fmt:formatNumber value="${scholarship.schAmount}" pattern="#,###" />원</td>
                                        <td><a class='btn btn-secondary detailBtn' href='/admin/scholarshipDetail?schNo=${scholarship.schNo}'>상세보기</a></td>
                                        <td><a class='btn btn-danger deleteBtn' data-scholarship-id="${scholarship.schNo}"><font style="color: white">삭제</font></a></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="card-footer">
                        <!-- 등록 버튼 -->
                        <button type="button" class="btn btn-primary" id="insertBtn">신규 장학 종류 등록</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        var pagingArea = $("#pagingArea");
        var colSelect = $("#colSelect");
        var insertBtn = $("#insertBtn");
        var searchForm = $("#searchForm");

        pagingArea.on("click", "a", function(event) {
            event.preventDefault(); // a태그의 href속성 이벤트를 꺼준다.
            var pageNo = $(this).data("page"); // pageNo 전달

            // 검색 시 사용할 form태그 안에 넣어준다.
            // 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
            searchForm.find("#page").val(pageNo);
            searchForm.submit();
        });

        colSelect.on("change", function() {
            searchForm.submit();
        });

        // 삭제 버튼 이벤트
        $(".deleteBtn").click(function() {
            var scholarshipId = $(this).data("scholarship-id");
            if (confirm("해당 장학금을 삭제하시겠습니까?")) {
                $.ajax({
                    url: "/admin/deleteScholarship",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({ schNo: scholarshipId }),
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(header, token);
                    },
                    success: function(response) {
                        if (response === "success") {
                            alert("해당 장학금이 삭제되었습니다.");
                            location.reload();
                        } else {
                            alert("장학금 삭제 중 오류가 발생했습니다.");
                        }
                    },
                    error: function() {
                        alert("장학금 삭제 중 오류가 발생했습니다.");
                    }
                });
            }
        });

        // 등록 버튼 이벤트
        $("#insertBtn").click(function() {
            location.href = "/admin/scholarshipInsertForm";
        });
    });
</script>
