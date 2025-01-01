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

			<h2 class="fw-bold py-3 mb-4">홈 > 강의명 > 참여자목록</h2>
			<hr>
			<form>
				<input type="hidden" name="lecNo" value="${param.lecNo}" /> <input
					type="hidden" name="page" id="page" />

				<div class="filter-container"
					style="display: flex; align-items: center;">
					<div class="filter-item" style="margin-right: 10px;">
						<select class="form-select" name="searchType"
							style="width: 150px;">
							<option value="stuNo"
								<c:if test="${searchType eq 'stuNo' }">selected</c:if>>학번</option>
							<option value="stuName"
								<c:if test="${searchType eq 'stuName' }">selected</c:if>>이름</option>
						</select>
					</div>
					<div class="filter-item" style="margin-right: 10px;">
						<div class="input-group input-group-merge">
							<input type="text" name="searchWord" value="${searchWord }"
								class="form-control" placeholder="Search">
							<button type="submit" class="btn btn-primary">검색</button>
						</div>
					</div>
				</div>
				<sec:csrfInput />
			</form>
			<br>
			<div class="card">
				<div class="table-responsive text-nowrap">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>학번</th>
								<th>학과</th>
								<th>학년</th>
								<th>이름</th>
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
									<c:forEach items="${pagingVO.dataList }" var="student">
										<tr>
											<td>${student.stuNo }</td>
											<td>${student.studentVO.departmentVO.deptName }</td>
											<td>${student.studentVO.stuYear }</td>
											<td>${student.studentVO.stuName }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>

					</table>
				</div>
				<div class="card-footer clearfix" id="pagingArea">
					${pagingVO.pagingHTML }</div>
				<form id="pageInfo">
					<input type="hidden" name="page" id="page"> <input
						type="hidden" name="lecNo" value="${lecNo }">
					<sec:csrfInput />
				</form>
				<!--/ Hoverable Table rows -->
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		var pagingArea = $("#pagingArea");
		var pageInfo = $("#pageInfo");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page");
			// 검색시 사용할 form 태그안에 넣어준다. 
			// 검색시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
			pageInfo.find("#page").val(pageNo);
			pageInfo.submit();
		})

	})
</script>
</html>