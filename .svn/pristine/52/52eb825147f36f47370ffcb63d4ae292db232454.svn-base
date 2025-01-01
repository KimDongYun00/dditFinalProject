<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
  .table-responsive {
    overflow-x: auto;
  }
  .table-hover th, .table-hover td {
    text-align: left;
    padding: 15px; /* Padding added */
    border-left: 1px solid #ddd;
  }
  .table-hover th:first-child, .table-hover td:first-child {
    border-left: none;
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
  .card-header, .card-footer {
    background-color: #f8f9fa;
    border-bottom: 1px solid #e9ecef;
  }
  .card-footer {
    text-align: right;
  }
  .btn {
    margin: 5px;
  }
  .readonly {
    background-color: #f9f9f9;
    border: none;
  }
</style>
<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align:left;">장학 관리 > 장학금 종류 > 장학 종류 상세조회</h5>
                <hr class="my-0">
                <div class="card-body">
                   <form action="/admin/scholarshipUpdate" method="post" id="formData">
                   <sec:csrfInput/>
                    <div class="table-responsive">
                        <table class="table table-hover" border="1" style="width: 100%;">
                            <tbody>
                                <c:forEach var="scholarship" items="${scholarshipVO}">
                                    <tr>
                                        <th>장학금번호</th>
                                        <td>
                                            <input type="text" name="schNo" id="schNo" value="${scholarship.schNo}" class="readonly" readonly>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>장학금명</th>
                                        <td><input type="text" class="form-control" name="schName" value="${scholarship.schName}"></td>
                                    </tr>
                                    <tr>
                                        <th>장학금 설명</th>
                                        <td><textarea rows="10" cols="5" class="form-control" name="schContent">${scholarship.schContent}</textarea></td>
                                    </tr>
                                    <tr>
                                        <th>장학 조건</th>
                                        <td><textarea rows="10" cols="5" class="form-control" name="schReq">${scholarship.schReq}</textarea></td>
                                    </tr>
                                    <tr>
                                        <th>장학금액</th>
                                        <td>
                                        
                                            <input style="width: 150px; display: inline-block;" type="text" class="form-control" name="schAmount" value="${scholarship.schAmount}">원
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>장학 종류</th>
                                        <td>
                                            <select class="form-control" name="schType" style="width: 150px; display: inline-block;">
                                                <option value="선차감" <c:if test="${scholarship.schType == '선차감'}">selected</c:if>>선차감</option>
                                                <option value="후지급" <c:if test="${scholarship.schType == '후지급'}">selected</c:if>>후지급</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>신청 가능 최대 인원</th>
                                        <td>
                                            <input style="width: 150px; display: inline-block;" type="text" class="form-control" name="schMax" value="${scholarship.schMax}">명
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    </form>
                </div>
                <hr class="my-0">
                <div class="card-footer">
                    <!-- 목록 버튼 -->
                    <button type="button" class="btn btn-primary" id="listBtn">목록</button>
                     
                     <!-- 수정 버튼 -->
                     <button type="button" class="btn btn-primary" id="modifyBtn">수정</button> 
                     
                     <!-- 삭제 버튼 -->
                    <button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
                </div>
                <!-- 삭제 폼 추가 -->
                <form id="deleteForm" method="post" action="/admin/deleteScholarship">
                    <input type="hidden" name="schNo" id="deleteSchNo">
                    <sec:csrfInput/>
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
        location.href="/admin/scholarshipList";
    });
    // 삭제 버튼 클릭 이벤트
    $("#deleteBtn").click(function(){
        var schNo = $("#schNo").val().trim(); // hidden input field에서 장학금 번호 가져오기
        if(confirm("해당 장학금을 삭제하시겠습니까?")) {
            $("#deleteSchNo").val(schNo);
            $("#deleteForm").submit();
        }
    });

    // 수정 버튼 클릭 이벤트
    $("#modifyBtn").click(function(){
        $("#formData").submit();
    });
})
</script>
