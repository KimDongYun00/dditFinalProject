<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
  .table-responsive {
    overflow-x: auto;
  }
  .table-hover th, .table-hover td {
    text-align: left; /* 왼쪽 정렬로 수정 */
    border-left: 1px solid #ddd; /* 왼쪽 경계선 추가 */
  }
  .table-hover th:first-child, .table-hover td:first-child {
    border-left: none; /* 첫 번째 열의 왼쪽 경계선 제거 */
  }
  .form-label {
    font-size: 16px;
  }
  .row.mb-3 {
    margin-bottom: 1rem;
  }
  .col-sm-2 {
    font-weight: bold;
  }
  .card-footer {
    text-align: left;
  }
</style>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align:left;">장학 종류 상세조회</h5>
                <hr class="my-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover" border="1">
                            <tbody>
                                <c:forEach var="scholarship" items="${scholarshipVO}">
                                    <tr style="display:none;">
                                        <th>장학금번호</th>
                                        <td id="scholarshipNo">${scholarship.schNo}</td>
                                    </tr>
                                    <tr>
                                        <th>장학금명</th>
                                        <td>${scholarship.schName}</td>
                                    </tr>
                                    <tr>
                                        <th>장학금 설명</th>
                                        <td>${scholarship.schContent}</td>
                                    </tr>
                                    <tr>
                                        <th>장학 조건</th>
                                        <td>${scholarship.schReq}</td>
                                    </tr>
                                    <tr>
                                        <th>장학금액</th>
                                        <td><fmt:formatNumber value="${scholarship.schAmount}" pattern="#,###" />원</td>
                                    </tr>
                                    <tr>
                                        <th>장학 종류</th>
                                        <td>${scholarship.schType}</td>
                                    </tr>
                                    <tr>
                                        <th>신청 가능 최대 인원</th>
                                        <td>${scholarship.schMax}명</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <hr class="my-0">
                <div class="card-footer">
                    <!-- 목록 버튼 -->
                    <button type="button" class="btn btn-primary" id="applyBtn">신청</button>
                    <button type="button" class="btn btn-dark" id="listBtn">목록</button>
                </div>
                <!-- 신청 폼 추가 -->
                <form id="applyForm" method="get" action="/student/scholarshipRequestInsertForm">
                    <input type="hidden" name="schNo" id="formSchNo">
                </form>
            </div>
        </div>
    </div>
    <sec:csrfInput/>
</div>

<script>
$(function(){
    // 목록 버튼 클릭 이벤트
    $("#listBtn").click(function(){
        location.href="/student/scholarshipList";
    });
    // 신청 버튼 클릭 이벤트
    $("#applyBtn").click(function(){
        var schNo = $("#scholarshipNo").text().trim(); // 상세보기에서 클릭하고 들어온 장학금 번호
        $("#formSchNo").val(schNo);
        $("#applyForm").submit();
    });
})
</script>
