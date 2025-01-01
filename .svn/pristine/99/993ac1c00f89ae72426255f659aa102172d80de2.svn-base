<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">휴가 > 휴가신청목록</h5>
				<hr class="mb-0"/>
				<div class="card-body">
					<form action="" id="searchForm">
						<div class="row mb-3">
							<div class="col-6">
								<div class="input-group">
									<label class="input-group-text">승인여부</label>
									<select class="form-select" name="searchType" id="searchType">
										<option value="C99" <c:if test="${searchType eq 'C99' }">selected</c:if>>== 전체 ==</option>
										<option value="C0101" <c:if test="${searchType eq 'C0101' }">selected</c:if>>승인</option>
										<option value="C0102" <c:if test="${searchType eq 'C0102' }">selected</c:if>>미승인</option>										
										<option value="C0103" <c:if test="${searchType eq 'C0103' }">selected</c:if>>반려</option>
									</select>										
									<label class="input-group-text">검색타입</label>
									<select class="form-select" name="assNo" id="assNo"> 
										<option value="C99" <c:if test="${assNo eq 'C99' }">selected</c:if>>== 전체 ==</option>
										<option value="proNo"  <c:if test="${assNo eq 'proNo' }">selected</c:if>>아이디</option>
										<option value="proName" <c:if test="${assNo eq 'proName' }">selected</c:if>>이름</option>
									</select>					
									<span class="input-group-text" id="basic-addon-search31"><i class="bx bx-search"></i></span>	
									<input type="text" name="searchWord" class="form-control" value="${searchWord }" 
									 placeholder="검색어를 입력하세요"
	                          		aria-label="Search..."
	                          		aria-describedby="basic-addon-search31">
									<button type="submit" class="btn btn-outline-primary">검색</button>
								</div>
							</div>
						</div>
					</form>
					<div class="row mb-3">
						<div class="table-responsive text-nowrap"  style="overflow:hidden;">	
						
							<table class="table table-hover" style="text-align: center;">
								<thead>
									<tr>
										<th></th>
										<th>아이디</th>
										<th>이름</th>
										<th>목적</th>
										<th>신청일자</th>
										<th>시작일자</th>
										<th>끝난일자</th>
										<th>상태</th>
										<th>상세보기</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${pagingVO.dataList }" var="vac">
										<tr>
											<td>${vac.rnum }</td>
											<td>${vac.userNo }</td>
											<td>${vac.proName }</td>
											<td style="text-align: left;">${vac.vacContent }</td>
											<td>${vac.vacRegdate }</td>
											<td>${vac.vacSdate }</td>
											<td>${vac.vacEdate }</td>
											<td>
												<c:forEach items="${cList }" var="codeC">
													<c:if test="${codeC.comDetNo eq vac.comDetCNo }">${codeC.comDetName }</c:if> 
												</c:forEach>
											</td>
											<td>
												<a href="/vacation/empVacationDetail?vacNo=${vac.vacNo }" class="btn btn-outline-primary">
													상세보기
												</a>											
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						
			  			<div class="card-footer clearfix" id="pagingArea">
			                 ${pagingVO.pagingHTML }
			            </div>
						<br>
	<!-- 					<input class="btn btn-primary" type="button" value="일괄승인" id="agree"/> -->		            	
					</div>
				</div>
			</div>
		</div>
	</div>
</div>			
<script>
$(function(){
	var pagingArea = $("#pagingArea");
	var colSelect = $("#colSelect");
	var insertBtn = $("#insertBtn");
	var searchForm = $("#searchForm");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	
	$("#searchType").change(function(){
		searchForm.submit();
	});
	
})
</script>				