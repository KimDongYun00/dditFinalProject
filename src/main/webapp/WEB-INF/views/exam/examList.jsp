<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!-- 시큐리티 회원권한 가져오기 -->
<sec:authentication property="principal" var="prc" />
<c:set value="${prc.user.comDetUNo }" var="auth" />
<input type="hidden" id="auth" value="${auth }">


<div class="container-xxl flex-grow-1 container-p-y">
	<c:if test="${auth eq 'U0101' }">
		<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">시험목록</h4>
	</c:if>
	<c:if test="${auth eq 'U0102' }">
		<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">시험관리</h4>
	</c:if>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<div class="card-header">
					<form action="" method="get" id="searchFrm">
						<sec:csrfInput/>
						<input type="hidden" name="lecNo" value="${lecNo }">
						<div class="row mb-3" id="searchDiv">
							
							<div class="col-sm-2">
								<div class="input-group">
									<label class="input-group-text" for="searchType">시험구분</label>
									<select class="form-select" name="searchType" id="searchType">
										<option></option>
										<option value="H0101" <c:if test="${searchType eq 'H0101' }">selected='selected'</c:if>>중간고사</option>
										<option value="H0102" <c:if test="${searchType eq 'H0102' }">selected='selected'</c:if>>기말고사</option>
										<option value="H0103" <c:if test="${searchType eq 'H0103' }">selected='selected'</c:if>>쪽지시험</option>
									</select>
								</div>
							</div>
						
						</div>
					</form>
				</div>
				<hr class="my-0">
				<div class="card-body">
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover" style="overflow:hidden;">
	      					<thead>
	        					<tr>
						          	<th width="10%">시험구분</th>
						          	<th width="60%">시험명</th>
						          	<th width="15%">시험일시</th>
						          	<th width="15%">등록일시</th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:choose>
	      							<c:when test="${examList ne null}">
			      						<c:forEach items="${examList }" var="exam" varStatus="status">
				      						<tr>
				      							<td>${exam.comDetHName }</td>
				      							<td class="examNo" data-no="${exam.examNo }">${exam.examName }</td>
				      							<td>${exam.examDate }</td>
				      							<td>
				      								<fmt:parseDate value="${exam.examRegdate }" var="regDate" pattern="yyyy-MM-dd HH:mm"/>
				      								<fmt:formatDate value="${regDate }" pattern="yyyy-MM-dd HH:mm"/>
				      							</td>
				      						</tr>      						
				      					</c:forEach>
	      							</c:when>
	      							<c:otherwise>
	      								<tr>
	      									<td colspan="4">없음</td>
	      								</tr>
	      							</c:otherwise>
	      						</c:choose>
	      					</tbody>
	   	 				</table>
	  				</div>
				</div>
				<div class="card-footer">
					<!-- 등록 버튼 -->
					<c:if test="${auth ne 'U0101' }">
						<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>


<script>

$(function(){
	
	var searchFrm = $("#searchFrm");
	var searchType = $("#searchType");
	var insertBtn = $("#insertBtn");
	var tbody = $("#tbody");
	
	insertBtn.on('click', function(){
		location.href="/exam/examInsertForm?lecNo=${lecNo}";
	});
	
	searchType.on('change', function(){
		searchFrm.submit();
	});
	
	tbody.on('click', 'tr', function(){
		var examNo = $(this).find('.examNo').attr("data-no");
		location.href="/exam/examDetail?examNo="+examNo+"&lecNo=${lecNo}";
	});
	
});

</script>


































