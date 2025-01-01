<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
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
</head>
<body>
<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align:left;">증명서 종류 상세조회</h5>
                <hr class="my-0">
                <div class="card-body">
                   <form action="/admin/certificationUpdate" method="post" id="formData">
                   <sec:csrfInput/>
                    <div class="table-responsive">
                        <table class="table table-hover" border="1" style="width: 100%;">
                            <tbody>
                                    <tr>
                                        <th>증명서 고유 번호</th>
                                        <td>
                                            <input type="text" name="cerNo" id="cerNo" value="${certification.cerNo}" class="readonly" readonly>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>증명서명</th>
                                        <td><input type="text" class="form-control" name="cerName" value="${certification.cerName}" class="readonly" readonly></td>
                                    </tr>
                                    <tr>
                                        <th>증명서 내용</th>
                                        <td><textarea rows="10" cols="5" class="form-control" name="cerContent">${certification.cerContent}</textarea></td>
                                    </tr>
										<tr>
											<th>발급 수수료</th>
											<td><input type="text" class="form-control"
												name="cerCharge" value="${certification.cerCharge}"
												style="width: 150px; display: inline-block;"> 원</td>
										</tr>

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
                     
                </div>
            </div>
        </div>
    </div>
    <sec:csrfInput/>
</div>

<script>
$(function(){
    // 목록 버튼 클릭 이벤트
    $("#listBtn").click(function(){
        location.href="/admin/certificationList";
    });

    // 수정 버튼 클릭 이벤트
    $("#modifyBtn").click(function(){
        console.log("수정 버튼 클릭됨"); // 디버깅 로그 추가
        $("#formData").submit();
    });
});
</script>
</body>
</html>
