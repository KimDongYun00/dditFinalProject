<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<style>

.check{
	color : black;
}

.noCheck{
	color : red;
}

</style>


<!-- 시큐리티 회원권한 가져오기 -->
<sec:authentication property="principal" var="prc" />
<c:set value="${prc.user.comDetUNo }" var="auth" />

<c:if test="${auth eq null }">
	<h3>로그인정보가 필요합니다!</h3>
</c:if>


<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">시험</h4>
	<div class="row mb-5">
		<div class="col-md-6 col-lg-8 mb-3">
		
			<div class="card mb-4 bg-white">
				<h4 class="card-header">${examVO.examName }(${examVO.comDetHName })</h4>
				<hr class="my-0">
				<div class="card-body examInfo">
					<div style="font-size:1.1rem; margin-top:10px;">
						${examVO.examContent }
					</div>
				</div>
			</div>
			
			<hr>
			
			<form action="/exam/examSubmit" method="post" id="submitFrm">
				<sec:csrfInput/>
				<input type="hidden" name="stuNo" value="${prc.user.stuVO.stuNo }">
				<input type="hidden" name="lecNo" value="${examVO.lecNo }">
				<input type="hidden" name="examNo" value="${examVO.examNo }">
				<c:forEach items="${examVO.examQueList }" var="que" varStatus="status">
				
					<div class="card mb-4 bg-white">
						<h5 class="card-header">${status.count }. ${que.examQueContent } (${que.examQueScore }점)</h5>
						<hr class="my-0">
						<div class="card-body queSelList">
							<c:forEach items="${que.examQueSelList }" var="sel" varStatus="status2">
								<input type="radio" data-que="${status.index }" name="answer${status.index }"
									value="${status2.count }" id="${status.count }.${status2.count }"
									<c:if test="${submitList ne null }">disabled="disabled"</c:if>
									<c:if test="${submitList[status.index].examSubAnswer eq status2.count }">checked="checked"</c:if>
								>
								<label for="${status.count }.${status2.count }"
									<c:if test="${submitList ne null and que.examQueAnswer eq status2.count }">style="color:red;"</c:if>
								> &nbsp;&nbsp; ${status2.count }. ${sel.examQueSelContent }</label><br>
							</c:forEach>
						</div>
					</div>
				
				</c:forEach>
			</form>
			
		</div>
		
		<div class="col-md-6 col-lg-4 mb-3">
		
			<div class="card mb-4 bg-white" style="position: fixed; width: 24%; height:73%;">
				<h4 class="card-header">응시정보</h4>
				<hr class="my-0">
				<div class="card-body">
					<c:if test="${submitList eq null }">
						<div>
							남은 시간 <span class="noCheck" id="timeLimit">${examVO.examLimit }</span>
						</div>
						<br>
						
						<c:forEach items="${examVO.examQueList }" var="que" varStatus="status">
							${status.count }. <span class="queAnswer noCheck">답변없음</span><br>
						</c:forEach>
					</c:if>
					<c:if test="${submitList ne null }">
						<c:forEach items="${submitList }" var="sub" varStatus="status">
							${status.count }. <span class="queAnswer">${sub.examSubAnswer }</span>
							<c:if test="${sub.examSubScore eq 0 }"><span>&nbsp;&nbsp;&nbsp;X(${sub.examSubScore }점)</span></c:if>
							<c:if test="${sub.examSubScore ne 0 }"><span>&nbsp;&nbsp;&nbsp;O(${sub.examSubScore }점)</span></c:if>
							<br>
						</c:forEach>
					</c:if>
				</div>
				<div class="card-footer">
					<c:if test="${submitList eq null }">
						<button type="button" class="btn btn-primary" id="submitBtn"
							style="float:right;">제출하기</button>
					</c:if>
					<c:if test="${submitList ne null }">
						<button type="button" class="btn btn-primary" style="float:right;"
							onclick="javaxcript:location.href='/exam/examDetail?examNo=${examVO.examNo}'">제출목록</button>
					</c:if>
				</div>
			</div>
		
		</div>
		
		
	</div>
</div>



<script>

$(function(){
	
	var submitFrm = $("#submitFrm");
	var submitBtn = $("#submitBtn");
	
	$("input[type=radio]").on('change', function(){
		console.log("radio change...!");
		
		var count = $(this).attr("data-que");
		var answer = $(this).val();
		$(".queAnswer").eq(count).text(answer);
		$(".queAnswer").eq(count).removeClass('noCheck');
		$(".queAnswer").eq(count).addClass('check');
	});
	
	submitBtn.on('click', function(){
		console.log("submitBtn click...!");
		
		if($(".queAnswer").hasClass('noCheck')){
			if(confirm("풀지않은 문제가 있습니다. 정말로 제출하시겠습니까?")){
				submitAnswer()
			} else{
				return false;
			}
		}
		
		if(confirm("제출하시겠습니까?")){
			submitAnswer()
		}
	});
	
	
// 	제한시간 만들기
	var time = $("#timeLimit").text() * 60;
	
	setInterval(() => {
		time -= 1;
		$("#timeLimit").text(flowTime(time));
		
		if(time == 0){
			alert("제한시간이 끝났습니다! 자동으로 제출됩니다.");
			submitAnswer()
		}
		
	}, 1000);
	
	
// 	submit function
	function submitAnswer(){
		var html = "";
		$(".queSelList").each(function(i,v){
			var name = $(v).find("input[type='radio']:checked").val();
			name = name == null ? 0 : name;
			html += "<input type='hidden' name='answerArr' value='"+name+"'>";
		});
		submitFrm.append(html);
		
		submitFrm.submit();
	}
	
	
});

function flowTime(time){
	var timeStr = "";
	h = Math.floor(time / 3600);
	var ts = time % 3600;
	m = Math.floor(ts / 60);
	s = Math.floor(ts % 60);
	timeStr = h + ":" + m + ":" + s;
	
	return timeStr;
}

</script>
























