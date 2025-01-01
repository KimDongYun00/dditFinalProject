<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>



<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">과목관리</h4>
	<button type="button" class="btn btn-primary" id="listBtn">목록</button>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">${subjectVO.subName }</h5>
				<hr class="my-0">
				<div class="card-body">
					<form action="/admin/updateSubject" method="post" id="updateFrm">
						<sec:csrfInput/>
						<div class="row mb-3">
							<input type="hidden" name="subNo" value="${subjectVO.subNo }">
						
							<label class="col-sm-2 col-form-label" for=""><font size="4">학과</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="" id="" 
									value="${subjectVO.deptName }" readonly="readonly">
							</div>
							
							<label class="col-sm-2 col-form-label" for="subName"><font size="4">과목 이름</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="subName" id="subName"
									value="${subjectVO.subName }" readonly="readonly">
							</div>
							
							<label class="col-sm-2 col-form-label" for="subContent"><font size="4">과목 설명</font></label>
							<div class="col-sm-10">
								<textarea rows="10" class="form-control" name="subContent" id="subContent" readonly="readonly">${subjectVO.subContent }</textarea>
							</div>
							
						</div>
					</form>
				</div>
				<div class="card-footer">
					<!-- 등록 버튼 -->
					<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
					<button type="button" class="btn btn-danger" id="updateBtn2" style="display:none;">수정완료</button>
					<button type="button" class="btn btn-primary" id="cancelBtn" style="display:none;">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>



<script>

$(function(){
	
	var listBtn = $("#listBtn");
	var updateBtn = $("#updateBtn");
	var updateBtn2 = $("#updateBtn2");
	var cancelBtn = $("#cancelBtn");
	var updateFrm = $("#updateFrm");
	
	var subContent = "";
	var subName = "";
	
	listBtn.on('click',function(){
		console.log("listBtn click...!");
		
		location.href="/admin/subjectList";
	});
	
	updateBtn.on('click',function(){
		console.log("updateBtn click...!");
		
		$("#subContent").attr("readonly", false);
		$("#subName").attr("readonly", false);
		
		subContent = $("#subContent").val();
		subName = $("#subName").val();
		
		cancelBtn.show();
		updateBtn2.show();
		updateBtn.hide();
	});
	
	updateBtn2.on('click', function(){
		console.log("updateBtn2 click...!");
		
		updateFrm.submit();
	});
	
	cancelBtn.on('click',function(){
		console.log("cancelBtn click");

		$("#subContent").attr("readonly", true);
		$("#subName").attr("readonly", true);
		
		$("#subContent").val(subContent);
		$("#subName").val(subName);
		
		cancelBtn.hide();
		updateBtn2.hide();
		updateBtn.show();
	});
	
});

</script>



















