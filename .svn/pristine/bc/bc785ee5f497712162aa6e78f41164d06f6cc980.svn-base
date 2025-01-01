<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<style>
.accordion-body div{
	margin: 10px 0 0 0;
	padding:0;
}
.accordion-body div button{
	margin-left:0 auto 0 100;
}
</style>



<div class="container-xxl flex-grow-1 container-p-y">
	<c:set value="/exam/examInsert" var="path"/>
	<c:if test="${examVO ne null }">
		<c:set value="/exam/examUpdate" var="path"/>
	</c:if>
	<form action="${path }" method="post" id="queFrm">
		<sec:csrfInput/>
		<input type="hidden" name="lecNo" value="${lecVO.lecNo }">
		<c:if test="${examVO eq null }">
			<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">시험등록</h4>
		</c:if>
		<c:if test="${examVO ne null }">
			<input type="hidden" name="examNo" value="${examVO.examNo }">
			<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">시험수정</h4>
		</c:if>
		<div class="row mb-5">
			<div class="col-md-6 col-lg-4 mb-3">
				<div class="card mb-4 bg-white">
					<h4 class="card-header">${lecVO.lecName }</h4>
					<hr class="my-0">
					<div class="card-body row">
						<div>
							<label class="form-label" for="comDetHNo">시험구분</label>
							<select class="form-select " name="comDetHNo" id="comDetHNo">
								<option value="H0101" <c:if test="${examVO.comDetHNo == 'H0101' }">selected='selected'</c:if>>중간고사</option>
								<option value="H0102" <c:if test="${examVO.comDetHNo == 'H0102' }">selected='selected'</c:if>>기말고사</option>
								<option value="H0103" <c:if test="${examVO.comDetHNo == 'H0103' }">selected='selected'</c:if>>기타시험</option>
							</select>
						</div>
						<div>
							<label class="form-label" for="comDetHNo">시험명</label>
							<input type="text" class="form-control" name="examName" id="examName" value="${examVO.examName }">
						</div>
						<div>
							<label class="form-label" for="examContent">시험내용</label>
							<textarea rows="3" class="form-control" name="examContent" id="examContent">${examVO.examContent }</textarea>
						</div>
						<div>
							<label class="form-label" for="examLimit">제한시간(분)</label>
							<input type="text" class="form-control" name="examLimit" id="examLimit" value="${examVO.examLimit }">
						</div>
						<div>
							<div class="row">
								<div class="col-sm-6">
									<label class="form-label" for="examDate">시험일자</label>
									<input type="date" class="form-control" name="examDate" id="examDate" value="${examVO.examDate }">
								</div>
								<div class="col-sm-6">
									<label class="form-label" for="examTime">시험일시</label>
									<select class="form-select " name="examTime" id="examTime">
										<c:forEach begin="8" end="21" step="1" var="time">
											<c:set value="${time }:00" var="time1"/>
											<c:set value="${time }:30" var="time2"/>
											<option value="${time }_00" <c:if test="${examVO.examTime eq time1 }">selected='selected'</c:if>>${time }:00</option>
											<option value="${time }_30" <c:if test="${examVO.examTime eq time2 }">selected='selected'</c:if>>${time }:30</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="card-footer">
						<button type="button" class="btn btn-primary" onclick="javascript:location.href='/exam/examList?lecNo=${lecVO.lecNo }'">목록</button>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-8 mb-3">
				
				<div class="input-group" style="margin-bottom: 10px;">
					<c:if test="${examVO eq null }">
						<label class="input-group-text" id="totalQueCnt" style="width:30%">총 1 문제</label>
						<label class="input-group-text" id="totalQueScore" style="width:30%">총 0 점</label>
					</c:if>
					<c:if test="${examVO ne null }">
						<label class="input-group-text" id="totalQueCnt" style="width:30%">총 ${fn:length(examVO.examQueList) } 문제</label>
						<c:set value="0" var="totalScore"/>
						<c:forEach items="${examVO.examQueList }" var="que">
							<c:set value="${totalScore + que.examQueScore }" var="totalScore"/>
						</c:forEach>
						<label class="input-group-text" id="totalQueScore" style="width:30%">총 ${totalScore } 점</label>
					</c:if>
					<button type="button" class="btn btn-sm btn-secondary " id="plusQueBtn" style="width:20%;">문제추가</button>
					<button type="submit" class="btn btn-sm btn-primary " id="saveQueBtn" style="width:20%;">저장</button>
				</div>
	          		
				<div class="card accordion-item" id="queList">
					
					<c:if test="${examVO eq null }">
					
				        <h2 class="accordion-header" id="head1" style="border-bottom: 1px solid #dddddd;">
				          	<button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" 
				          		data-bs-target="#que1" aria-expanded="false" aria-controls="que1"
				          		style="width:90%; float:left;">
				          		<span class="queNo" style="width:4%;">1</span>번
				          		<span class="queConSum" style="width:80%;"></span>
				          	</button>
				          	<button type="button" class="btn btn-sm btn-danger removeQueBtn"
				          		style="width:10%; float:left; margin: 10px 0;">삭제</button>
				        </h2> 
				        <div id="que1" class="accordion-collapse collapse" aria-labelledby="head1" style="border-bottom: 1px solid #dddddd; background: #f5f5f5;">
				          	<div class="accordion-body">
				          		<div class="row">
					          		<label class="col-sm-2 col-form-label"><font size="3">문제내용</font></label>
									<div class="col-sm-10">
										<textarea rows="5" class="form-control queContent" name="examQueArr[0].examQueContent"></textarea>
									</div>
									<label class="col-sm-2 col-form-label"><font size="3">정답</font></label>
									<div class="col-sm-4">
										<select class="form-select queAnswer" name="examQueArr[0].examQueAnswer">
											<option value="1">선택지1</option>
										</select>
									</div>
									<label class="col-sm-2 col-form-label"><font size="3">점수</font></label>
									<div class="col-sm-4">
										<input type="text" class="form-control queScore" name="examQueArr[0].examQueScore" value="0">
									</div>
								</div>
								<div class="queSelList">
									<div class="input-group queSel">
										<label class="input-group-text">선택지1</label>
										<textarea rows="1" class="form-control" style="width:60%;" name="examQueArr[0].examQueSelArr[0].examQueSelContent"></textarea>
										<button type="button" class="btn btn-secondary removeQueSelBtn">X</button>
									</div>
								</div>
								<button type="button" class="btn btn-sm btn-secondary plusQueSelBtn" 
									style="margin-top:10px; width:100%;">선택지 추가</button>
				          	</div>
			        	</div>
					
					</c:if>
					
					<c:if test="${examVO ne null }">
						<c:forEach items="${examVO.examQueList }" var="que" varStatus="status">
						
							<h2 class="accordion-header" id="head${status.count }" style="border-bottom: 1px solid #dddddd;">
					          	<button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" 
					          		data-bs-target="#que${status.count }" aria-expanded="false" aria-controls="que${status.count }"
					          		style="width:90%; float:left;">
					          		<span class="queNo" style="width:4%;">${status.count }</span>번
					          		<span class="queConSum" style="width:80%;"></span>
					          	</button>
					          	<button type="button" class="btn btn-sm btn-danger removeQueBtn"
					          		style="width:10%; float:left; margin: 10px 0;">삭제</button>
					        </h2> 
					        <div id="que${status.count }" class="accordion-collapse collapse" aria-labelledby="head${status.count }" style="border-bottom: 1px solid #dddddd; background: #f5f5f5;">
					          	<div class="accordion-body">
					          		<div class="row">
						          		<label class="col-sm-2 col-form-label"><font size="3">문제내용</font></label>
										<div class="col-sm-10">
											<textarea rows="5" class="form-control queContent" name="examQueArr[${status.index }].examQueContent">${que.examQueContent }</textarea>
										</div>
										<label class="col-sm-2 col-form-label"><font size="3">정답</font></label>
										<div class="col-sm-4">
											<select class="form-select queAnswer" name="examQueArr[${status.index }].examQueAnswer">
												<c:forEach items="${que.examQueSelList }" var="queSel" varStatus="status2">
													<option value="${status2.count }" <c:if test="${status2.count eq que.examQueAnswer }">selected='selected'</c:if> >선택지${status2.count }</option>
												</c:forEach>
											</select>
										</div>
										<label class="col-sm-2 col-form-label"><font size="3">점수</font></label>
										<div class="col-sm-4">
											<input type="text" class="form-control queScore" name="examQueArr[${status.index }].examQueScore" value="${que.examQueScore }">
										</div>
									</div>
									<div class="queSelList">
										<c:forEach items="${que.examQueSelList }" var="queSel" varStatus="status2">
											<div class="input-group queSel">
												<label class="input-group-text">선택지${status2.count }</label>
												<textarea rows="1" class="form-control" style="width:60%;" name="examQueArr[${status.index }].examQueSelArr[${status2.index }].examQueSelContent">${queSel.examQueSelContent }</textarea>
												<button type="button" class="btn btn-secondary removeQueSelBtn">X</button>
											</div>
										</c:forEach>
									</div>
									<button type="button" class="btn btn-sm btn-secondary plusQueSelBtn" 
										style="margin-top:10px; width:100%;">선택지 추가</button>
					          	</div>
				        	</div>
				        	
						</c:forEach>
					</c:if>
					
		        	
		      	</div>
			</div>
		</div>
	</form>
</div>


<c:if test="${examVO eq null }">
	<div id="queNo">2</div>
</c:if>
<c:if test="${examVO ne null }">
	<div id="queNo">${fn:length(examVO.examQueList) + 1 }</div>
</c:if>
<div style="display: none;" id="queHTML">

	<h2 class="accordion-header" id="head1" style="border-bottom: 1px solid #dddddd;">
	   	<button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" 
	   		data-bs-target="#que1" aria-expanded="false" aria-controls="que1"
	   		style="width:90%; float:left;">
	   		<span class="queNo" style="width:4%;">1</span>번
	   		<span class="queConSum" style="width:80%;"></span>
	   	</button>
	   	<button type="button" class="btn btn-sm btn-danger removeQueBtn"
	   		style="width:10%; float:left; margin: 10px 0;">삭제</button>
	</h2> 
	<div id="que1" class="accordion-collapse collapse" aria-labelledby="head1" style="border-bottom: 1px solid #dddddd; background: #f5f5f5;">
	  	<div class="accordion-body">
	  		<div class="row">
	      		<label class="col-sm-2 col-form-label"><font size="3">문제내용</font></label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control queContent" name="examQueArr[0].examQueContent"></textarea>
				</div>
				<label class="col-sm-2 col-form-label"><font size="3">정답</font></label>
				<div class="col-sm-4">
					<select class="form-select queAnswer" name="examQueArr[0].examQueAnswer">
						<option value="1">선택지1</option>
					</select>
				</div>
				<label class="col-sm-2 col-form-label"><font size="3">점수</font></label>
				<div class="col-sm-4">
					<input type="text" class="form-control queScore" name="examQueArr[0].examQueScore" value="0">
				</div>
			</div>
			<div class="queSelList">
				<div class="input-group queSel">
					<label class="input-group-text">선택지1</label>
					<textarea rows="1" class="form-control" style="width:60%;" name="examQueArr[0].examQueSelArr[0].examQueSelContent"></textarea>
					<button type="button" class="btn btn-secondary removeQueSelBtn">X</button>
				</div>
			</div>
			<button type="button" class="btn btn-sm btn-secondary plusQueSelBtn" 
				style="margin-top:10px; width:100%;">선택지 추가</button>
	  	</div>
	</div>
</div>


<script>

$(function(){
	
	var queList = $("#queList");
	var queHTML = $("#queHTML").html();
	var queSelHTML = $("#queHTML").find('.queSelList').html();
	var plusQueBtn = $("#plusQueBtn");
	var queNo = parseInt($("#queNo").text());
	
	$("#head1").find('button').trigger('click');
	
	function queSetting(i){
		var header = queList.find('.accordion-header:eq('+(i-1)+')');
		header.attr("id", "head"+i);
		header.find('button').attr("data-bs-target", "#que"+i);
		header.find('button').attr("aria-controls", "que"+i);
		header.find('.queNo').text(i);
		
		var collapse = queList.find('.accordion-collapse:eq('+(i-1)+')');
		collapse.attr("id", "que"+i);
		collapse.attr("aria-labelledby", "head"+i);
		collapse.find("textarea:eq(0)").attr("name", "examQueArr["+(i-1)+"].examQueContent");
		collapse.find("select").attr("name", "examQueArr["+(i-1)+"].examQueAnswer");
		collapse.find("input").attr("name", "examQueArr["+(i-1)+"].examQueScore");
		
		queSelSetting(i-1);
	};
	
	function queSelSetting(index){
		console.log("index", index);
		var queSelCnt = $(".queSelList").eq(index).find('.queSel').length;
		$(".queAnswer").eq(index).find('option').remove();
		for(let j=0;j<queSelCnt;j++){
			$(".queSelList").eq(index).find('.queSel').eq(j).find('label').text('선택지'+(j+1));
			$(".queSelList").eq(index).find('.queSel').eq(j).find('textarea').attr("name", "examQueArr["+index+"].examQueSelArr["+j+"].examQueSelContent");
			$(".queAnswer").eq(index).append('<option value="'+(j+1)+'">선택지'+(j+1)+'</option>');
		}
	};
	
	plusQueBtn.on('click', function(){
		console.log("plusQueBtn click...!");
		
		queList.append(queHTML);
		queSetting(queNo);
		
		queNo += 1;
		$("#totalQueCnt").text("총 " + (queNo-1) + " 문제");
	});
	
	$(document).on('click', '.removeQueBtn', function(){
		console.log("removeQueBtn click");
		
		if(!confirm($(this).parent().find('.queNo').text() + "문제를 삭제하시겠습니까?")){
			return false;
		}
		
		$(this).parents('h2').next().remove();
		$(this).parents('h2').remove();
		
		queNo -= 1;
		$("#totalQueCnt").text("총 " + (queNo-1) + " 문제");
		
		for(let i=0;i<queList.find('.accordion-header').length;i++){
			queSetting(i+1);
		}
	});
	
	$(document).on('click', '.plusQueSelBtn', function(){
		console.log("plusQueSelBtn click"); 
		
		var index = $(this).parents('.accordion-collapse').prev().find('.queNo').text() - 1;
		console.log("index >> ", index); 
		$(this).prev().append(queSelHTML);
		queSelSetting(index);
	});
	
	$(document).on('click', '.removeQueSelBtn', function(){
		console.log("removeQueSelBtn click...!");
		
		if($(this).parents('.queSelList').find('.queSel').length == 1){
			alert("선택지는 하나 이상 존재해야 합니다!");
			return false;
		}
		
		var index = $(this).parents('.accordion-collapse').prev().find('.queNo').text() - 1;
		console.log("index >> ", index); 
		$(this).parent().remove();
		queSelSetting(index);
	});
	
	$(document).on('input', '.queScore', function(){
		console.log("queScore input");
		
		if(!$.isNumeric($(this).val())){
			alert("숫자만 입력 가능합니다!");
			$(this).val("0");
			return false;
		}
		if($(this).val().length > 1 && $(this).val().substring(0,1) == "0"){
			alert("정수만 입력 가능합니다!");
			$(this).val("0");
			return false;
		}
		
		var totalScore = 0;
		
		for(let i=0;i<$(".queScore").length;i++){
			totalScore += parseInt($(".queScore").eq(i).val());
		}
		
		$("#totalQueScore").text("총 " +totalScore+" 점");
	})
	
	
	
});

</script>










































