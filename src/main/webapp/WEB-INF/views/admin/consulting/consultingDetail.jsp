<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<h4 class="card-header">상담 > 상담상세</h4>
		<hr class="mb-0">
		<div class="card-body">
			<div class="row">
				<div class="col-6 p-4">
					<div class="row mb-3">	
						<label class="col-2 col-form-label" for="conTitle"><font size="4">상담명</font></label>						
						<label class="col-10 col-form-label" for="conTitle"><font size="4">${consulting.conTitle }</font></label>			
					</div>
					<div class="row mb-3">	
						<label class="col-2 col-form-label" for="proName"><font size="4">교수</font></label>						
						<label class="col-10 col-form-label" for="proName"><font size="4">${consulting.proName }</font></label>			
					</div>
					<div class="row mb-3">
						<label class="col-2 col-form-label"><font size="4">교수아이디</font></label>
						<label class="col-10 col-form-label"><font size="4">${consulting.proNo }</font></label>
					</div>
					<div class="row mb-3">	
						<label class="col-2 col-form-label" for="stuName"><font size="4">학생</font></label>						
						<label class="col-10 col-form-label" for="stuName"><font size="4">${consulting.stuName }</font></label>			
					</div>
					<div class="row mb-3">
						<label class="col-2 col-form-label"><font size="4">학생아이디</font></label>
						<label class="col-10 col-form-label"><font size="4">${consulting.stuNo }</font></label>
					</div>
					<div class="row mb-3">	
						<label class="col-2 col-form-label" for="comDetNNo"><font size="4">상담구분</font></label>						
						<label class="col-10 col-form-label" for="comDetNNo">
							<font size="4">
								<c:if test="${consulting.comDetNNo eq 'N0101'}">진로</c:if>
								<c:if test="${consulting.comDetNNo eq 'N0102'}">학업</c:if>
								<c:if test="${consulting.comDetNNo eq 'N0103'}">휴학</c:if>
								<c:if test="${consulting.comDetNNo eq 'N0104'}">기타</c:if>					
							</font>
						</label>			
					</div>
					<div class="row mb-3">	
						<label class="col-sm-2 col-form-label" for="comDetSNo"><font size="4">진행상태</font></label>						
														
						<div class="col-sm-10">
							<form action="/admin/updateConsulting" id="updateForm" method="post">
								<sec:csrfInput/>
								<input type="hidden" name="conNo" value="${consulting.conNo }">
								<select name="comDetSNo" class="form-select">
									<option value="S0101" <c:if test="${consulting.comDetSNo eq 'S0101'}">selected</c:if>>완료</option>
									<option value="S0102" <c:if test="${consulting.comDetSNo eq 'S0102'}">selected</c:if>>대기</option>									
								</select>
							</form>	
						</div>		
						
					</div>
					<div class="row mb-3">	
						<label class="col-sm-2 col-form-label" for="conOnoff"><font size="4">대면여부</font></label>						
						<label class="col-sm-10 col-form-label" for="conOnoff">
							<font size="4">
								<c:if test="${consulting.conOnoff eq 'Y' }">대면</c:if>
								<c:if test="${consulting.conOnoff eq 'N' }">비대면</c:if>					
							</font>
						</label>			
					</div>
				</div>
				<div class="col-6 p-4">	
					
					<div class="row mb-3">	
						<label class="col-sm-2 col-form-label" for="conContent"><font size="4">내용</font></label>						
						<textarea rows="5" class="form-control" readonly="readonly">${consulting.conContent }</textarea>			
					</div>
					<c:if test="${consulting.comDetSNo eq 'S0101' }">
						<div class="row mb-3">
							<label class="col-2 col-form-label" for="conResult"><font size="4">상담결과</font></label>
							<textarea rows="5" class="form-control" readonly="readonly">${consulting.conResult }</textarea>
						</div>
					</c:if>	
					<div class="mb-3">
						<div class="card-footer" align="right">						
							<a  class="btn btn-outline-primary" id="listBtn" href="/admin/consultingMain">목록</a>
							<input type="button" class="btn btn-primary" id="updateBtn" value="수정">						
							<input type="button" class="btn btn-danger" id="deleteBtn" value="삭제">						
						</div>
					</div>	
				</div>	
			</div>
		</div>	
	</div>
</div>
<script>
$(function(){
	$("#updateBtn").click(function(){
		$("#updateForm").attr("action", "/admin/updateConsulting");
		$("#updateForm").submit();
	});
	
	$("#deleteBtn").click(function(){
		if(confirm('정말 삭제 하시겠습니까?')){			
			$("#updateForm").attr("action", "/admin/deleteConsulting");
			$("#updateForm").submit();			
		}
	})
})
</script>