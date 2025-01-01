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
#pagingArea{
	display: flex;
	justify-content: center;
}


</style>
</head>
<body>
	<!-- Content wrapper -->
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">

			<h2 class="fw-bold py-3 mb-4">강의자료실</h2>
			<div class="card">
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>등록일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody class="table-border-bottom-0">
							<c:choose>
								<c:when test="${empty pagingVO.dataList }">
									<tr>
										<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${pagingVO.dataList }" var="lectureData">
										<tr>
											<td>${lectureData.rnum }</td>
											<td><a href="/professor/selectLectureDataDetail.do?lecDataNo=${lectureData.lecDataNo }&lecNo=${lecNo}">
													${lectureData.lecDataTitle }</a></td>
											<fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${lectureData.lecDataRegdate}"/>
											<fmt:formatDate var="regdate" pattern="yyyy-MM-dd" value="${regdate }"/>
											<td>${regdate}</td>
											<td>${lectureData.lecDataCnt }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>

					</table>
				</div>
				<div class="card-footer row">
					<div class="col-sm-8" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
					<div class="col-sm-4">
						<button type="button" class="btn btn-primary" id="insertBtn" style="float:right;">자료등록</button>
					</div>
				</div>
				<form id="pageInfo">
					<input type="hidden" name="page" id="page">
					<input type="hidden" name="lecNo" value="${lecNo }">
					<sec:csrfInput />
				</form>
				<!--/ Hoverable Table rows -->
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	var pagingArea = $("#pagingArea");
	var pageInfo = $("#pageInfo");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		// 검색시 사용할 form 태그안에 넣어준다. 
		// 검색시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		pageInfo.find("#page").val(pageNo);
		pageInfo.submit();
	});
	
	var insertBtn = $("#insertBtn");
	
	insertBtn.on("click", function(){
		location.href="/professor/lectureDataForm.do?lecNo=${param.lecNo }";
	})
	
})

</script>
</html>