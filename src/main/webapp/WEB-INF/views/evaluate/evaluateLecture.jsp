<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<sec:authentication property="principal" var="prc" />
<c:set value="${prc.user.comDetUNo }" var="auth" />
<c:set value="${prc.user.stuVO }" var="stuVO" />



<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">강의평가</h4>
	<div class="row mb-5">
		<div class="col-md-6 col-lg-12 mb-3">
		
			<div class="card mb-4 bg-white">
				<h4 class="card-header">${lectureVO.lecName }</h4>
				<hr class="my-0">
				<div class="card-body">
					<form action="/evaluate/submitEvaluate" method="post" id="evaFrm">
						<sec:csrfInput/>
						<input type="hidden" name="lecNo" value="${lectureVO.lecNo }">
						<input type="hidden" name="stuNo" value="${stuVO.stuNo }">
						<table class="table">
							<thead>
								<tr>
									<th width="5%">번호</th>
									<th width="55%">평가내용</th>
									<th width="8%">매우그렇다</th>
									<th width="8%">그렇다</th>
									<th width="8%">보통이다</th>
									<th width="8%">그저그렇다</th>
									<th width="8%">그렇지않다</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${queList }" var="que" varStatus="status">
									<c:if test="${que.lecEvaQueNo ne 'LEC_EVA_QUE_0' }">
										<tr>
											<td>${status.count }</td>
											<td>${que.lecEvaQueContent }</td>
											<td><input type="radio" name="${que.lecEvaQueNo }_name" value="${que.lecEvaQueNo }_5"></td>
											<td><input type="radio" name="${que.lecEvaQueNo }_name" value="${que.lecEvaQueNo }_4"></td>
											<td><input type="radio" name="${que.lecEvaQueNo }_name" value="${que.lecEvaQueNo }_3"></td>
											<td><input type="radio" name="${que.lecEvaQueNo }_name" value="${que.lecEvaQueNo }_2"></td>
											<td><input type="radio" name="${que.lecEvaQueNo }_name" value="${que.lecEvaQueNo }_1"></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
						<label for="lecEvaContent" style="margin-top: 30px;">기타의견</label>
						<textarea class="form-control" rows="7" name="lecEvaContent" id="lecEvaContent"></textarea>
					</form>
				</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="button" id="submitBtn" style="float:right; margin-left: 7px;">제출</button>
					<button class="btn btn-primary" type="button" id="fastBtn" style="float: right;">시연용</button>
				</div>
			</div>
		</div>
	</div>
</div>



<script>

$(function(){
	
	var evaFrm = $("#evaFrm");
	var submitBtn = $("#submitBtn");
	
	$("#fastBtn").click(function(){
		for(var i=1; i<6; i++){
			$("input:radio[name='LEC_EVA_QUE_"+i+"_name']:radio[value='LEC_EVA_QUE_"+i+"_5']").prop("checked", true);
		}	
		$("#lecEvaContent").html("저에게 광고학이 무엇인지 각인시켜준 과목이였습니다. 감사합니다.");
	})
	
	submitBtn.on('click', function(){
		var html = "";
		$('input[type=radio]:checked').each(function(i,v){
			html += "<input type='text' name='lecEvaContentArr' value='"+$(v).val()+"'>";
		});
		evaFrm.append(html);
		evaFrm.submit();
	});
	
});

</script>


























