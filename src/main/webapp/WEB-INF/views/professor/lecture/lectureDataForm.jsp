
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
								<h3 class="card-title">강의자료${name}</h3>
								<div class="card-tools"></div>
							</div>
							<form action="/professor/insertLectureData.do" method="post"
								enctype="multipart/form-data" id="lecDataForm">
								<input type="hidden" name="lecNo" value="${param.lecNo }">
								
								<c:if test="${status eq 'u' }">
									<input type="hidden" name="lecDataNo"
										value="${lectureDataVO.lecDataNo }" />
								</c:if>
								<div class="card-body">
									<div class="form-group" style="margin-bottom: 30px;">
										<label>제목</label><a class="link link-outline-primary" href="#" style="float: right;" id="fastBtn">빠른완성</a> <input type="text" id="title"
											name="lecDataTitle" class="form-control"
											placeholder="제목을 입력해주세요"
											value="${lectureDataVO.lecDataTitle }">
									</div>
									<div class="form-group">
										<div class="input-group">
											<input type="file" class="form-control" id="inputGroupFile02"
												name="lecFile" multiple="multiple" />

										</div>
										<!-- 										<ul class="list-group" id="fileList"></ul> -->
									</div>
									<c:if test="${status eq 'u' }">
										<c:forEach items="${fileList }" var="file">
											<div class="mailbox-attachment-info">
												<span class="mailbox-attachment-size clearfix mt-1">
													<a
													href="/common/fileDownload.do?fileGroupNo=${file.fileGroupNo}&fileNo=${file.fileNo}">
														${file.fileName } </a> <span>${file.fileFancysize }</span>
												</span>
											</div>
										</c:forEach>
									</c:if>

									<div class="form-group" style="margin-top: 30px;">
										<label for="lecDataContent">내용</label>
										<textarea id="lecDataContent" name="lecDataContent"
											class="form-control" rows="14">${lectureDataVO.lecDataContent }</textarea>
									</div>
								</div>
								<sec:csrfInput />
							</form>
							<div class="card-footer bg-white">
								<div class="row">
									<div class="col-12">
										<input type="button" value="${name}" id="addBtn" class="btn btn-primary float-right">
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
	$(function() {
		CKEDITOR.replace("lecDataContent",{
			filebrowserUploadUrl : '${pageContext.request.contextPath}/imageUpload.do?${_csrf.parameterName}=${_csrf.token}'
		});
		CKEDITOR.config.height = "600px";
		$("#fastBtn").click(function(){
			$("#title").val("강의 첨부 자료 입니다.");
			CKEDITOR.instances.lecDataContent.setData("이번 광고학 첨부 pdf입니다. 수업 들어오실때 들고 인쇄해서 같이 봐주세요.");
		})
		
		var lecDataForm = $("#lecDataForm");
		var listBtn = $("#listBtn");
		var addBtn = $("#addBtn");
		var cancelBtn = $("#cancelBtn");

		addBtn.on("click", function() {
			var title = $("#title").val();
			var content = CKEDITOR.instances.lecDataContent.getData();

			if (title == null || title == "") {
				alert("제목을 입력해주세요!");
				$("#lecDataTitle").focus();
				return false;
			}

			if (content == null || content == "") {
				alert("내용을 입력해주세요!");
				$("#assContent").focus();
				return false;
			}

			if ($(this).val() == "수정") {
				
				lecDataForm.attr("action", "/professor/updateLectureData.do");
			}

			lecDataForm.get(0).submit();
		});

		cancelBtn.on("click",function() {
			location.href = "/professor/selectLectureDataDetail.do?lecDataNo=${param.lecDataNo}&lecNo=${param.lecNo}";
		});

		listBtn.on("click",function() {
			location.href = "/professor/selectLectureDataList.do?lecNo=${param.lecNo}";
		});

	});

	// 	 document.getElementById('inputGroupFile02').addEventListener('change', function(event) {
	//          const fileList = document.getElementById('fileList');
	//          fileList.innerHTML = ''; // 기존 리스트 초기화

	//          Array.from(event.target.files).forEach(file => {
	//              const listItem = document.createElement('li');
	//              listItem.className = 'list-group-item';
	//              listItem.textContent = file.name;
	//              fileList.appendChild(listItem);
	//          });
	//      });
</script>

</html>