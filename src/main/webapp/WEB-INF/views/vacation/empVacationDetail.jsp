<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">	
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">휴가 > 휴가신청</h5>
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
									<input type="text" name="userNo" id="userNo" class="form-control" value="${vac.userNo }" readonly="readonly">
								</div>
							</div>
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-sm-2">이름</label>							
									<input type="text" name="proName" id="proName" class="form-control"  value="${vac.proName }" readonly>							
								</div>
							</div>						
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-sm-2">시작일자</label>							
									<input type="date" name="vacSdate" id="vacSdate" class="form-control" value="${vac.vacSdate }">							
								</div>
							</div>						
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-sm-2">종료일자</label>							
									<input type="date" name="vacEdate" id="vacEdate" class="form-control" value="${vac.vacEdate }">							
								</div>
							</div>						
							
							<div class="row mb-3">
								<div class="input-group">
									<label class="input-group-text col-sm-2">상태</label> 
									<c:forEach items="${comC }" var="com">			
										<c:if test="${com.comDetNo eq vac.comDetCNo }"><label class="form-control">${com.comDetName }</label></c:if>
									</c:forEach>							
								</div>
							</div>						
							
						</div>
						<div class="col-sm-6">
							<div class="row mb-3">
								<label class="form-label col-sm-2">내용</label>
								<textarea rows="5" class="form-control" name="vacContent" id="vacContent">${vac.vacContent }</textarea>
							</div>
							<c:if test="${vac.comDetCNo eq 'C0103' }">
							<div class="row mb-3">
								<label class="form-label col-sm-2">반려사유</label>
								<textarea rows="5" class="form-control" readonly name="rejContent" id="rejContent1">${vac.rejContent }</textarea>
							</div>
							</c:if>
						</div>
						
					</div>
					</form>
				</div>
				<div class="card-footer" style="margin-left: auto;">
					<c:if test="${vac.comDetCNo eq 'C0102' }">
					<input type="button" value="승인" id="approveBtn" class="btn btn-danger">
						<button	
                          type="button"
                          class="btn btn-primary"
                          data-bs-toggle="modal"
                          data-bs-target="#smallModal"
                        >
                          	반려
                        </button>
                    </c:if>    
					<input type="button" value="목록" id="listBtn" class="btn btn-primary">									
				</div>
			</div>			
		</div>
	</div>
</div>


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
            <textarea rows="10" cols=""  name="rejContent" id="rejContent" class="form-control"></textarea>
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
		location.href="/vacation/empVacationList";
	})
	
	$("#rejectBtn").click(function(){
		var rejContent = $("#rejContent").val();
		var vacNo = $("#vacNo").val();
		$.ajax({
			url:"/vacation/rejectVacation",
			type : "post",
			data : {vacNo:vacNo, rejContent : rejContent},
			success : function(res){
				swal('반려 처리', '휴가 내역 반려처리가 완료 되었습니다.', "success")
				.then(function(){
					location.reload(true);                   
				})				
			},
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		         xhr.setRequestHeader(header, token);
		    },
			error : function(xhr){
				swal('서버 오류', '알 수 없는 이유로 실패', 'error');
			}
		})
	});
	
	$("#approveBtn").click(function(){
		var vacNo = $("#vacNo").val();
		swal({
			  
			}).then(function () {
			  swal(
			    'Deleted!',
			    'Your file has been deleted.',
			    'success'
			  )
			})

		swal({
			  title: "정말 승인처리 하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
				  $.ajax({
						url:"/vacation/approveVacation",
						type : "post",
						data : {vacNo : vacNo},
						success : function(res){
							swal("승인 처리", "휴가 내역 승인처리가 완료되었습니다.", "success")
							.then(function(){
								location.reload(true);
							})
						},
						beforeSend : function(xhr){
							xhr.setRequestHeader(header, token);
						}
					})
			  }
			});
	})
})
</script>