<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">등록금 고지서관리</h4>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<div class="card-header">
					<form action="" method="get" id="searchFrm">
						<sec:csrfInput/>
						<input type="hidden" name="page" id="page">
						<div class="row mb-3" id="searchDiv">
							
							<div class="col-sm-8"> 
								<div class="input-group">
									<label class="input-group-text" for="searchYear">년도/학기</label>
									<select class="form-select" name="searchYear" id="searchYear">
										<option value="99"></option>
										<c:forEach items="${yearList }" var="year" varStatus="status">
											<option value="${year }" <c:if test="${year eq pagingVO.searchYear }">selected="selected"</c:if> >${year }년</option>
											<c:if test="${status.count eq fn:length(yearList) }">
			                      				<option value="${year + 1 }" <c:if test="${year + 1 eq pagingVO.searchYear }">selected="selected"</c:if>>${year + 1 }년</option>
			                      				<option value="${year + 2 }" <c:if test="${year + 2 eq pagingVO.searchYear }">selected="selected"</c:if>>${year + 2 }년</option>
			                      				<option value="${year + 3 }" <c:if test="${year + 3 eq pagingVO.searchYear }">selected="selected"</c:if>>${year + 3 }년</option>
			                      				<option value="${year + 4 }" <c:if test="${year + 4 eq pagingVO.searchYear }">selected="selected"</c:if>>${year + 4 }년</option>
			                      				<option value="${year + 5 }" <c:if test="${year + 5 eq pagingVO.searchYear }">selected="selected"</c:if>>${year + 5 }년</option>
		                      				</c:if>
										</c:forEach>
									</select>
									<select class="form-select" name="searchSemester" id="searchSemester">
										<option value="99"></option>
										<option value="1" <c:if test="${1 eq pagingVO.searchSemester }">selected="selected"</c:if>>1학기</option>
										<option value="2" <c:if test="${2 eq pagingVO.searchSemester }">selected="selected"</c:if>>2학기</option>
									</select>
									<label class="input-group-text" for="searchWord">학과명</label>
									<input class="form-control" style="width:30%;" name="searchWord" id="searchWord">
									<button class="btn btn-primary" id="searchBtn">검색</button>
								</div>
							</div>
							<div class="col-sm-4">
								<button type="button" class="btn btn-primary" id="insertModalBtn"
									style="float:right;" data-bs-toggle="modal" data-bs-target="#modalTui">등록</button>
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
						          	<th width="5%">번호</th>
						          	<th width="15%">년도/학기</th>
						          	<th width="15%">학과명</th>
						          	<th width="15%">등록금</th>
						          	<th width="10%">은행명</th>
						          	<th width="20%">계좌번호</th>
						          	<th width="10%">납부시작일자</th>
						          	<th width="10%">납부끝일자</th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:choose>
	      							<c:when test="${pagingVO.dataList ne null}">
			      						<c:forEach items="${pagingVO.dataList }" var="tui" varStatus="status">
				      						<tr data-bs-toggle="modal" data-bs-target="#modalTui" class="updTui">
				      							<td data-tuiNo="${tui.tuiNo }">${status.count + (pagingVO.currentPage - 1) * 10 }</td>
				      							<td data-year="${tui.year }" data-semester="${tui.semester }">${tui.year }년도 ${tui.semester }학기</td>
				      							<td data-deptNo="${tui.deptNo }">${tui.deptName }</td>
				      							<td data-tuiPayment="${tui.tuiPayment }"><fmt:formatNumber value="${tui.tuiPayment }" pattern="#,###" />(원)</td>
				      							<td data-comDetBNo="${tui.comDetBNo }">${tui.bankName }</td>
				      							<td>${tui.tuiAccount }</td>
				      							<td>${tui.tuiSdate }</td>
				      							<td>${tui.tuiEdate }</td>
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
	  				<div id="pagingDiv" style="margin-top: 20px;">
	  					${pagingVO.pagingHTML }
	  				</div>
					<!-- 등록 버튼 -->
				</div>
			</div>
			<!-- 고지서 등록 Modal -->
	        <div class="modal fade" id="modalTui" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="modalTuiLabel" 
	                  			style="font-weight:bold;">등록금 고지서 등록</h5>
	                  		<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	               		<div class="modal-body">
	               			<form action="/tuition/insertTuition" id="insertFrm" method="post">
	               				<sec:csrfInput/>
	               				<input type="hidden" name="tuiNo" id="tuiNo">
			                  	<div class="row mb-3">
			                    	<div class="col-sm-6">
			                      		<label for="deptNo" class="form-label">학과</label>
			                      		<select name="deptNo" id="deptNo" class="form-select">
			                      			<c:forEach items="${deptList }" var="dept">
			                      				<option value="${dept.deptNo }">${dept.deptName }</option>
			                      			</c:forEach>
			                      		</select>
			                      	</div>
			                    	<div class="col-sm-3">
			                      		<label for="year" class="form-label">년도</label>
			                      		<select name="year" id="year" class="form-select">
			                      			<c:forEach items="${ysList }" var="ys" varStatus="status">
			                      				<option value="${ys.ysYear }">${ys.ysYear }년</option>
			                      				<c:if test="${status.count eq fn:length(ysList) }">
				                      				<option value="${ys.ysYear + 1 }">${ys.ysYear + 1 }년</option>
				                      				<option value="${ys.ysYear + 2 }">${ys.ysYear + 2 }년</option>
				                      				<option value="${ys.ysYear + 3 }">${ys.ysYear + 3 }년</option>
				                      				<option value="${ys.ysYear + 4 }">${ys.ysYear + 4 }년</option>
				                      				<option value="${ys.ysYear + 5 }">${ys.ysYear + 5 }년</option>
			                      				</c:if>
			                      			</c:forEach>
			                      		</select>
			                      	</div>
			                    	<div class="col-sm-3">
			                      		<label for="semester" class="form-label">학기</label>
			                      		<select name="semester" id="semester" class="form-select">
		                      				<option value="1">1학기</option>
		                      				<option value="2">2학기</option>
			                      		</select>
			                      	</div>
		                      		<div class="col-sm-12">
			                      		<label for="tuiPayment" class="form-label">등록금</label>
			                      		<input type="text" id="tuiPayment" name="tuiPayment" class="form-control">
			                      	</div>	
		                      		<div class="col-sm-4">
			                      		<label for="comDetBNo" class="form-label">은행</label>
			                      		<select name="comDetBNo" id="comDetBNo" class="form-select">
			                      			<c:forEach items="${bankList }" var="bank">
			                      				<option value="${bank.comDetNo }">${bank.comDetName }</option>
			                      			</c:forEach>
			                      		</select>
			                      	</div>	
		                      		<div class="col-sm-8">
			                      		<label for="tuiAccount" class="form-label">계좌번호</label>
			                      		<input type="text" id="tuiAccount" name="tuiAccount" class="form-control">
			                      	</div>	
			                      	<div class="col-sm-6">
			                      		<label for="tuiSdate" class="form-label">납부시작일자</label>
			                      		<input type="date" id="tuiSdate" name="tuiSdate" class="form-control">
			                      	</div>
			                      	<div class="col-sm-6">
			                      		<label for="tuiEdate" class="form-label">납부끝일자</label>
			                      		<input type="date" id="tuiEdate" name="tuiEdate" class="form-control">
			                      	</div>
			                	</div>
	               			</form>
	         			</div>
	         			<div class="modal-footer">
	         				<button type="button" class="btn btn-primary" id="fastBtn">시연용</button>
	         				<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
	         				<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
	         				<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
	         			</div>
	            	</div>
	    	   	</div>
	 		</div>
		</div>
	</div>
</div>


<script>

$(function(){
	
	var insertModalBtn = $("#insertModalBtn");
	var insertBtn = $("#insertBtn");
	var updateBtn = $("#updateBtn");
	var deleteBtn = $("#deleteBtn");
	var insertFrm = $("#insertFrm");
	
	updateBtn.hide();
	deleteBtn.hide();
	
	$("#fastBtn").click(function(){
		$("#tuiPayment").val("32000000");
		$("#tuiSdate").val("2024-01-01");
		$("#tuiAccount").val("453332-35203-11020");
		$("#tuiEdate").val("2024-03-01");		
	})
	
	insertBtn.on('click', function(){
		insertFrm.attr("action", "/tuition/insertTuition");
		insertFrm.submit();
	});
	
	updateBtn.on('click', function(){
		insertFrm.attr("action", "/tuition/updateTuition");
		insertFrm.submit();
	});
	
	deleteBtn.on('click', function(){
		if(!confirm("정말 삭제하시겠습니까?")){
			return false;
		}
		insertFrm.attr("action", "/tuition/deleteTuition");
		insertFrm.submit();
	});
	
	insertModalBtn.on('click', function(){
		insertBtn.show();
		$("#fastBtn").show();
		updateBtn.hide();
		deleteBtn.hide();
		
		$("#modalTuiLabel").text("등록금 고지서 등록");
		
		$("#year").find('option').attr("selected", false);
		$("#semester").find('option').attr("selected", false);
		$("#deptNo").attr("selected", false);
		$("#tuiPayment").val("");
		$("#comDetBNo").find('option').attr("selected", false);
		$("#tuiAccount").val("");
		$("#tuiSdate").val("");
		$("#tuiEdate").val("");
	});
	
	$(".updTui").on('click', function(){
		insertBtn.hide();
		$("#fastBtn").hide();
		updateBtn.show();
		deleteBtn.show();
		
		$("#modalTuiLabel").text("등록금 고지서 수정");
		
		var td = $(this).find('td');
		var tuiNo = td.eq(0).attr("data-tuiNo");
		var year = td.eq(1).attr("data-year");
		var semester = td.eq(1).attr("data-semester");
		var deptNo = td.eq(2).attr("data-deptNo");
		var tuiPayment = td.eq(3).attr("data-tuiPayment");
		var comDetBNo = td.eq(4).attr("data-comDetBNo");
		var tuiAccount = td.eq(5).text();
		var tuiSdate = td.eq(6).text();
		var tuiEdate = td.eq(7).text();
		
		$("#tuiNo").val(tuiNo);
		$("#year").find('option').attr("selected", false);
		$("#year").find("option[value='"+year+"']").attr("selected", true);
		$("#semester").find('option').attr("selected", false);
		$("#semester").find("option[value='"+semester+"']").attr("selected", true);
		$("#deptNo").find('option').attr("selected", false);
		$("#deptNo").find("option[value='"+deptNo+"']").attr("selected", true);
		$("#tuiPayment").val(tuiPayment);
		$("#comDetBNo").find('option').attr("selected", false);
		$("#comDetBNo").find("option[value='"+comDetBNo+"']").attr("selected", true);
		$("#tuiAccount").val(tuiAccount);
		$("#tuiSdate").val(tuiSdate);
		$("#tuiEdate").val(tuiEdate);
	});
});

</script>

























