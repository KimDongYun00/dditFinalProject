<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<style>

.searchHeader {
	background : #dddddd;
	padding : 1% 2% 0% 2%;
	border-radius: 10px;
}

.searchWord{
	color : black;
	font-size : 1.2rem;
	text-align : center;
}

#searchBtn {
	font-weight : bold;
	background:skyblue;
}

.hoverColor{
	background:skyblue;
}

.thead, .tbody tr{
	display: table;
  	width: 100%;
}

.tbody{
	display: block;
/* 	max-height: 300px; */
	height: 300px;
	overflow-y: scroll;
}

.blue{
	background : blue;
}

.skyblue{
	background : skyblue;
}

.yellowgreen{
	background : yellowgreen;
}

.green{
	background : green;
}

.red{
	background : red;
}

.black{
	font-color : black;
	font-size : 1.0001rem;
}

.modalDiv{
 	border-bottom: 1px solid #dddddd; 
	padding: 5px 10px 5px 10px;
	margin-bottom : 20px;
}
</style>


<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<div class="card-header searchHeader">
					<form action="" method="get" id="searchFrm">
						<sec:csrfInput/>
						<input type="hidden" name="page" id="page">
						<input type="hidden" name="year" id="year">
						<input type="hidden" name="semester" id="semester">
						<div class="row mb-3" id="searchDiv">
							
							<div class="col-sm-12">
								<div class="input-group">
									<label class="input-group-text" for="searchLecType">강의구분</label>
									<select class="form-select" name="searchLecType" id="searchLecType">
										<c:forEach items="${comLNoList }" var="comLec">
											<option value="${comLec.comDetNo }" 
												<c:if test="${comLec.comDetNo eq pagingVO.searchLecType }">
													selected='selected'
												</c:if>>
												${comLec.comDetName }
											</option>
										</c:forEach>
									</select>
									<label class="input-group-text" for="searchScore">학점</label>
									<select class="form-select" name="searchScore" id="searchScore">
										<option></option>
										<option value="2" <c:if test="${pagingVO.searchScore == 2 }">selected='selected'</c:if>>2학점</option>
										<option value="3" <c:if test="${pagingVO.searchScore == 3 }">selected='selected'</c:if>>3학점</option>
									</select>
									<label class="input-group-text" for="searchAge">학년</label>
									<select class="form-select" name="searchAge" id="searchAge">
										<option></option>
										<option value="1" <c:if test="${pagingVO.searchAge == 1 }">selected='selected'</c:if>>1학년</option>
										<option value="2" <c:if test="${pagingVO.searchAge == 2 }">selected='selected'</c:if>>2학년</option>
										<option value="3" <c:if test="${pagingVO.searchAge == 3 }">selected='selected'</c:if>>3학년</option>
										<option value="4" <c:if test="${pagingVO.searchAge == 4 }">selected='selected'</c:if>>4학년</option>
										<option value="5" <c:if test="${pagingVO.searchAge == 5 }">selected='selected'</c:if>>5학년</option>
									</select>
									<label class="input-group-text" for="searchOnoff">대면여부</label>
									<select class="form-select" name="searchOnoff" id="searchOnoff">
										<option></option>
										<option value="Y" <c:if test="${pagingVO.searchOnoff == 'Y' }">selected='selected'</c:if>>대면</option>
										<option value="N" <c:if test="${pagingVO.searchOnoff == 'N' }">selected='selected'</c:if>>비대면</option>
									</select>
									<select class="form-select" name="searchType" id="searchType">
										<option value="1" <c:if test="${pagingVO.searchType == 1 }">selected='selected'</c:if>>강의명</option>
										<option value="2" <c:if test="${pagingVO.searchType == 2 }">selected='selected'</c:if>>교수명</option>
									</select>
									<input class="form-control" style="width:20%;" name="searchWord" id="searchWord">
									<button class="btn btn-outline" id="searchBtn">검색</button>
								</div>
							</div>
						
						</div>
					</form>
				</div>
				<hr class="my-0">
				<div class="table-responsive text-nowrap">
					<form action="/student/reserveCourseCart" method="post" id="resFrm">
						<sec:csrfInput/>
						<input type="hidden" name="stuNo" id="stuNo" value="${pagingVO.searchStudent }">
						<input type="hidden" name="lecNo" id="lecNo" value="">
					</form>
    				<table class="table table-hover">
      					<thead class="thead">
        					<tr>
					          	<th width="10%">강의구분</th>
					          	<th width="25%">강의명</th>
					          	<th width="15%">교수명</th>
					          	<th width="10%">수강학년</th>
					          	<th width="10%">학점</th>
					          	<th width="10%">대면여부</th>
					          	<th width="10%">신청</th>
					     	</tr>
      					</thead>
      					<tbody class="table-border-bottom-0 tbody">
      						<c:choose>
      							<c:when test="${pagingVO.dataList ne null}">
		      						<c:forEach items="${pagingVO.dataList }" var="lecture" varStatus="status">
			      						<tr class="lec">
			      							<td width="10%">${lecture.comDetLName }</td>
			      							<td width="25%" class="lecNo no" data-no="${lecture.lecNo }"
			      								 data-bs-toggle="modal" data-bs-target="#modalLec">${lecture.lecName }</td>
			      							<td width="15%">${lecture.proName }</td>
			      							<td width="10%">${lecture.lecAge }</td>
			      							<td width="10%" class="lecScore">${lecture.lecScore }</td>
			      							<td width="10%">
			      								<c:if test="${lecture.lecOnoff eq 'Y' }">대면</c:if>
			      								<c:if test="${lecture.lecOnoff ne 'Y' }">비대면</c:if>
			      							</td>
			      							<td width="10%">
												<button class="btn btn-sm btn-primary courseBtn" data-res="0">신청하기</button>
											</td>
											<c:forEach items="${lecture.lectureTimes }" var="times">
												<td class="lecTime" data-day="${fn:substring(times, 0, 5) }" 
													data-time="${fn:substring(times, 5, 10) }" style="display:none;"></td>
											</c:forEach>
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
			<div class="card mb-4 bg-white">
				<h5 class="card-header" style="background : #dddddd; text-weight:bold;">
					예비수강신청목록 - 총 <span id="scoreSum">0</span>/<span id="maxScore">15</span> 학점
				</h5>
				<hr class="my-0">
				<div class="table-responsive text-nowrap">
    				<table class="table table-hover" style="overflow:hidden;">
      					<thead>
        					<tr>
					          	<th width="10%">강의구분</th>
					          	<th width="25%">강의명</th>
					          	<th width="15%">교수명</th>
					          	<th width="10%">수강학년</th>
					          	<th width="10%">학점</th>
					          	<th width="10%">대면여부</th>
					     	</tr>
      					</thead>
      					<tbody class="table-border-bottom-0" id="tbody">
      						<c:forEach items="${courseCartList }" var="cart" varStatus="status">
	      						<tr class="cart">
	      							<td width="10%">${cart.comDetLName }</td>
	      							<td width="25%" class="cartNo no" data-no="${cart.lecNo }"
	      								data-bs-toggle="modal" data-bs-target="#modalLec">${cart.lecName }</td>
	      							<td width="15%">${cart.proName }</td>
	      							<td width="10%">${cart.lecAge }</td>
	      							<td width="10%" class="cartScore">${cart.lecScore }</td>
	      							<td width="10%">
	      								<c:if test="${cart.lecOnoff eq 'Y' }">대면</c:if>
			      						<c:if test="${cart.lecOnoff ne 'Y' }">비대면</c:if>
			      					</td>
	      							<td width="10%">
										<button class="btn btn-sm btn-primary courseCancelBtn" data-res="0">취소하기</button>
									</td>
									<c:forEach items="${cart.lectureTimes }" var="times">
										<td class="cartTime" data-day="${fn:substring(times, 0, 5) }" 
											data-time="${fn:substring(times, 5, 10) }" style="display:none;"></td>
									</c:forEach>
	      						</tr>      						
	      					</c:forEach>
      					</tbody>
   	 				</table>
  				</div>
			</div>
			<!-- 교수 검색 Modal -->
	        <div class="modal fade" id="modalLec" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" style="font-weight:bold;">
	                  			<span id="mLecName">강의 상세</span>
	                  		</h5>
	                  		<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	               		<div class="modal-body">
		                  	<div class="row mb-3">
		                    	<div class="col-sm-6">
		                      		<label class="form-label">강의실</label>
		                      		<div class="modalDiv" id="mLecRoom">강의실</div>
		                      	</div> 
		                    	<div class="col-sm-6">
		                      		<label class="form-label">수강인원</label>
		                      		<div class="modalDiv" id="mLecMax">수강인원</div>
		                      	</div>
		                    	<div class="col-sm-12">
		                      		<label class="form-label">강의설명</label>
		                      		<div class="modalDiv" id="mLecExplain">강의설명</div>
		                      	</div>
		                    	<div class="col-sm-4">
		                      		<label class="form-label">중간고사비율</label>
		                      		<div class="modalDiv" id="mLecMidRate">10</div>
		                      	</div>
		                    	<div class="col-sm-4">
		                      		<label class="form-label">시험비율</label>
		                      		<div class="modalDiv" id="mLecExamRate">10</div>
		                      	</div>
		                    	<div class="col-sm-4">
		                      		<label class="form-label">출석비율</label>
		                      		<div class="modalDiv" id="mLecAdRate">10</div>
		                      	</div>
		                    	<div class="col-sm-4">
		                      		<label class="form-label">기말고사비율</label>
		                      		<div class="modalDiv" id="mLecLastRate">10</div>
		                      	</div>
		                    	<div class="col-sm-4">
		                      		<label class="form-label">과제비율</label>
		                      		<div class="modalDiv" id="mLecAssRate">10</div>
		                      	</div>
		                    	<div class="col-sm-4">
		                      		<label class="form-label">태도비율</label>
		                      		<div class="modalDiv" id="mLecAtRate">10</div>
		                      	</div>
		                    	<div class="col-sm-6">
		                      		<label class="form-label">강의계획서</label>
		                      		<div class="modalDiv" id="mLecFile">
		                      		</div>
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
	
token = $("meta[name='_csrf']").attr("content");
header = $("meta[name='_csrf_header']").attr("content");

$(function(){
	
	var courseBtn = $(".courseBtn");
	var courseCancelBtn = $(".courseCancelBtn");
	var resFrm = $("#resFrm");
	var maxScore = parseInt($("#maxScore").text());
	
	$.each($('.cartTime'), function(i,v){
		var time = $(v).attr("data-time");
		var day = $(v).attr("data-day");
		
		$("tr[data-time="+time+"]").find("td[data-day="+day+"]").addClass("yellowgreen");
	});
	
	var score = 0;
	$.each($(".cartScore"), function(i,v){
		score += parseInt($(v).text());
	});
	$("#scoreSum").text(score);
	
	courseBtn.on('click', function(){
		console.log("courseBtn click...!");
		
		var lecScore = parseInt($(this).parents('.lec').find('.lecScore').text());
		if(parseInt($("#scoreSum").text()) + lecScore > maxScore){
			alert("예비수강신청은 "+maxScore+"학점까지 신청가능합니다!");
			return false;
		}
		
		var flag = false;
		$.each($(this).parents('.lec').find('.lecTime'), function(i,v){
			var time = $(v).attr("data-time");
			var day = $(v).attr("data-day");
			
			var td = $("tr[data-time="+time+"]").find("td[data-day="+day+"]");
			
			if(td.hasClass("red")){
				alert("겹치는 시간대의 강의입니다!");
				flag = true;
				return false;		
			} 
		});
		if(flag) return false;
		
		var lecNo = $(this).parents('.lec').find('.lecNo').attr("data-no");
		
		$("#lecNo").val(lecNo);
		resFrm.attr("action", "/student/reserveCourseCart");
		resFrm.submit();
	});
	
	courseCancelBtn.on('click', function(){
		console.log("courseCancelBtn click...!");
		var lecNo = $(this).parents('.cart').find('.cartNo').attr("data-no");
		
		$("#lecNo").val(lecNo);
		resFrm.attr("action", "/student/cancelCourseCart");
		resFrm.submit();
	});
	
	$(".lec").hover(function(){
		$.each($(this).find('.lecTime'), function(i,v){
			var time = $(v).attr("data-time");
			var day = $(v).attr("data-day");
			
			var td = $("tr[data-time="+time+"]").find("td[data-day="+day+"]");
			
			if(td.hasClass("yellowgreen")){
				td.addClass("red");				
			} else{
				td.addClass("skyblue");
			}
		});
	}, function(){
		var td = $("tr[data-time]").find("td[data-day")
		td.removeClass("skyblue");
		td.removeClass("red");
	});
	
	$(".cart").hover(function(){
		$.each($(this).find('.cartTime'), function(i,v){
			var time = $(v).attr("data-time");
			var day = $(v).attr("data-day");
			
			$("tr[data-time="+time+"]").find("td[data-day="+day+"]").addClass("green");
		});
	}, function(){
		$("tr[data-time]").find("td[data-day").removeClass("green");
	});
	
	$(".no").hover(function(){
		$(this).addClass("black");
	}, function(){
		$(this).removeClass("black");
	});
	
	$(".no").click(function(){
		console.log("no click...!");
		
		var lecNo = $(this).attr("data-no");
		var lecName = $(this).text();
		
		$("#mLecName").text(lecName);
		
		var data = {
			lecNo : lecNo
		};
		
		$.ajax({
			url : "/student/lectureDetail.do",
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(data),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				console.log("result : " + res);
				
				$("#mLecRoom").text(res.buiName + " " + res.facName);
				$("#mLecMax").text(res.lecMax);
				$("#mLecExplain").text(res.lecExplain);
				$("#mLecMidRate").text(res.lecMidRate);
				$("#mLecLastRate").text(res.lecLastRate);
				$("#mLecExamRate").text(res.lecExamRate);
				$("#mLecAssRate").text(res.lecAssRate);
				$("#mLecAdRate").text(res.lecAdRate);
				$("#mLecAtRate").text(res.lecAtRate);
				
				console.log("res.lecFileList[0].fileGroupNo", res.lecFileList[0].fileGroupNo);
				console.log("res.lecFileList[0].fileGroupNo", res.lecFileList[0].fileNo);
				console.log("res.lecFileList[0].fileGroupNo", res.lecFileList[0].fileName);
				
				var html = "<a style='font-size:1.1rem;'"
						+" href='/common/fileDownload.do?${_csrf.parameterName}=${_csrf.token}"
						+"&fileGroupNo="+res.lecFileList[0].fileGroupNo
						+"&fileNo="+res.lecFileList[0].fileNo+"'>"+res.lecFileList[0].fileName+"</a>";
				$("#mLecFile").html(html);
			}
		});
	});
	
	
	
});

</script>


























