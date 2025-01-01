<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>




<style type="text/css">
#timeTable {
	border: 2px solid #d2d2d2;
	border-collapse: collapse;
	font-size: 0.9em;
	margin : 0 5% 20% 5%;
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
	width: 18%;
	height: 15px;
}

.menu-inner li {
    list-style-type: none;
    padding-left: 0;
}



</style>



<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

 <!-- Menu -->
        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme" style="width:20%;">
          <div class="app-brand demo" style="width:250px; height: 250px; margin-left: 30px;">

			<!-- 로고눌렀을대 링크 -->
			<a href="#" class="app-brand-link"> 
				 <img src="${pageContext.request.contextPath}/resources/images/대덕대학교로고_최종.png" alt="대덕대학교로고이미지" 
				 class="app-brand-logo" style="height: 180px; width: 130px; margin-top:-40px; margin-left:56%;">
	 		</a> 

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
            </a>
          </div>

		
          <ul class="menu-inner">
          
          	<!-- 시큐리티 회원권한 가져오기 -->
			<sec:authentication property="principal" var="prc" />
			<c:set value="${prc.user.comDetUNo }" var="auth" />
			<c:set value="${prc.user.stuVO }" var="stuVO" />
			
			<!-- 학생 개인정보 -->
			<li>
				<div class="card-body">
					<span style="width:10%; font-size: 1rem;">이름&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<span style="font-size:1rem;">${stuVO.stuName }</span>
					<br>
					<span style="width:10%; font-size: 1rem;">학과&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<span style="font-size:1rem;">${stuVO.deptName }</span>
					<br>
					<span style="width:10%; font-size: 1rem;">학년&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<span style="font-size:1rem;">${stuVO.stuYear }</span>
					<br>
				</div>
			</li>
			
            
            <!-- 수강신청 -->
            <li class="menu-item">
              <a href="/student/preCourse" class="menu-link" style="font-size: 1rem;">
                <i class="menu-icon bi bi-activity"></i>
                <div data-i18n="Account Settings">예비수강신청</div>
              </a>              
            </li>
            <!-- 강의 -->
            <li class="menu-item">
              <a href="/student/course" class="menu-link menu-link" style="font-size: 1rem;">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Authentications">수강신청</div>
              </a>                   
            </li>
            
          </ul>
          
          
          <h5 style="margin: 0 auto;">시간표</h5>
          <br>
          <table width="90%" height="600" id="timeTable">
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
			
			
			
			
        </aside>
        <!-- / Menu -->





























