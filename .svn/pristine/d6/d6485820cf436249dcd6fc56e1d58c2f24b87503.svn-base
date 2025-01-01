<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 -->
	<sec:authentication property="principal.user" var="user" />
</sec:authorize>

<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">등록금 납부</h4>
	<div class="row">
		
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<div class="card-header row">
					<div class="col-sm-10">
						<form action="" method="get" id="searchFrm">
							<sec:csrfInput/>
							<input type="hidden" name="page" id="page">
							<div class="input-group">
								<label class="input-group-text" for="searchYear">년도</label>
								<select name="searchYear" class="form-select">
									<c:forEach items="${yearList }" var="year">
										<option value="${year.ysYear }" <c:if test="${year.ysYear eq pagingVO.searchYear }">selected='selected'</c:if> >${year.ysYear }년</option>
									</c:forEach>
								</select>
								<label class="input-group-text" for="searchYear">납부상태</label>
								<select name="searchType" class="form-select">
									<option value="" <c:if test="${empty pagingVO.searchType }">selected='selected'</c:if>>미납</option>
									<option value="Y0101" <c:if test="${'Y0101' eq pagingVO.searchType }">selected='selected'</c:if> >납부 중</option>
									<option value="Y0102" <c:if test="${'Y0102' eq pagingVO.searchType }">selected='selected'</c:if> >납부 완료</option>
								</select>
								<label class="input-group-text" for="searchYear">납부상태</label>
								<select name="searchStatus" class="form-select">
									<option value=""></option>
									<option value="Y0201" <c:if test="${'Y0201' eq pagingVO.searchStatus }">selected='selected'</c:if> >일시불</option>
									<option value="Y0202" <c:if test="${'Y0202' eq pagingVO.searchStatus }">selected='selected'</c:if> >할부</option>
								</select>
								<label class="input-group-text" for="searchStuId">학번</label>
								<input class="form-control" type="text" name="searchStuId" id="searchStuId" style="width:20%;"
										placeholder="20xxxxxx" value="${pagingVO.searchStuId }">
								<button class="btn btn-primary" id="searchBtn">검색</button>
							</div>
						</form>
					</div>
					<div class="col-sm-2">
						<c:if test="${user.comDetUNo ne 'U0103' }">
							<button class="btn btn-primary" type="button" style="float:right;"
								 data-bs-toggle="modal" data-bs-target="#modalTui">납부</button>
						</c:if>
					</div>
				</div>
				<hr class="my-0">
				<div class="card-body">
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover" style="overflow:hidden;">
	      					<thead>
	        					<tr>
						          	<th width="15%">학번</th>
						          	<th width="15%">학과</th>
						          	<th width="10%">이름</th>
						          	<th width="10%">학년</th>
						          	<th width="15%">년도</th>
						          	<th width="10%">납부상태</th>
						          	<th width="10%">납부구분</th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:choose>
	      							<c:when test="${fn:length(pagingVO.dataList) != 0}">
	      								<c:set value="1" var="cnt"/>
			      						<c:forEach items="${pagingVO.dataList }" var="stu">
			      							<tr class="submitDetail" data-tuiPayNo="${stu.TUI_PAY_NO }">
			      								<td>${stu.STU_NO }</td>
			      								<td>${stu.DEPT_NAME }</td>
			      								<td>${stu.STU_NAME }</td>
			      								<td>${stu.STU_YEAR }</td>
			      								<td>${pagingVO.searchYear }년</td>
			      								<td>
			      									<c:if test="${stu.COM_DET_Y_NO eq null }">미납</c:if>
			      									<c:if test="${stu.COM_DET_Y_NO ne null }">
			      										<c:if test="${stu.COM_DET_Y_NO eq 'Y0101' }">납부 중</c:if>
			      										<c:if test="${stu.COM_DET_Y_NO eq 'Y0102' }">납부 완료</c:if>
			      									</c:if>
			      								</td>
			      								<td>
			      									<c:if test="${stu.COM_DET_Y2_NO eq null }">-</c:if>
			      									<c:if test="${stu.COM_DET_Y2_NO ne null }">
			      										<c:if test="${stu.COM_DET_Y2_NO eq 'Y0201' }">일시불</c:if>
			      										<c:if test="${stu.COM_DET_Y2_NO eq 'Y0202' }">할부</c:if>
			      									</c:if>
			      								</td>
			      							</tr>
				      					</c:forEach>
	      							</c:when>
	      							<c:otherwise>
	      								<tr>
	      									<td colspan="7" align="center">조회된 납부 내역이 없습니다.</td>
	      								</tr>
	      							</c:otherwise>
	      						</c:choose>
	      					</tbody>
	   	 				</table>
	  				</div>
				</div>
				<div class="card-footer" id="pagingDiv">
					${pagingVO.pagingHTML }
				</div>
			</div>
			<button type="button" style="display: none;" data-bs-toggle="modal" data-bs-target="#modalDet" id="modalOpen"></button>
			<!-- 납부 상세내역 Modal -->
	        <div class="modal fade" id="modalDet" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="modalDetLabel" 
	                  			style="font-weight:bold;">납부내역</h5>
	                  		<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	                	<div class="modal-body">
		                  	<div class="row mb-3">
		                    	<div class="col-sm-6">
		                      		<label for="deptNo" class="form-label">학과</label>
		                      		<input type="text" class="form-control" readonly="readonly" id="deptName">
		                      	</div>
		                    	<div class="col-sm-3">
		                      		<label for="year" class="form-label">년도</label>
		                      		<input type="text" class="form-control" readonly="readonly" id="year">
		                      	</div>
		                    	<div class="col-sm-3">
		                      		<label for="semester" class="form-label">학기</label>
		                      		<input type="text" class="form-control" readonly="readonly" id="semester">
		                      	</div>
	                      		<div class="col-sm-12">
		                      		<label for="tuiPayment" class="form-label">등록금</label>
		                      		<input type="text" class="form-control" readonly="readonly" id="tuiPayment">
		                      	</div>	
	                      		<c:set value="0" var="totalSch"/>
	                      		<c:forEach items="${scholarList }" var="sch">
		                      		<div class="col-sm-6">
			                      		<label for="tuiPayment" class="form-label">장학금명</label>
			                      		<input type="text" class="form-control" readonly="readonly" value="${sch.schName }">
			                      	</div>	
		                      		<div class="col-sm-6">
			                      		<label for="tuiPayment" class="form-label">선차감금액</label>
			                      		<c:set value="${totalSch + sch.schAmount }" var="totalSch"/>
			                      		<input type="text" class="form-control tuiPayDed" readonly="readonly" data-ded="${sch.schAmount }"
			                      			value="<fmt:formatNumber value="${totalSch }" pattern="#,###" />">
			                      	</div>	
	                      		</c:forEach>
	                      		<div class="col-sm-4">
		                      		<label for="comDetBNo" class="form-label">은행</label>
		                      		<input type="text" class="form-control" readonly="readonly" id="bankName">
		                      	</div>	
	                      		<div class="col-sm-8">
		                      		<label for="tuiAccount" class="form-label">계좌번호</label>
		                      		<input type="text" class="form-control" readonly="readonly" id="tuiAccount">
		                      	</div>	
		                      	<div class="col-sm-6">
		                      		<label for="tuiSdate" class="form-label">납부시작일자</label>
		                      		<input type="text" class="form-control" readonly="readonly" id="tuiSdate">
		                      	</div>
		                      	<div class="col-sm-6">
		                      		<label for="tuiEdate" class="form-label">납부끝일자</label>
		                      		<input type="text" class="form-control" readonly="readonly" id="tuiEdate">
		                      	</div>
		                	</div>
		                	<hr>
	                		<div class="row mb-3" id="detBody">
	                			
	                		</div>
	                	</div>
	            	</div>
	    	   	</div>
	 		</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>

$(function(){
	
	var searchFrm = $("#searchFrm");
	
	$("#pagingDiv").on('click', 'a', function(){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		searchFrm.find("#page").val(pageNo);
		searchFrm.submit();
	});
	
	$(".submitDetail").on('click', function(){
		var tuiPayNo = $(this).attr("data-tuiPayNo");
		if(tuiPayNo == ""){
			alert("미납상태입니다!");
			return false;
		}
		$.ajax({
			url : "/tuition/submitDetail.do?tuiPayNo="+tuiPayNo,
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			success : function(res){
				console.log("res", res.deptName);
				
				$("#deptName").val(res.deptName);
				$("#year").val(res.year);
				$("#semester").val(res.semester);
				$("#tuiPayment").val(new Intl.NumberFormat('en-US').format(res.tuiPayment));
				$("#bankName").val(res.bankName);
				$("#tuiAccount").val(res.tuiAccount);
				$("#tuiSdate").val(res.tuiSdate);
				$("#tuiEdate").val(res.tuiEdate);
				
				var html = "";
				$.each(res.tuiPayList[0].tuiPayDetList, function(i, v){
					html +=   "<div class='col-sm-2'>"
								+ "<label class='form-label'>납부회차</label>"
								+ "<input type='text' class='form-control' readonly='readonly' value='"+(i+1)+"'>"
							+ "</div>"
							+ "<div class='col-sm-5'>"
								+ "<label class='form-label'>납부금액</label>"
								+ "<input type='text' class='form-control' readonly='readonly' value='"+v.tuiPayDetAmount+"'>"
							+ "</div>"
							+ "<div class='col-sm-5'>"
								+ "<label class='form-label'>납부일자</label>"
								+ "<input type='text' class='form-control' readonly='readonly' value='"+v.tuiPayDetDate.substring(0, 16)+"'>"
							+ "</div>";
				})
				$("#detBody").html(html);
				$("#modalOpen").trigger("click");
			}
		});
	});
		
});

</script>






























