<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<div class="card-header">
				<h3 class="card-title">상담관리 > 상담목록</h3>
				    <form id="searchForm">
				    	<input type="hidden" name="page" id="page">
<%-- 	                    <sec:csrfInput/> --%>
						<div class="row mb-3">
							<div class="col-3">															
							</div>
							<div class="col-2">
							</div>
	                  		<div class="col-7" align="right">	                     		
	                     		<div class="input-group"> 
	                     			<label class="input-group-text">상태</label>				  
									<select class="form-select" name="assNo" id="assNo">
										<option value="C99" <c:if test="${assNo eq 'C99' }">selected</c:if>>전체</option>
										<option value="C1" <c:if test="${assNo eq 'C1' }">selected</c:if>>대기</option> 
										<option value="C2" <c:if test="${assNo eq 'C2' }">selected</c:if>>완료</option>
									</select>
		                        	<select class="form-select" name="searchType">
		                           		<option value="student" <c:if test="${searchType eq 'student'}">selected</c:if>>학생</option>
		                           		<option value="professor" <c:if test="${searchType eq 'professor'}">selected</c:if>>교수</option>
		                        	</select>                                  
			                    	<input type="text" class="form-control float-right" placeholder="검색어를 입력하세요!" name="searchWord" value="${searchWord }"/>
			                    	<button class="btn btn-outline-primary" type="submit" id="button-addon2">검색</button>
	                        	</div>
	                  		</div>
                  		</div>
					</form> 
				</div>
               
				<div class="table-responsive text-nowrap">
    				<table class="table table-hover">
      					<thead>
        					<tr>
        						<th></th>
					          	<th width="">상담제목</th>
					          	<th style="text-align: center;">교수명</th>
					          	<th style="text-align: center;" width="">학생명</th>
					          	<th width="" style="text-align: center;">신청날짜</th>
					          	<th width="" style="text-align: center;">상담날짜</th>
					          	<th style="text-align: center;">상담상태</th>
					          	<th width="" style="text-align: center;">대면여부</th>
					          	<th width=""></th>
					     	</tr>
      					</thead>
      					<c:set value="${pagingVO.dataList }" var="consultingList"/>
      					<tbody class="table-border-bottom-0" id="tbody">
	      					<c:choose>
	      						<c:when test="${empty consultingList}">
	      							<tr>
	      								<td colspan="7">상담내역이 존재하지 않습니다.</td>
	      							</tr>
	      						</c:when>
	      						<c:otherwise>
	      							<c:forEach items="${consultingList }" var="consulting" varStatus="status">
			      						<tr>
			      							<td>${status.index+1 }</td>
			      							<td>${consulting.conTitle }</td>
			      							<td style="text-align: center;">${consulting.proName }</td>
			      							<td style="text-align: center;">${consulting.stuName }</td>
			      							<td style="text-align: center;">${consulting.conRegdate }</td>
			      							<td style="text-align: center;">${consulting.conDate }</td>
			      							<td style="text-align: center;">
			      								<c:if test="${consulting.comDetSNo eq 'S0101'}">완료</c:if>
			      								<c:if test="${consulting.comDetSNo eq 'S0102'}">대기</c:if>
			      							</td>
			      							<td style="text-align: center;">
			      								<c:if test="${consulting.conOnoff eq 'Y'}">대면</c:if>
			      								<c:if test="${consulting.conOnoff eq 'N'}">비대면</c:if>			      								
			      							</td>
			      							<td>
			      								<a class="btn btn-outline-primary" href="/admin/consultingDetail?conNo=${consulting.conNo }">상세보기</a>
			      							</td>
			      						</tr>      					
			      					</c:forEach>
	      						</c:otherwise>
	      					</c:choose>	      					
      					</tbody>
   	 				</table>   	 			
  				</div>
  				<hr class="mb-1">
				<div class="card-footer" id="pagingArea">
					${pagingVO.pagingHTML }
					<!-- 등록 버튼 -->
				</div>
				<div class="mb-3" align="right">
<!-- 					<button type="button" class="btn btn-primary mx-4" id="insertBtn">등록</button>				 -->
				</div>
			</div>
		</div>		
	</div>
</div>

<script>
$(function(){
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	$("#assNo").on("change", function(){
		searchForm.submit();
	})
})

</script>