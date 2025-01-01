<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학적 > 학적변경신청목록</h5>
				<hr class="mb-0"/>
				<div class="card-body">
					<form action="" id="searchForm">
						<div class="row mb-3">
							<div class="input-group">
								<sec:csrfInput/>		
								<input type="hidden" name="page" id="page">
								<label class="input-group-text" for="searchType">승인여부선택</label>			
								<select class="form-select" name="searchType" id="searchType">							
									<option value="99">전체</option>
									<option value="C0101" <c:if test="${searchType eq 'C0101' }">selected</c:if>>승인</option>
									<option value="C0102" <c:if test="${searchType eq 'C0102' }">selected</c:if>>미승인</option>
									<option value="C0103" <c:if test="${searchType eq 'C0103' }">selected</c:if>>반려</option>
								</select>
								
								<label class="input-group-text" for="searchLecType">학과선택</label>
								<select class="form-select" name="searchLecType" id="searchType2">						
									<!-- 과를 동적으로 넣어주자 -->
										<option value="99">전체</option>
									<c:forEach items="${deptList }" var="dept">								
										<option value="${dept.deptNo }" <c:if test="${searchLecType eq dept.deptNo }">selected</c:if>>${dept.deptName }</option>								
									</c:forEach>
								</select>
								
								<label class="input-group-text" for="searchScore">검색타입</label>
								<select class="form-select" name="searchScore">
									<option value="1" <c:if test="${searchScore eq '1' }">selected</c:if>>이름</option>
									<option value="2" <c:if test="${searchScore eq '2' }">selected</c:if>>학번</option>							
								</select>
								<input type="text" placeholder="검색어를 입력하세요." name="searchWord" class="form-control" style="width:40%;" value="${searchWord }">						
								<button class="btn btn-primary" id="searchBtn" type="button">검색</button>
							</div>
						</div>
					</form>
					
					<div class="row mb-3">
						<div class="table-responsive text-nowrap"  style="overflow:hidden;">	
						
							<table class="table table-hover" style="text-align: center;">
								<thead>
									<tr>
										<th></th>
										<th>학번</th>
										<th>이름</th>
										<th>학과</th>
										<th>학기</th>
										<th>처리종류</th>
										<th>처리상태</th>
										<th>상세보기</th>
									</tr>
								</thead>								
								<tbody>
									<c:set var="breakL" value="${pagingVO.dataList }"/>
									<c:forEach items="${breakL }" var="breL">
										<tr>
											<td>${breL.rnum }</td>
											<td>${breL.stuNo }</td>
											<td>${breL.stuName }</td>
											<td>
												<c:forEach items="${deptList }" var="dept">
													<c:if test="${dept.deptNo eq breL.deptNo }">${dept.deptName }</c:if>
												</c:forEach>
											</td>
											<td>${breL.year }년 ${breL.semester }학기</td>
											<td>
												<c:forEach items="${mList }" var="m">
													<c:if test="${m.comDetNo eq breL.comDetMNo }">${m.comDetName }</c:if>
												</c:forEach>
											</td>
											<td>
												<c:forEach items="${cList }" var ="cL">
													<c:if test="${cL.comDetNo eq breL.comDetCNo }">${cL.comDetName}</c:if>
												</c:forEach>
											</td>
											<td> 
												<a class="btn btn-outline-primary" href="/admin/breakDetail?breNo=${breL.breNo }">
													상세보기
												</a>
											</td>
										</tr>
									</c:forEach>								
								</tbody>
							</table>							
						</div>
					</div>
				</div>
				<div class="card-footer" align="right">
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
	
	$("#searchBtn").click(function(){
		
		searchForm.submit();
	});
	$("#searchType").on("change", function(){
		searchForm.submit();
	})
	$("#searchType2").on("change", function(){
		searchForm.submit();
	})
	
})
</script>						