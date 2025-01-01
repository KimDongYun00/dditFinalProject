<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<h4 class="card-header">시설 > 예약상세정보</h4>
		<hr class="my-0"/>
		<div class="card-body">			
			<div class="row mb-3">
				<div class="col-sm-6">
			
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="stuNo"><font size="4">아이디</font></label>					
						<label class="col-sm-8 col-form-label" for="stuNo"><font size="4">${facResVO.userNo }</font></label>
					</div>
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="stuName"><font size="4">건물명</font></label>						
						<label class="col-sm-8 col-form-label" for="stuNo"><font size="4">${facResVO.buiName }</font></label>						
					</div>
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="stuName"><font size="4">시설명</font></label>						
						<label class="col-sm-8 col-form-label" for="stuNo"><font size="4">${facResVO.facName }</font></label>						
					</div>
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="volName"><font size="4">사용목적</font></label>						
						<label class="col-sm-8 col-form-label" for="stuNo"><font size="4">${facResVO.facResPurpose}</font></label>
					</div>
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="volName"><font size="4">사용인원수</font></label>						
						<label class="col-sm-8 col-form-label" for="stuNo"><font size="4">${facResVO.facResNum}명</font></label>
					</div>					
					
				</div>
				
				<div class="col-sm-6">
					<div class="row mb-3">	
						<label class="col-sm-3 col-form-label" for="lecMax"><font size="4">승인상태</font></label>						
						<label class="col-sm-8 col-form-label" for="stuNo" id="ajaxStatus">
							<c:if test="${facResVO.comDetCNo eq 'C0101' }"><font size="4" color="green">승인</font></c:if>
							<c:if test="${facResVO.comDetCNo eq 'C0102' }"><font size="4" color="red">미승인</font></c:if>
							<c:if test="${facResVO.comDetCNo eq 'C0103' }"><font size="4" color="blue">반려</font></c:if>
						</label>
					</div>	
					
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="volEdate"><font size="4">신청일자</font></label>						
						<label class="col-sm-8 col-form-label" for="stuNo">
							<font size="4">
								${facResVO.facResRegdate }
							</font>
						</label>
					</div>	
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="volTime"><font size="4">시작시간</font></label>
					
						<label class="col-sm-8 col-form-label" for="stuNo">
							<font size="4">
								${facResVO.facResSdate }
							</font>
						</label>						
					</div>
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="volSdate"><font size="4">종료시간</font></label>						
						<label class="col-sm-8 col-form-label" for="stuNo">
							<font size="4">
								${facResVO.facResEdate }
							</font>
						</label>						
					</div>
				
							
				</div>
			</div>
				
			<c:if test="${facResVO.comDetCNo eq 'C0103' }">										
				<label class="col-sm-2 col-form-label" for="lecMax"><font size="4">반려사유</font></label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="rejContent" id="rejContent" readonly="readonly">${facResVO.rejContent }</textarea>
				</div>
			</c:if>					
														
		</div>
			
		<div class="card-footer" align="right">
			<!-- 등록 버튼 -->
			<input type="button" class="btn btn-primary" value="목록" id="listBtn">
			
			<input type="button" class="btn btn-success" value="승인" id="approveBtn">
			<input type="button" class="btn btn-info" value="반려" data-bs-target="#smallModal" data-bs-toggle="modal">			
		</div> 
		
	</div>
</div>



<!-- 반려적는모달 -->
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
		location.href= "/admin/facResList";
	});
	
	var facResNo = '${facResVO.facResNo}';
	
	// 승인처리 버튼
	$("#approveBtn").click(function(){
		if(confirm("${facResVO.userNo}님의 시설예약을 정말 승인 하시겠습니까?")){
			//성공하면 아작스로 승인처리
			$.ajax({
				url : "/admin/facResApprove",
				type : "post",
				beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
			         xhr.setRequestHeader(header, token);
			    },
				data : {facResNo : facResNo},
				success : function(res){					
					alert("승인처리가 완료되었습니다.");
					location.reload(true);
				}
			});
		}
	});
	
	// 반려처리 버튼
	$("#rejectBtn").click(function(){		
		var rejContent = $("#rejContent").val();
		if(confirm('정말 반려 처리 하시겠습니까?')){
			$.ajax({
				url : "/admin/facResReject",
				type : "post",
				beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
			         xhr.setRequestHeader(header, token);
			    },
				data : {rejContent : rejContent, facResNo : facResNo},
				success : function(res){					
					alert("반려처리가 완료되었습니다.");
					location.reload(true);				
				}
			});
			
			$('#smallModal').modal('hide');			
		}
	});
	
	
})
</script>