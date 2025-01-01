<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	 <div class="card mb-4 bg-white">
    	 <h5 class="card-header" style="text-align: left; color: red;">유의사항</h5>
    	 <hr class="my-0"><br>
    	<ul>
            <li>자격증 신청 승인/반려 건에 한해 취득일자, 유효기간, 첨부 파일 수정이 가능합니다.</li>
            <li>승인 완료된 건에 대해서는 수정이 불가능합니다.</li>
            <li>보유 자격증 유효기간을 반드시 확인해주시길 바랍니다.</li>
            <li>관련 문의는 담당자(042-123-4567)에게 연락 바랍니다.</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-xl-12">
            <div class="filter-container">
            </div>
        </div>
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">자격증 > 자격증 신청 내역 조회</h5>
                <hr class="my-0">
                <div class="table-responsive text-nowrap">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>자격증명</th>
                                <th>취득일자</th>
                                <th>유효기간</th>
                                <th>등록일자</th>
                                <th>처리현황</th>
                                <th>상세보기</th>
                            </tr>
                        </thead>
                        <tbody class="table-border-bottom-0" id="licenseTable">
                            <c:if test="${empty licenseList}">
                                <tr>
                                    <td colspan="8" style="text-align: center;">조회하실 데이터가 없습니다.</td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty licenseList}">
                                <c:forEach var="license" items="${licenseList}">
                                    <tr>
                                        <td>${license.rnum}</td>
                                        <td>${license.licName}</td>
                                        <td>${license.licDate}</td>
                                        <td>${license.licLimit}</td>
                                        <td>${license.licRegdate}</td>
                                        <c:choose>
                                            <c:when test="${license.comdetCNo eq 'C0201'}">
                                                <td><font style="color: green;">승인</font></td>
                                            </c:when>
                                            <c:when test="${license.comdetCNo eq 'C0202'}">
                                                <td><font style="color: red;">미승인</font></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><font style="color: blue;">반려</font></td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td>
                                            <button type="button" class='btn btn-secondary detailBtn' data-licno="${license.licNo}">상세보기</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <hr class="my-0">
                <div class="card-footer">
                    <!-- 목록 버튼 -->
                    <button type="button" class="btn btn-primary" id="addLicenseBtn">자격증 추가 등록하기</button>
                </div>
            </div>
        </div>
    </div>
</div>
<form method="post" action="/student/licenseDelete" id="deleteForm">
	<sec:csrfInput/>
	<input type="hidden" value="${license.licNo}" name="licNo">
</form>

<script>
    $(document).ready(function() {
        // 상세보기 버튼 클릭 이벤트
        $(".detailBtn").on("click", function() {
            var licNo = $(this).data("licno"); // 버튼의 data-licno 속성 값 가져오기
            location.href = "/student/licenseDetail?licNo=" + licNo;
        });

    	 // 미승인된거 삭제 처리
    	$("#deleteBtn").click(function(){
    		if(confirm('자격증 신청 내역을 삭제 하시겠습니까?')){
    			$("#deleteForm").submit();
    		}
    	});
        
    });

    // 자격증 추가 등록하기 버튼 이벤트
    var addLicenseBtn = $("#addLicenseBtn");
    addLicenseBtn.on("click", function() {
        location.href = "/student/licenseForm";
    });
</script>
