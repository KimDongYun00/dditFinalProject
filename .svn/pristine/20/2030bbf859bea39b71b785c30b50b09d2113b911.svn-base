<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<style>
/*이요일 날짜 빨간색*/
.fc-day-sun a {
  color: red;
  text-decoration: none;
  
}
/* 토요일 날짜 파란색 */
.fc-day-sat a {
  color: blue;
  text-decoration: none;
}
</style>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-7">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학사관리 > 학사일정</h5>
				<hr class="mb-0"/>
				<div class="card-body">
					<div id='calendar'></div>
				</div>
			</div>
		</div>
		<div class="col-5">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학년 학기 관리</h5>
				<hr class="mb-0">
				<div class="card-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>연도</th>	
								<th>학기</th>	
								<th>시작일자</th>	
								<th>끝난일자</th>	
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty dataList }">
								<tr>
									<td colspan="4">데이터가 하나도 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${dataList }" var="ys">
								<c:if test="${not empty ys }">
									<tr>
										<td>${ys.ysYear }</td>
										<td>${ys.ysSemester }</td>
										<td>${ys.ysSdate}</td>
										<td>${ys.ysEdate }</td>								
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>					
					<div class="my-4" id="pagingArea">
	                	${pagingVO.pagingHTML }
	                </div>					
				</div>
			</div>
			<form action="/academic/yearSemesterInsert" method="post" id="yInsertForm">
			<sec:csrfInput/>
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학년학기 폼</h5>
				<hr class="mb-0">
				<div class="card-body">
					<div class="row mb-3">
						<div class="input-group">
							<label class="input-group-text col-3">연도</label>
							<input type="number" placeholder="YYYY를 입력해 주세요" class="form-control" name="ysYear" id="ysYear">
						</div>
					</div>
					<div class="row mb-3">
						<div class="input-group">
							<label class="input-group-text col-3">학기</label>
							<select class="form-select" name="ysSemester" is="ysSemester">
								<option value="1">1학기</option>
								<option value="2">2학기</option>								
							</select>
						</div> 
					</div>
					<div class="row mb-3">
						<div class="input-group">
							<label class="input-group-text col-3">시작일자</label>
							<input type="date" name="ysSdate" id="ysSdate" class="form-control">
						</div>
					</div>
					<div class="row mb-3">
						<div class="input-group">
							<label class="input-group-text col-3">끝난일자</label>
							<input type="date" name="ysEdate" id="ysEdate" class="form-control">
						</div>
					</div>
					<div class="" align="right">	
						<input type="button" value="저장" id="yInsertBtn" class="btn btn-primary">
						<input type="reset" value="취소" id="resetBtn" class="btn btn-primary">
					</div>	
				</div>
			</div>
			</form>
		</div>
	</div>
</div>	
<form id="searchForm">
	<input type="hidden" name="page" id="page">
</form>



<!-- 달력 모달창 -->
<form action="/acdemic/insert" method="post" id="modalForm">
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
        <div class="row mt-3">
        	<div class="col mb-0">
	        	<label for="acaColor" class="form-label">일정 배경색을 골라주세요 </label>
	        	<input type="color" class="" id="acaColor" name="acaColor" value="#C2B4D6">
        	</div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal"  id="closeBtn">
          Close
        </button>
        <button type="button" class="btn btn-outline-primary" id="insertBtn">등록</button>
        <button type="button" class="btn btn-info" id="modifyBtn" style="display:none;">수정</button>
        <button type="button" class="btn btn-danger" id="deleteBtn" style="display:none;">삭제</button>        
      </div>
    </div>
  </div>
</div>
<input type="hidden" id="acaNo" name="acaNo">
</form>              
	
<script>
$(function(){

	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	$("#yInsertBtn").click(function(){
		if($("#ysYear").val() == "" || $("#ysYear").val() == null){
			swal("내용입력", "년도를 입력해 주세요", "error");			
			return false;		
		}
		$("#yInsertForm").submit();
		// 다시 모달 원래대로 돌리기
		$("#ysYear").val("");
		$("#select[name='ysSemsester']").val('1').prop("selected", true);
		$("#ysSdate").val("");
		$("#ysEdate").val("");
		$("#yInsertForm").attr("action", "/academic/yearSemesterInsert");
	});
	
	// 삭제버튼
	$("#deleteBtn").click(function(){
		$.ajax({
			url : "/academic/delete", 
			data : {acaNo : $("#acaNo").val()},
			type : "post",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			success : function(res){
				swal("일정삭제", "학사일정 삭제 완료", "success")
				.then(function(){
					location.reload(true);
				});
			}
		})
		
	});
	// 수정버튼
	$("#modifyBtn").click(function(){
		var data = {
				 acaNo : $("#acaNo").val(),
				 acaTitle : $("#acaTitle").val(),
				 acaSdate : $("#acaSdate").val(),
				 acaEdate : $("#acaEdate").val(),
				 acaColor : $("#acaColor").val(),
				 acaContent : $("#acaContent").val()			 
		}
		$.ajax({
			url : "/academic/modify",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			type : "post",
			success : function(res){
				swal("일정수정", "학사일정 수정 완료했습니다.", "success")
				.then(function(){
					 $("#acaTitle").val("");
					 $("#acaSdate").val("");
					 $("#acaEdate").val("");
					 $("#acaColor").val("#c2b4d6");
					 $("#acaContent").val("");					 
					 $("#modalCenter").modal("hide");
					 location.reload(true);
				});
			}
		});
	});
	
	var calendarEl = $('#calendar')[0];
	var calendar = new FullCalendar.Calendar(calendarEl,{
		initialView : 'dayGridMonth',	
		themeSystem : 'bootstrap5',
		height : 750,
		expandRows: true, // 화면에 맞게 높이 재설정
		dayMaxEvents: true,
        selectable: true,
        droppable : true,
        editable : true,
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
	       
        // 일정등록 버튼 
		customButtons: {
			myCustomBytton:{				
        		text:"일정등록",
        		click:function(){
        			$("#modalCenter").modal("show");
        			$("#acaSdate").val("");
        			$("#acaEdate").val("");
        			$("#acaColor").val("#C2B4D6");
        			$("#insertBtn").css("display", "block");
                	$("#modifyBtn").css("display", "none");
                	$("#deleteBtn").css("display", "none");   
        		}
        	}     	
        },
        
        headerToolbar: {
            left: 'prev, myCustomBytton',
            center: 'title',
            right: 'next'
        },        
        // 드래그 또는 달력 클릭했을때
        select : function(info){
        	$("#acaSdate").val(new Date(info.start.getTime() + (info.start.getTimezoneOffset() * 60 * 1000) +  18 * 60 * 60 * 1000).toISOString().substring(0, 16));
        	$("#acaEdate").val(new Date(info.end.getTime() + (info.end.getTimezoneOffset() * 60 * 1000) +  18 * 60 * 60 * 1000).toISOString().substring(0, 16));
        	$("#modalCenter").modal("show");
        	$("#acaColor").val("#C2B4D6");
        	$("#insertBtn").css("display", "block");
        	$("#modifyBtn").css("display", "none");
        	$("#deleteBtn").css("display", "none");  
        },
        events : [   	        	
        		
        ]
	});
	calendar.render();	
	// 모달창 닫기 버튼
	$("#closeBtn").click(function(){
		$("#acaTitle").val("");
		$("#acaSdate").val("");
		$("#acaEdate").val("");
		$("#acaContent").val("");
		$("#acaColor").val("#C2B4D6");
	})
	// 모달창 닫기 버튼
   	$("#xButton").click(function(){
	   	 $("#acaTitle").val("");
		 $("#acaSdate").val("");
		 $("#acaEdate").val("");
		 $("#acaColor").val("#C2B4D6");
		 $("#acaContent").val("");		 
   	})
// 	calendar.refetchEvents(); 리패치라는데 이건 javascript에서 쓰이는 메서드인가?
	 
	$("#insertBtn").click(function(){		 
		var data = {
				 acaTitle : $("#acaTitle").val(),
				 acaSdate : $("#acaSdate").val(),
				 acaEdate : $("#acaEdate").val(),
				 acaColor : $("#acaColor").val(),
				 acaContent : $("#acaContent").val()			 
		}
		
		$.ajax({
			url : "/academic/insert",
			data : JSON.stringify(data),
			type : "post",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			contentType : "application/json; charset=utf-8",
			success : function(res){
				swal("성공", "학사일정등록 성공", "success")
				.then(function(){
					 $("#acaTitle").val("");
					 $("#acaSdate").val("");
					 $("#acaEdate").val("");
					 $("#acaColor").val("#C2B4D6");
					 $("#acaContent").val("");					 
					 $("#modalCenter").modal("hide");
					 location.reload(true);
				});
			},
			error : function(xhr){
				swal("실패", "학사일정등록 실패", "error");
			}
				
		});
	});
	
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
   	});
	$("tbody").find("tr").click(function(){
		console.log("첫번재 텍스트 :" + $(this).find("td").eq(0).text());
		console.log("두번재 텍스트 :" + $(this).find("td").eq(1).text());
		console.log("세번재 텍스트 :" + $(this).find("td").eq(2).text());
		console.log("네번재 텍스트 :" + $(this).find("td").eq(3).text());
		$("#ysYear").val($(this).find("td").eq(0).text()); 
		$("select[name='ysSemester']").val($(this).find("td").eq(1).text()).prop("selected", true); 
		$("#ysSdate").val($(this).find("td").eq(2).text());
		$("#ysEdate").val($(this).find("td").eq(3).text());
		$("#yInsertForm").attr("action", "/academic/yearSemesterUpdate");
		// 서브밋 하고난후
// 		$("#yInsertForm").submit();		
	})
	
	$("#resetBtn").click(function(){
		$("#yInsertForm").attr("action", "/academic/yearSemesterInsert");
	})
})
</script>			