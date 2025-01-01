<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">등록금 납부</h4>
	<div class="row">
		
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h4 class="card-header" width="500">
					납부내역
					<button class="btn btn-primary" type="button" style="float:right;"
						 data-bs-toggle="modal" data-bs-target="#modalTui">납부</button>
				</h4>
				<hr class="my-0">
				<div class="card-body">
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover" style="overflow:hidden;">
	      					<thead>
	        					<tr>
						          	<th width="5%">번호</th>
						          	<th width="15%">년도/학기</th>
						          	<th width="10%">등록금(원)</th>
						          	<th width="10%">차감금액(원)</th>
						          	<th width="10%">납부금액(원)</th>
						          	<th width="10%">납부구분</th>
						          	<th width="15%">납부일자</th>
						          	<th width="10%">납부상태</th>
						          	<th width="10%">납부상세</th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:choose>
	      							<c:when test="${fn:length(tuiList) != 0}">
	      								<c:set value="1" var="cnt"/>
			      						<c:forEach items="${tuiList }" var="tui">
				      						<c:forEach items="${tui.tuiPayList }" var="pay">
					      						<tr class="tui" data-tuiNo="${tui.tuiNo }">
					      							<td>${cnt }</td>
					      							<td>${tui.year }년도 ${tui.semester }학기</td>
					      							<td><fmt:formatNumber value="${tui.tuiPayment }" pattern="#,###" /></td>
					      							<td>
						      							<c:set value="0" var="totalSch"/>
							                      		<c:forEach items="${scholarList }" var="sch">
								                      		<c:set value="${totalSch + sch.schAmount }" var="totalSch"/>
							                      		</c:forEach>
								                      	<fmt:formatNumber value="${totalSch }" pattern="#,###" />
					      							</td>
					      							<td>
					      								<c:set value="0" var="payAmount"/>
					      								<c:forEach items="${pay.tuiPayDetList }" var="det">
						      								<c:set value="${payAmount + det.tuiPayDetAmount }" var="payAmount"/>
					      								</c:forEach>
					      								<fmt:formatNumber value="${payAmount }" pattern="#,###" />
					      							</td>
					      							<td>
					      								<c:choose>
					      									<c:when test="${pay.comDetY2No == 'Y0201' }">일시불</c:when>
					      									<c:otherwise>분할납부</c:otherwise>
					      								</c:choose>
					      							</td>
					      							<td>${fn:substring(pay.tuiPayDate, 0, 16) }</td>
					      							<td>
					      								<c:if test="${pay.comDetYNo eq 'Y0101' }">납부중</c:if>
					      								<c:if test="${pay.comDetYNo ne 'Y0101' }">납부완료</c:if>
					      							</td>
					      							<td>
					      								<button type="button" class="btn btn-sm btn-primary detBtn"
					      									data-bs-toggle="modal" data-bs-target="#modalDet">상세보기</button>
					      							</td>
					      						</tr>      
					      						<c:set value="${cnt + 1 }" var="cnt"/>						
					      					</c:forEach>
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
			</div>
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
			<!-- 고지서 등록 Modal -->
	        <div class="modal fade" id="modalTui" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="modalTuiLabel" 
	                  			style="font-weight:bold;">등록금 고지서</h5>
	                  		<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	               		<div class="modal-body">
		                  	<div class="row mb-3">
		                    	<div class="col-sm-6">
		                      		<label for="deptNo" class="form-label">학과</label>
		                      		<input type="text" class="form-control" readonly="readonly" value="${tuiVO.deptName }">
		                      	</div>
		                    	<div class="col-sm-3">
		                      		<label for="year" class="form-label">년도</label>
		                      		<input type="text" class="form-control" readonly="readonly" value="${tuiVO.year }">
		                      	</div>
		                    	<div class="col-sm-3">
		                      		<label for="semester" class="form-label">학기</label>
		                      		<input type="text" class="form-control" readonly="readonly" value="${tuiVO.semester }">
		                      	</div>
	                      		<div class="col-sm-12">
		                      		<label for="tuiPayment" class="form-label">등록금</label>
		                      		<input type="text" class="form-control" readonly="readonly" value="<fmt:formatNumber value="${tuiVO.tuiPayment }" pattern="#,###" />">
		                      	</div>	
	                      		<div class="col-sm-4">
		                      		<label for="comDetBNo" class="form-label">은행</label>
		                      		<input type="text" class="form-control" readonly="readonly" value="${tuiVO.bankName }">
		                      	</div>	
	                      		<div class="col-sm-8">
		                      		<label for="tuiAccount" class="form-label">계좌번호</label>
		                      		<input type="text" class="form-control" readonly="readonly" value="${tuiVO.tuiAccount }">
		                      	</div>	
		                      	<div class="col-sm-6">
		                      		<label for="tuiSdate" class="form-label">납부시작일자</label>
		                      		<input type="text" class="form-control" readonly="readonly" value="${tuiVO.tuiSdate }">
		                      	</div>
		                      	<div class="col-sm-6">
		                      		<label for="tuiEdate" class="form-label">납부끝일자</label>
		                      		<input type="text" class="form-control" readonly="readonly" value="${tuiVO.tuiEdate }">
		                      	</div>
		                	</div>
	         			</div>
	                	<h5 class="modal-header" style="font-weight:bold;">납부 방법</h5>
	                	<div class="modal-body">
	               			<form action="/tuition/submitTuition" id="submitFrm" method="post">
	               				<sec:csrfInput/>
	               				<input type="hidden" name="tuiNo" id="tuiNo" value="${tuiVO.tuiNo }">
	               				<input type="hidden" name="tuiPayAmount" id="tuiPayAmount" value="${tuiVO.tuiPayment }">
	                			<div class="row mb-3">
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
	                				<div class="col-sm-6">
	                					<label for="tuiPayment" class="form-label">납부방법</label>
	                					<select class="form-select" name="submitType" id="submitType">
	                						<option value="1">일시불</option>
	                						<option value="2">분할납부</option>
	                					</select>
	                				</div>
	                				<div class="col-sm-6">
	                					<label for="tuiPayment" class="form-label">납부금액</label>
	                					<c:set value="${tuiVO.tuiPayment - totalSch }" var="payment"/>
	                					<input type="text" class="form-control" readonly="readonly" id="submit1"
	                						value="<fmt:formatNumber value="${payment }" pattern="#,###" />">
	                					<input type="text" class="form-control" readonly="readonly" id="submit2"
	                						value="<fmt:formatNumber value="${payment / 4 }" pattern="#,###" /> * 4">
	                				</div>
	                			</div>
	               			</form>
	                	</div>
	         			<div class="modal-footer">
	         				<button type="button" class="btn btn-primary" id="submitBtn">납부</button>
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
	
	var submitFrm = $("#submitFrm");
	var submitBtn = $("#submitBtn");
	var submitType = $("#submitType");
	var submit1 = $("#submit1");
	var submit2 = $("#submit2");
	
	submit2.hide();
	
	submitType.on('change', function(){
		if($(this).val() == "1"){
			submit1.show();
			submit2.hide();
		} else{
			submit1.hide();
			submit2.show();
		}
	});
	
	submitBtn.on('click', function(){
		var tuiPayDed = 0;
		$.each($(".tuiPayDed"), function(i,v){
			tuiPayDed += parseInt($(v).data("ded"));
		})
		submitFrm.append("<input type='hidden' name='tuiPayDed' value='"+tuiPayDed+"'>");
		requestPay();
// 		submitFrm.submit();
	});
	
	$(".detBtn").on('click', function(){
		var tuiNo = $(this).parents('tr').attr("data-tuiNo");
		$.ajax({
			url : "/tuition/tuitionDetail.do?tuiNo="+tuiNo,
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			success : function(res){
				console.log("res", res);
				
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
			}
		});
	});
	
	function requestPay() {
		IMP.init("imp40065601"); // 고객사 식별코드
		IMP.request_pay({ // param
			pg: "html5_inicis",
			pay_method: "card",
			merchant_uid: "merchant_" + new Date().getTime(),
			name: "그냥결제",
			amount: "100",
			buyer_name: "리사이틀",           
			buyer_tel: "010-4242-4242",
			buyer_addr: "서울특별시 강남구 신사동",
			buyer_postcode: "01181"
		}, function (rsp) { // callback
				if (rsp.success) {// 결제성공시 로직
		      	alert("결제 완료");
		      	// 결제 종료 시 호출되는 콜백 함수
		      	// response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,
		      	// 결제 결과를 처리하는 로직을 작성합니다.
		      	// 여기서 결제 관련 DB에 ajax로 요청하여 저장한다.
				submitFrm.submit();		// 납부 submit
		   	} else {// 결제 실패시
		      	alert("결제 실패");
		      	alert(rsp.error_msg);
		    }
		})
	};
	
});

</script>






























