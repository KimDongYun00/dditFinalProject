<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style type="text/css">
#pagingArea{
	display: flex;
	justify-content: center;
}


</style>

	<!-- Content wrapper -->
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">

			<h2 class="fw-bold py-3 mb-4">홈 > 과제목록</h2>
			<hr>
			<!-- Hoverable Table rows -->
			<div class="card">

				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr style="text-align: center;">
								<th>번호</th>
								<th>내용</th>
								<th>등록일자</th>
								<th>마감일시</th>
								<th>최대점수</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody class="table-border-bottom-0">
							<c:set value="${pagingVO.dataList }" var="assignmentList" />
							<c:choose>
								<c:when test="${empty assignmentList }">
									<tr style="text-align: center;">
										<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${assignmentList }" var="assign">
										<tr style="text-align: center;">
											<td>${assign.rnum }</td>
											<td style="text-align: left;"><a href="/assignment/selectAssignmentDetail.do?assNo=${assign.assNo }&lecNo=${lecNo}">
													${assign.assTitle }</a></td>
											<fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${assign.assRegdate}"/>
											<fmt:formatDate var="regdate" pattern="yyyy-MM-dd" value="${regdate }"/>
											<td>${regdate }</td>
											<fmt:parseDate var="eDate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${assign.assEdate}"/>
											<fmt:formatDate var="eDate" pattern="yyyy-MM-dd HH:mm" value="${eDate }"/>
											<td>${eDate}</td>
											<td>${assign.assMaxscore}</td>
											<td>
												<c:if test="${assign.assSubmit eq '미제출'}">
													<font color="red">${assign.assSubmit}</font>
												</c:if>
												<c:if test="${assign.assSubmit eq '제출'}">
													<font color="green">${assign.assSubmit}</font>
												</c:if>
											</td>
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
	
	
	
})

</script>
