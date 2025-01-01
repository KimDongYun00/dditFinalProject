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
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align: left;">증명서 발급 유의사항</h5>
                 <hr class="my-0">
                <div class="card-body">
                    <div class="table-responsive info-container">
                        <div>
                            <h6>[ 인터넷 증명 발급 ]</h6>
                            <table class="info-table" style="height:188px;">
                                <tbody>
                                    <tr>
                                        <th style="width:120px;">운영시간</th>
                                        <td>24시간</td>
                                    </tr>
                                    <tr>
                                        <th>소요시간</th>
                                        <td>즉시 발급</td>
                                    </tr>
                                    <tr>
                                        <th>수수료</th>
                                        <td>증명서 별 상이</td>
                                    </tr>
                                    <tr>
                                        <th>문의 전화</th>
                                        <td>1999-9281</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div>
                            <h6>[ 방문 신청 ]</h6>
                            <table class="info-table">
                                <tbody>
                                    <tr>
                                        <th>장소</th>
                                        <td>인문본관 1층 학사관리팀</td>
                                    </tr>
                                    <tr>
                                        <th>운영시간</th>
                                        <td>
                                            09:00 ~ 18:00 (단, 주말 및 점심시간 제외)<br>
                                            방학기간 : 09:00 ~ 17:00 (단, 집중휴가기간 불가)
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>소요시간</th>
                                        <td>즉시 발급</td>
                                    </tr>
                                    <tr>
                                        <th>수수료</th>
                                        <td>증명서 별 상이</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div> <br>
                    <hr class="my-0"> <br>
                    <h6>[ 유의사항 ]</h6>
                    <div class="table-responsive">
                        <table class="info-table">
                            <tbody>
                                <tr>
                                    <th>1</th>
                                    <td>영문성명 및 학적기재사항에 오류가 있을 경우 학적담당자(042-123-4567)에게 수정요청 후 이용하시기 바랍니다.</td>
                                </tr>
                                <tr>
                                	<th>2</th>
                                	<td>증명서를 발급받기 전에, 제출해야 할 기관에서 요구하는 증명서 종류를 정확히 확인하시기 바랍니다. 잘못 발급된 증명서로 인한 불이익이 발생하지 않도록 주의해 주세요.</td>
                                </tr>
                                <tr>
                                	<th>3</th>
                                	<td>결제 완료 후에는 증명서 발급 신청의 취소 및 환불이 불가능합니다. 신중하게 결제해 주시기 바랍니다.</td>
                                </tr>
                                <tr>
                                	<th>4</th>
                                	<td>발급된 증명서에는 별도의 유효기간이 정해져 있지 않습니다. 다만, 증명서를 제출하는 기관에서 요구하는 발급일 기준 유효기간이 있을 수 있으니, 제출처의 요구사항을 미리 확인하시기 바랍니다.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <hr class="my-0">
            </div>
        </div>

        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align: left;">증명서 발급</h5>
                <hr class="my-0">
                <div class="card-header searchHeader">
                    <form id="searchForm" method="get" action="/student/certificationList">
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
                <hr class="my-0">
                <div class="table-responsive text-nowrap">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>증명서명</th>
                                <th>발급 수수료</th>
                                <th>비고</th>
                            </tr>
                        </thead>
                        <c:set value="${pagingVO.dataList}" var="certificationList" />
                        <tbody class="table-border-bottom-0" id="tbody">
                            <c:forEach var="certification" items="${certificationList}" varStatus="status">
                                <tr>
                                    <td>${certification.rnum}</td>
                                    <td>${certification.cerName}</td>
                                    <td><fmt:formatNumber value="${certification.cerCharge}" pattern="#,###" />원</td>
                                    <td>
                                        <button class="btn btn-primary requestCertification"
                                                type="button" id="requestCertification"
                                                data-cer-no="${certification.cerNo}"
                                                data-cer-name="${certification.cerName}"
                                                data-cer-charge="${certification.cerCharge}">발급</button>
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
$(document).on('click', '#requestCertification', function() {
    var cerNo = $(this).data('cer-no');
    var cerName = $(this).data('cer-name');
    var cerCharge = $(this).data('cer-charge');

    previewCertification(cerNo, cerName, cerCharge);
});

function previewCertification(cerNo, cerName, cerCharge) {
    var url;
    switch (cerName) {
        case '재학증명서':
            url = "/student/enrollmentCertification?cerNo=" + cerNo + "&cerName=" + cerName + "&cerCharge=" + cerCharge;
            break;
        case '성적증명서':
            url = "/student/gradeCertification?cerNo=" + cerNo + "&cerName=" + cerName + "&cerCharge=" + cerCharge;
            break;
        case '졸업증명서':
            url = "/student/graduationCertification?cerNo=" + cerNo + "&cerName=" + cerName + "&cerCharge=" + cerCharge;
            break;
        default:
            url = "/student/certificationList"; // default fallback
    }
    console.log("Redirecting to: " + url); // 디버깅을 위해 추가
    window.location.href = url;
}
</script>
