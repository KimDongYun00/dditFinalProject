<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
</style>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align: left;">자격증 관리 > 자격증 등록 신청 내역</h5>
                <hr class="my-0">
                <div class="card-header searchHeader">
                    <form id="searchForm" method="get" action="/admin/licenseList">
                        <div class="row mb-3">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <sec:csrfInput />
                                    <input type="hidden" name="page" id="page" value="${page}">
                                    <label class="input-group-text" for="licenseSelect">자격증 선택</label>
                                    <select class="form-select" id="licenseSelect" name="searchType">
                                        <option value="99">전체</option>
                                        <c:set var="uniqueLicenses" value="${fn:split('', '')}" />
                                        <c:forEach var="lic" items="${licenseTypeList}">
                                            <c:if test="${fn:indexOf(uniqueLicenses, lic.licName) == -1}">
                                                <c:set var="uniqueLicenses" value="${uniqueLicenses},${lic.licName}" />
                                                <option value="${lic.licName}" <c:if test="${searchType eq lic.licName }">selected</c:if>>${lic.licName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    
                                    <label class="input-group-text" for="departmentSelect">학과 선택</label>
                                    <select class="form-select" id="departmentSelect" name="searchDept">
                                        <option value="99">전체</option>
                                        <c:forEach var="dept" items="${deptList}">
                                            <option value="${dept.deptNo}" <c:if test="${searchDept eq dept.deptNo }">selected</c:if>>${dept.deptName}</option>
                                        </c:forEach>
                                    </select>
                                    
                                    <label class="input-group-text" for="statusSelect">처리 상태</label>
                                    <select class="form-select" id="statusSelect" name="searchStatus">
                                        <option value="99" <c:if test="${searchStatus eq '99' }">selected</c:if>>전체</option>
                                        <option value="1" <c:if test="${searchStatus eq '1' }">selected</c:if>>승인 완료</option>
                                        <option value="2" <c:if test="${searchStatus eq '2' }">selected</c:if>>미승인</option>
                                        <option value="3" <c:if test="${searchStatus eq '3' }">selected</c:if>>반려</option>
                                    </select>

                                    <label class="input-group-text" for="searchStuId">학생 학번</label>
                                    <input type="text" id="searchStuId" class="form-control" placeholder="학생 학번 검색" aria-label="Search..." name="searchStuId" value="${searchStuId}">
                                    
                                    <label class="input-group-text" for="searchStuName">학생 이름</label>
                                    <input type="text" id="searchStuName" class="form-control" placeholder="학생 이름 검색" aria-label="Search..." name="searchStuName" value="${searchStuName}">
                                    
                                    <button type="submit" class="btn btn-outline" id="searchBtn">검색</button>
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
                                <c:if test="${searchStatus eq '2' or searchStatus eq '3'}">
                                    <th><input type="checkbox" id="allSelect"></th>
                                </c:if>
                                <th>No</th>
                                <th>학생 학번</th>
                                <th>학생 이름</th>
                                <th>학과</th>
                                <th>자격증명</th>
                                <th>신청 날짜</th>
                                <th>처리 현황</th>
                                <th>상세 보기</th>
                            </tr>
                        </thead>
                        <tbody class="table-border-bottom-0" id="licenseTable">
                            <c:set value="${pagingVO.dataList }" var="requestList" />
                            <c:choose>
                                <c:when test="${empty requestList or requestList eq null}">
                                    <tr>
                                        <td colspan="8" style="text-align: center;">조회하실 데이터가 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="license" items="${requestList}">
                                        <tr>
                                            <c:if test="${searchStatus eq '2' or searchStatus eq '3'}">
                                                <td><input type="checkbox" name="licenseApprove" value="${license.licNo}"></td>
                                            </c:if>
                                            <td>${license.rnum}</td>
                                            <td>${license.stuNo}</td>
                                            <td>${license.stuName}</td>
                                            <td>${license.deptName}</td>
                                            <td>${license.licName}</td>
                                            <td>${license.licRegdate}</td>
                                            <td>
                                                <c:if test="${license.comdetCNo == 'C0201'}"><font style="color: green;">승인 완료</font></c:if>
                                                <c:if test="${license.comdetCNo == 'C0202'}"><font style="color: red;">미승인</font></c:if>
                                                <c:if test="${license.comdetCNo == 'C0203'}"><font style="color: blue;">반려</font></c:if>
                                            </td>
                                            <td><a class='btn btn-secondary detailBtn' href='/admin/licenseRequestDetail?licNo=${license.licNo}'>상세 보기</a></td>
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
                    <c:if test="${searchStatus eq '2' or searchStatus eq '3'}">
                        <span><input type="button" id="approveAllBtn" class="btn btn-primary" value="일괄 승인 처리"></span>
                    </c:if>
                    <input type="button" id="showChartBtn" class="btn btn-primary" value="신청 통계 현황">
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function() {
        var pagingArea = $("#pagingArea");
        var searchForm = $("#searchForm");

        // CSRF 토큰 설정
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        pagingArea.on("click", "a", function(event) {
            event.preventDefault();
            var pageNo = $(this).data("page");

            searchForm.find("#page").val(pageNo);
            searchForm.submit();
        });

        var allSelect = $("#allSelect");
        allSelect.click(function() {
            var allChecked = $(this).prop('checked');
            $("input[name='licenseApprove']").prop('checked', allChecked);
        });

        $("#licenseSelect, #departmentSelect, #statusSelect, #searchStuName, #searchStuId").on("change", function() {
            searchForm.submit();
        });

        $("#approveAllBtn").click(function() {
            var selectedIds = [];

            $("input[name='licenseApprove']:checked").each(function() {
                selectedIds.push($(this).val());
            });

            if (selectedIds.length === 0) {
                alert("승인 대기중인 항목을 선택해주세요.");
                return false;
            }

            if (confirm("선택된 항목들을 일괄 승인 처리할까요?")) {
                $.ajax({
                    url: "/admin/licenseApproveAll",
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

        $("#showChartBtn").click(function() {
            location.href = "/admin/licenseStatistics";
        });
    });
</script>
