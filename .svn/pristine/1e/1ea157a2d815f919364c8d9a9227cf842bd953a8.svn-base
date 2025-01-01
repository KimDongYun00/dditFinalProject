<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 -->
	<sec:authentication property="principal.user" var="user" />
</sec:authorize>
<style type="text/css">
/* #div1 { */
/* 	margin: 50px 100px; */
/* } */

/* #div2 { */
/* 	padding: 50px 200px; */
/* } */

#content {
	font-size: 1.5em;
}

table {
	border: 2px solid #d2d2d2;
	border-collapse: collapse;
	font-size: 0.9em;
}

th, td {
	border: 1px solid #d2d2d2;
	border-collapse: collapse;
	text-align: center;
}

th {
	height: 5px;
}

td {
	width: 75px;
	height: 30px;
}

</style>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">
			<div id="div1">
				<div class="col-md-12">
					<div class="card mb-4" id="div2">
						<!-- 			<div class="card mb-4" style="padding: 50px 100px ;"> -->
						<h3 class="card-header">Mypage</h3>
						<!-- Account -->
						<div class="container">
							<div class="d-flex align-items-start align-items-sm-center gap-4">
								<img src="${pageContext.request.contextPath }${empVO.empImg}" alt="user-avatar"
									class="d-block rounded" height="250" width="250"
									id="uploadedAvatar" />
								<div class="col" style="padding-top: 180px;" id="content">
									<span>${user.empVO.empName }</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span>
										<c:if test="${user.empVO.comDetDNo eq 'D0101'}">행정과</c:if>
										<c:if test="${user.empVO.comDetDNo eq 'D0102'}">인사과</c:if>										
									</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span>${user.empVO.empPhone }</span>
								</div>
							</div>

							<input type="button" class="btn btn-primary me-2 mb-4"
								style="float: right" id="modBtn" value="개인정보수정">
						</div>
						<hr class="my-0" />
						<div class="card-body">
							<div class="row">
								<div class="mb-3 col-md-6">
									<label for="firstName" class="form-label">금주 학식</label>
									<div class="card" id="menuTable">		
										<table class="table table-hover" style="text-align: center;">
											<tr>
												<th width="5%"></th>
												<th>월</th>
												<th>화</th>
												<th>수</th>
												<th>목</th>
												<th>금</th>
												<th>토</th>
												<th>일</th>
											</tr>	
											<tr>  
												<th>아침</th>
												<c:forEach items="${mList }" var ="mor">					
													<td>${mor.menuFood } ${mor.menuPrice }원</td>	
												</c:forEach>				
											</tr>			
											<tr>
												<th>점심</th>
												<c:forEach items="${lList }" var ="lan">					
													<td>${lan.menuFood } ${lan.menuPrice }원</td>	
												</c:forEach>					
											</tr>			
											<tr>
												<th>저녘</th>
												<c:forEach items="${dList }" var ="din">					
													<td>${din.menuFood } ${din.menuPrice }원</td>	
												</c:forEach>					
											</tr>			
										</table>		
									</div>
								</div>	
								<div class="mb-3 col-md-6">
									<div id="calendar"></div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function(){
	$("#menuTable").click(function(){
		location.href="/menu/menuList";
	});
	
	// 캘린더 클릭하면 일정변경 페이지로
	$("#calendar").click(function(){
		location.href="/academic/main"
	});
	var calendarEl = $('#calendar')[0];
	var calendar = new FullCalendar.Calendar(calendarEl,{
		initialView : 'dayGridMonth',
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
   	
	var modBtn = $("#modBtn");
	
	modBtn.on("click", function(){
		location.href = "/admin/modify.do";
	});
});
</script>