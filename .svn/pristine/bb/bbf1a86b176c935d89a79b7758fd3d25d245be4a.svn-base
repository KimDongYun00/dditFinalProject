<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">
			<h3 class="fw-bold py-3 mb-4">강의 목록</h3>
			<!-- Text alignment -->

			<div class="row mb-5" id="lectureDiv">
				<c:choose>
					<c:when test="${empty lectureList }">
						<h3>강의가 존재하지 않습니다.</h3>
					</c:when>
					<c:otherwise>
						<c:forEach items="${lectureList }" var="list">
							<div class="col-md-6 col-lg-4 mb-4">								
									<div class="card text-center" onclick="javascript:location.href='/professor/lectureDetail.do?lecNo=${list.lecNo }'">
										<div class="card-body">
											<h4 class="card-title">${list.lecName }</h4>
											<p class="card-text">${list.year }년도 ${list.semester }학기</p>
											<p class="card-text">수강학년 : ${list.lecAge }학년</p>
											<button id="noticeBtn" class="btn btn-primary noticeBtn" data-lecno="${list.lecNo }">공지사항</button>
											<button id="assBtn" class="btn btn-primary assBtn" data-lecno="${list.lecNo }">과제목록</button>											
										</div>
									</div>								
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			
		</div>
	</div>
</body>
<script type="text/javascript">
var lectureDiv = $("#lectureDiv");

lectureDiv.on("click", ".noticeBtn", function(event){
    let lecNo = $(this).data("lecno");
	location.href = "/lectureNotice/selectLectureNotice.do?lecNo="+lecNo;
})
lectureDiv.on("click", ".assBtn", function(event){
    let lecNo = $(this).data("lecno");
    location.href = "/professor/selectAssignmentList.do?lecNo="+lecNo;
});
</script>
</html>