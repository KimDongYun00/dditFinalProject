<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>






<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">${departmentVO.deptName }</h4>
	<button type="button" class="btn btn-primary" id="listBtn">목록</button>
	<div class="row">
		<div class="col-xl-7">
			<div class="card mb-4 bg-white">
				<h5 class="card-header"style="font-weight:bold;">정보</h5>
				<hr class="my-0">
				<div class="card-body">
					<form action="/admin/departmentUpdate.do" method="post" id="deptUpdFrm">
						<sec:csrfInput/>
						<input type="hidden" name="colNo" id="colNo" value="${colleageVO.colNo }">
						<input type="hidden" name="deptNo" id="deptNo" value="${departmentVO.deptNo }">
						<div class="row mb-3">
							
							<label class="col-sm-2 col-form-label" for="colName"><font size="4">단과대</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="colName" id="colName" 
									value="${colleageVO.colName }" readonly="readonly">
							</div>
							
							<label class="col-sm-2 col-form-label" for="deptName"><font size="4">학과 이름</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="deptName" id="deptName"
									value="${departmentVO.deptName }" readonly="readonly">
							</div>
							
							<label class="col-sm-2 col-form-label" for="buiNo"><font size="4">건물</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="buiNo" id="buiNo" disabled="disabled">
									<c:forEach items="${builingList }" var="building">
										<option value="${building.buiNo }" 
											<c:if test="${building.buiNo eq departmentVO.buiNo}">selected='selected'</c:if>>
												${building.buiName }
										</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="facNo"><font size="4">사무실</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="facNo" id="facNo" disabled="disabled">
									<c:forEach items="${facilityList }" var="facility">
										<option value="${facility.facNo }" class="facOption"
											<c:if test="${facility.facNo eq departmentVO.facNo}">selected='selected'</c:if>>
												${facility.facName }
										</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="proName"><font size="4">학과장</font></label>
							<div class="col-sm-8">
								<input type="hidden" name="proNo" id="proNo" value="${departmentVO.proNo }">
								<input type="text" class="form-control" name="proName" id="proName"
									value="${departmentVO.proName }" readonly="readonly">
							</div>
							<div class="col-sm-2 d-flex flex-wrap justify-content-between">
								<span></span>
								<span class="btn btn-info" id="proSearchBtn" 
									data-bs-toggle="none" data-bs-target="#modal3">검색</span>	
							</div>
							
							<label class="col-sm-2 col-form-label" for="deptCall"><font size="4">학과 전화번호</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="deptCall" id="deptCall"
									value="${departmentVO.deptCall }" readonly="readonly">
							</div>
							
							<label class="col-sm-2 col-form-label" for="comDetBNo"><font size="4">은행</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="comDetBNo" id="comDetBNo" disabled="disabled">
									<c:forEach items="${bankList }" var="bank">
										<option value="${bank.comDetNo }" class="bankOption"
											<c:if test="${bank.comDetNo eq departmentVO.comDetBNo}">selected='selected'</c:if>>
												${bank.comDetName }
										</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="deptAccount"><font size="4">계좌번호</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="deptAccount" id="deptAccount"
									value="${departmentVO.deptAccount }" readonly="readonly">
							</div>
							
						</div>
					</form>
				</div>
				<div class="card-footer">
					<!-- 목록 버튼 -->
<!-- 					<button type="submit" class="btn btn-primary" id="listBtn">목록</button> -->
					<!-- 등록 버튼 -->
					<button type="submit" class="btn btn-primary" id="infoUpdateBtn">수정</button>
					<button type="submit" class="btn btn-danger" id="infoUpdate2Btn" style="display: none;">수정완료</button>
					<button type="submit" class="btn btn-primary" id="infoCancelBtn" style="display: none;">취소</button>
				</div>
			</div>
			<!-- 교수 검색 Modal -->
	        <div class="modal fade" id="modal3" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="exampleModalLabel3" 
	                  			style="font-weight:bold;">교수 검색</h5>
	                  		<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	               		<div class="modal-body">
		                  	<div class="row mb-3">
		                    	<div class="col-sm-12">
		                      		<label for="searchProName" class="form-label">이름</label>
		                      		<input type="text" class="form-control" id="searchProName" name="proName">
		                      	</div>
	                      		<div class="col-sm-12 table-responsive text-nowrap">
				    				<table class="table table-hover">
				      					<thead>
				        					<tr>
									          	<th width="20%">교번</th>
									          	<th width="30%">학과</th>
									          	<th width="20%">교수이름</th>
									          	<th width="30%">전화번호</th>
									     	</tr>
				      					</thead>
				      					<tbody class="table-border-bottom-0" id="tbody">
				      						
				      					</tbody>
				   	 				</table>
		                      	</div>	
		                	</div>
	         			</div>
	            	</div>
	         	</div>
	       </div>
		</div>
		<div class="col-xl-5">
			<div class="card mb-4 bg-white">
				<h5 class="card-header"style="font-weight:bold;">졸업요건</h5>
				<hr class="my-0">
				<div class="card-body">	
					<div class="row mb-3">
					
						<div class="table-responsive text-nowrap">
		    				<table class="table table-hover">
		      					<thead>
		        					<tr>
							          	<th width="20%">년도/학기</th>
							          	<th width="20%">총 학점</th>
							          	<th width="20%">전공학점</th>
							          	<th width="20%">교양학점</th>
							          	<th width="20%">봉사시간</th>
							     	</tr>
		      					</thead>
		      					<tbody class="table-border-bottom-0" id="tbody">
									<c:forEach items="${graReqList }" var="graReq">
										<tr class='tuitionList'>
	  										<td>${graReq.year }년 ${graReq.semester }학기</td>
	  										<td>${graReq.graReqTotal }</td>
	  										<td>${graReq.graReqMc }</td>
	  										<td>${graReq.graReqLac }</td>
	  										<td>${graReq.graReqVol } 시간</td>
	  									</tr>
									</c:forEach>
		      					</tbody>
		   	 				</table>
		  				</div>
					</div>		
				</div>
				<div class="card-footer">
					<!-- 목록 버튼 -->
<!-- 					<button type="submit" class="btn btn-primary" id="listBtn">목록</button> -->
					<!-- 등록 버튼 -->
					<button type="submit" class="btn btn-primary" id="graInsertBtn"
						data-bs-toggle="modal" data-bs-target="#modal2">등록</button>
				</div>
				<!-- 졸업요건 등록 Modal -->
		        <div class="modal fade" id="modal2" tabindex="-1" aria-hidden="true">
		           	<div class="modal-dialog" role="document">
		              	<div class="modal-content">
		                	<div class="modal-header">
		                  		<h5 class="modal-title" id="exampleModalLabel2" 
		                  			style="font-weight:bold;">졸업 요건 등록</h5>
		                  		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		                	</div>
		               		<div class="modal-body">
			                  	<div class="row mb-3">
			                  		<form action="/admin/graReqInsert.do" method="post" id="modal2Form">
			                  			<sec:csrfInput/>
				                  		<input type="hidden" class="form-control" name="deptNo" value="${departmentVO.deptNo }">
				                    	<div class="col-sm-12">
				                      		<label for="graReqTotal" class="form-label">총요구학점</label>
				                      		<input type="text" class="form-control" id="graReqTotal" name="graReqTotal">
				                    	</div>
				                    	<div class="col-sm-12">
				                      		<label for="graReqMc" class="form-label">전공학점</label>
				                      		<input type="text" class="form-control" id="graReqMc" name="graReqMc">
				                    	</div>
				                    	<div class="col-sm-12">
				                      		<label for="graReqLac" class="form-label">교양학점</label>
				                      		<input type="text" class="form-control" id="graReqLac" name="graReqLac">
				                    	</div>
				                    	<div class="col-sm-12">
				                      		<label for="graReqVol" class="form-label">봉사시간</label>
				                      		<input type="text" class="form-control" id="graReqVol" name="graReqVol">
				                    	</div>
				                    	<div class="col-sm-12">
				                      		<label for="year2" class="form-label">년도</label>
				                      		<input type="text" class="form-control" id="year2" name="year">
				                    	</div>
				                    	<div class="col-sm-12">
				                      		<label for="semester2" class="form-label">학기</label>
				                      		<input type="text" class="form-control" id="semester2" name="semester">
				                    	</div>
			                  		</form>
			                	</div>
		         			</div>
			                <div class="modal-footer">
			                  	<button type="button" class="btn btn-primary" id="graInsertBtn2">등록</button>
			                </div>
		            	</div>
		         	</div>
		       </div>
			</div>
		</div>
	</div>
</div>

<meta id="_csrf" name="_csrf" content="${_csrf.token }">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">

<script type="text/javascript">

$(function(){
	
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	
	var listBtn = $("#listBtn");
	var infoUpdateBtn = $("#infoUpdateBtn");
	var infoUpdate2Btn = $("#infoUpdate2Btn");
	var infoCancelBtn = $("#infoCancelBtn");
	var tuiInsertBtn = $("#tuiInsertBtn");
	var tuiInsertBtn2 = $("#tuiInsertBtn2");
	var graInsertBtn = $("#graInsertBtn");
	var graInsertBtn2 = $("#graInsertBtn2");
	var modal1Form = $("#modal1Form");
	var modal2Form = $("#modal2Form");
	var proSearchBtn = $("#proSearchBtn");
	var deptUpdFrm = $("#deptUpdFrm");
	
	var deptName = "";
	var buiNo = "";
	var facNo = "";
	var proName = "";
	var deptCall = "";
	var comDetBNo = "";
	var deptAccount = "";
	
	listBtn.on('click', function(){
		location.href="/admin/departmentList";
	});
	
	tuiInsertBtn2.on('click', function(){
		console.log("tuiInsertBtn2 click...!");
		
		modal1Form.submit();
	});
	
	graInsertBtn2.on('click', function(){
		console.log("graInsertBtn2 click...!");
		
		modal2Form.submit();
	});
	
	infoUpdateBtn.on('click', function(){
		console.log("infoUpdateBtn click...!");
		
		$("#deptName").attr('readonly', false);
		$("#buiNo").attr('disabled', false);
		$("#facNo").attr('disabled', false);
		$("#deptCall").attr('readonly', false);
		$("#comDetBNo").attr('disabled', false);
		$("#deptAccount").attr('readonly', false);
		$("#proSearchBtn").attr('data-bs-toggle', "modal");
		
		deptName = $("#deptName").val();
		buiNo = $("#buiNo").val();
		facNo = $("#facNo").val();
		proName = $("#proName").val();
		deptCall = $("#deptCall").val();
		comDetBNo = $("#comDetBNo").val();
		deptAccount = $("#deptAccount").val();
		
		infoCancelBtn.show();
		infoUpdate2Btn.show();
		infoUpdateBtn.hide();
	});
	
	infoCancelBtn.on('click', function(){
		console.log("infoCancelBtn click...!");
		
		$("#deptName").val(deptName);
		$("#buiNo").val(buiNo);
		$("#facNo").val(facNo);
		$("#proName").val(proName);
		$("#deptCall").val(deptCall);
		$("#comDetBNo").val(comDetBNo);
		$("#deptAccount").val(deptAccount);
		
		var buiData = {
				buiNo : $("#buiNo").val(),
				facTypeNo : "4"
		};
		
		$.ajax({
			url : "/admin/facList.do",
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(buiData),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				console.log("result : " + res + " " + facNo);
				
				$(".facOption").remove();
				var html = "";
				
				$.each(res, function(i, v){
					console.log(i + " fac >> " + v.facName);
					if(v.facNo == facNo)html += "<option value='"+v.facNo+"' class='facOption' selected='selected'>"+v.facName;
					else html += "<option value='"+v.facNo+"' class='facOption'>"+v.facName;
					html += "</option>";
				});
				
				$("#facNo").append(html);
			}
		});
		
		$("#deptName").attr('readonly', true);
		$("#buiNo").attr('disabled', true);
		$("#facNo").attr('disabled', true);
		$("#deptCall").attr('readonly', true);
		$("#comDetBNo").attr('disabled', true);
		$("#deptAccount").attr('readonly', true);
		$("#proSearchBtn").attr('data-bs-toggle', 'none');
		
		infoCancelBtn.hide();
		infoUpdate2Btn.hide();
		infoUpdateBtn.show();
	});
	
	$("#buiNo").on('change', function(){
		console.log("buiNo changed...!");
		
		var buiData = {
				buiNo : $("#buiNo").val(),
				facTypeNo : "4"
		};
		
		$.ajax({
			url : "/admin/facList.do",
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(buiData),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				console.log("result : " + res);
				
				$(".facOption").remove();
				var html = "";
				
				$.each(res, function(i, v){
					console.log(i + " fac >> " + v.facName);
					html += "<option value='"+v.facNo+"' class='facOption'>"+v.facName;
					html += "</option>";
				});
				
				$("#facNo").append(html);
			}
		});
	});
	
	$("#searchProName").on('input', function(){
		console.log("proName keydown...!");
		
		var searchWord = {
			proName : $("#searchProName").val()
		}
		
		$.ajax({
			url : "/admin/searchProfessor.do",
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(searchWord),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				console.log("result : " + res);
				
				$(".searchedProList").remove();
				var html = "";
				
				$.each(res, function(i, v){
					console.log(i +" >> " + v.proName);
					
					html += "<tr class='searchedProList'>" +
						"<td class='searchedProNo'>"+v.proNo+"</span></td>" +
						"<td>"+v.deptName+"</td>" +
						"<td class='searchedProName'>"+v.proName+"</td>" +
						"<td>"+v.proPhone+"</td>" +
					"</tr>";
				});
				
				$("#tbody").append(html);
			}
		});
		
	});
	
	$(document).on('click', '.searchedProList', function(){
		console.log("searchedProList click...!");
		
		var searchedProNo = $(this).find('.searchedProNo').text();
		var searchedProName = $(this).find('.searchedProName').text();
		
		console.log("proNo >> " + searchedProNo);
		console.log("proName >> " + searchedProName);
		
		$("#proNo").val(searchedProNo);
		$("#proName").val(searchedProName);
		
		$("#modal3Btn").click();
	});
	
	proSearchBtn.on('click', function(){
		console.log("proSearchBtn click...!");
		
	});
	
	infoUpdate2Btn.on('click', function(){
		console.log("infoUpdate2Btn click...!");
		
		
		deptUpdFrm.submit();
	});
	
});

</script>


























