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
<title>LectureData Detail</title>
<style type="text/css">
#pagingArea {
	display: flex;
	justify-content: center;
}


</style>
</head>
<body>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">

			<h2 class="fw-bold py-3 mb-4">홈 > 강의자료실 > 상세보기</h2>
			<hr>
			<div class="col-lg">
				<div class="card">
					<div class="card-body">
						<h3>
							<b>${lectureDataVO.lecDataTitle }</b>
						</h3>
						<div id="date">
							<fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${lectureDataVO.lecDataRegdate}" />
							<fmt:formatDate var="regdate" pattern="yyyy-MM-dd" value="${regdate}" />
							<span>등록일 : ${regdate}</span>
							<span>조회수 : ${lectureDataVO.lecDataCnt }</span>
						</div>
					</div>
					
					<hr class="m-0" />
					<div class="card-body">
					<c:if test="${not empty fileList }">
						<c:forEach items="${fileList }" var="file">
							<div class="mailbox-attachment-info">
								<label for="recFiles" class="form-label me-3 my-auto">
			                                 <i class="bi bi-file-earmark-arrow-down"></i>
			                                 <span>첨부파일</span>
			                    </label>
			                    	
										<span class="mailbox-attachment-size clearfix mt-1"> 
											<a href="/common/fileDownload.do?fileGroupNo=${file.fileGroupNo}&fileNo=${file.fileNo}"> 
												${file.fileName }
											</a>
											<span>${file.fileFancysize }</span>
										</span>
								
							</div>
						</c:forEach>
					</c:if>						
					<c:if test="${empty fileList }" >
						<div class="mailbox-attachment-info">
									<label for="recFiles" class="form-label me-3 my-auto">
				                                 <i class="bi bi-file-earmark-arrow-down"></i>
				                                 <span>첨부파일</span>
				                    </label>
							<span class="mailbox-attachment-size clearfix mt-1"> 
								<a href="#"> 
									파일이 없습니다.
								</a>
								<span></span>
							</span>
						</div>	
					</c:if>	
					</div>
					<hr class="m-0" />
					<div class="card-body">
						<h5>${lectureDataVO.lecDataContent }</h5>

					</div>
					<div class="card-footer">
			        	<input type="button" id="deleteBtn" value="삭제" class="btn btn-danger" style="float:right;">
			        	<input type="button" id="modifyBtn" value="수정" class="btn btn-primary" style="float:right;">
			        	<form action="/professor/deleteLectureData.do" method="post" id="delForm">
			        		<input type="hidden" name="lecDataNo" value="${lectureDataVO.lecDataNo }" >
			        		<input type="hidden" name="lecNo" value="${lectureDataVO.lecNo }" >
			        		<sec:csrfInput />
			        	</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		var modifyBtn = $("#modifyBtn");
		var deleteBtn = $("#deleteBtn");
		
		modifyBtn.on("click", function(){
			location.href="/professor/updateLectureData.do?lecNo=${param.lecNo}&lecDataNo=${lectureDataVO.lecDataNo}";
		})
		
		deleteBtn.on("click", function(){
			if(confirm("정말로 삭제하시겠습니까?")){
		         delForm.submit();
		     }
		})
		

	})
</script>
</html>
