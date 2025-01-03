<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">출석관리</h4>
	<form action="/attendance/saveAttendance" id="attFrm" method="post">
		<div class="row">
			<div class="col-xl-12">
				<div class="card mb-4 bg-white">
					<sec:csrfInput/>
					<input type="hidden" name="lecNo" value="${lecNo }" id="lecNo">
					<div class="card-header">
					
						<div class="input-group" style="width:20%; float:left; margin-right: 50px;">
							<label class="input-group-text" for="attDate">출석일자</label>
							<select class="form-select" name="attDate" id="attDate">
								<c:forEach items="${attendanceDayList }" var="att">
									<option value="${att }" <c:if test="${date eq att }">selected='selected'</c:if>>${att }</option>
								</c:forEach>
							</select>
						</div>
						<div class="input-group" style="width:60%; float:left;">
							<label class="input-group-text" for="attDate">전체인원수</label>
							<input type="text" class="form-control" id="cnt1" value="${fn:length(stuAttList) }명" readonly="readonly">
							<label class="input-group-text" for="attDate">출석</label>
							<input type="text" class="form-control" id="cnt1" value="${chul }" readonly="readonly">
							<label class="input-group-text" for="attDate">지각</label>
							<input type="text" class="form-control" id="cnt1" value="${zi }" readonly="readonly">
							<label class="input-group-text" for="attDate">결석</label>
							<input type="text" class="form-control" id="cnt1" value="${gyel }" readonly="readonly">
						</div>
						<button type="button" class="btn btn-primary" id="saveBtn"
							style="float:right;">저장</button>
						
					</div>
					<hr class="my-0">
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover" style="overflow:hidden;">
	      					<thead>
	        					<tr>
						          	<th width="15%">학번</th>
						          	<th width="15%">학과</th>
						          	<th width="10%">이름</th>
						          	<th width="10%">학년</th>
						          	<th width="15%">
										<input type="radio" class="form-radio" id="all1" name="all">
	      								<label for="all1">출석</label>
	      								<input type="radio" class="form-radio" id="all2" name="all">
	      								<label for="all2">지각</label>
	      								<input type="radio" class="form-radio" id="all3" name="all">
	      								<label for="all3">결석</label>
									</th>
						          	<th width="35%">비고</th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:choose>
	      							<c:when test="${stuAttList ne null}">
			      						<c:forEach items="${stuAttList }" var="stu" varStatus="status">
				      						<tr>
				      							<td class="stuNo">${stu.stuNo }</td>
				      							<td>${stu.deptName }</td>
				      							<td>${stu.stuName }</td>
				      							<td>${stu.stuYear }</td>
				      							<td>
				      								<input type="radio" class="form-radio all1" name="${stu.stuNo }" id="${stu.stuNo }1" value="1_${stu.stuNo }"
				      									<c:if test="${not empty stu.attVO.comDetANo and stu.attVO.comDetANo eq 'A0101' }">checked="checked"</c:if>
				      								>
				      								<label for="${stu.stuNo }1">출석</label>
				      								<input type="radio" class="form-radio all2" name="${stu.stuNo }" id="${stu.stuNo }2" value="2_${stu.stuNo }"
				      									<c:if test="${not empty stu.attVO.comDetANo and stu.attVO.comDetANo eq 'A0103' }">checked="checked"</c:if>
				      								>
				      								<label for="${stu.stuNo }2">지각</label>
				      								<input type="radio" class="form-radio all3" name="${stu.stuNo }" id="${stu.stuNo }3" value="3_${stu.stuNo }"
				      									<c:if test="${not empty stu.attVO.comDetANo and stu.attVO.comDetANo eq 'A0102' }">checked="checked"</c:if>
				      								>
				      								<label for="${stu.stuNo }3">결석</label>
												</td>
												<td>
													<c:set value="" var="value"/>
													<c:if test="${not empty stu.attVO.attEtc }">
														<c:set value="${stu.attVO.attEtc }" var="value"/>
													</c:if>
													<input type="text" class="form-control" name="attEtc" id="${stu.stuNo }4" value="${value }">
												</td>
				      						</tr>      						
				      					</c:forEach>
	      							</c:when>
	      							<c:otherwise>
	      								<tr>
	      									<td colspan="5">없음</td>
	      								</tr>
	      							</c:otherwise>
	      						</c:choose>
	      					</tbody>
	   	 				</table>
	  				</div>
				</div>
			</div>
		</div>
	</form>
</div>



<script>

$(function(){
	
	var attFrm = $("#attFrm");
	var saveBtn = $("#saveBtn");
	var attDate = $("#attDate");
	
	$("input[name='all']").on('click', function(){
		console.log("all1 change");
		$(".all1").attr("checked", false);
		$(".all2").attr("checked", false);
		$(".all3").attr("checked", false);
		$("."+$(this).attr("id")).attr("checked", true);
	});
	
	saveBtn.on('click', function(){
		var html = "";
		$(".stuNo").each(function(i,v){
			var att = $("input[name='"+$(v).text()+"']:checked").val();
			var etc = "_" + $("#"+$(v).text()+"4").val();
			html += "<input type='hidden' name='attArr' value='"+att+etc+"'>";
		})
		console.log("html", html);
		attFrm.append(html);
		attFrm.submit();
	});
	
	attDate.on('change', function(){
		location.href="/attendance/attendanceList?lecNo="+$("#lecNo").val()+"&date=" + $(this).val();
	});
	
});

</script>




















