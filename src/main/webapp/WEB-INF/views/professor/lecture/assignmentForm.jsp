  <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<style type="text/css">
input{
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<c:set value="등록" var="name" />
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="name" />
	</c:if>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">
			<!-- Form controls -->
			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-dark">
							<div class="card-header">
								<h3 class="card-title">과제${name}</h3>
							</div>
							<form action="/professor/insertAssignment.do" method="post" id="assignForm">
								<input type="hidden" name="lecNo" value="${param.lecNo }">
								<c:if test="${status eq 'u' }">
									<input type="hidden" name="assNo" id="assNo" value="${assignmentVO.assNo }" />
								</c:if>
								<div class="card-body row">
									<div class="form-group col-sm-6">
										<label>과제명</label> 
										<input type="text" id="assTitle" name="assTitle" class="form-control"
											placeholder="제목을 입력해주세요" value="${assignmentVO.assTitle }">
									</div>
									<div class="form-group col-sm-3">
										<label>마감일시</label> <input
											class="form-control" type="datetime-local" name="assEdate" value="${assignmentVO.assEdate }"
											id="assEdate">
									</div>
									<div class="form-group col-sm-3">
									
										<!-- 시연용만듬 -->
										<label>최대점수</label><a href="#" style="float: right;" id="fastBtn">시연용</a> 
										    
										    
										    <input
											class="form-control" type="number" min="5" max="100" name="assMaxscore" value="${assignmentVO.assMaxscore }"
											id="assMaxscore">
									</div>
									<div class="form-group col-sm-12">
										<label for="assContent">내용</label>
										<textarea id="assContent" name="assContent" class="form-control"
											rows="5">${assignmentVO.assContent }</textarea>
									</div>
								</div>
								<sec:csrfInput />
							</form>
							<div class="card-footer bg-white">
								<div class="row">
									<div class="col-12">
										<input type="button" value="${name }" id="addBtn"
											class="btn btn-primary float-right">
										<c:if test="${status eq 'u' }">
											<input type="button" value="취소" id="cancelBtn"
												class="btn btn-secondary float-right">
										</c:if>
										<c:if test="${status ne 'u' }">
											<input type="button" value="목록" id="listBtn"
												class="btn btn-secondary float-right">
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	CKEDITOR.replace("assContent", {
		//filebrowserUploadUrl: '${pageContext.request.contextPath}/imageUpload.do?${_csrf.parameterName}=${_csrf.token}'
	});
	CKEDITOR.config.height = "300px";
	
	$("#fastBtn").click(function(){
		$("#assTitle").val("2주차 과제입니다");
		$("#assMaxscore").val("15");
		$("#assEdate").val("2024-06-10 23:59");
		CKEDITOR.instances.assContent.setData("<p>2주차시에서 광고유형에 대해 학습해보았습니다.</p>"
				+"<p> 광고의 목적에 따라, 즉 무엇을 광고의 대상으로 하느냐에 따라 6가지로 분류할 수 있습니다.</p>"+
				"<p> 6가지에 대한 개념을 제시하고, 이 중 3가지를 선택한 후 이와 관련된 최근 광고의 사례를 제시해봅시다.</p>");
	})
	
	
	var assignForm = $("#assignForm");
	var listBtn = $("#listBtn");
	var addBtn = $("#addBtn");
	var cancelBtn = $("#cancelBtn");
	
	addBtn.on("click", function(){
		var title = $("#assTitle").val();
		var content = CKEDITOR.instances.assContent.getData();
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요!");
			$("#assTitle").focus();
			return false;
		}
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요!");
			$("#assContent").focus();
			return false;
		}
		
		if($(this).val() == "수정"){
			assignForm.attr("action", "/professor/updateAssignment.do");
		}
		
		assignForm.submit();
	});   
	
 	cancelBtn.on("click", function(){
		location.href = "/professor/selectAssignmentDetail.do?assNo=${param.assNo}&lecNo=${param.lecNo}";
	}); 
	
	listBtn.on("click", function(){
		location.href = "/professor/selectAssignmentList.do?lecNo=${param.lecNo}";
	});
	
	
});
</script>

</html>