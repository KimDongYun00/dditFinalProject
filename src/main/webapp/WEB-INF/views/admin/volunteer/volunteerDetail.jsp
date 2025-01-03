<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<h4 class="card-header">봉사 > 봉사상세정보</h4>
		<hr class="my-0"/>
		<div class="card-body">			
			<div class="row mb-3">
				<div class="col-6">
			
					<div class="row mb-3">
						<label class="col-3 col-form-label" for="stuNo"><font size="4">아이디</font></label>					
						<label class="col-9 col-form-label" for="stuNo"><font size="4">${volunteerVO.stuNo }</font></label>
					</div>
					<div class="row mb-3">
						<label class="col-3 col-form-label" for="stuName"><font size="4">이름</font></label>						
						<label class="col-9 col-form-label" for="stuNo"><font size="4">${volunteerVO.stuName }</font></label>						
					</div>
					<div class="row mb-3">
						<label class="col-3 col-form-label" for="volName"><font size="4">봉사명</font></label>						
						<label class="col-9 col-form-label" for="stuNo"><font size="4">${volunteerVO.volName}</font></label>
					</div>
					<div class="row mb-3">	
						<label class="col-3 col-form-label" for="lecMax"><font size="4">승인상태</font></label>						
						<label class="col-9 col-form-label" for="stuNo" id="ajaxStatus">
							<c:if test="${volunteerVO.comDetCNo eq 'C0101' }"><font size="4" color="green">승인</font></c:if>
							<c:if test="${volunteerVO.comDetCNo eq 'C0102' }"><font size="4" color="red">미승인</font></c:if>
							<c:if test="${volunteerVO.comDetCNo eq 'C0103' }"><font size="4" color="blue">반려</font></c:if>
						</label>
					</div>	
					
				</div>
				
				<div class="col-sm-6">
					
					<div class="row mb-3">
						<label class="col-3 col-form-label" for="volTime"><font size="4">봉사인정시간</font></label>
					
						<label class="col-9 col-form-label" for="stuNo"><font size="4">${volunteerVO.volTime }</font></label>						
					</div>
					<div class="row mb-3">
						<label class="col-3 col-form-label" for="volSdate"><font size="4">봉사시작날짜</font></label>						
						<label class="col-9 col-form-label" for="stuNo"><font size="4">${volunteerVO.volSdate }</font></label>						
					</div>
				
					<div class="row mb-3">
						<label class="col-3 col-form-label" for="volEdate"><font size="4">봉사끝난날짜</font></label>						
						<label class="col-9 col-form-label" for="stuNo"><font size="4">${volunteerVO.volEdate }</font></label>
					</div>	
					<div class="row mb-3">				
						<label class="col-3 col-form-label" for="lecMax"><font size="4">파일첨부</font></label>						
						<label class="col-9 col-form-label" for="stuNo">
							<font size="4">
								<c:if test="${empty fileList }">
									첨부된 파일이 없습니다.
								</c:if>
								<c:if test="${not empty fileList }">
									<c:forEach items="${fileList }" var="file">
			 							<a class="link-primary" href="/common/fileDownload.do?fileGroupNo=${file.fileGroupNo }&fileNo=${file.fileNo}&${_csrf.parameterName}=${_csrf.token}">
											${file.fileName} 
										</a>
									</c:forEach>
								</c:if>
							</font>
						</label>						
					</div>
							
				</div>
			</div>								
						
			<div class="row mb-3">									
				<label class="col-1 col-form-label" for="volContent"><font size="4">봉사내용</font></label>
				<div class="col-11">
					<textarea rows="5" class="form-control" name="volContent" id="volContent" readonly="readonly">${volunteerVO.volContent }</textarea>
				</div>				
			</div>
			<div class="row mb-3">
					
				<c:if test="${volunteerVO.comDetCNo eq 'C0103' }">										
					<label class="col-1 col-form-label" for="lecMax"><font size="4">반려사유</font></label>
					<div class="col-11">
						<textarea rows="5" class="form-control" name="rejContent" id="rejContent" readonly="readonly">${volunteerVO.rejContent }</textarea>
					</div>
				</c:if>					
			</div>
														
		</div>
			
		<div class="card-footer" align="right">
			<!-- 등록 버튼 -->
			<input type="button" class="btn btn-primary" value="목록" id="listBtn">
			
			<input type="button" class="btn btn-success" value="승인" id="approveBtn">
			<input type="button" class="btn btn-info" value="반려" data-bs-target="#smallModal" data-bs-toggle="modal">			
		</div> 
		
	</div>
</div>

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
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	
	$("#listBtn").click(function(){
		location.href= "/admin/volunteerList";
	});
	
	var volNo = '${volunteerVO.volNo}';
	
	// 승인처리 버튼
	$("#approveBtn").click(function(){
		if(confirm("${volunteerVO.stuName}님의 봉사활동을 정말 승인 하시겠습니까?")){
			//성공하면 아작스로 승인처리
			$.ajax({
				url : "/admin/volunteerApprove",
				type : "post",
				beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
			         xhr.setRequestHeader(header, token);
			    },
				data : {volNo : volNo},
				success : function(res){					
					alert("승인처리가 완료되었습니다.");
					location.reload(true);
				},
				error : function(xhr){
					alert("문제...");					
				}
			});
		}
	});
	
	// 반려처리 버튼
	$("#rejectBtn").click(function(){		
		var rejContent = $("#rejContent").val();
		$.ajax({
			url : "/admin/volunteerReject",
			type : "post",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		         xhr.setRequestHeader(header, token);
		    },
			data : {rejContent : rejContent, volNo : volNo},
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
})
</script>	