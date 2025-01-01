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
        border-radius: 5px; /* 둥근 모서리 적용 */
        border: 1px solid #007bff; /* 버튼 테두리 색상 */
    }
    .info-table th, .info-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    .info-table th {
        background-color: #f2f2f2;
    }
    .info-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .info-container {
        display: flex;
        justify-content: space-between;
    }
    .info-container > div {
        flex: 0 0 48%; /* 두 테이블을 나란히 배치하고, 양쪽에 약간의 여백을 줌 */
    }
</style>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card mb-4 bg-white">
    	 <h5 class="card-header" style="text-align: left; color: red;">유의사항</h5>
    	 <hr class="my-0"><br>
    	<ul>
            <li>발급받은 증명서는 재발급 시 추가 비용이 발생하므로, 반드시 개인 PC에 저장하여 필요 시 언제든지 사용할 수 있도록 보관하시기 바랍니다.</li>
            <li>증명서 발급 관련 문의는 담당자(042-123-4567)에게 연락 바랍니다.</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align: left;">증명서 > 증명서 발급 내역 조회</h5>
                <hr class="my-0">
                <div class="card-header searchHeader">
                    <form id="filterForm" method="GET" action="/student/myCertificationList">
                        <div class="row mb-3" id="searchDiv">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <label class="input-group-text" for="searchName">증명서명</label>
                                    <input type="text" class="form-control" id="searchName" name="searchName" placeholder="검색어 입력" value="${searchName}">
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
                                <th>증명서명</th>
                                <th>발급 수수료</th>
                                <th>발급일자</th>
                            </tr>
                        </thead>
                        <tbody class="table-border-bottom-0" id="certificationTable">
								<c:if test="${empty certificationList}">
									<tr>
										<td colspan="4" style="text-align: center;">조회하실 데이터가
											없습니다.</td>
									</tr>
								</c:if>
								<c:if test="${not empty certificationList}">
									<c:forEach var="certification" items="${certificationList}">
										<tr>
											<td>${certification.rnum}</td>
											<td>${certification.cerName}</td>
											<td>
											<fmt:formatNumber value="${certification.cerCharge}" pattern="#,###" />원</td>
											<td>${certification.cerPriDate}</td>
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
$(function(){
    $("#typeSelect").on("change", function(){
        $("#filterForm").submit();
    });
});
</script>
