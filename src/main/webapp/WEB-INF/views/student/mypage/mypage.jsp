<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>


<style type="text/css">

#timeTable {
	border: 2px solid #d2d2d2;
	border-collapse: collapse;
	font-size: 0.9em;
}

#timeTable th, #timeTable td {
	border: 1px solid #d2d2d2;
	border-collapse: collapse;
	text-align: center;
}

#timeTable th {
	height: 5px;
}

#timeTable td {
	width: 75px;
	height: 15px;
}

.skyblue{
	background : skyblue;
}

.blue{
	background : #035b99;
}

#timeTableDetail{
	font-size: 1.2rem;
}

</style>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">
		
			<div class="row">
			
				<div class="col-lg-7 mb-4">
					<div class="card" style="height:400px;">
						<h4 class="card-header">
							내 정보
						</h4>
						<div class="card-body">
							<div style="float:left;">
								<img src="${pageContext.request.contextPath }${stuVO.stuImg}" alt="user-avatar"
									class="d-block rounded" height="300" width="250"
									id="uploadedAvatar" />
							</div>
							<div class="row">
								<div class="col-sm-7">
									<label>이름</label><input type="text" class="form-control" value="${stuVO.stuName }" readonly="readonly">
								</div>
								<div class="col-sm-5">
									<label>학년</label><input type="text" class="form-control" value="${stuVO.stuYear }" readonly="readonly">
								</div>
								<div class="col-sm-12">
									<label>학과</label><input type="text" class="form-control" value="${stuVO.deptName }" readonly="readonly">
								</div>
								<div class="col-sm-12">
									<label>전화번호</label><input type="text" class="form-control" value="${stuVO.stuPhone }" readonly="readonly">
								</div>
								<div class="col-sm-12">
									<label>이메일</label><input type="text" class="form-control" value="${stuVO.stuEmail }" readonly="readonly">
								</div>
							</div>
							<input type="button" class="btn btn-primary me-2 mb-4"
								style="float: right; margin: 10px 0 0 0;" id="modBtn" value="수정">
						</div>
					</div>
				</div>
				
				<div class="col-lg-5 mb-4">
					<div class="card" style="height:400px;">
						<h4 class="card-header">졸업요건</h4>
						<div class="card-body row">
							<div class="col-sm-3">
								<canvas id="bar-chart1" width="100" height="300"></canvas>
							</div>
							<div class="col-sm-3">
								<canvas id="bar-chart2" width="100" height="300"></canvas>
							</div>
							<div class="col-sm-3">
								<canvas id="bar-chart3" width="100" height="300"></canvas>
							</div>
							<div class="col-sm-3">
								<canvas id="bar-chart4" width="100" height="300"></canvas>
							</div>
						</div>
					</div>	
				</div>
				
				<div class="col-lg-4 mb-4">
					<div class="card">
						<h4 class="card-header">시간표</h4>
						<div class="card-body">
							<table width="400" height="600" id="timeTable">
								<tr>
									<th></th>
									<th>월</th>
									<th>화</th>
									<th>수</th>
									<th>목</th>
									<th>금</th>
								</tr>
								<c:forEach begin="8" end="21" var="time" varStatus="status">
									<tr data-time="<fmt:formatNumber value='${status.index }' pattern="00"/>_00">
										<th rowspan="2"><fmt:formatNumber value='${status.index }' pattern="00"/></th>
										<td data-day="W0101" data-res="0"></td>
										<td data-day="W0102" data-res="0"></td> 
										<td data-day="W0103" data-res="0"></td>
										<td data-day="W0104" data-res="0"></td>
										<td data-day="W0105" data-res="0"></td>
									</tr>
									<tr data-time="<fmt:formatNumber value='${status.index }' pattern="00"/>_30">
										<td data-day="W0101" data-res="0"></td>
										<td data-day="W0102" data-res="0"></td>
										<td data-day="W0103" data-res="0"></td>
										<td data-day="W0104" data-res="0"></td>
										<td data-day="W0105" data-res="0"></td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<div class="card-footer" id="timeTableDetail">
							강의명 : <span></span>
							<br>
							강의실 : <span></span>
						</div>
					</div>
				</div>
				
				<div class="col-lg-8 mb-4">
					<div class="card">
						<h4 class="card-header">캘린더</h4>
						<div class="card-body">
							<div id="calendar"></div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	
<!-- 달력 상세보기 모달 -->	
<div class="modal fade" id="modalCenter" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalCenterTitle">학사일정</h5>
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
<!--         <button type="button" class="btn btn-outline-primary" id="insertBtn">등록</button> -->
<!--         <button type="button" class="btn btn-info" id="modifyBtn" style="display:none;">수정</button> -->
<!--         <button type="button" class="btn btn-danger" id="deleteBtn" style="display:none;">삭제</button>         -->
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">


$(function(){
	$("#calendar").click(function(){
		location.href="/academic/user";
	})
	
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
	var modBtn = $("#modBtn");
	
	modBtn.on("click", function(){
		location.href = "/student/modify.do";
	});
	
	$.ajax({
		url : "/admin/myLecTimeList.do?type=stu",
		type : "post",
		beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
			xhr.setRequestHeader(header, token);
		},
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log("result : " + res);
			
			$.each(res, function(i, v){
				var time = v.comDetTName.replace(":", "_");
				
				var element = $("tr[data-time="+time+"]").find("td[data-day="+v.comDetWNo+"]");
				element.addClass("skyblue");
				element.attr("data-lecName", v.lecName);
				element.hover(function(){
					$("td[data-lecName='"+v.lecName+"']").addClass("blue");
					$("#timeTableDetail").find('span').eq(0).html(v.lecName);
					$("#timeTableDetail").find('span').eq(1).html(v.buiName + " " + v.facName);
					$("#timeTableDetail").find('span').css('color', 'blue');
				}, function(){
					$("td[data-lecName='"+v.lecName+"']").removeClass("blue");
					$("#timeTableDetail").find('span').eq(0).html("");
					$("#timeTableDetail").find('span').eq(1).html("");
				});
			});
		}
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
   	})
	new Chart(document.getElementById("bar-chart1"), {
	    type: 'bar',
	    data: {
	      labels: ["", ""],
	      datasets: [
	        {
	          backgroundColor: ["skyblue", "#035b99"],
	          data: ['${graReqVO.graReqTotal }','${graScoreMap.L0000 }']
	        }
	      ]
	    },
	    options: {
	      legend: { display: false },
	      title: {
	        display: true,
	        text: '총 학점'
	      },
	      scales : {
		  		yAxes : [ {
		  			ticks : {
		  				beginAtZero : true
		  			}
		  		} ]
		      }
	    }
	});
	
	new Chart(document.getElementById("bar-chart2"), {
	    type: 'bar',
	    data: {
	      labels: ["", ""],
	      datasets: [
	        {
	          backgroundColor: ["skyblue", "#035b99"],
	          data: ['${graReqVO.graReqMc }','${graScoreMap.L0101 }']
	        }
	      ]
	    },
	    options: {
	      legend: { display: false },
	      title: {
	        display: true,
	        text: '전공'
	      },
	      scales : {
		  		yAxes : [ {
		  			ticks : {
		  				beginAtZero : true
		  			}
		  		} ]
		      }
	    }
	});
	
	new Chart(document.getElementById("bar-chart3"), {
	    type: 'bar',
	    data: {
	      labels: ["", ""],
	      datasets: [
	        {
	          backgroundColor: ["skyblue", "#035b99"],
	          data: ['${graReqVO.graReqLac }','${graScoreMap.L0201 }']
	        }
	      ]
	    },
	    options: {
	      legend: { display: false },
	      title: {
	        display: true,
	        text: '교양'
	      },
	      scales : {
		  		yAxes : [ {
		  			ticks : {
		  				beginAtZero : true
		  			}
		  		} ]
		      }
	    }
	});
	
	new Chart(document.getElementById("bar-chart4"), {
	    type: 'bar',
	    data: {
	      labels: ["", ""],
	      datasets: [
	        {
	          backgroundColor: ["skyblue", "#035b99"],
	          data: ['${graReqVO.graReqVol }','${graScoreMap.VOL }']
	        }
	      ]
	    },
	    options: {
	      legend: { display: false },
	      title: {
	        display: true,
	        text: '봉사'
	      },
	      scales : {
	  		yAxes : [ {
	  			ticks : {
	  				beginAtZero : true
	  			}
	  		} ]
	      }
	    }
	});
	
});

	
</script>
</html>





























