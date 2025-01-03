<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">학과관리</h4>
	<button type="button" class="btn btn-primary" id="listBtn">목록</button>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학과등록</h5>
				<hr class="my-0">
				<div class="card-body">
					<form action="/admin/departmentInsert.do" method="post" id="insertFrm">
						<sec:csrfInput/>
						<input type="hidden" name="colNo" id="colNo" value="${colleageVO.colNo }">
						<div class="row mb-3">
						
							<label class="col-sm-2 col-form-label" for="colNo"><font size="4">단과대</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="colName" id="colName" 
									value="${colleageVO.colName }" readonly="readonly">
							</div>
							
							<label class="col-sm-2 col-form-label" for="deptName"><font size="4">학과 이름</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="deptName" id="deptName">
							</div>
							
							<label class="col-sm-2 col-form-label" for="subName"><font size="4">건물</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="buiNo" id="buiNo">
									<c:forEach items="${builingList }" var="building">
										<option value="${building.buiNo }">${building.buiName }</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="subName"><font size="4">사무실 선택</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="facNo" id="facNo">
									<c:forEach items="${facilityList }" var="facility">
										<option value="${facility.facNo }" class="facOption">${facility.facName }</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="proName"><font size="4">학과장</font></label>
							<div class="col-sm-8">
								<input type="hidden" name="proNo" id="proNo" value="">
								<input type="text" class="form-control" name="proName" id="proName"
									value="" readonly="readonly">
							</div>
							<div class="col-sm-2 d-flex flex-wrap justify-content-between">
								<span></span>
								<span class="btn btn-info" id="proSearchBtn" 
									data-bs-toggle="modal" data-bs-target="#modal3">검색</span>	
							</div>
							
							<label class="col-sm-2 col-form-label" for="deptCall"><font size="4">학과 전화번호</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="deptCall" id="deptCall"
									value="">
							</div>
							
							<label class="col-sm-2 col-form-label" for="comDetBNo"><font size="4">은행</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="comDetBNo" id="comDetBNo">
									<c:forEach items="${bankList }" var="bank">
										<option value="${bank.comDetNo }" class="bankOption">${bank.comDetName }</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="deptAccount"><font size="4">계좌번호</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="deptAccount" id="deptAccount" value="">
							</div>
							
						</div>
					</form>
				</div>
				<div class="card-footer">
					<!-- 등록 버튼 -->					
					<button type="button" class="btn btn-primary" id="fastBtn">시연용</button>
					<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
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
	</div>
</div>

<meta id="_csrf" name="_csrf" content="${_csrf.token }">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">

<script type="text/javascript">
$(function(){
	$("#fastBtn").click(function(){
		$("#deptName").val("경영학과");
		$("#deptCall").val("042-0000-0000");
		$("#deptAccount").val("453332-35203-11020");
	});
	
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	
	var listBtn = $("#listBtn");
	var insertBtn = $("#insertBtn");
	var insertFrm = $("#insertFrm");
	
	listBtn.on('click', function(){
		location.href="/admin/departmentList";
	});
	
	insertBtn.on('click', function(){
// 		console.log("insertBtn click...!");
		
		insertFrm.submit();
	});
	
	var buiData = {
			buiNo : $("#buiNo").val(),
			facTypeNo : 4
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
// 			console.log("result : " + res);
			
			$(".facOption").remove();
			var html = "";
			
			$.each(res, function(i, v){
// 				console.log(i + " fac >> " + v.facName);
				html += "<option value='"+v.facNo+"' class='facOption'>"+v.facName;
				html += "</option>";
			});
			
			$("#facNo").append(html);
		}
	});
	
	$("#buiNo").on('change', function(){
// 		console.log("buiNo changed...!");
		
		var buiData = {
				buiNo : $("#buiNo").val(),
				facTypeNo : 4
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
// 				console.log("result : " + res);
				
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
// 		console.log("proName keydown...!");
		
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
// 				console.log("result : " + res);
				
				$(".searchedProList").remove();
				var html = "";
				
				$.each(res, function(i, v){
// 					console.log(i +" >> " + v.proName);
					
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
// 		console.log("searchedProList click...!");
		
		var searchedProNo = $(this).find('.searchedProNo').text();
		var searchedProName = $(this).find('.searchedProName').text();
		
// 		console.log("proNo >> " + searchedProNo);
// 		console.log("proName >> " + searchedProName);
		
		$("#proNo").val(searchedProNo);
		$("#proName").val(searchedProName);
		
		$("#modal3Btn").click();
	});
	
});
</script>







































