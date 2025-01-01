<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>





<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">강의신청내역</h4>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<div class="card-header">
					<form action="" method="get" id="searchFrm">
						<sec:csrfInput/>
						<input type="hidden" name="page" id="page">
						<div class="row mb-3" id="searchDiv">
							
							<div class="col-sm-6">
								<div class="input-group">
									<label class="input-group-text" for="searchYear">년도/학기</label>
									<select class="form-select" name="searchYear" id="searchYear">
										<option></option>
										<c:forEach items="${yearList }" var="year">
											<option value="${year }"
												<c:if test="${year eq pagingVO.searchYear }">
													selected='selected'
												</c:if>>
												${year }
											</option>
										</c:forEach>
									</select>
									<select class="form-select" name="searchSemester" id="searchSemester">
										<option value="1" <c:if test="${pagingVO.searchSemester eq 1 }">selected='selected'</c:if>>1학기</option>
										<option value="2" <c:if test="${pagingVO.searchSemester eq 2 }">selected='selected'</c:if>>2학기</option>
									</select>
									<label class="input-group-text" for="searchConType">승인여부</label>
									<select class="form-select" name="searchConType" id="searchConType">
										<option></option>
										<c:forEach items="${comCNoList }" var="comCon">
											<option value="${comCon.comDetNo }"
												<c:if test="${comCon.comDetNo eq pagingVO.searchConType }">
													selected='selected'
												</c:if>>
												${comCon.comDetName }
											</option>
										</c:forEach>
									</select>
									<button class="btn btn-primary" id="searchBtn">검색</button>
								</div>
							</div>
							
						</div>
					</form>
				</div>
				<div class="card-body">
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover" style="overflow:hidden;">
	      					<thead>
	        					<tr>
						          	<th width="10%">강의구분</th>
						          	<th width="25%">강의명</th>
						          	<th width="10%">수강학년</th>
						          	<th width="10%">학점</th>
						          	<th width="15%">년도/학기</th>
						          	<th width="10%">대면여부</th>
						          	<th width="10%">승인여부</th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:choose>
      							<c:when test="${pagingVO.dataList ne null}">
		      						<c:forEach items="${pagingVO.dataList }" var="lecture" varStatus="status">
			      						<tr>
			      							<td>${lecture.comDetLName }</td>
			      							<td class="lecNo" data-no="${lecture.lecNo }">${lecture.lecName }</td>
			      							<td>${lecture.lecAge }</td>
			      							<td>${lecture.lecScore }</td>
			      							<td>${lecture.year } / ${lecture.semester }</td>
			      							<td>
			      								<c:if test="${lecture.lecOnoff eq 'Y' }">대면</c:if>
			      								<c:if test="${lecture.lecOnoff ne 'Y' }">비대면</c:if>
			      							</td>
			      							<td>${lecture.comDetCName }</td>
			      						</tr>      						
			      					</c:forEach>
      							</c:when>
      							<c:otherwise>
      								<tr>
      									<td colspan="7">없음</td>
      								</tr>
      							</c:otherwise>
      						</c:choose>
	      					</tbody>
	   	 				</table>
	  				</div>
				</div>
				<div class="card-footer">
	  				<div class="row mb-3">
		  				<div class="col-sm-6" id="pagingDiv" style="margin-top: 20px;">
		  					${pagingVO.pagingHTML }
		  				</div>
		  				<div class="col-sm-5">
						</div>
						<div class="col-sm-1">
							<form action="/professor/lectureSignUp" id="signUpFrm" method="post">
								<sec:csrfInput/>
								<input type="hidden" name="proNo" id="proNo" value="${proVO.proNo }">
							</form>
							<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
						</div>
	  				</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script>

$(function(){
	
	var searchBtn = $("#searchBtn");
	var searchFrm = $("#searchFrm");
	var signUpFrm = $("#signUpFrm");
	var insertBtn = $("#insertBtn");
	var pagingDiv = $("#pagingDiv");
	
	searchBtn.on('click', function(){
		searchFrm.submit();
	});
	
	insertBtn.on('click', function(){
		signUpFrm.submit();
	});
	
	pagingDiv.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		searchFrm.find("#page").val(pageNo);
		searchFrm.submit();
	});
	
	$("#tbody").on('click', 'tr', function(){
		
		var lecNo = $(this).find('.lecNo').attr("data-no");
		location.href="/professor/lectureDetail?lecNo="+lecNo;
	});
	
	
});

</script>




















