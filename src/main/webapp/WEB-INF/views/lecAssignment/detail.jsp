  <%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css?family=Roboto"
	rel="stylesheet">

<script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>
<style type="text/css">

body {
	background: #EEE;
	font-family: 'Roboto', sans-serif;
}

.dropzone {
	width: 98%;
	margin: 1%;
	border: 2px solid #3498db !important;
	border-radius: 5px;
	-webkit-transition: .2s;
	transition: .2s;
}

.dropzone.dz-drag-hover {
	border: 2px solid #3498db !important;
}

.dz-message.needsclick img {
	width: 50px;
	display: block;
	margin: auto;
	opacity: .6;
	margin-bottom: 15px;
}

span.plus {
	display: none;
}

.dropzone.dz-started .dz-message {
	display: inline-block !important;
	width: 120px;
	float: right;
	border: 1px solid rgba(238, 238, 238, 0.36);
	border-radius: 30px;
	height: 120px;
	margin: 16px;
	-webkit-transition: .2s;
	transition: .2s;
}

.dropzone.dz-started .dz-message span.text {
	display: none;
}

.dropzone.dz-started .dz-message span.plus {
	display: block;
	font-size: 70px;
	color: #AAA;
	line-height: 110px;
}


</style>

<div class="content-wrapper">
	<div class="container-xxl flex-grow-1 container-p-y">

		<h2 class="fw-bold py-3 mb-4">홈 > 과제 > 상세보기</h2>
		<hr>
		<div class="col-lg">
			<div class="card">
				<div class="card-body">
					<h3>
						<b>${assignmentVO.assTitle }</b>
					</h3>
					<h5>최대점수 : ${assignmentVO.assMaxscore}</h5>
					<div id="date">
						<fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS"
							value="${assignmentVO.assRegdate}" />
						<fmt:formatDate var="regdate" pattern="yyyy-MM-dd"
							value="${regdate}" />
						<span>등록일 : ${regdate}</span>
						<fmt:parseDate var="edate" pattern="yyyy-MM-dd HH:mm:ss.SSS"
							value="${assignmentVO.assEdate}" />
						<fmt:formatDate var="edate" pattern="yyyy-MM-dd HH:mm"
							value="${edate}" />
						<span>마감일시 : ${edate}</span>
					</div>
				</div>

				<hr class="m-0" />
				<div class="card-body">
					<h5>${assignmentVO.assContent }</h5>

				</div>
			</div>
		</div>


		<hr class="my-5" />
		<!-- Bordered Table -->
		<div class="card">
			<h5 class="card-header">제출 상황</h5>
			<div class="card-body">
				<div class="table-responsive text-nowrap">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td><i class="fab fa-angular fa-lg text-danger me-3"></i>
								<strong>제출여부</strong></td>
								<c:if test="${not empty assignmentSubmitVO}">
									<td><font color="green">제출완료</font></td>
								</c:if>
								<c:if test="${empty assignmentSubmitVO}">
									<td><font color="red">미제출</font></td>
								</c:if>
							</tr>
							<tr>
								<td><i class="fab fa-angular fa-lg text-danger me-3"></i>
								<strong>채점 상황</strong></td>
								<c:choose>
									<c:when test="${empty assignmentSubmitVO.assSubScore || assignmentSubmitVO.assSubScore eq '0' }">
										<td><font color="black">채점되지 않음</font></td>
									</c:when>
									<c:otherwise>
									<td><font color="green">채점완료</font></td>
									</c:otherwise>
								</c:choose>
								

							</tr>
							<tr>
								<td><i class="fab fa-angular fa-lg text-danger me-3"></i>
								<strong>점수</strong></td>
								<c:if test="${empty assignmentSubmitVO.assSubScore}">
								 	 <c:set var="assSubScore" value="0"/>
								</c:if>
								<c:if test="${not empty assignmentSubmitVO.assSubScore}">
								 	<c:set var="assSubScore" value="${assignmentSubmitVO.assSubScore}"/>
								</c:if>
								<td>${assSubScore} / ${assignmentVO.assMaxscore}</td>

							</tr>
							<tr>
								<td><i class="fab fa-angular fa-lg text-danger me-3"></i>
								<strong>종료일시</strong></td>
								<td>${edate}</td>
							</tr>
							<tr>
								<td><i class="fab fa-angular fa-lg text-danger me-3"></i>
								<strong>마감까지 남은 기한</strong></td>
								<td>
								<%
								    Calendar now = Calendar.getInstance();
								    Calendar deadline = Calendar.getInstance();
								    String edate = (String)pageContext.getAttribute("edate");
								    
								    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
								    try {
								    	deadline.setTime(sdf.parse(edate)); 
								    } catch (ParseException e) {
								        e.printStackTrace();
								    }
								
								    long diffInSeconds = (deadline.getTimeInMillis() - now.getTimeInMillis()) / 1000;
								
								    long days = diffInSeconds / (24 * 60 * 60);
								    long hours = (diffInSeconds % (24 * 60 * 60)) / (60 * 60);
								    long minutes = ((diffInSeconds % (24 * 60 * 60)) % (60 * 60)) / 60;
								  %>
								
								  <c:set var="diffInSeconds" value="<%=diffInSeconds%>" />
								  <c:set var="remainingDays" value="<%=days%>" />
								  <c:set var="remainingHours" value="<%=hours%>" />
								  <c:set var="remainingMinutes" value="<%=minutes%>" />
								
								  <c:choose>
								    <c:when test="${diffInSeconds < 0}">
								     	<font color="red">마감일이 지났습니다.</font> 
								    </c:when>
								    <c:when test="${remainingDays > 0}">
								      ${remainingDays}일 ${remainingHours}시간 ${remainingMinutes}분 남았습니다.
								    </c:when>
								    <c:when test="${remainingHours > 0}" >
								      ${remainingHours}시간 ${remainingMinutes}분 남았습니다.
								    </c:when>
								    <c:otherwise>
								      ${remainingMinutes}분 남았습니다.
								    </c:otherwise>
								 
								  </c:choose>
								</td>
							</tr>
							<tr>
								<td><i class="fab fa-angular fa-lg text-danger me-3"></i>
								<strong>최종 수정 일시</strong></td>
								<fmt:parseDate var="assSubDate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${assignmentSubmitVO.assSubDate}" />
								<fmt:formatDate var="assSubDate" pattern="yyyy-MM-dd HH:mm" value="${assSubDate}" />
								<td>${assSubDate }</td>
							</tr>
							<tr>
								<td><i class="fab fa-angular fa-lg text-danger me-3"></i>
								<strong>제출물 설명</strong></td>
								<td>${assignmentSubmitVO.assSubComment }</td>
							</tr>

						</tbody>
					</table>
				</div>
			</div>
		</div>
	
		<!--/ Bordered Table -->
		<!-- Vertically Centered Modal -->
		<div class="col-lg-4 col-md-6">
			<div class="mt-3">
				<!-- Button trigger modal -->
				<c:choose>
					<c:when test="${not empty assignmentSubmitVO }">
						<c:set var="name" value="제출한과제 편집"/>
					</c:when>
					<c:otherwise>
						<c:set var="name" value="제출하기"/>
					</c:otherwise>
				</c:choose>
				
				<button type="button" id="subBtn" class="btn btn-primary" data-bs-toggle="modal"
					data-bs-target="#modalCenter" >${name}</button>

				<!-- Modal -->
				<div class="modal fade" id="modalCenter" tabindex="-1"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="modalCenterTitle">제출하기</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							
							<div class="modal-body">
								<div class="row">
									<div class="col mb-3" id="dropzoneArea">
										<label for="nameWithTitle" class="form-label">파일</label>
										<!-- 파일제출하는곳 -->
										<form action="/target" class="dropzone" id="dropzone">
										
											<ul class="list-unstyled mb-0" id="dropzone-preview">	
												<c:choose>
													<c:when test="${empty fileList }">
														<li class="mt-2 dropItem" id="dropzone-preview-list" style="display:none;">
															<!-- This is used as the file preview template -->
															<div class="border rounded-3">
																<div class="d-flex align-items-center p-2">
																	<div class="flex-shrink-0 me-3">
																		<div class="width-8 h-auto rounded-3">
																			<img data-dz-thumbnail="data-dz-thumbnail"
																				class="w-full h-auto rounded-3 block" src=""
																				alt="Dropzone-Image" style="width: 120px;" />
																		</div> 
																	</div>
																	<div class="flex-grow-1">
																		<div class="pt-1">
																			<h6 class="font-semibold mb-1"
																				data-dz-name="data-dz-name">${file.fileName }&nbsp;</h6>
																			<p class="text-sm text-muted fw-normal"
																				data-dz-size="data-dz-size">${file.fileFancysize }</p>
																			<strong class="error text-danger"
																				data-dz-errormessage="data-dz-errormessage"></strong>
																		</div>
																	</div>
																	<div class="shrink-0 ms-3">
																		<button type="button" data-dz-remove="data-dz-remove" data-file-no="${file.fileNo }" 
																			class="btn btn-sm btn-danger dropzone-del-btn">삭제</button>
																	</div>
																</div>
															</div>
														</li>
													</c:when>
												</c:choose>
												<c:forEach items="${fileList }" var="file">
													<li class="mt-2" id="dropzone-preview-list">
														<!-- This is used as the file preview template -->
														<div class="border rounded-3">
															<div class="d-flex align-items-center p-2">
																<div class="flex-shrink-0 me-3">
																	<div class="width-8 h-auto rounded-3">
																		<img data-dz-thumbnail="data-dz-thumbnail"
																			class="w-full h-auto rounded-3 block" src="${pageContext.request.contextPath }/resources/images/upload.png"
																			alt="Dropzone-Image" style="width: 120px;" />
																	</div> 
																</div>
																<div class="flex-grow-1">
																	<div class="pt-1">
																		<h6 class="font-semibold mb-1"
																			data-dz-name="data-dz-name">${file.fileName }&nbsp;</h6>
																		<p class="text-sm text-muted fw-normal"
																			data-dz-size="data-dz-size">${file.fileFancysize }</p>
																		<strong class="error text-danger"
																			data-dz-errormessage="data-dz-errormessage"></strong>
																	</div>
																</div>
																<div class="shrink-0 ms-3">
																	<button type="button" data-dz-remove="data-dz-remove" data-file-no="${file.fileNo }" 
																		class="btn btn-sm btn-danger dropzone-del-btn">삭제</button>
																</div>
															</div>
														</div>
													</li>
												</c:forEach>
											</ul>
										</form>
										<!-- 끝 -->
									</div>
								</div>
								<form id="insertForm" method="post" enctype="multipart/form-data">
									<sec:authentication property="principal" var="prc" />
									<c:set value="${prc.user.userNo}" var="userNo" />
									<input type="hidden" name="stuNo" value="${userNo}">
									<input type="hidden" name="assNo" value="${param.assNo}">
									<input type="hidden" name="fileGroupNo" value="${assignmentSubmitVO.fileGroupNo}">
									<input type="hidden" name="assSubNo" value="${assignmentSubmitVO.assSubNo}">
									<div class="row g-2">
										<div class="col mb-0">
											<label class="form-label">제출물 설명</label>
											<textarea class="form-control" name="assSubComment" rows="3" id="assSubComment"
												style="height: 271px;">${assignmentSubmitVO.assSubComment}</textarea>
										</div>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-outline-secondary"
									data-bs-dismiss="modal">닫기</button>
								<button type="button" id="insertBtn" class="btn btn-primary">저장</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
var addedFiles = [];
var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');	
// dropzonePreviewNode.id = "";
var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
// dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
// dropzonePreviewNode.parentNode.style.display = "none";

Dropzone.autoDiscover = false; // deprecated 된 옵션. false로 해놓는걸 공식문서에서 명시
const dropzone = new Dropzone('#dropzone', {
    url: "https://httpbin.org/post", // 파일을 업로드할 서버 주소 url. 
    method: "post", // 기본 post로 request 감. put으로도 할수있음

    previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
    previewsContainer:  '#dropzone-preview',
   init: function () {
      // 최초 dropzone 설정시 init을 통해 호출
      console.log('최초 실행');
      let myDropzone = this; // closure 변수 (화살표 함수 쓰지않게 주의)

      // 파일이 업로드되면 실행
      this.on('addedfile', function (file) {
    	  var items = $(".dropItem");
    	  for(var i = 0; i < items.length; i++){
    		  if(i == 0)
    			  continue;
	    	  items[i].style.display = "block";
    	  }
         // 중복된 파일의 제거
         if (this.files.length) {
            // -1 to exclude current file
            var hasFile = false;
            for (var i = 0; i < this.files.length - 1; i++) {
               if (
                  this.files[i].name === file.name &&
                  this.files[i].size === file.size &&
                  this.files[i].lastModifiedDate.toString() === file.lastModifiedDate.toString()
               ) {
                  hasFile = true;
                  this.removeFile(file);
               }
            }
            if (!hasFile) {
               addedFiles.push(file);
            }
         } else {
            addedFiles.push(file);
         }
      });
   },
   
});

$(function() {
	var insertBtn = $("#insertBtn");
/* 	var dzBtn = $(".dz-button").val();
	dzBtn.val("파일을 드래그 하거나 클릭하십시오."); */
	
	var delFileNos = [];
	// dropzone 이벤트
	$("#dropzoneArea").on("click", ".dropzone-del-btn", function(){
		var fileNo = $(this).data("file-no"); 
// 		var html = "<input type='hidden' name='delFileNo' value='" + fileNo + "'/>";
// 		$("#insertForm").append(html);
		delFileNos.push(fileNo);	// 삭제 내역 공간에 삭제 버튼을 누를때마다 삭제할 파일 번호를 담는다.
		$(this).parents("li").hide();
	});
	
	//저장 버튼 클릭
	insertBtn.on("click", function() {
		
		let subUrl = "/assignment/insertAssignmentSubmit.do"; 
		
		if($("#subBtn").html().includes("편집")){
			subUrl = "/assignment/updateAssignmentSubmit.do"; 	
		}
		
		let stuNo = $("input[name='stuNo']").val();
		let assNo = $("input[name='assNo']").val();
		let fileGroupNo = $("input[name='fileGroupNo']").val();
		let assSubNo = $("input[name='assSubNo']").val();
		let assSubComment = $("#assSubComment").val();
		
		console.log("stuNo : " + stuNo);
		console.log("assNo : " + assNo);
		console.log("assSubComment : " + assSubComment);
		console.log("delFileNos : " + delFileNos);
		console.log("addedFiles : " + addedFiles);

		let formData = new FormData();
		formData.append("stuNo", stuNo);
		formData.append("assNo", assNo);
		formData.append("fileGroupNo", fileGroupNo);
		formData.append("assSubComment", assSubComment);
		formData.append("assSubNo", assSubNo);
		formData.append("delFileNo", delFileNos);	// 기존 파일중 삭제 하려고 하는 파일 번호들
		for(var i = 0; i < addedFiles.length; i++){
			formData.append("assFile", addedFiles[i]);
		}
		
		// 파일 첨부가 필수인 경우 체크
	    if(addedFiles.length === 0){
	        alert("파일을 첨부해 주십시오.");
	        return false; 
	    }
		
		$.ajax({
			url : subUrl,
			type : "post",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			contentType:false,
			processData:false,
			data : formData,
			dataType : "text",
			success : function(result) {
				if(result == "SUCCESS"){
					Swal.fire({
                        title: '제출완료',
                        text: '제출이 완료되었습니다.',
                        icon: 'success',
                        confirmButtonText: '확인'
                    })
					console.log("result : ", result);
				  // 모달 닫기
				  const modal = document.querySelector('.modal');
				  const modalInstance = bootstrap.Modal.getInstance(modal);
				  modalInstance.hide();
					
				}
			}
		});
	});



})
</script>
</html>
