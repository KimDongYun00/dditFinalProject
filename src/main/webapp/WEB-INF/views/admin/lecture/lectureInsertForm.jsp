<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
#timeTable {
	border: 2px solid #d2d2d2;
	border-collapse: collapse;
	font-size: 0.9em;
}

#timeTable th, #timeTable td {
	border: 1px solid #d2d2d2;
	border-collapse: collapse;
	text-align: center;
}

#timeTable th {
	height: 5px;
}

#timeTable td {
	width: 75px;
	height: 15px;
}

.tdHover{
	background : lightgreen;
}
.tdClick{
	background : blue;
}
.tdReserved{
	background : red;
}
.tdProTime{
	background : green;
}
</style>




<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">강의등록</h4>
	<c:set value="/admin/lectureInsert" var="path"/>
	<c:if test="${type eq 'update' }"><c:set value="/admin/lectureUpdate" var="path"/></c:if>
	<form action="${path }" method="post" id="insertFrm" enctype="multipart/form-data">
		<sec:csrfInput/>
		<c:if test="${proVO ne null }">
			<input type="hidden" name="type" id="type" value="professor">
		</c:if>
		<div class="row mb-5">
			<div class="col-md-6 col-lg-4 mb-3">
				<div class="card mb-4 bg-white">
					<h5 class="card-header">시간표</h5>
					<hr class="my-0">
					<div class="card-body">
						<div class="mb-3 col-md-6">
							<div style="display:none;">
								<c:forEach items="${lecTimeList }" var="lecTime">
									<input type='hidden' name='lectureTimes' value='${lecTime.comDetWNo }${lecTime.comDetTName }' id='${lecTime.comDetWNo }${lecTime.comDetTName }'>
									<p class="upLecTime" data-day="${lecTime.comDetWNo }" data-time="${lecTime.comDetTName }"/>
								</c:forEach>
								<p id="upFacNo">${lectureVO.facNo }</p>
								<p id="upBuiName">${lectureVO.buiName }</p>
								<p id="upComDetLNo">${lectureVO.comDetLNo }</p>
								<p id="upLecOnoff">${lectureVO.lecOnoff }</p>
								<p id="upLecAge">${lectureVO.lecAge }</p>
								<input type="hidden" name="lecNo" value="${lectureVO.lecNo }">
							</div>
							<table width="400" height="600" id="timeTable">
								<tr>
									<th></th>
									<th>월</th>
									<th>화</th>
									<th>수</th>
									<th>목</th>
									<th>금</th>
								</tr>
								<c:forEach begin="8" end="21" var="time" varStatus="status">
									<tr data-time="<fmt:formatNumber value='${status.index }' pattern="00"/>_00">
										<th rowspan="2"><fmt:formatNumber value='${status.index }' pattern="00"/></th>
										<td data-day="W0101" data-res="0"></td>
										<td data-day="W0102" data-res="0"></td> 
										<td data-day="W0103" data-res="0"></td>
										<td data-day="W0104" data-res="0"></td>
										<td data-day="W0105" data-res="0"></td>
									</tr>
									<tr data-time="<fmt:formatNumber value='${status.index }' pattern="00"/>_30">
										<td data-day="W0101" data-res="0"></td>
										<td data-day="W0102" data-res="0"></td>
										<td data-day="W0103" data-res="0"></td>
										<td data-day="W0104" data-res="0"></td>
										<td data-day="W0105" data-res="0"></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					
					</div>
				</div>
				<div class="card mb-4 bg-white">
					<h5 class="card-header">성적반영비율(%)</h5>
					<hr class="my-0">
					<div class="card-body">
						<div class="row mb-3" id="rate">
							
							<label class="col-sm-4 col-form-label" for="lecMidRate"><font size="4">중간고사</font></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="lecMidRate" id="lecMidRate" value="${lectureVO.lecMidRate }">
							</div>	
							
							<label class="col-sm-4 col-form-label" for="lecLastRate"><font size="4">기말고사</font></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="lecLastRate" id="lecLastRate" value="${lectureVO.lecLastRate }">
							</div>	
							
							<label class="col-sm-4 col-form-label" for="lecAssRate"><font size="4">과제</font></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="lecAssRate" id="lecAssRate" value="${lectureVO.lecAssRate }">
							</div>	
							
							<label class="col-sm-4 col-form-label" for="lecExamRate"><font size="4">시험</font></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="lecExamRate" id="lecExamRate" value="${lectureVO.lecExamRate }">
							</div>	
							
							<label class="col-sm-4 col-form-label" for="lecAdRate"><font size="4">출석</font></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="lecAdRate" id="lecAdRate" value="${lectureVO.lecAdRate }">
							</div>	
							
							<label class="col-sm-4 col-form-label" for="lecAtRate"><font size="4">태도</font></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="lecAtRate" id="lecAtRate" value="${lectureVO.lecAtRate }">
							</div>	
							
							<c:if test="${lectureVO eq null }">
								<p id="rateSum" data-rate="0" style="color:red;">값을 입력하세요!</p>
							</c:if>
							<c:if test="${lectureVO ne null }">
								<p id="rateSum" data-rate="100" style="color:red;">현재 반영비율 합계는 '100(%)' 입니다</p>
							</c:if>

						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-8 mb-3">
				<div class="card mb-4 bg-white">
					<c:if test="${proVO eq null }">
						<h5 class="card-header">정보</h5>
					</c:if>
					<c:if test="${proVO ne null }">
						<h5 class="card-header">정보
							<button type="button" style="float:right;" class="btn btn-primary" id="getLecBtn"
								data-bs-toggle="modal" data-bs-target="#modalLec">불러오기</button>
						</h5>
					</c:if>
					<hr class="my-0">
					<div class="card-body">
				
						<div class="row mb-3">
							
							<label class="col-sm-2 col-form-label" for="subName"><font size="4">과목</font></label>
							<div class="col-sm-8">
								<input type="hidden" name="subNo" id="subNo" value="${lectureVO.subNo }">
								<input type="text" class="form-control" name="subName" id="subName"
									value="${lectureVO.subName }" readonly="readonly">
							</div>
							<div class="col-sm-2 d-flex flex-wrap justify-content-between">
								<span></span>
								<span class="btn btn-info" id="proSearchBtn"
									data-bs-toggle="modal" data-bs-target="#modalSub">검색</span>	
							</div>
							
							<label class="col-sm-2 col-form-label" for="proName"><font size="4">담당교수</font></label>
							<c:if test="${proVO eq null }">
								<div class="col-sm-8">
									<input type="hidden" name="proNo" id="proNo" value="${lectureVO.proNo }">
									<input type="text" class="form-control" name="proName" id="proName"
										value="${lectureVO.proName }" readonly="readonly">
								</div>
								<div class="col-sm-2 d-flex flex-wrap justify-content-between">
									<span></span>
									<span class="btn btn-info" id="proSearchBtn"
										data-bs-toggle="modal" data-bs-target="#modalPro">검색</span>	
								</div>
							</c:if>
							<c:if test="${proVO ne null }">
								<div class="col-sm-10">
									<input type="hidden" name="proNo" id="proNo" value="${proVO.proNo }">
									<input type="text" class="form-control" name="proName" id="proName"
										value="${proVO.proName }" readonly="readonly">
								</div>
							</c:if>
							
							<label class="col-sm-2 col-form-label" for="buiNo"><font size="4">건물</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="buiNo" id="buiNo">
									<c:forEach items="${builingList }" var="building">
										<option value="${building.buiNo }">${building.buiName }</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="facNo"><font size="4">강의실 선택</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="facNo" id="facNo">
									<c:forEach items="${facilityList }" var="facility">
										<option value="${facility.facNo }" class="facOption">${facility.facName }</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="comDetLNo"><font size="4">강의구분</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="comDetLNo" id="comDetLNo">
									<c:forEach items="${lecTypeList }" var="lecType">
										<c:if test="${lecType.comDetNo ne 'L0101' and lecType.comDetNo ne 'L0201'}">
											<option value="${lecType.comDetNo }" class="lecTypeOption">${lecType.comDetName }</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						
							<label class="col-sm-2 col-form-label" for="lecName"><font size="4">강의명</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="lecName" id="lecName" value="${lectureVO.lecName }">
							</div>
						
							<label class="col-sm-2 col-form-label" for="lecExplain"><font size="4">강의설명</font></label>
							<div class="col-sm-10">
								<textarea rows="10" class="form-control" name="lecExplain" id="lecExplain">${lectureVO.lecExplain }</textarea>
							</div>
						
							<label class="col-sm-2 col-form-label" for="lecMax"><font size="4">수강인원</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="lecMax" id="lecMax" value="${lectureVO.lecMax }">
							</div>
						
							<label class="col-sm-2 col-form-label" for="lecOnoff"><font size="4">대면여부</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="lecOnoff" id="lecOnoff">
									<option value="Y">대면</option>
									<option value="N">비대면</option>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="lecAge"><font size="4">수강학년</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="lecAge" id="lecAge">
									<option value="1">1학년</option>
									<option value="2">2학년</option>
									<option value="3">3학년</option>
									<option value="4">4학년</option>
									<option value="5">5학년</option>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="lecScore"><font size="4">학점</font></label>
							<div class="col-sm-10">
								<input type="number" class="form-control" name="lecScore" id="lecScore" value="${lectureVO.lecScore }">
							</div>
							
							<label class="col-sm-2 col-form-label" for="year"><font size="4">년도</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="year" id="year" value="${lectureVO.year }">
							</div>
							
							<label class="col-sm-2 col-form-label" for="semester"><font size="4">학기</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="semester" id="semester" value="${lectureVO.semester }">
							</div>
							
							<c:if test="${lectureVO.lecFileList[0] ne null }">
								<label class="col-sm-2 col-form-label" for="lecFile"><font size="4">강의계획서</font></label>
								<div class="col-sm-10">
									<c:set value="${lectureVO.lecFileList[0] }" var="file"/>
									<c:url value="/common/fileDownload.do?${_csrf.parameterName}=${_csrf.token}" var="downloadUrl"> 
										<c:param name="fileGroupNo" value="${file.fileGroupNo }"/>
										<c:param name="fileNo" value="${file.fileNo }"/>
									</c:url>
									<a style="font-size:1.1rem;" href="${downloadUrl }">
										${file.fileName }
									</a>
								</div>
								<div class="col-sm-2"></div>
								<div class="col-sm-10">
									<input type="file" class="form-control" name="lecFile" id="lecFile" multiple="multiple">
								</div>
							</c:if>
							<c:if test="${lectureVO.lecFileList[0] eq null }">
								<label class="col-sm-2 col-form-label" for="lecFile"><font size="4">강의계획서</font></label>
								<div class="col-sm-10">
									<input type="file" class="form-control" name="lecFile" id="lecFile" multiple="multiple">
								</div>
							</c:if>
							
						</div>
				
					</div>
					<div class="card-footer">
						<!-- 등록 버튼 -->
						<c:if test="${lectureVO eq null }">
							<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
						</c:if>
						<c:if test="${lectureVO ne null }">
							<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
						</c:if>
					</div>
				</div>
			</div>
			
			<!-- 과목 검색 Modal -->
	        <div class="modal fade" id="modalSub" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="modalSubLabel" 
	                  			style="font-weight:bold;">과목 검색</h5>
	                  		<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	               		<div class="modal-body">
		                  	<div class="row mb-3">
		                    	<div class="col-sm-12">
		                      		<label for="searchSubName" class="form-label">이름</label>
		                      		<input type="text" class="form-control" id="searchSubName" name="subName">
		                      	</div>
	                      		<div class="col-sm-12 table-responsive text-nowrap">
				    				<table class="table table-hover">
				      					<thead>
				        					<tr>
									          	<th width="20%">과목번호</th>
									          	<th width="30%">과목명</th>
									          	<th width="30%">담당학과</th>
									          	<th width="20%">활성화여부</th>
									     	</tr>
				      					</thead>
				      					<tbody class="table-border-bottom-0" id="tbody_sub">
				      						
				      					</tbody>
				   	 				</table>
		                      	</div>	
		                	</div>
	         			</div>
	            	</div>
	    	   	</div>
	 		</div>
			<!-- 교수 검색 Modal -->
	        <div class="modal fade" id="modalPro" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="modalProLabel" 
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
				      					<tbody class="table-border-bottom-0" id="tbody_pro">
				      						
				      					</tbody>
				   	 				</table>
		                      	</div>	
		                	</div>
	         			</div>
	            	</div>
	    	   	</div>
	 		</div>
			<!-- 강의 불러오기 Modal -->
	        <div class="modal fade" id="modalLec" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="modalLecLabel" 
	                  			style="font-weight:bold;">강의 목록</h5>
	                  		<button type="button" id="modal4Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	               		<div class="modal-body">
		                  	<div class="row mb-3">
		                  		<div class="col-sm-12">
		                  			<h6 style="text-align: center;">시간표, 강의실, 년도/학기, 강의계획서를 제외한 데이터를 불러옵니다.</h6>
		                  		</div>
	                      		<div class="col-sm-12 table-responsive text-nowrap">
				    				<table class="table table-hover">
				      					<thead>
				        					<tr>
									          	<th width="35%">년도/학기</th>
									          	<th width="45%">과목명</th>
									          	<th width="20%">대면여부</th>
									     	</tr>
				      					</thead>
				      					<tbody class="table-border-bottom-0" id="tbody_pro">
				      						<c:if test="${proVO ne null }">
				      							<c:forEach items="${proLecList }" var="proLec">
				      								<tr class="proLec" data-lecNo="${proLec.lecNo }">
				      									<td>${proLec.year }년도${proLec.semester }학기</td>
				      									<td>${proLec.lecName }</td>
				      									<td>
				      										<c:if test="${proLec.lecOnoff eq 'Y' }">비대면</c:if>
				      										<c:if test="${proLec.lecOnoff eq 'N' }">대면</c:if>
				      									</td>
				      								</tr>
				      							</c:forEach>
				      						</c:if>
				      					</tbody>
				   	 				</table>
		                      	</div>	
		                	</div>
	         			</div>
	            	</div>
	    	   	</div>
	 		</div>
		</div>
	</form>
</div>


<meta id="_csrf" name="_csrf" content="${_csrf.token }">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">

<script type="text/javascript">
	
token = $("meta[name='_csrf']").attr("content");
header = $("meta[name='_csrf_header']").attr("content");
	
$(function(){
	
	var rateSum = $("#rateSum").attr("data-rate");
	var rate = $("#rate");
	var insertBtn = $("#insertBtn");
	var updateBtn = $("#updateBtn");
	var insertFrm = $("#insertFrm");
	var timeTable = $("#timeTable");
	var listBtn = $("#listBtn");
	
	$(".proLec").on('click', function(){
		
		var lecNo = $(this).attr("data-lecNo");
		
		$.ajax({
			url : "/professor/getProLec.do?lecNo="+lecNo,
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			success : function(res){
				console.log("result : " + res.lecName);
				
				$("#lecMidRate").val(res.lecMidRate);
				$("#lecLastRate").val(res.lecLastRate);
				$("#lecExamRate").val(res.lecExamRate);
				$("#lecAssRate").val(res.lecAssRate);
				$("#lecAtRate").val(res.lecAtRate);
				$("#lecAdRate").val(res.lecAdRate);
				
				$("#subNo").val(res.subNo);
				$("#subName").val(res.subName);
				
				$("#lecName").val(res.lecName);
				$("#lecExplain").val(res.lecExplain);
				$("#lecMax").val(res.lecMax);
				$("#lecScore").val(res.lecScore);
				
				rateSum = 100;
				
				$("#modal4Btn").click();
			}
		});
	});
	
	if($(".upLecTime").length != 0){
		$.each($("#buiNo").find('option'), function(i,v){
			if($(v).text() == $("#upBuiName").text()){
				$(v).attr("selected", true);
			}
		});
		$.each($("#comDetLNo").find('option'), function(i,v){
			if($(v).val() == $("#upComDetLNo").text()){
				$(v).attr("selected", true);
			}
		});
		$.each($("#lecOnoff").find('option'), function(i,v){
			if($(v).val() == $("#upLecOnoff").text()){
				$(v).attr("selected", true);
			}
		});
		$.each($("#lecAge").find('option'), function(i,v){
			if($(v).val() == $("#upLecAge").text()){
				$(v).attr("selected", true);
			}
		});
	}
	
	listBtn.on('click', function(){
		console.log("listBtn click...!");
		location.href="/admin/lectureList";
	});
	
	insertBtn.on('click',function(){
		console.log("insertBtn click...!");
		
		if(rateSum != 100){
			alert("반영비율을 알맞게 설정해주세요!");
			return false;
		}
		if($('#lecMax').val().trim() == ""){
			alert("값을 입력해주세요!")
			return false;
		}
		if($('#lecScore').val().trim() == ""){
			alert("값을 입력해주세요!")
			return false;
		}
		
		insertFrm.submit();
	});
	
	updateBtn.on('click', function(){
		console.log("updateBtn click..!");

		if(rateSum != 100){
			alert("반영비율을 알맞게 설정해주세요!");
			return false;
		}
		if($('#lecMax').val().trim() == ""){
			alert("값을 입력해주세요!")
			return false;
		}
		if($('#lecScore').val().trim() == ""){
			alert("값을 입력해주세요!")
			return false;
		}
		
		insertFrm.attr("action", "/admin/lectureUpdate");
		insertFrm.submit();
	});
	
	rate.find('input').on('input', function(){
		console.log("rate input...!");
		
		var lecMidRate = parseInt($("#lecMidRate").val());
		var lecLastRate = parseInt($("#lecLastRate").val());
		var lecAssRate = parseInt($("#lecAssRate").val());
		var lecExamRate = parseInt($("#lecExamRate").val());
		var lecAdRate = parseInt($("#lecAdRate").val());
		var lecAtRate = parseInt($("#lecAtRate").val());
		
		console.log(lecMidRate);
		
		var msg = "";
		
		if($.isNumeric(lecMidRate) && $.isNumeric(lecLastRate)
			&& $.isNumeric(lecAssRate) && $.isNumeric(lecExamRate)
			&& $.isNumeric(lecAdRate) && $.isNumeric(lecAtRate)){
			rateSum = lecMidRate + lecLastRate + lecAssRate + lecExamRate + lecAdRate + lecAtRate;
			
			msg = "현재 반영비율 합계는 '" + rateSum+ "(%)' 입니다";
			if(rateSum != 100) msg += "<br>비율합계가 '100(%)' 이 되야 합니다!";
		} else{
			rateSum = 0;
			msg = "숫자만 입력해주세요!";
		}
		
		$("#rateSum").html(msg);
	});
	
	$("#searchProName").on('input', function(){
		console.log("proName keydown...!");

		if($("#searchProName").val().trim() == "") return false;
		
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
				
				$("#tbody_pro").append(html);
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
		
		$("#modalPro").click();
		$("#searchProName").val("");
		$(".searchedProList").remove();
		
		var facNo = $("#facNo").val();
		var proNo = $("#proNo").val();
		var year = $("#year").val();
		var semester = $("#semester").val();
		getTimeList(facNo, proNo, year, semester);
	});
	
	$("#searchSubName").on('input', function(){
		console.log("subName keydown...!");
		
		if($("#searchSubName").val().trim() == "") return false;
		
		var searchWord = {
			subName : $("#searchSubName").val()
		}
		
		$.ajax({
			url : "/admin/searchSubject.do",
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(searchWord),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				console.log("result : " + res);
				
				$(".searchedSubList").remove();
				var html = "";
				
				$.each(res, function(i, v){
					console.log(i +" >> " + v.subName);
					
					html += "<tr class='searchedSubList'>" +
								"<td class='searchedSubNo'>"+v.subNo+"</span></td>" +
								"<td class='searchedSubName'>"+v.subName+"</td>" +
								"<td>"+v.deptName+"</td>";
					if(v.comDetVNo == "V0101"){
						html += "<td>O</td>";
					} else{
						html += "<td>X</td>";
					}	
					html += "</tr>";
				});
				
				$("#tbody_sub").append(html);
			}
		});
	});
	
	$(document).on('click', '.searchedSubList', function(){
		console.log("searchedSubList click...!");
		
		var searchedSubNo = $(this).find('.searchedSubNo').text();
		var searchedSubName = $(this).find('.searchedSubName').text();
		
		console.log("subNo >> " + searchedSubNo);
		console.log("subName >> " + searchedSubName);
		
		$("#subNo").val(searchedSubNo);
		$("#subName").val(searchedSubName);
		
		$("#modalSub").click();
		$("#searchSubName").val("");
		$(".searchedSubList").remove();
	});
	
	$(document).on('change', '#facNo', function(){
		var facNo = $("#facNo").val();
		var proNo = $("#proNo").val();
		var year = $("#year").val();
		var semester = $("#semester").val();
		getTimeList(facNo, proNo, year, semester);
	});
	
	$("#year").on('input', function(){
		var facNo = $("#facNo").val();
		var proNo = $("#proNo").val();
		var year = $("#year").val();
		var semester = $("#semester").val();
		getTimeList(facNo, proNo, year, semester);
	});
	
	$("#semester").on('input', function(){
		var facNo = $("#facNo").val();
		var proNo = $("#proNo").val();
		var year = $("#year").val();
		var semester = $("#semester").val();
		getTimeList(facNo, proNo, year, semester);
	});
	
	var buiData = {
			buiNo : $("#buiNo").val(),
			facTypeNo : "1"
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
				html += "<option value='"+v.facNo+"' class='facOption'>"+v.facName+ "</option>";
			});
			
			$("#facNo").append(html);
			
			if($(".upLecTime").length != 0){
				$.each($("#facNo").find('option'), function(i,v){
					if($(v).val() == $("#upFacNo").text()){
						$(v).attr("selected", true);
					}
				});
			}
			
			var facNo = $("#facNo").val();
			var proNo = $("#proNo").val();
			var year = $("#year").val();
			var semester = $("#semester").val();
			getTimeList(facNo, proNo, year, semester);
		}
	});
	
	$("#buiNo").on('change', function(){
		console.log("buiNo changed...!");
		
		var buiData = {
				buiNo : $("#buiNo").val(),
				facTypeNo : "1"
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
				
				var facNo = $("#facNo").val();
				var proNo = $("#proNo").val();
				var year = $("#year").val();
				var semester = $("#semester").val();
				getTimeList(facNo, proNo, year, semester);
			}
		});
	});
	
	timeTable.find("td").hover(function(){
		$(this).addClass('tdHover');
	}, function(){
		$(this).removeClass('tdHover');
	});
	
	// 아무 일정 없는 td data-res > 0
	// 다른 강의가 예약된 td data-res > 1
	// 내가 누른 td data-res > 2
	// value 값 10_00 _로 저장되어있음
	timeTable.on("click", "td", function(){
		
		var year = $("#year").val();
		var semester = $("#semester").val();
		var proNo = $("#proNo").val();
		
		if(year.trim() == "" || semester.trim() == ""){
			alert("년도/학기를 입력한 후에 시간을 정할 수 있습니다!");
			return false;
		}
		
		if(proNo.trim() == ""){
			alert("담당교수를 선택한 후에 시간을 정할 수 있습니다!");
			return false;
		}
		
		console.log($(this));
		var res = $(this)[0].dataset.res;
		
		var day = $(this).data("day");
		var time = $(this).parent().data("time");
		
		console.log(day + " " + time);
		
		if(res == 0){
			$(this).attr("data-res", "2");
			$(this).addClass('tdClick');
			
			let html = "<input type='hidden' name='lectureTimes' value='"+day+time+"' id='"+day+time+"'>";
			insertFrm.append(html);
		} else if(res == 1){
			alert("다른 강의가 예약된 시간입니다.");
		} else if(res == 2){
			$(this).attr("data-res", "0");
			$(this).removeClass('tdClick');
			
			$("#"+day+time).remove();
		} else if(res == 4){
			alert($("#proName").val()+" 교수의 다른 강의가 있는 시간입니다.")
		}
	});
	
	if($(".upLecTime").length != 0){
		$.each($("#buiNo").find('option'), function(i,v){
			if($(this).text() == $("#upBuiName")){
				$(this).attr("selected", true);
			}
		});
	}
});

















function getTimeList(facNo, proNo, year, semester){
	console.log("getTimeList()...!");
	console.log(facNo, year, semester);
	
	if(facNo == null || year == null || semester == null || proNo == null
	|| facNo == "" || year == "" || semester == "" || proNo == "") {
		return false;
	}
	
	$('td').removeClass("tdReserved");
	$('td').removeClass("tdClick");
	$('td').removeClass("tdProTime");
	$('td').attr("data-res", "0");
	
	var data = {
			facNo : facNo,
			proNo : proNo,
			year : year,
			semester : semester
	};
	
	$.ajax({
		url : "/admin/timeList.do",
		type : "post",
		beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
			xhr.setRequestHeader(header, token);
		},
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log("result : " + res);
			
			$.each(res.lecTimeList, function(i, v){
				console.log(i + ", v >> ",v.comDetWNo, v.comDetTName);
				var time = v.comDetTName.replace(":", "_");
				
				$("tr[data-time="+time+"]").find("td[data-day="+v.comDetWNo+"]").attr("data-res", "1");
				$("tr[data-time="+time+"]").find("td[data-day="+v.comDetWNo+"]").addClass("tdReserved");
			});
			
			$.each(res.proTimeList, function(i, v){
				console.log(i + ", v >> ",v.comDetWNo, v.comDetTName);
				var time = v.comDetTName.replace(":", "_");
				
				$("tr[data-time="+time+"]").find("td[data-day="+v.comDetWNo+"]").attr("data-res", "4");
				$("tr[data-time="+time+"]").find("td[data-day="+v.comDetWNo+"]").addClass("tdProTime");
			});
			
			$("input[name='lectureTimes']").remove();
			
			if(facNo == $("#upFacNo").text()){
				if($(".upLecTime").length != 0){
					$.each($(".upLecTime"), function(i,v){
						$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").attr("data-res", "2");
						$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").removeClass("tdReserved");
						$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").removeClass("tdProTime");
						$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").addClass("tdClick");
						let html = "<input type='hidden' name='lectureTimes' value='"+$(v).attr('data-day')+$(v).attr('data-time')+"' id='"+$(v).attr('data-day')+$(v).attr('data-time')+"'>";
						$("#insertFrm").append(html);
					});
				}
			} else{
				if($(".upLecTime").length != 0){
					$.each($(".upLecTime"), function(i,v){
						$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").attr("data-res", "0");
						$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").removeClass("tdReserved");
						$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").removeClass("tdProTime");
						$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").removeClass("tdClick");
					});
				}
			}
		
		}
	});
}
</script>










							

















