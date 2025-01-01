<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<style>

.blue{
	color : blue;
}

</style>





<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">성적관리</h4>
	<form action="/score/saveScore" id="scoreFrm" method="post">
		<div class="row">
			<div class="col-xl-12">
				<div class="card mb-4 bg-white">
					<sec:csrfInput/>
					<input type="hidden" name="lecNo" value="${lecVO.lecNo }" id="lecNo">
					<div class="card-header">
						
						<h4>${lecVO.lecName }</h4>
						<div class="input-group">		
							<label class="input-group-text">중간비율</label>
							<input type="text" class="input-group-text rate" value="${lecVO.lecMidRate }" 
								readonly="readonly" style="width:5%;">
							<label class="input-group-text">기말비율</label>
							<input type="text" class="input-group-text rate" value="${lecVO.lecLastRate }" 
								readonly="readonly" style="width:5%;">
							<label class="input-group-text">쪽지비율</label>
							<input type="text" class="input-group-text rate" value="${lecVO.lecExamRate }" 
								readonly="readonly" style="width:5%;">
							<label class="input-group-text">과제비율</label>
							<input type="text" class="input-group-text rate" value="${lecVO.lecAssRate }" 
								readonly="readonly" style="width:5%;">
							<label class="input-group-text">출석비율</label>
							<input type="text" class="input-group-text rate" value="${lecVO.lecAdRate }" 
								readonly="readonly" style="width:5%;">
							<label class="input-group-text">태도비율</label>
							<input type="text" class="input-group-text rate" value="${lecVO.lecAtRate }" 
								readonly="readonly" style="width:5%;">
						</div>
						<button type="button" class="btn btn-primary" id="saveBtn" style="float:right;">저장</button>
						<button type="button" class="btn btn-secondary" id="calBtn" style="float:right;">계산</button>
						
					</div>
					<hr class="my-0">
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover" style="overflow:hidden;">
	      					<thead>
	        					<tr>
						          	<th width="10%">학번</th>
						          	<th width="10%">이름</th>
						          	<th width="5%">학년</th>
						          	<th width="15%">학과</th>
						          	<th width="5%">중간</th>
						          	<th width="5%">기말</th>
						          	<th width="5%">쪽지</th>
						          	<th width="5%">과제</th>
						          	<th width="5%">출석</th>
						          	<th width="8%" id="atAllScore">
						          		태도<select style="width:45px;">
		      								<c:forEach begin="0" end="100" varStatus="status">
		      									<option value="${status.index }">${status.index }</option>
		      								</c:forEach>
	      								</select>
						          	</th>
						          	<th width="5%">총점</th>
						          	<th width="8%">학점</th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:choose>
	      							<c:when test="${studentScoreList ne null}">
			      						<c:forEach items="${studentScoreList }" var="stu" varStatus="status">
				      						<tr>
				      							<td class="stuNo">${stu.STU_NO }</td>
				      							<td>${stu.STU_NAME }</td>
				      							<td>${stu.STU_YEAR }</td>
				      							<td>${stu.DEPT_NAME }</td>
				      							<c:if test="${stu.MID_SCORE eq null }">
					      							<td class="midScore"><span class="blue">0</span>/${scoreMap.midMaxScore }</td>
				      							</c:if>
				      							<c:if test="${stu.MID_SCORE ne null }">
					      							<td class="midScore"><span class="blue">${stu.MID_SCORE }</span>/${scoreMap.midMaxScore }</td>
				      							</c:if>
				      							<c:if test="${stu.LAST_SCORE eq null }">
					      							<td class="lastScore"><span class="blue">0</span>/${scoreMap.lastMaxScore }</td>
				      							</c:if>
				      							<c:if test="${stu.LAST_SCORE ne null }">
					      							<td class="lastScore"><span class="blue">${stu.LAST_SCORE }</span>/${scoreMap.lastMaxScore }</td>
				      							</c:if>
				      							<c:if test="${stu.ETC_SCORE eq null }">
					      							<td class="etcScore"><span class="blue">0</span>/${scoreMap.examMaxScore }</td>
				      							</c:if>
				      							<c:if test="${stu.ETC_SCORE ne null }">
					      							<td class="etcScore"><span class="blue">${stu.ETC_SCORE }</span>/${scoreMap.examMaxScore }</td>
				      							</c:if>
				      							<c:if test="${stu.ASS_SCORE eq null }">
					      							<td class="assScore"><span class="blue">0</span>/${scoreMap.assMaxScore }</td>
				      							</c:if>
				      							<c:if test="${stu.ASS_SCORE ne null }">
					      							<td class="assScore"><span class="blue">${stu.ASS_SCORE }</span>/${scoreMap.assMaxScore }</td>
				      							</c:if>
				      							<c:if test="${stu.AD_SCORE eq null }">
					      							<td class="adScore"><span class="blue">0</span>/100</td>
				      							</c:if>
				      							<c:if test="${stu.AD_SCORE ne null }">
					      							<td class="adScore"><span class="blue">${stu.AD_SCORE }</span>/100</td>
				      							</c:if>
				      							<td class="atScore">
				      								<select name="couAttitudeArr" style="width:50px;">
					      								<c:forEach begin="0" end="100" varStatus="status">
					      									<option value="${stu.STU_NO }_${status.index }"
					      										<c:if test="${stu.AT_SCORE ne null and stu.AT_SCORE eq status.index }">selected='selected'</c:if>
					      									>${status.index }</option>
					      								</c:forEach>
				      								</select>/100
				      							</td>
				      							<td class="totalScore"></td>
				      							<td>
				      								<select class="couScoreArr" style="width:50px;">
				      									<option value="4.5" 
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '4.5' }">selected='selected'</c:if> 
				      									>4.5</option>
				      									<option value="4.3"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '4.3' }">selected='selected'</c:if> 
				      									>4.3</option>
				      									<option value="4.0"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '4.0' }">selected='selected'</c:if> 
				      									>4.0</option>
				      									<option value="3.7"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '3.7' }">selected='selected'</c:if> 
				      									>3.7</option>
				      									<option value="3.5"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '3.5' }">selected='selected'</c:if> 
				      									>3.5</option>
				      									<option value="3.3"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '3.3' }">selected='selected'</c:if> 
				      									>3.3</option>
				      									<option value="3.0"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '3.0' }">selected='selected'</c:if> 
				      									>3.0</option>
				      									<option value="2.7"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '2.7' }">selected='selected'</c:if> 
				      									>2.7</option>
				      									<option value="2.5"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '2.5' }">selected='selected'</c:if> 
				      									>2.5</option>
				      									<option value="2.3"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '2.3' }">selected='selected'</c:if> 
				      									>2.3</option>
				      									<option value="2.0"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '2.0' }">selected='selected'</c:if> 
				      									>2.0</option>
				      									<option value="1.7"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '1.7' }">selected='selected'</c:if> 
				      									>1.7</option>
				      									<option value="0"
				      										<c:if test="${stu.COU_SCORE ne null and stu.COU_SCORE eq '0' }">selected='selected'</c:if> 
				      									>0</option>
				      								</select>/4.5
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
	
	var scoreFrm = $("#scoreFrm");
	var calBtn = $("#calBtn");
	var saveBtn = $("#saveBtn");
	var atAllScore = $("#atAllScore");
	
	$(document).on('click', "#saveBtn", function(){
		
		$('.stuScoreArr').remove();
		$(".atScore").each(function(i,v){
			var atScore = $(v).find('select').val();
			var score = $(v).parent().find(".couScoreArr").val();
			var html = "<input class='stuScoreArr' type='hidden' name='stuScoreArr' value='"+atScore+"_"+score+"'>";
			scoreFrm.append(html);
		});
		
		scoreFrm.submit();
	});
	
	$(document).on('click', "#calBtn", function(){
		calScore();
	});
	
	$(document).on('change', "#atAllScore", function(){
		var score = $(this).find('option:selected').val();
		$('.atScore').find("select").each(function(i,v){
			$(v).find('option').attr("selected", false);
			$(v).find('option').eq(score).attr("selected", true);
		});
	});
	
	$(document).on('change', "select[name='couAttitudeArr']", function(){
		var score = $(this).find('option:selected').val().split("_")[1];
		$(this).find('option').attr("selected", false);
		$(this).find('option').eq(score).attr("selected", true);
	});
	
	function calScore(){
		$(".totalScore").each(function(i,v){
			var totalScore = 0.0;
			
			stuScore = $(v).parent().find('.midScore').text().split("/")[0];
			maxScore = $(v).parent().find('.midScore').text().split("/")[1];
			if(stuScore == 0 || maxScore == 0)totalScore += 0;
			else totalScore += $('.rate').eq(0).val() * stuScore / maxScore;
			
			stuScore = $(v).parent().find('.lastScore').text().split("/")[0];
			maxScore = $(v).parent().find('.lastScore').text().split("/")[1];
			if(stuScore == 0 || maxScore == 0)totalScore += 0;
			else totalScore += $('.rate').eq(1).val() * stuScore / maxScore;
			
			stuScore = $(v).parent().find('.etcScore').text().split("/")[0];
			maxScore = $(v).parent().find('.etcScore').text().split("/")[1];
			if(stuScore == 0 || maxScore == 0)totalScore += 0;
			else totalScore += $('.rate').eq(2).val() * stuScore / maxScore;
			
			stuScore = $(v).parent().find('.assScore').text().split("/")[0];
			maxScore = $(v).parent().find('.assScore').text().split("/")[1];
			if(stuScore == 0 || maxScore == 0)totalScore += 0;
			else totalScore += $('.rate').eq(3).val() * stuScore / maxScore;
			
			stuScore = $(v).parent().find('.adScore').text().split("/")[0];
			maxScore = $(v).parent().find('.adScore').text().split("/")[1];
			if(stuScore == 0 || maxScore == 0)totalScore += 0;
			else totalScore += $('.rate').eq(4).val() * stuScore / maxScore;
			
			stuScore = $(v).parent().find('.atScore').find('select').val().split("_")[1];
			maxScore = 100;
			if(stuScore == 0 || maxScore == 0)totalScore += 0;
			else totalScore += $('.rate').eq(5).val() * stuScore / maxScore;
			
			$(v).text(totalScore.toFixed(2));
		});
		
		for(let i=0;i<$(".totalScore").length-1;i++){
			for(let j=0;j<$(".totalScore").length-1;j++){
				var html1 = $(".totalScore").eq(j).parents('tr').html();
				var html2 = $(".totalScore").eq(j+1).parents('tr').html();
				if(parseFloat($(".totalScore").eq(j).text()) < parseFloat($(".totalScore").eq(j+1).text())){
					$(".totalScore").eq(j).parents('tr').html(html2);
					$(".totalScore").eq(j+1).parents('tr').html(html1);
				}
			}
		}
	}
	
}); 

</script>






















