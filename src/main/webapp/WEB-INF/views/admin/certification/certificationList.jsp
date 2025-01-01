<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                    <h5 class="card-header" style="text-align: left;">증명서 발급관리 > 증명서 종류 관리 </h5>
                    <hr class="my-0">
                    <div class="card mb-4 bg-white">
                        <div class="card-header searchHeader">
                            <form id="searchForm" method="get" action="/admin/certificationList">
                                <input type="hidden" name="page" id="page">
                                <div class="row mb-3" id="searchDiv">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <label class="input-group-text" for="searchType">증명서명</label>
                                            <input type="text" class="form-control" id="searchType" name="searchType" placeholder="검색어 입력" value="${param.searchType}">
                                            <button type="submit" class="btn btn-outline" id="searchBtn">검색</button>
                                            <sec:csrfInput />
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-xl-12">
                        <div class="card mb-4 bg-white">
                            <hr class="my-0">
                            <div class="table-responsive text-nowrap">
                                <table class="table table-hover" style="overflow: hidden;">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>증명서명</th>
                                            <th>발급 수수료</th>
                                            <th>상세보기</th>
                                            <th>비활성화</th>
                                        </tr>
                                    </thead>
                                    <c:set value="${pagingVO.dataList}" var="certificationList" />
                                    <tbody class="table-border-bottom-0" id="tbody">
                                        <c:forEach var="certification" items="${certificationList}" varStatus="status">
                                            <tr>
                                                <td>${certification.rnum}</td>
                                                <td>${certification.cerName}</td>
                                                <td><fmt:formatNumber value="${certification.cerCharge}" pattern="#,###" />원</td>
                                                  <td><a class='btn btn-secondary detailBtn' href='/admin/certificationDetail?cerNo=${certification.cerNo}'>상세보기</a></td>
                                                <td> 
                                                    <div class="form-check form-switch mb-2">
                                                        <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" style="width: 40px; align-items: center;">
                                                        <label class="form-check-label" for="flexSwitchCheckDefault"></label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <hr class="my-0">
                            <div class="card-footer">
                                <button type="button" class="btn btn-primary" id="insertBtn">등록</button>
                                <input type="button" id="showChartBtn" class="btn btn-primary" value="발급 통계 현황">
                            </div>
                        </div>
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
            var searchForm = $("#searchForm");

            pagingArea.on("click", "a", function(event) {
                event.preventDefault();
                var pageNo = $(this).data("page");
                searchForm.find("#page").val(pageNo);
                searchForm.submit();
            });

            $("#insertBtn").click(function() {
                location.href = "/admin/certificationInsertForm";
            });

            $("#showChartBtn").click(function() {
                location.href = "/admin/certificationStatistics";
            });
        });
    </script>
