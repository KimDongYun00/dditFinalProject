<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    

<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">과목관리</h4>
	<button type="button" class="btn btn-primary" id="listBtn">목록</button>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">과목등록</h5>
				<hr class="my-0">
				<div class="card-body">
					<form action="/admin/insertSubject.do" method="post" id="insertFrm">
						<sec:csrfInput/>
						<div class="row mb-3">
							<!-- 과목명 text -->
							<label class="col-sm-2 col-form-label" for="subName"><font size="4">과목명</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="subName" id="subName">
							</div>
							<!-- 담당학과 text -->
							<label class="col-sm-2 col-form-label" for="deptNo"><font size="4">담당학과</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="deptNo" id="deptNo">
									<c:forEach items="${deptList }" var="department">
										<option value="${department.deptNo }">${department.deptName }</option>
									</c:forEach>
								</select>
							</div>
							<!-- 활성화공통코드 radio -->
							<span class="col-sm-2 col-form-label"><font size="4">활성화여부</font></span>
							<div class="col-sm-10">
								<div class="form-check form-check-inline mt-2">
									<input type="radio" class="form-check-label" name="comDetVNo" value="V0101" id="V0101" checked="checked">
									<label class="form-check-label" for="V0101"><font size="3">활성</font></label>
								</div> 
								<div class="form-check form-check-inline mt-2">
									<input type="radio" class="form-check-label" name="comDetVNo" value="V0102" id="V0102">
									<label class="form-check-label" for="V0102"><font size="3">비활성</font></label>
								</div> 
							</div>
							<!-- 과목 설명 textarea -->
							<label class="col-sm-2 col-form-label" for="subContent"><font size="4">과목설명</font></label>
							<div class="col-sm-10">
								<textarea class="form-control" rows="10" name="subContent" id="subContent"></textarea>
							</div>
						</div>
					</form>
				</div>
				<hr class="my-0">
				<div class="card-footer">
					<!-- 등록 버튼 -->
					<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(function(){
	
	var insertBtn = $("#insertBtn");
	var insertFrm = $("#insertFrm");
	var listBtn = $("#listBtn");
	
	insertBtn.on('click', function(){
		console.log("insertBtn click...!");
		
		insertFrm.submit();
	});
	
	listBtn.on('click', function(){
		location.href="/admin/subjectList";
	});
	
	
});

</script>


























