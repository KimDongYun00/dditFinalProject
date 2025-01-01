<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


	<!-- Content wrapper -->
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">

			<h2 class="fw-bold py-3 mb-4">과제관리</h2>
			<!-- Hoverable Table rows -->
			<div class="card">
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>내용</th>
								<th>등록일</th>
								<th>마감일시</th>
							</tr>
						</thead>
						<tbody class="table-border-bottom-0">
							<c:set value="${pagingVO.dataList }" var="assignmentList" />
							<c:choose>
								<c:when test="${empty assignmentList }">
									<tr>
										<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${assignmentList }" var="assign">
										<tr>
											<td>${assign.rnum }</td>
											<td><a href="/professor/selectAssignmentDetail.do?assNo=${assign.assNo }&lecNo=${lecNo}">
													${assign.assTitle }</a></td>
											<fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${assign.assRegdate}"/>
											<fmt:formatDate var="regdate" pattern="yyyy-MM-dd" value="${regdate }"/>
											<td>${regdate }</td>
											<fmt:parseDate var="eDate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${assign.assEdate}"/>
											<fmt:formatDate var="eDate" pattern="yyyy-MM-dd HH:mm" value="${eDate }"/>
											<td>${eDate}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>

					</table>
				</div>
				<div class="card-footer row">
					<c:if test="${not empty assignmentList }">
						<div class="col-sm-8" id="pagingArea">
							${pagingVO.pagingHTML }
						</div>
					</c:if>
					<div class="col-sm-4">
						<button type="button" class="btn btn-primary" id="insertBtn" style="float:right;">자료등록</button>
					</div>
				</div>
				<form id="pageInfo">
					<input type="hidden" name="page" id="page">
					<input type="hidden" name="lecNo" value="${lecNo }">
					<sec:csrfInput />
				</form>
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
		location.href="/professor/assignmentForm.do?lecNo=${param.lecNo }";
	})
	
})

</script>
