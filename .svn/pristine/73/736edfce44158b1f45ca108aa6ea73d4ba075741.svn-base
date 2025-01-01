<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



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

.pContent{
	color : black;
	font-size : 1.1rem;
/* 	font-weight : bold; */
/* 	border-radius: 5px; */
/* 	border: 1px solid #d2d2d2; */
	padding: 5px 15px 5px 15px;
	margin-bottom : 10px;
}
</style>

<sec:authentication property="principal" var="prc" />
<c:set value="${prc.user.comDetUNo }" var="auth" />


<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">강의상세</h4>
	<c:if test="${auth ne 'U0101' }">
		<c:if test="${type ne null }">
<!-- 			<button type="button" class="btn btn-primary" -->
<!-- 				onclick="javascript:location.href='/professor/lecSignUp'">목록</button> -->
		</c:if>
		<c:if test="${type eq null }">
			<button type="button" class="btn btn-primary" id="listBtn">목록</button>
		</c:if>
	</c:if>
	<div class="row mb-5">
		<div class="col-md-6 col-lg-4 mb-3">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">시간표</h5>
				<hr class="my-0">
				<div class="card-body">
					
					<div class="mb-3 col-md-6">
						<div style="display:none">
							<c:forEach items="${lecTimeList }" var="lecTime">
								<p class="lecTime" data-day="${lecTime.comDetWNo }" data-time="${lecTime.comDetTName }"/>
							</c:forEach>
							<form action="/admin/lectureUpdateForm" id="updateFrm" method="post">
								<sec:csrfInput/>
								<input type="hidden" name="lecNo" id="lecNo" value="${lectureVO.lecNo }"/>
								<input type="hidden" name="rejContent" id="rejContent">
							</form>
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
		</div>
		<div class="col-md-6 col-lg-8 mb-3">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">${lectureVO.lecName }</h5>
				<hr class="my-0">
				<div class="card-body">
					<div class="row mb-3">
							
						<font class="col-sm-2" size="4">과목</font>
						<p class="col-sm-4 pContent">${lectureVO.subName }</p>
							
						<font class="col-sm-2" size="4">담당교수</font>
						<p class="col-sm-4 pContent">${lectureVO.proName }</p>
							
						<font class="col-sm-2" size="4">강의실 위치</font>
						<p class="col-sm-4 pContent">${lectureVO.buiName } ${lectureVO.facName }</p>
							
						<font class="col-sm-2" size="4">강의구분</font>
						<p class="col-sm-4 pContent">${lectureVO.comDetLName }</p>
							
						<font class="col-sm-2" size="4">강의설명</font>
						<p class="col-sm-10 pContent">${lectureVO.lecExplain }</p>
							
						<font class="col-sm-2" size="4">수강인원</font>
						<p class="col-sm-4 pContent">${lectureVO.lecMax } 명</p>
							
						<font class="col-sm-2" size="4">대면여부</font>
						<p class="col-sm-4 pContent">${lectureVO.lecOnoff }</p>
							
						<font class="col-sm-2" size="4">수강학년</font>
						<p class="col-sm-4 pContent">${lectureVO.lecAge } 학년</p>
							
						<font class="col-sm-2" size="4">학점</font>
						<p class="col-sm-4 pContent">${lectureVO.lecScore } 학점</p>
							
						<font class="col-sm-2" size="4">년도/학기</font>
						<p class="col-sm-4 pContent">${lectureVO.year } 년도 ${lectureVO.semester } 학기</p>
						
						<c:set value="${lectureVO.lecFileList[0] }" var="file"/>
						<c:url value="/common/fileDownload.do?${_csrf.parameterName}=${_csrf.token}" var="downloadUrl"> 
							<c:param name="fileGroupNo" value="${file.fileGroupNo }"/>
							<c:param name="fileNo" value="${file.fileNo }"/>
						</c:url>
						<font class="col-sm-2" size="4">강의계획서</font>
						<c:if test="${lectureVO.lecFileList[0] ne null }">
							<a class="col-sm-4" style="font-size:1.1rem;" href="${downloadUrl }">
								${file.fileName }
							</a>
						</c:if>
						<c:if test="${lectureVO.lecFileList[0] eq null }">
							<font class="col-sm-4" color="red">강의계획서 없음</font>
						</c:if>
						
					</div>
				</div>
				<h5 class="card-header">성적반영비율(%)</h5>
				<div class="card-body">
					<div class="row mb-3">
							
						<font class="col-sm-2" size="4">중간고사</font>
						<p class="col-sm-2 pContent">${lectureVO.lecMidRate }</p>

						<font class="col-sm-2" size="4">기말고사</font>
						<p class="col-sm-2 pContent">${lectureVO.lecLastRate }</p>
						
						<font class="col-sm-2" size="4">과제</font>
						<p class="col-sm-2 pContent">${lectureVO.lecAssRate }</p>
						
						<font class="col-sm-2" size="4">시험</font>
						<p class="col-sm-2 pContent">${lectureVO.lecExamRate }</p>
						
						<font class="col-sm-2" size="4">출석</font>
						<p class="col-sm-2 pContent">${lectureVO.lecAdRate }</p>
						
						<font class="col-sm-2" size="4">태도</font>
						<p class="col-sm-2 pContent">${lectureVO.lecAtRate }</p>
							
					</div>
				</div>
				<c:if test="${lectureVO.rejContent ne null }">
					<div class="card-body">
						<div class="row mb-3">
								
							<font class="col-sm-2" size="4" style="color:red;">반려사유</font>
							<p class="col-sm-10 pContent">${lectureVO.rejContent }</p>
								
						</div>
					</div>
				</c:if>
				<c:if test="${auth ne 'U0101' }">
					<div class="card-footer">
						<c:if test="${type ne null }">
							<c:if test="${lectureVO.comDetCNo eq 'C0103' }">
								<button type="button" class="btn btn-primary" id="ReConfirmBtn">승인요청</button>
							</c:if>
						</c:if>
						<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
						<c:if test="${type eq null }">
							<c:if test="${lectureVO.comDetCNo eq 'C0101' }">
								<button type="button" class="btn btn-primary" id="unConfirmBtn">미승인</button>
							</c:if>
							<c:if test="${lectureVO.comDetCNo eq 'C0102' }">
								<button type="button" class="btn btn-primary" id="confrimBtn">승인</button>
								<button type="button" class="btn btn-warning"
										data-bs-toggle="modal" data-bs-target="#modalReject">반려</button>
							</c:if>
							<c:if test="${lectureVO.comDetCNo eq 'C0103' }">
								<button type="button" class="btn btn-primary" id="unConfirmBtn">미승인</button>
							</c:if>
						</c:if>
						<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
					</div>
				</c:if>
			</div>
			<!-- 반려 Modal -->
	        <div class="modal fade" id="modalReject" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="modalReject" 
	                  			style="font-weight:bold;">반려 사유</h5>
	                  		<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	               		<div class="modal-body">
		                  	<div class="row mb-3">
		                  		<div class="col-sm-12">반려 사유를 작성해주세요.</div>
		                    	<div class="col-sm-12">
		                      		<textarea rows="10" class="form-control" id="rejContent2"></textarea>
		                      	</div>
		                	</div>
	         			</div>
	         			<div class="modal-footer">
	         				<button class="btn btn-warning" id="rejectBtn">반려</button>
	         			</div>
	            	</div>
	    	   	</div>
	 		</div>
		</div>
	</div>
</div>




<script>

$(function(){
	
	var listBtn = $("#listBtn");
	var updateBtn = $("#updateBtn");
	var confrimBtn = $("#confrimBtn");
	var rejectBtn = $("#rejectBtn");
	var unConfirmBtn = $("#unConfirmBtn");
	var deleteBtn = $("#deleteBtn");
	var updateFrm = $("#updateFrm");
	
	if($(".lecTime").length != 0){
		$.each($(".lecTime"), function(i,v){
			$("tr[data-time="+$(v).attr('data-time')+"]").find("td[data-day="+$(v).attr('data-day')+"]").css("background", "skyblue");
		});
	}
	
	listBtn.on('click', function(){
		history.back();
	});
	
	updateBtn.on('click', function(){
		updateFrm.attr("action", "/admin/lectureUpdateForm");
		updateFrm.submit();
	});
	
	confrimBtn.on('click', function(){
		updateFrm.attr("action", "/admin/lectureConfirm");
		updateFrm.submit();
	});
	
	rejectBtn.on('click', function(){
		updateFrm.attr("action", "/admin/lectureReject");
		$("#rejContent").val($("#rejContent2").val());
		updateFrm.submit();
	});
	
	unConfirmBtn.on('click', function(){
		updateFrm.attr("action", "/admin/lectureUnConfirm");
		updateFrm.submit();
	});
	
	deleteBtn.on('click', function(){
		
		if(!confirm("정말 삭제하시겠습니까?")){
			return false;
		}
		
		updateFrm.attr("action", "/admin/lectureDelete");
		updateFrm.submit();
	});
	
});

</script>

























