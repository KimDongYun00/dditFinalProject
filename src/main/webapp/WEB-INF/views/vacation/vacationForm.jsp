<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 -->
	<sec:authentication property="principal.user" var="user" />
</sec:authorize>
 
<div class="container-xxl flex-grow-1 container-p-y">	
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">휴가 > 휴가신청폼</h5>
				<hr class="mb-0"/>
				<div class="card-body">
					<form action="/vacation/vacationInsert" method="post" id="insertForm">
					<sec:csrfInput/>
					<input type="hidden" name="vacNo" value="${vac.vacNo }" id="vacNo">
					<div class="row"> 
						<div class="col-sm-6">	
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-sm-2">아이디</label>
									<input type="text" name="userNo" id="userNo" class="form-control" value="${user.userNo }" readonly="readonly">
								</div>
							</div>
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-sm-2">이름</label>							
									<input type="text" name="proName" id="proName" class="form-control"  value="${user.profVO.proName }" readonly>							
								</div>
							</div>						
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-sm-2">시작일</label>							
									<input type="date" name="vacSdate" id="vacSdate" class="form-control" value="${vac.vacSdate }">							
								</div>
							</div>						
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-sm-2">종료일</label>							
									<input type="date" name="vacEdate" id="vacEdate" class="form-control" value="${vac.vacEdate }">							
								</div>
							</div>						
							<c:if test="${flag eq 'Y' }">
								<div class="row mb-3">
									<div class="input-group">
										<label class="input-group-text col-sm-2">상태</label> 
										<c:forEach items="${comC }" var="com">
										
										<c:if test="${com.comDetNo eq vac.comDetCNo }">			
											<input type="text" class="form-control" value="${com.comDetName }" readonly>
										</c:if>	
										</c:forEach>							
									</div>
								</div>						
							</c:if>
						</div>
						
						<div class="col-sm-6">						
							<div class="row mb-3">
								<label class="form-label col-sm-2">내용</label>
								<textarea rows="5" class="form-control" name="vacContent" id="vacContent" <c:if test="${vac.comDetCNo eq 'C0101' }">readonly</c:if>>${vac.vacContent }</textarea>
							</div>
							<c:if test="${vac.comDetCNo eq 'C0103' }">
							<div class="row mb-3">
								<label class="form-label col-sm-2">반려사유</label>
								<textarea rows="5" class="form-control" readonly name="rejContent" id="rejContent">${vac.rejContent }</textarea>
							</div>
							</c:if>
						</div>
						
					</div>
					</form>
				</div>
				<div class="card-footer" style="margin-left: auto;">
					<c:if test="${vac.comDetCNo eq 'C0102' }">
						<c:if test="${flag eq 'Y' }">
							<input type="button" value="수정" id="modifyBtn" class="btn btn-primary">
							<input type="button" value="삭제" id="deleteBtn" class="btn btn-danger">
							<input type="button" value="목록" id="listBtn" class="btn btn-primary">
						</c:if>						
					</c:if>									
					<c:if test="${vac.comDetCNo ne 'C0102' and not empty vac.comDetCNo}">
						<input type="button" value="목록" id="listBtn" class="btn btn-primary">
					</c:if>
					<c:if test="${empty vac.comDetCNo }">						
						<input type="button" value="등록" id="insertBtn" class="btn btn-primary">
						<input type="button" value="목록" id="listBtn" class="btn btn-primary">					
					</c:if>
				</div>
			</div>			
		</div>
	</div>
</div>

<form action="/professor/vacationDelete" method="post" id="deleteForm">
	<sec:csrfInput/>
	<input type="hidden" value="${vac.vacNo }" name="vacNo">
</form>
<script>
$(function(){
	var now_utc = Date.now() // 지금 날짜를 밀리초로
	// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
	var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
	// new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
	var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
	document.getElementById("vacSdate").setAttribute("min", today);
	document.getElementById("vacEdate").setAttribute("min", today);	
	
	$("#insertBtn").click(function(){
		
		$("#insertForm").submit();
	});
	$("#listBtn").click(function(){
		if("${user.comDetUNo}" == "U0102"){
			location.href="/vacation/vacationList";			
		}
		if("${user.comDetUNo}" == "U0103"){
			location.href="/vacation/empVacationList";
		}
		
	});
	$("#deleteBtn").click(function(){
		if(confirm('정말 휴가 신청 내역을 삭제 하시겠습니까?')){
			$("#deleteForm").submit();
		}
	});
	
	$("#modifyBtn").click(function(){
		$("#insertForm").attr("action", "/vacation/vacationModify");
		$("#insertForm").submit();
	});
	
	// 반려처리 버튼
	$("#rejectBtn").click(function(){		
		var rejContent = $("#rejContent").val();
		$.ajax({
			url : "/vacation/rejectBreak",
			type : "post",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		         xhr.setRequestHeader(header, token);
		    },
			data : {rejContent : rejContent, vacNo : $("#vacNo").val()},
			success : function(res){					
				alert("반려처리가 완료되었습니다.");
				location.reload(true);				
			},
			error : function(xhr){
				alert("문제...");					
			}
		});
		
		$('#smallModal').modal('hide');
	});
	
	// 승인처리버튼
	$("#aprroveBtn").click(function(){
		if(confirm('${vac.proName }님의 휴가 신청을 정말 승인 하시겠습니까?')){
			$.ajax({
				url : "/vacation/approveBreak",
				type : "post",
				beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
				data : {vacNo : vacNo
					  , stuNo : $("#stuNo").val()
					  , comDetMNo : $("#comDetMNo").val()					  
				},
				success : function(res){
					alert("승인처리가 완료되었습니다.");
					location.reload(true);
				}
			})
		}
	})
});
</script>					