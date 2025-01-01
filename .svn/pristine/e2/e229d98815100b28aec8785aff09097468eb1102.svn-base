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

			<h2 class="fw-bold py-3 mb-4">홈 > 강의공지 > 상세보기</h2>
			<hr>
			<div class="col-lg">
				<div class="card">
					<div class="card-body">
						<h3>
							<b>${lectureNoticeVO.lecNotTitle }</b>
						</h3>
						<div id="date">
							<fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${lectureNoticeVO.lecNotDate}" />
							<fmt:formatDate var="regdate" pattern="yyyy-MM-dd" value="${regdate}" />
							<span>등록일 : ${regdate}</span>
							<span>조회수 : ${lectureNoticeVO.lecNotCnt }</span>
						</div>
					</div>
					
					<hr class="m-0" />
					<div class="card-body">
						<h5>${lectureNoticeVO.lecNotContent }</h5>

					</div>
				</div>
			</div>
			<br>
			<div class="container mt-2">
	      		 <a href="${pageContext.request.contextPath}/lectureNotice/selectLectureNotice.do?lecNo=${lectureNoticeVO.lecNo}" class="btn btn-primary">목록으로</a>
		        	
		        	<c:if test="${prc.user.comDetUNo eq 'U0102'}">
			        	<input type="button" id="modifyBtn" value="수정" class="btn btn-primary">
			        	<input type="button" id="deleteBtn" value="삭제" class="btn btn-danger">
			        	<form action="/lectureNotice/deleteLectureNotice.do" method="post" id="delForm">
			        		<input type="hidden" name="lecNotNo" value="${lectureNoticeVO.lecNotNo }" >
			        		<input type="hidden" name="lecNo" value="${lectureNoticeVO.lecNo }" >
			        		<sec:csrfInput />
			        	</form>
		        	</c:if>
			</div>
			


		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		var modifyBtn = $("#modifyBtn");
		var deleteBtn = $("#deleteBtn");
		
		modifyBtn.on("click", function(){
			location.href="/lectureNotice/updateLectureNotice.do?lecNo=${param.lecNo}&lecNotNo=${lectureNoticeVO.lecNotNo}";
		})
		
		deleteBtn.on("click", function(){
			if(confirm("정말로 삭제하시겠습니까?")){
		         delForm.submit();
		     }
		})
		

	})
</script>
</html>
