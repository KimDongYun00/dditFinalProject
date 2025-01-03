<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">		
		<div class="col-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">시설예약 > 시설리스트</h5>
				<hr class="my-0">
				<div class="card-body">
					<div class="row mb-3" align="right">
						<form id="searchForm">					
						<div class="col-4">
							<div class="input-group">
								<input type="hidden" name="page" id="page">
								<label class="input-group-text">시설종류</label>
								<select class="form-select" id="colSelect" name="searchType">	
									<option value="999">전체</option>
									<option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>회의실</option>
									<option value="3" <c:if test="${searchType eq '3' }">selected</c:if>>운동시설</option>					
								</select>
								<sec:csrfInput/>
							</div>
						</div>
						</form>
					</div>
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover" style="text-align: center;">
	      					<thead>
	        					<tr>
	        						<th width="10%"></th>
						          	<th width="20%">시설구분</th>
						          	<th width="20%">건물명</th>
						          	<th width="20%">시설명</th>
						          	<th width="20%">사용가능인원수</th>
						          	<th width="10%"></th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      					 <c:set value="${pagingVO.dataList }" var="facList"/>
	      					<c:forEach items="${facList }" var="facility" varStatus="status">
	      						<tr>
	      							<td>${status.index+1 }</td>
	      							<td>
	      								<c:choose>
			      							<c:when test="${facility.facTypeNo eq '1' }">
			      								강의실
			      							</c:when>
			      							<c:when test="${facility.facTypeNo eq '2' }">
			      								회의실
			      							</c:when>
			      							<c:when test="${facility.facTypeNo eq '3' }">
			      								운동시설      								
			      							</c:when>
			      							<c:when test="${facility.facTypeNo eq '4' }">
			      								사무실  								
			      							</c:when>
	      								</c:choose>
									</td>
	      							<td>${facility.buiName }</td>
	      							<td>${facility.facName }</td>
	      							<td>${facility.facMax }</td>
	      							<td>
	      								<a class='btn btn-outline-primary detailBtn' href='/student/facDetail?facNo=${facility.facNo }'>상세보기</a>      								
	      							</td>
	      						</tr>      						
	      					</c:forEach>
	      					</tbody>
	   	 				</table>
	  				</div>
	  			</div>	
  				<div class="card-footer" align="right">
	  				<div class="card-footer clearfix" id="pagingArea">
	                  ${pagingVO.pagingHTML }
	               </div>
                  
               </div>
               
  				
				
			</div>
		</div>
	</div>
</div>	
<script>
$(function(){
	var searchForm = $("#searchForm");
	var selectBox = $("#selectBox");
	var colSelect = $("#colSelect");
	
	// 셀렉트박스가 선택될대마다 form전송 이벤트
	selectBox.on("change", function(){
		console.log("바뀝니다!");
		searchForm.submit();
	});
	
	
	colSelect.on("change", function(){
		searchForm.submit();
	});	

	
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	
	var colSelect = $("#colSelect");
	var insertBtn = $("#insertBtn");
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});
</script>