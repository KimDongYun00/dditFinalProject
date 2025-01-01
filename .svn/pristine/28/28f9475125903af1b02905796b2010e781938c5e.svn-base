<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
<!-- 	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">회원관리</h4> -->
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">인원관리 > 학생조회</h5>
				<hr class="my-0">
				<div class="card-body">
					<div class="row mb-3">
						
						<div class="col-3">
							<div class="input-group">
			   					<label class="input-group-text" for="memberSelect"><font size="4">회원종류</font></label>
			   					<select class="form-select" id="memberSelect">
			   						<option selected>학생</option>
			   						<option>교수</option>
			   						<option>직원</option>
			   					</select>
			   					
		   					</div>
	   					</div>   					
   					
						<div class="col-9">
		   					<form id="searchForm">				    					
			    				<div class="input-group">		    					
			    					<label class="input-group-text" for="memberSelect">학과</label>
				   					<select name="assNo" id="assNo" class="form-select">
					   						<option value="C99" <c:if test="${assNo eq 'C99' }">selected</c:if>>== 전체 ==</option>
					   						<c:forEach items="${deptL }" var="dep">
					   							<option value="${dep.deptNo }"  <c:if test="${assNo eq dep.deptNo }">selected</c:if>>${dep.deptName }</option>
					   						</c:forEach>
				   					</select> 
			   						<input type="hidden" name="page" id="page">
			   						<select class="form-select" id="searchType" name="searchType">
			   							<option value="99">검색옵션 선택</option>
			   							<option value="stuNo" <c:if test="${searchType eq 'stuNo' }">selected</c:if>>아이디</option>
			   							<option value="stuName" <c:if test="${searchType eq 'stuName' }">selected</c:if>>이름</option>
			   						</select>
			  							<input type="text" name="searchWord" class="form-control float-right" style="width:40%;" placeholder="Search" value="${searchWord }">
			                           <button type="submit" class="btn btn-primary">
			                              <i class="fas fa-search">검색</i>
			                           </button>
		                       		    					
			   					</div>
							</form>	
						</div>
					</div>
					
	    			<div class="table-responsive text-nowrap"  style="overflow:hidden;">	
	    				<table class="table table-hover"  style="overflow:hidden; text-align: center;">
	      					<thead>
	        					<tr>
	        						<th></th>
						          	<th width="">학번/사번</th>
						          	<th width="">학과</th>
						          	<th width="">학년</th>
						          	<th width="">이름</th>
						          	<th width="">성별</th>
						          	<th width="">이메일</th>
						          	<th width="">전화번호</th>
						          	<th width="">학적상태</th>
						          	<th width=""></th>
						     	</tr>
	      					</thead>
	      					<c:set value="${pagingVO.dataList }" var="stuList"/>
	      					
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:if test="${empty stuList }">
	      							<tr>
	      								<td colspan="10">데이터가 하나도 없습니다.</td>
	      							</tr>
	      						</c:if>
	      						<c:forEach items="${stuList }" var="stu">
	      							<tr class="subject">
	      								<td>${stu.rnum }</td>
	      								<td class="stuNo">${stu.stuNo }</td>
	      								<td>${stu.deptName }</td>
	      								<td>${stu.stuYear }</td>
	      								<td>${stu.stuName }</td>
	      								<td>
	      									<c:if test="${stu.comDetGNo eq 'G0101'}">남자</c:if> 
	      									<c:if test="${stu.comDetGNo eq 'G0102'}">여자</c:if>	      								
	      								</td>
	      								<td>${stu.stuEmail }</td>
	      								<td>${stu.stuPhone }</td>
	      								<td>
	      									<c:if test="${stu.comDetMNo eq 'M0101'}">재학</c:if>
	      									<c:if test="${stu.comDetMNo eq 'M0102'}">휴학</c:if>
	      									<c:if test="${stu.comDetMNo eq 'M0103'}">자퇴</c:if>
	      									<c:if test="${stu.comDetMNo eq 'M0104'}">졸업</c:if>	      								
	      								</td>
	      								<td>
											<a class="btn btn-sm btn-secondary" href="/admin/stuDetail?stuNo=${stu.stuNo }">상세보기</a>
										</td>
	      							</tr>
	      						</c:forEach>
	      					</tbody>
	   	 				</table>	   	 				
	  				</div>	  	
				</div>
				<div class="card-footer clearfix">
					<div class="row">
		  				<div class="col-md-8" id="pagingArea">
		  					${pagingVO.pagingHTML }
		  				</div>
		  				<div class="col-md-4">
							<button type="button" style="float:right;" class="btn btn-primary" id="insertAllBtn">일괄등록</button>
							<button type="button" style="float:right;" class="btn btn-primary" id="insertBtn">등록</button>
		  				</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(function(){
	var pagingArea = $("#pagingArea");
	var memberSelect = $("#memberSelect");
	var searchForm = $("#searchForm");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	// 셀렉트바가 바뀔때
	memberSelect.on("change", function(){
		if($("#memberSelect option:selected").text() == '교수'){
			location.href="/admin/proList";
			return false;
		}
		if($("#memberSelect option:selected").text() == '직원'){
			location.href="/admin/empList";
			return false;
		}
	});
	
	// 개별 등록 버튼 이벤트
	$("#insertBtn").click(function(){
		location.href="/admin/stuInsertForm";
	});
	
	// 일괄 등록 버튼 이벤트
	$("#insertAllBtn").click(function(){
		location.href="/admin/stuInsertAllForm";
	});
	
	$("#assNo").on("change", function(){
		searchForm.submit();
	})
	
})

</script>