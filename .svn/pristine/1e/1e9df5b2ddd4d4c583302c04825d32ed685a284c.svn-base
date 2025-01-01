<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<sec:authentication var="user" property="principal"/>
<!-- fullcalendar CDN -->

  
  <!-- fullcalendar 언어 CDN -->

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h2 class="card-header"> 
					${facVO.buiName } ${facVO.facName } ${facVO.facTypeName }
				</h2>
					
				<hr class="mb-0">
				<div class="card-body">
					<div class="mb-3">
						수용 최대 인원 : ${facVO.facMax }명<br>
						<font color="red">주의 : 한번에 3시간까지만 예약이 가능합니다.</font>
					</div>
					<div class="mb-3">
						<input type="button" class="btn btn-primary" value="목록" id="listBtn">					
					
					</div>	
				</div>
				
			</div>	
			<div class="card mb-4 bg-white">
				<div id='calendar-container'>
				    <div id='calendar'></div>
				</div>				
			</div>		
		</div>
	</div>
</div>


					<div class="modal fade" id="smallModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-sm" role="document">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title" id="exampleModalLabel2">예약하기</h5>
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
                                  <label for="nameSmall" class="form-label">이용목적</label>
                                  <input type="text" id="title" class="form-control" placeholder="이용목적" />
                                </div>
                              </div>
                              <div class="row">
                                <div class="col mb-3">
                                  <label for="nameSmall" class="form-label">사용인원수</label>
                                  <input type="number" id="number" class="form-control" placeholder="사용인원수"/>
                                </div>
                              </div>
                             
                              <div class="row g-2">
                                <div class="col mb-0">
                                  <label class="form-label" for="emailSmall">시작시간</label>
                                  <input type="datetime-local" class="form-control" id="start" placeholder="DD / MM / YY" />
                                </div>
                                <div class="col mb-0">
                                  <label for="dobSmall" class="form-label">끝나는시간</label>
                                  <input id="end" type="datetime-local" class="form-control" placeholder="DD / MM / YY" />
                                </div>
                              </div>
                               <div class="row g-2">
                              	<div class="col mt-3">
                              		<label class="form-label"><font color="red">대여 시간은 2시간을 초과할 수 없습니다.</font></label>
                              	</div>
                              </div>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" id="closeModal">
                                	닫기
                              </button>
                              <button type="button" class="btn btn-primary" id="saveChanges">예약하기</button>
                              <input type="hidden" id="userNo" value="${user.username}">
                              <input type="hidden" id="facNo" value="${facVO.facNo }">
                            </div>
                          </div>
                        </div>
                      </div>


<!-- 여기는 스크립트 -->
<script> 
$(function(){
	// 모달창 닫기 버튼...
	var closeModal = $("#closeModal");
	// 모달 닫을때 input태그에 데이터가 남아있더라.
	closeModal.click(function(){
		$("#start").val("");
		$("#end").val("");
		$("#title").val("");
		$("#number").val("");
	});
	// date 타입 오늘 날짜 이전으로 못고르게 하기
	var now_utc = Date.now() // 지금 날짜를 밀리초로
	// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
	var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
	// new Date(today-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
	var today = new Date(now_utc-timeOff).toISOString().substring(0, 16);	 
	document.getElementById("start").setAttribute("min", today);
	document.getElementById("end").setAttribute("min", today);
	
	// 달력에 데이터 조회하기
	$.ajax({
		url: '/student/facreserveList',
		type: 'POST',
		beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
			xhr.setRequestHeader(header, token);
		},
		data: {
    		facNo : $("#facNo").val()
   		},       
       success: function (response) {
    	   var events = [];
           // 서버에서 받은 데이터(response)를 이벤트 객체로 변환하여 배열에 추가
           for (var i = 0; i < response.length; i++) {
               var res = response[i];
//                alert(res.facResSdate);
               calendar.addEvent({
                   title : res.facResPurpose,
                   start : res.facResSdate,
                   end :  res.facResEdate,
                   id : res.facResNo                   
               });                  
               console.log("시작시간? ==> " + res.facResSdate);
               console.log("끝난시간? ==> " + res.facResEdate);
            
			}
			
		},
		error: function () {                 
			console.log('Failed to fetch data from the server.');
		}
        
	}); //조회 아작스 끝
	
	// calendar element 취득
	var calendarEl = $('#calendar')[0];
	// full-calendar 생성하기
	var calendar = new FullCalendar.Calendar(calendarEl, {
		height: '900px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '09:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '23:00', // Day 캘린더에서 종료 시간
        
        customButtons: {
			myCustomBytton:{				
        		text:"예약하기",
        		click:function(){
        			$("#smallModal").modal("show");
        		}
        	}     	
        },
        
        // 해더에 표시할 툴바
        headerToolbar: {
          left: 'prev,myCustomBytton',
          center: 'title',
          right: 'next'
        },
        initialView: 'timeGridWeek', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
//         initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
//         nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
//           console.log("이벤트가 추가되면 발생되는 이벤트 ==> "+obj);
        },
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
//           console.log("이벤트가 수정되면 발생되는 이벤트 ==> " + obj);
        },
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
//           console.log("이벤트가 삭제되면 발생하는 이벤트 ==> " + obj);
        },
        eventClick:function(info){
        	if(confirm("시설 예약 내역을 삭제하시겠습니까?")){
        		$.ajax({
        			url : "/student/facStuResDelete",
        			type: 'POST',
        			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
        				xhr.setRequestHeader(header, token);
        			},
        			data: {
        	    		facResNo : info.event.id
        	   		},       
        	        success: function (response) {
        	    	   alert("시설 예약 내역을 삭제하셨습니다.");
// 						calendar.refetchEvents();// 달력 리로딩
        	        }
        		});
        	    info.event.remove();
        	}
        },
        select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
        	var title = prompt('이용목적을 적어주세요 : ');
            var number = parseInt(prompt("사용인원을 적어주세요 : ${facVO.facMax }명까지 가능합니다."));            
            
            if (number > ${facVO.facMax }){
            	alert("사용인원이 초과하였습니다.");
            	return false;
            } 
            
            if((arg.end - arg.start)/3600000 > 3 ){
            	alert("시설대여는 3시간 이상 할 수 없습니다.");
            	return false;
            }
            
            // 캘린더 events일정 불러오기 ( 내 DB데이터)
            events = calendar.getEvents();
            
            // 일정이 겹치면 배열의 갯수와 cnt가 다르기 때문에 예약을 할 수 없다.
            var cnt = 0;
            // 드래그 했을때 데이터 가 안들어오길래 고민했더니 -9시간 이라 새벽으로 잡혀있더라
            // 그래서 시간 더했는데 그래도 새벽이길래 9시간 더 더해줬더니 그제서야 정상적으로 시간이 잡힌다.
            data = {
            		title : title,
        			start : new Date(arg.start.getTime() + (arg.start.getTimezoneOffset() * 60 * 1000) +  18 * 60 * 60 * 1000),
        			end : new Date(arg.end.getTime() + (arg.end.getTimezoneOffset() * 60 * 1000) +  18 * 60 * 60 * 1000),
        			stuNo : $("#userNo").val(),
        			facNo : $("#facNo").val(),
        			number : number            		
            }  
            
	        if(events == "" || events == null){
	        	$.ajax({
					url : "/student/facilityReserve",
					type : "post",
					beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		 		         xhr.setRequestHeader(header, token);
					},
					data : JSON.stringify(data),
					contentType : "application/json; charset=utf-8",
					success : function(res){
						alert("시설 ${facVO.facName}을 예약하셨습니다.");
						// 이벤트 추가
						// 아작스 성공을 하면 페이지 리로딩 대신 달력에 일정 추가 새로고침하면 ajax이벤트추가가 reload되어 들어가 있다.
						calendar.addEvent({
        	        		title: title,
        	        		start: arg.start,
        	        		end: arg.end		        	        		
    	            	})
//     	            	calendar.refetchEvents();// 달력 리로딩
					} 
				})	
				
	        } else {
            	$.each(events, function(i, v) {
	            	if(arg.start < v.start && arg.end < v.start || arg.start > v.end && arg.end > v.end){
	            		cnt++;
	            		if(events.length == cnt){	           			
	            			// ajax들어갈 자리 alert한번뜨는거 확인했음
	            			$.ajax({
								url : "/student/facilityReserve",
								type : "post",
								beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
					 		         xhr.setRequestHeader(header, token);
								},
								data : JSON.stringify(data),
								contentType : "application/json; charset=utf-8",
								success : function(res){
									alert("시설 ${facVO.facName}을 예약하셨습니다.");
									// 이벤트 추가
									// 아작스 성공을 하면 페이지 리로딩 대신 달력에 일정 추가 새로고침하면 ajax이벤트추가가 reload되어 들어가 있다.
									calendar.addEvent({
			        	        		title: title,
			        	        		start: arg.start,
			        	        		end: arg.end		        	        		
		        	            	})
// 									calendar.refetchEvents();// 달력 리로딩
								} 
							}); // 아작스 끝
	            			
	            		}// if문끝
	            	// cnt와 길이가 같지 않으면 겹치는 시간대가 있다는 뜻이므로 아래와 같은 alert를 띄워준다.	
	            	} else {
	            		alert("이미 예약 되어있는 시간입니다.");
	            		calendar.unselect()
	            	}
	        	
            	}) // 반복문끝
	        } // else끝    
           
    		calendar.unselect();
        }, // select끝
        
        // 이벤트 
        events: [ 
        	
		]
		
	})//calendar끝
	
	// 캘린더 랜더링
	calendar.render();
      
	//모달창 이벤트
	$("#saveChanges").on("click", function () {
		var eventData = {
			title: $("#title").val(),
            start: $("#start").val(),
            end: $("#end").val(),         
		};
		//빈값입력시 오류
		if (eventData.title == "" || eventData.start == "" ||  eventData.end == "" ) {
			swal("입력오류","입력하지 않은 값이 있습니다.","error");          
            return false;	
            //끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
		} 
		if ($("#start").val() >= $("#end").val()) {
            swal("시간오류","끝나는 날자가 시작하는 날짜보다 늦으면 안됩니다.","error");
            return false;
		}  
		var currentH = new Date($("#start").val());
		var endH = new Date( $("#end").val());
		var hourTime = (endH-currentH) / 3600000;	
		
		if(hourTime > 3 ){
			alert("3시간 이상 대여할 수 없습니다.");
			return false;
		}
          
		var data ={
			title : eventData.title,
			start : eventData.start,
			end : eventData.end,
			stuNo : $("#stuNo").val(),
			facNo : $("#facNo").val(),
			number : $("#number").val()
		};
		var cnt = 0;
		// 이벤트 목록 가져오기
		events = calendar.getEvents();
		

		if( events == "" || events == null ){
			$.ajax({
				url : "/student/facilityReserve",
				type : "post",
				beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
	 		         xhr.setRequestHeader(header, token);
				},
				data : JSON.stringify(data),
				contentType : "application/json; charset=utf-8",
				success : function(res){
					alert("시설 ${facVO.facName}을 예약하셨습니다.");
					// 이벤트 추가
					calendar.addEvent(eventData);
// 					calendar.refetchEvents();// 달력 리로딩  
					$("#smallModal").modal("hide");
					$("#title").val("");
					$("#start").val("");
					$("#end").val("");
					$("#number").val("");	
				} 
			})		
		} else {
			$.each(events, function(i, v) {
				if(new Date(data.start) < v.start && new Date(data.end) < v.start || new Date(data.start) > v.end && new Date(data.end) > v.end){
					cnt++;
					console.log("cnt??  ==> " + cnt)
            		if(events.length == cnt){	 
            			$.ajax({
            				url : "/student/facilityReserve",
            				type : "post",
            				beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
            	 		         xhr.setRequestHeader(header, token);
            				},
            				data : JSON.stringify(data),
            				contentType : "application/json; charset=utf-8",
            				success : function(res){
            					alert("시설 ${facVO.facName}을 예약하셨습니다.");
            					// 이벤트 추가
            					calendar.addEvent(eventData);
//             					calendar.refetchEvents();// 달력 리로딩  
            					$("#smallModal").modal("hide");
            					$("#title").val("");
            					$("#start").val("");
            					$("#end").val("");
            					$("#number").val("");            	
            				} 
            			})
            		}else {
	            		alert("이미 예약 되어있는 시간입니다.");
	            		return false;
	            	}
				}
			});
		}  
				
						
	});// 모달이벤트끝   
	
	$("#listBtn").click(function(){
		location.href="/student/facMain";
	})
	
});// $function끝

</script>