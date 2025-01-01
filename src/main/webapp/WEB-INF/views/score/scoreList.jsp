<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">성적조회</h4>
	<div class="row mb-5">
		<div class="col-md-6 col-lg-12 mb-3">
		
			<div class="card mb-4 bg-white">
				<div class="card-header">
					<form action="" method="get" id="searchFrm">
						<sec:csrfInput/>
						<div class="row mb-3" id="searchDiv">
							
							<div class="col-sm-4">
								<div class="input-group">
									<label class="input-group-text" for="year">년도</label>
									<select class="form-select" name="year" id="year">
										<option value="">==전체==</option>
										<c:forEach items="${yearList }" var="y">
											<option value="${y.ysYear }" <c:if test="${y.ysYear eq year }">selected='selected'</c:if>>${y.ysYear }</option>
										</c:forEach>
									</select>
									<label class="input-group-text" for="semester">학기</label>
									<select class="form-select" name="semester" id="semester">
										<option value="">==전체==</option>
										<option value="1" <c:if test="${1 eq semester }">selected='selected'</c:if>>1학기</option>
										<option value="2" <c:if test="${2 eq semester }">selected='selected'</c:if>>2학기</option>
									</select>
								</div>
							</div>
						
						</div>
					</form>
				</div>
				<hr class="my-0">
				<div class="card-body">
					<table class="table">
						<thead>
							<tr>
								<th width="10%">년도</th>
								<th width="10%">학기</th>
								<th width="50%">강의명</th>
								<th width="10%">학점</th>
								<th width="10%">성적</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${scoreList }" var="score" varStatus="status">
								<tr>
									<td>${score.YEAR }</td>
									<td>${score.SEMESTER }</td>
									<td>${score.LEC_NAME }</td>
									<td>${score.LEC_SCORE }</td>
									<td>${score.COU_SCORE }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>



<script>

$(function(){
	
	var searchFrm = $("#searchFrm");
	
	$(".form-select").on('change', function(){
		searchFrm.submit();
	});
	
});

</script>






















