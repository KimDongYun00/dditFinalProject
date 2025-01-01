<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
        justify-content: left;
    }
    #statusChart {
        max-width: 400px;
        max-height: 400px;
        margin: 0 auto;
    }
</style>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align: left;">장학 관리 > 장학 신청 및 수혜 내역</h5>
                <hr class="my-0">
                <div class="card mb-4 bg-white">
                    <div class="card-header searchHeader">
                        <form id="searchForm" method="get" action="/admin/scholarshipRequestList">
                            <input type="hidden" name="page" id="page" value="${page}">
                            <div class="row mb-3" id="searchDiv">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <label class="input-group-text" for="scholarshipTypeSelect">지급방식</label> 
                                        <select class="form-select" id="typeSelect" name="searchType">
                                            <option value="99" <c:if test="${searchType eq '99' }">selected</c:if>>전체 상태</option>
                                            <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>선차감</option>
                                            <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>후지급</option>
                                        </select>
                                        <label class="input-group-text" for="scholarshipNameSelect">장학금명</label> 
                                        <select class="form-select" id="scholarshipNameSelect" name="searchName">
                                            <option value="99">전체 장학금명</option>
                                            <c:forEach var="scholarship" items="${scholarshipList}">
                                                <option value="${scholarship.schName}"
                                                    <c:if test="${searchName eq scholarship.schName }">selected</c:if>>${scholarship.schName}</option>
                                            </c:forEach>
                                        </select> 
                                        <label class="input-group-text" for="departmentSelect">학과</label>
                                        <select class="form-select" id="departmentSelect" name="searchDept">
                                            <option value="99">전체 학과</option>
                                            <c:forEach var="dept" items="${deptList}">
                                                <option value="${dept.deptNo}" <c:if test="${searchDept eq dept.deptNo }">selected</c:if>>${dept.deptName}</option>
                                            </c:forEach>
                                        </select>
                                        <label class="input-group-text" for="statusSelect">처리상태</label>
                                        <select class="form-select" id="statusSelect" name="searchStatus">
                                            <option value="99" <c:if test="${searchStatus eq '99' }">selected</c:if>>전체 상태</option>
                                            <option value="1" <c:if test="${searchStatus eq '1' }">selected</c:if>>승인완료</option>
                                            <option value="2" <c:if test="${searchStatus eq '2' }">selected</c:if>>미승인</option>
                                            <option value="3" <c:if test="${searchStatus eq '3' }">selected</c:if>>반려</option>
                                        </select>
                                        <div class="filter-item">
                                            <div class="input-group input-group-merge">
                                                <span class="input-group-text" id="basic-addon-search32"><i class="bx bx-search"></i></span>
                                                <input type="text" id="searchStuId" class="form-control" placeholder="학생 학번 검색" aria-label="Search..." aria-describedby="basic-addon-search32" name="searchStuId" value="${searchStuId}">
                                            </div>
                                        </div>
                                        <div class="filter-item">
                                            <div class="input-group input-group-merge">
                                                <span class="input-group-text" id="basic-addon-search32"><i class="bx bx-search"></i></span>
                                                <input type="text" id="searchStuName" class="form-control" placeholder="학생 이름 검색" aria-label="Search..." aria-describedby="basic-addon-search32" name="searchStuName" value="${searchStuName}">
                                            </div>
                                        </div>
                                        <div class="filter-item">
                                            <button type="submit" class="btn btn-outline" id="searchBtn">검색</button>
                                        </div>
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
                                    <c:if test="${searchStatus eq '2'}">
                                        <th><input type="checkbox" id="allSelect"></th>
                                    </c:if>
                                    <th>No</th>
                                    <th>학생 이름</th>
                                    <th>학생 학번</th>
                                    <th>학과</th>
                                    <th>장학금명</th>
                                    <th>장학종류</th>
                                    <th style="text-align:right;">장학금액</th>
                                    <th>신청일자</th>
                                    <th>수혜일자</th>
                                    <th>처리현황</th>
                                    <th>상세보기</th>
                                </tr>
                            </thead>
                            <tbody class="table-border-bottom-0" id="scholarshipTable">
                                <c:set value="${pagingVO.dataList}" var="requestList" />
                                <c:choose>
                                    <c:when test="${empty requestList}">
                                        <tr>
                                            <td colspan="12" style="text-align: center;">조회할 데이터가 없습니다.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="req" items="${requestList}" varStatus="status">
                                            <tr>
                                                <c:if test="${searchStatus eq '2'}">
                                                    <td><input type="checkbox" name="scholarshipApprove" value="${req.schRecNo}"></td>
                                                </c:if>
                                                <td>${req.rnum}</td>
                                                <td>${req.stuName}</td>
                                                <td>${req.stuNo}</td>
                                                <td>${req.deptName}</td>
                                                <td>${req.schName}</td>
                                                <td>${req.schType}</td>
                                                <td style="text-align:right;"><fmt:formatNumber value="${req.schAmount}" pattern="#,###" />원</td>
                                                <td>${req.schAplDate}</td>
                                                <td><c:choose>
                                                        <c:when test="${not empty req.schRecDate}">
                                                            <font>${req.schRecDate}</font>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <font>미지급</font>
                                                        </c:otherwise>
                                                    </c:choose></td>
                                                <td><c:choose>
                                                        <c:when test="${req.comDetCNo == 'C0201'}">
                                                            <font style="color: green;">승인완료</font>
                                                        </c:when>
                                                        <c:when test="${req.comDetCNo == 'C0202'}">
                                                            <font style="color: red;">미승인</font>
                                                        </c:when>
                                                        <c:when test="${req.comDetCNo == 'C0203'}">
                                                            <font style="color: blue;">반려</font>
                                                        </c:when>
                                                        <c:otherwise>알 수 없음</c:otherwise>
                                                    </c:choose></td>
                                                <td><a class='btn btn-secondary detailBtn' href='/admin/scholarshipRequestDetail?schRecNo=${req.schRecNo}'>상세보기</a></td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                    <hr class="my-0">
                    <div class="card-footer clearfix" id="pagingArea">
                        ${pagingVO.pagingHTML}
                    </div>
                    <div class="card-footer">
                        <c:if test="${searchStatus eq '2'}">
                            <span><input type="button" id="approveAllBtn" class="btn btn-primary" value="일괄 승인처리"></span>
                        </c:if>
                        <input type="button" id="showChartBtn" class="btn btn-primary" value="처리 통계 현황">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    $(function() {
        var pagingArea = $("#pagingArea");
        var searchForm = $("#searchForm");

        // CSRF 토큰 설정
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        pagingArea.on("click", "a", function(event) {
            event.preventDefault(); // a태그의 href속성 이벤트를 꺼준다.
            var pageNo = $(this).data("page"); // pageNo 전달

            searchForm.find("#page").val(pageNo);
            searchForm.submit();
        });

        // 일괄 선택
        var allSelect = $("#allSelect");
        allSelect.click(function() {
            var allChecked = $(this).prop('checked');
            $("input[name='scholarshipApprove']").prop('checked', allChecked);
        });

        $("#typeSelect, #departmentSelect, #statusSelect, #searchStuName, #searchStuId, #scholarshipNameSelect").on("change", function() {
            $("#searchForm").submit();
        });

        // 일괄 승인 이벤트
        $("#approveAllBtn").click(function() {
            var selectedIds = [];

            $("input[name='scholarshipApprove']:checked").each(function() {
                selectedIds.push($(this).val());
            });

            if (selectedIds.length === 0) {
                alert("승인 대기중인 항목을 선택해주세요.");
                return false;
            }

            if (confirm("선택된 항목들을 일괄 승인 처리할까요?")) {
                $.ajax({
                    url: "/admin/scholarshipApproveAll",
                    type: "POST",
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(header, token);
                    },
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(selectedIds),
                    success: function(response) {
                        alert("선택된 항목들이 승인되었습니다.");
                        location.reload();
                    },
                    error: function(xhr) {
                        alert("승인 중 오류가 발생했습니다.");
                    }
                });
            }
        });

        // 통계 현황으로 이동하는 버튼 이벤트
        $("#showChartBtn").on("click", function(){
            location.href="/admin/scholarshipStatistics";
        });
    });
</script>
