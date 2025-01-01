<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 -->
	<sec:authentication property="principal.user" var="user" />
</sec:authorize>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학적 > 상세보기</h5>
				<hr class="mb-0"/>
				<form action="/student/updateBreak" method="post" id="updateForm">
				<sec:csrfInput/>
				<input type="hidden" value="${breakVO.breNo }" name="breNo" id="breNo">
				<div class="card-body">
					<div class="row mb-3">
<!-- 						<div class="col-sm-1"></div>		 -->
						
						<div class="col-6 p-5">
							<div class="row mb-4">
								<div class="input-group">
									<label class="input-group-text col-2">아이디</label>
									<input type="text" class="form-control" name="stuNo" id="stuNo" readonly="readonly" value="${breakVO.stuNo}">
								</div>
							</div>
							<div class="row mb-4">
								<div class="input-group">
									<label class="input-group-text col-2">이름</label>
									<input type="text" class="form-control" name="stuName" readonly="readonly" value="${breakVO.stuName}">
								</div>
							</div>
							<div class="row mb-4">
								<div class="input-group">
									<label class="input-group-text col-2">신청일</label>
									<input type="text" class="form-control" readonly value="${breakVO.breRegdate}">
								</div>
							</div>
							<div class="row mb-4">
								<div class="input-group">
									<label class="input-group-text col-2">년도</label>
									<select class="form-select" name="year">
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyy" var="startYear"/>
										<c:forEach begin="${startYear }" end="${startYear + 5}" var="year" step="1">
											<option value="${year}" <c:if test="${breakVO.year eq year}">selected</c:if>>${year}년</option>
										</c:forEach>										
									</select>
									<label class="input-group-text col-2">학기</label>
									<select name="semester" class="form-select">
										<option value="1" <c:if test="${breakVO.semester eq '1' }">selected</c:if>>1학기</option>
										<option value="2" <c:if test="${breakVO.semester eq '2' }">selected</c:if>>2학기</option>
									</select>
								</div>
							</div>
							
							
							<div class="row mb-4">
								<div class="input-group">
									<label class="input-group-text col-2">구분</label>
									<select class="form-select" name="comDetMNo" id="comDetMNo">
										<c:forEach items="${comM }" var="comMList">
											<option value="${comMList.comDetNo }" <c:if test="${comMList.comDetNo eq breakVO.comDetMNo }">selected</c:if>>${comMList.comDetName }</option>
										</c:forEach>
										
									</select>
								</div>
							</div>
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-2">상태</label>
									<select class="form-select" disabled="disabled"> 
										<c:forEach items="${comC }" var="com">
											<c:if test="${breakVO.comDetCNo eq com.comDetNo}"><option>${com.comDetName }</option></c:if>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>				
						<div class="col-6 p-5">
							<div class="row mb-3">
								<div class="col-2">
									<label for="breContent">사유</label>
								</div>
								<div class="col-sm-10">	
									<textarea id="breContent" name="breContent" class="form-control" rows="5" cols="">${breakVO.breContent }</textarea>
								</div>	
							</div>
						<c:if test="${breakVO.comDetCNo eq 'C0103' }">
							<div class="row mb-3">
								<div class="col-2">
									<label for="breContent">반려</label>
								</div>
								<div class="col-10">	
									<textarea id="rejContent" class="form-control" readonly rows="5" cols="">${breakVO.rejContent }</textarea>
								</div>	
							</div>
						</c:if>
						</div>
					</div>
					<div class="row mb-3"></div>
				</div>
				</form>
				<div class="card-footer">
					<div class="row">
						<div class="col-lg-6 col-sm-12 text-lg-start text-center">
							<input type="button" value="목록" class="btn btn-primary" id="listBtn">
							<c:if test="${user.comDetUNo eq 'U0101' }">
								<input type="button" value="수정" class="btn btn-info" id="updateBtn">
								<input type="button" value="삭제" class="btn btn-danger" id="deleteBtn">
							</c:if>
							<c:if test="${user.comDetUNo eq 'U0103' }">					
								<input type="button" value="수정" class="btn btn-info" id="updateBtn"> 
								<input type="button" value="삭제" class="btn btn-danger" id="deleteBtn">
							</c:if>
						</div>
						<div class="col-lg-6 col-sm-12 text-lg-end text-center">
							<c:if test="${user.comDetUNo eq 'U0103' }">										
								<input type="button" value="승인" class="btn btn-info" id="aprroveBtn">
								<input type="button" value="반려" class="btn btn-danger" id="reject">
							</c:if>						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>		
</div>
<form id="deleteForm" action="/student/deleteBreak" method="post">
	<sec:csrfInput/>
	<input type="hidden" value="${breakVO.breNo }" name="breNo">
</form>


<!-- 반려 모달창 -->
<div class="modal fade" id="smallModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel2">반려창</h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col mb-3">
            <label for="rejContent" class="form-label"><font size="3">반려사유</font></label>           
            <textarea rows="10" cols="" name="rejContent" id="rejContent" class="form-control"></textarea>
          </div>
        </div>        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          	닫기
        </button>
        <button type="button" class="btn btn-primary" id="rejectBtn">반려</button>
      </div>
    </div>
  </div>
</div>
<script>
$(function(){
	$("#listBtn").click(function(){
		if("${user.comDetUNo}" == "U0101"){
			location.href="/student/breakList";			
		}
		if("${user.comDetUNo}" == "U0103"){
			location.href="/admin/breakList";
		}
	})
	
	$("#updateBtn").click(function(){
		if(confirm('학적 변경 신청을 수정하시겠습니까?')){
			$("#updateForm").submit();
		}
	})
	
	$("#deleteBtn").click(function(){
		if(confirm('정말 학적 변경 신청 내역을 삭제하시겠습니까?')){
			$("#deleteForm").submit();
		}
	})
	
	$("#reject").click(function(){
		$("#rejContent").html("");
		$("#smallModal").modal("show");
	})
	
	breNo = $("#breNo").val();
	// 반려처리 버튼
	$("#rejectBtn").click(function(){		
		var rejContent = $("#rejContent").val();
		$.ajax({
			url : "/admin/rejectBreak",
			type : "post",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		         xhr.setRequestHeader(header, token);
		    },
			data : {rejContent : rejContent, breNo : breNo},
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
		if(confirm('${breakVO.stuName}님의 학적변경 신청을 정말 승인 하시겠습니까?')){
			$.ajax({
				url : "/admin/approveBreak",
				type : "post",
				beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
				data : {breNo : breNo
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
})
</script>