<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학사관리 > 학사일정</h5>
				<hr class="mb-0"/>
				<div class="card-body">
					<div id='calendar'></div>
				</div>
			</div>
		</div>
	</div>
</div>		

<!-- 달력 모달창 -->
<div class="modal fade" id="modalCenter" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalCenterTitle">학사일정등록</h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
          id="xButton"         
        ></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col mb-3">
            <label for="title" class="form-label">학사일정</label>
            <input
              type="text"
              id="acaTitle"
              class="form-control"
              placeholder="캘린더에 표시될 내용을 입력해주세요."
            />
          </div>
        </div>
        <div class="row g-2">
          <div class="col mb-0">
            <label for="sdate" class="form-label">시작일자</label>
            <input
              type="datetime-local"
              id="acaSdate"
              class="form-control"
              placeholder="xxxx@xxx.xx"
            />
          </div>
          <div class="col mb-0">
            <label for="edate" class="form-label">끝난일자</label>
            <input
              type="datetime-local"
              id="acaEdate"              
              class="form-control"
              placeholder="DD / MM / YY"
            />
          </div>
        </div>
        <div class="row mt-3">
          <div class="col mb-0">
          	<label for="acaContent" class="form-label">내용</label>
          	<textarea rows="6" class="form-control" name="acaContent" id="acaContent"></textarea>
          </div>
        </div>
<!--         <div class="row mt-3"> -->
<!--         	<div class="col mb-0"> -->
<!-- 	        	<label for="acaColor" class="form-label">일정 배경색을 골라주세요 </label> -->
<!-- 	        	<input type="color" class="" id="acaColor" name="acaColor" value="#C2B4D6"> -->
<!--         	</div> -->
<!--         </div> -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal"  id="closeBtn">
          Close
        </button>
      </div>
    </div>
  </div>
</div>
<script>
$(function(){
	var calendarEl = $('#calendar')[0];
	var calendar = new FullCalendar.Calendar(calendarEl,{
		initialView : 'dayGridMonth',
		// 이미 있는 이벤트 클릭했을때는 수정
        eventClick :function(info){ 
        	
        	$("#modalCenter").modal("show");
        	$("#acaNo").val(info.event.id);
        	$.ajax({
           		url : "/academic/acaRead",
           		type : "get",
           		dataType : "json",
           		data : {acaNo : info.event.id},
           		success : function(res){
	           		$("#acaTitle").val(res.acaTitle);
	    			$("#acaSdate").val(res.acaSdate);
	    			$("#acaEdate").val(res.acaEdate);
	    			$("#acaColor").val(res.acaColor);
	    			$("#acaContent").val(res.acaContent);
           		}
           	})
        	$("#insertBtn").css("display", "none");
        	$("#modifyBtn").css("display", "block");
        	$("#deleteBtn").css("display", "block");        	
        },
		events : []
	});
	
	calendar.render();
	

	
	// 달력 출력
	$.ajax({
   		url : "/academic/acaList",
   		type : "get",
   		dataType : "json",
   		success : function(res){
   			$.each(res, function(i, v){
   				calendar.addEvent({
   						title : v.acaTitle,
   						start : v.acaSdate,
   						end : v.acaEdate,
   						color : v.acaColor,
   						startStr : v.acaContent,
   						id : v.acaNo
   				})
   				
   				
   			})        			
   		}
   	})
   	
})

</script>