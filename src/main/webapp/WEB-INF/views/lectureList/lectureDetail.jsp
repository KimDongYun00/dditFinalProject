<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
a {
/*   color: inherit; */
  text-decoration: none;
  color:#444444;
}
</style>
</head>
<body>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">
		
			<h2 class="fw-bold py-3 mb-4">${lectureVO.lecName }</h2>
			<div class="row">
			
				<div class="col-lg-6 mb-4">
					<div class="card">
						<div style="display: flex; justify-content: space-between;">
							<h5 class="card-header" style="width: 130px;" ><a href="/lectureNotice/selectLectureNotice.do?lecNo=${lecNo }">강의공지</a></h5>
							<a href="/lectureNotice/selectLectureNotice.do?lecNo=${lecNo }" class="btn btn-outline-primary" style="width: 90px; height: 35px; margin: 20px;">더보기</a>
						</div>
						<div class="table-responsive text-nowrap">
							<table class="table table-hover">
								<thead>
									<tr>
										<th width="70%;">공지명</th>
										<th width="30%;">등록일</th>
									</tr>
								</thead>
								<tbody class="table-border-bottom-0">
									<c:choose>
										<c:when test="${empty lectureNoticeList }">
											<tr>
												<td colspan="2">공지가 없습니다.</td>
											</tr>
										</c:when>
										 <c:otherwise>
		                                 <c:forEach items="${lectureNoticeList }" var="noticeList">
		                                    <tr>
		                                       <td>
			                                       <a href="/lectureNotice/selectLectureNoticeDetail.do?lecNotNo=${noticeList.lecNotNo }">
				                                       ${noticeList.lecNotTitle }
			                                       </a>
		                                       </td>
		                                       <fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${noticeList.lecNotDate}" />
											   <fmt:formatDate var="regdate" pattern="yyyy-MM-dd HH:mm" value="${regdate}" />
		                                       <td>${regdate}</td>
		                                    </tr>
		                                 </c:forEach>
		                              </c:otherwise>
									</c:choose>
								</tbody>
		
							</table>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6 mb-4">
					<div class="card">
						<div style="display: flex; justify-content: space-between;">
							<h5 class="card-header" style="width: 130px;">과제목록</h5>
							<a href="/assignment/selectAssignmentList.do?lecNo=${lecNo }" class="btn btn-outline-primary" style="width: 90px; height: 35px; margin: 20px;">더보기</a>
						</div>
						<div class="table-responsive text-nowrap">
							<table class="table table-hover">
								<thead>
									<tr>
										<th width="70%;">과제명</th>
										<th width="30%;">등록일</th>
									</tr>
								</thead>
								<tbody class="table-border-bottom-0">
									<c:choose>
										<c:when test="${empty assignmentList }">
											<tr>
												<td colspan="2">과제가 없습니다.</td>
											</tr>
										</c:when>
										 <c:otherwise>
		                                 <c:forEach items="${assignmentList }" var="assignList">
		                                    <tr>
		                                       <td>
			                                       <a href="/assignment/selectAssignmentDetail.do?lecNo=${lecNo}&assNo=${assignList.assNo }">
				                                       ${assignList.assTitle }
			                                       </a>
		                                       </td>
		                                       <fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${assignList.assRegdate}" />
											   <fmt:formatDate var="regdate" pattern="yyyy-MM-dd HH:mm" value="${regdate}" />
		                                       <td>${regdate}</td>
		                                    </tr>
		                                 </c:forEach>
		                              </c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6 mb-4">
					<div class="card">
						<div style="display: flex; justify-content: space-between;">
							<h5 class="card-header" style="width: 130px;">시험목록</h5>
							<a href="/exam/examList?lecNo=${lecNo }" class="btn btn-outline-primary" style="width: 90px; height: 35px; margin: 20px;">더보기</a>
						</div>
						<div class="table-responsive text-nowrap">
							<table class="table table-hover">
								<thead>
									<tr>
										<th width="70%;">시험명</th>
										<th width="30%;">등록일</th>
									</tr>
								</thead>
								<tbody class="table-border-bottom-0">
									<c:choose>
										<c:when test="${empty examList }">
											<tr>
												<td colspan="2">시험이 없습니다.</td>
											</tr>
										</c:when>
										 <c:otherwise>
		                                 <c:forEach items="${examList }" var="examList">
		                                    <tr>
		                                       <td>
			                                       <a href="/exam/examDetail.do?examNo=${examList.examNo }">
				                                       ${examList.examName }
			                                       </a>
		                                       </td>
		                                       <td>${examList.examDate}</td>
		                                    </tr>
		                                 </c:forEach>
		                              </c:otherwise>
									</c:choose>
								</tbody>
		
							</table>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6 mb-4">
					<div class="card">
						<div style="display: flex; justify-content: space-between;">
							<h5 class="card-header" style="width: 130px;">강의자료실</h5>
							<a href="/lectureData/selectLectureDataList.do?lecNo=${lecNo }" class="btn btn-outline-primary" style="width: 90px; height: 35px; margin: 20px;">더보기</a>
						</div>
						<div class="table-responsive text-nowrap">
							<table class="table table-hover">
								<thead>
									<tr>
										<th width="70%;">제목</th>
										<th width="30%;">등록일</th>
									</tr>
								</thead>
								<tbody class="table-border-bottom-0">
									<c:choose>
										<c:when test="${empty lecDataList }">
											<tr>
												<td colspan="2">강의자료가 없습니다.</td>
											</tr>
										</c:when>
										 <c:otherwise>
		                                 <c:forEach items="${lecDataList }" var="data">
		                                    <tr>
		                                       <td>
			                                       <a href="/lectureData/selectLectureDataDetail.do?lecDataNo=${data.LEC_DATA_NO }&lecNo=${lecNo}">
				                                       ${data.LEC_DATA_TITLE }
			                                       </a>
		                                       </td>
		                                       <fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${data.LEC_DATA_REGDATE }" />
											   <fmt:formatDate var="regdate" pattern="yyyy-MM-dd HH:mm" value="${regdate }" />
		                                       <td>${regdate }</td>
		                                    </tr>
		                                 </c:forEach>
		                              </c:otherwise>
									</c:choose>
								</tbody>
		
							</table>
						</div>
					</div>
				</div>
			</div>
			
			<!--/ Hoverable Table rows -->
		</div>
	</div>
</body>
<script type="text/javascript">
var noticeBtn = $("#noticeBtn");
var assBtn = $("#assBtn");

noticeBtn.on("click", function(){
    event.preventDefault(); // 기본 링크 동작 방지
	location.href = "/professor/lectureDetail/notice.do?lecNo=${list.lecNo }";
})
assBtn.on("click", function(event){
      event.preventDefault();
      location.href = "/professor/lectureDetail/assignment.do?lecNo=${list.lecNo }";
});

</script>
</html>