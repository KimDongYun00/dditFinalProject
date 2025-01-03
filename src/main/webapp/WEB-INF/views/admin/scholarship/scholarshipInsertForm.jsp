<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="card mb-4 bg-white">
			<h5 class="card-header">장학 종류 관리 > 장학금 종류 등록</h5>
			<hr class="my-0">
			<div class="card mb-4 bg-white">
                    <div class="card-body">
                    	<h3>[ 예시 ]</h3>
                        <img src="<c:url value='${pageContext.request.contextPath }/resources/images/장학 종류 등록 양식.png'/>" alt="Guideline" style="width: 100%; height:450px;">
                    </div>
                </div>
			<div class="card-body">
				<div class="table-responsive text-nowrap">
					<form id="scholarshipForm" action="/admin/scholarshipInsert" method="post">	
					<sec:csrfInput/>
						<div class="row mb-3">							
							<label class="col-sm-2 col-form-label" for="schName"><font size="4">장학금명</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="schName" id="schName">
							</div>
							
							<label class="col-sm-2 col-form-label" for="schContent"><font size="4">장학금 내용</font></label>
							<div class="col-sm-10">
								<textarea rows="8" cols="8" class="form-control" name="schContent" id="schContent"></textarea>								
							</div>

							<label class="col-sm-2 col-form-label" for="schReq"><font size="4">장학조건</font></label>
							<div class="col-sm-10">
								<textarea rows="10" cols="10" class="form-control" name="schReq" id="schReq"></textarea>								
							</div>

							<label class="col-sm-2 col-form-label" for="schAmount"><font size="4">장학 금액</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="schAmount" id="schAmount">
							</div>
							
							<label class="col-sm-2 col-form-label" for="schType"><font size="4">장학 종류</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="schType" id="schType">
										<option value="선차감">선차감</option>
										<option value="후지급">후지급</option>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="schMax"><font size="4">최대 수혜 가능 인원</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="schMax" id="schMax">
							</div>
							
						</div>
						
						<input type="button" id="insertBtn" value="등록" class="btn btn-primary">						
 						<button type="button" class="btn btn-warning" id="listBtn">취소</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$('#insertBtn').click(function(){
			if(confirm("신규 장학 종류를 등록하시겠습니까?")) {
				$('#scholarshipForm').submit();
			}
		});
		
		$("#listBtn").click(function(){
			location.href="/admin/scholarshipList";
		})
		
		 // 성공 메시지를 확인하고 알림 표시
        <c:if test="${not empty success}">
            Swal.fire({
                icon: 'success',
                title: '장학 종류 등록 성공',
                text: '${msg}'
            });
        </c:if>
		
	});
</script>
