<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>

<!-- 시큐리티 회원권한 가져오기 -->
<sec:authentication property="principal" var="prc" />
<c:set value="${prc.user.comDetUNo }" var="auth" />



<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

<!-- Menu -->
<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
	

	<div class="app-brand demo" style="height:270px; width: 300px;">
	<c:if test="${prc.user.comDetUNo eq 'U0101'}">
		<c:set value="/student/mypage.do" var="homeUrl"/>
	</c:if>
	<c:if test="${prc.user.comDetUNo eq 'U0102' }">
		<c:set value="/professor/mypage.do" var="homeUrl"/>
	</c:if>
	<c:if test="${prc.user.comDetUNo eq 'U0103' }">
		<c:set value="/admin/mypage.do" var="homeUrl"/>
	</c:if>
		<!-- 로고눌렀을대 링크 -->
		<a href="${homeUrl }" class="app-brand-link"> 
			 <img src="${pageContext.request.contextPath}/resources/images/대덕대학교로고_최종.png" alt="R E C I T A L" 
			 class="app-brand-logo" style="height: 180px; width: 130px; margin-top:-39px; margin-left:49px;">
 		</a> 
	</div>
	<br>
	<a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
    </a>
	<ul class="menu-inner py-1">

		<!-- 학생 -->
		<c:if test="${auth eq 'U0101' }">
			
			<!-- 마이페이지 -->
			<li class="menu-item active">
				<a href="/student/mypage.do" class="menu-link "> 
					<i class="menu-icon tf-icons bx bx-user me-2"></i>
					<div data-i18n="마이페이지">마이페이지</div>
				</a>
			</li>
			<!-- 수강신청 -->
			<li class="menu-item">
				<a href="/student/preCourse" class="menu-link" target="_blank"> 
					<i class="menu-icon bx bxs-book-open"></i>
					<div data-i18n="수강신청">수강신청</div>
				</a>
			</li>

			<!-- 강의 -->
			<li class="menu-item">
				<c:if test="${empty param.lecNo }">
					<a href="/lectureList/lectureList.do" class="menu-link"> 
					<i class="menu-icon tf-icons bx bx-file"></i>
						<div data-i18n="강의">강의</div>
					</a>
				</c:if>
				<c:if test="${not empty param.lecNo }">
					<a href="/lectureList/lectureList.do" class="menu-link"> 
					<i class="menu-icon tf-icons bx bx-file"></i>
						<div data-i18n="강의">강의</div>
					</a>
					<ul>
	               		<li class="menu-item">
			                <a href="/lectureList/lectureDetail.do?lecNo=${param.lecNo}" class="menu-link" >
								<i class="menu-icon tf-icons bx bx-minus"></i>
		           		        <div data-i18n="Basic">홈</div>
	                 		</a>
	               		</li>
		                <li class="menu-item">
	       				    <a href="/admin/lectureDetail?lecNo=${param.lecNo }" class="menu-link" >
								<i class="menu-icon tf-icons bx bx-minus"></i>
	                   			<div data-i18n="Basic">강의계획서</div>
			                </a>
	           			</li>
	               		<li class="menu-item">
	                 		<a href="/lectureData/selectLectureDataList.do?lecNo=${param.lecNo }" class="menu-link" >
								<i class="menu-icon tf-icons bx bx-minus"></i>
	                   			<div data-i18n="Basic">강의자료실</div>
			                </a>
	           		    </li>
	               		<li class="menu-item">
	                 		<a href="/lectureNotice/selectLectureNotice.do?lecNo=${param.lecNo }" class="menu-link" >
								<i class="menu-icon tf-icons bx bx-minus"></i>
	                   			<div data-i18n="Basic">강의공지</div>
			                </a>
	           		    </li>
	               		<li class="menu-item">
	                 		<a href="/assignment/selectAssignmentList.do?lecNo=${lecNo }" class="menu-link" >
								<i class="menu-icon tf-icons bx bx-minus"></i>
	                   			<div data-i18n="Basic">과제</div>
	                 		</a>
	               		</li>
	               		<li class="menu-item">
	                 		<a href="/exam/examList?lecNo=${param.lecNo }" class="menu-link" >
								<i class="menu-icon tf-icons bx bx-minus"></i>
			                    <div data-i18n="Basic">시험</div>
	           			    </a>
	               		</li>
	               		<li class="menu-item">
	                 		<a href="/online/onlineLecture?lecNo=${param.lecNo }" class="menu-link" >
								<i class="menu-icon tf-icons bx bx-minus"></i>
	                   			<div data-i18n="Basic">화상수업</div>
	               			</a>
	               		</li>
<!-- 	               		<li class="menu-item"> -->
<!-- 	                 		<a href="auth-forgot-password-basic.html" class="menu-link" > -->
<!-- 								<i class="menu-icon tf-icons bx bx-minus"></i> -->
<!-- 	                   			<div data-i18n="Basic">조</div> -->
<!-- 	                 		</a> -->
<!-- 	               		</li> -->
	               		<li class="menu-item">
	                 		<a href="/evaluate/evaluateLecture?lecNo=${param.lecNo }" class="menu-link" >
								<i class="menu-icon tf-icons bx bx-minus"></i>
	                   			<div data-i18n="Basic">강의평가</div>
	                 		</a>
	               		</li>                              
	             	</ul>
				</c:if>
			</li>

			<!-- 시설예약 -->
			<li class="menu-item">
				<a href="/student/facMain" class="menu-link"> 
					<i class="menu-icon tf-icons bx bx-buildings"></i>
					<div data-i18n="시설예약">시설예약</div>
				</a>
			</li>

			<!-- 성적확인 -->
			<li class="menu-item">
				<a href="/score/checkScore" class="menu-link"> 
					<i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
					<div data-i18n="성적확인">성적확인</div>
				</a>
			</li>

			<!-- 등록금 -->
			<li class="menu-item">
				<a href="/tuition/tuitionSubmit" class="menu-link"> 
					<i class="menu-icon tf-icons bx bx-box"></i>
					<div data-i18n="등록금">등록금</div>
				</a>
			</li>

			<!-- 게시판 -->
			<li class="menu-item">
				<a href="javascript:void(0)" class="menu-link menu-toggle">
					<i class="menu-icon tf-icons bx bxs-conversation"></i>
					<div data-i18n="게시판">게시판</div>
				</a>
				<ul class="menu-sub">
					<li class="menu-item">
						<a href="/student/notificationList" class="menu-link">
							<div data-i18n="공지게시판">공지게시판</div>
						</a>
					</li>
					<li class="menu-item">
						<a href="/student/freeList" class="menu-link">
							<div data-i18n="자유게시판">자유게시판</div>
						</a>
					</li>
					<li class="menu-item">
						<a href="/student/foodList" class="menu-link">
							<div data-i18n="Text Divider">맛집게시판</div>
						</a>
					</li>
				</ul>
			</li>

			<!-- 장학 -->
			<li class="menu-item">
				<a href="icons-boxicons.html" class="menu-link menu-toggle"> 
					<i class="menu-icon tf-icons bx bx-crown"></i>
					<div data-i18n="Boxicons">장학</div>
				</a>
				<ul class="menu-sub">
					<li class="menu-item">
						<a href="/student/scholarshipList" class="menu-link">
							<div>장학종류</div>
						</a>
					</li>
					<li class="menu-item">
						<a href="/student/myScholarshipList" class="menu-link">
							<div>장학내역</div>
						</a>
					</li>
				</ul>
			</li>


			<!-- 봉사 -->
			<li class="menu-item">
				<a href="/student/volunteerList" class="menu-link"> 
					<i class="menu-icon tf-icons bx bx-detail"></i>
					<div data-i18n="Form Elements">봉사</div>
				</a>
			</li>

			<!-- 상담 -->
			<li class="menu-item">
				<a href="/student/consultingList" class="menu-link"> 
					<i class="menu-icon tf-icons bx bx-message-rounded-dots"></i>
					<div data-i18n="Form Layouts">상담</div>
				</a>
			</li>

			<!-- 학적 -->
			<li class="menu-item">
				<a href="/student/breakList" class="menu-link"> 
				<i class="menu-icon tf-icons bx bx-table"></i>
					<div data-i18n="Tables">학적</div>
				</a>
			</li>
			<li class="menu-item">
				<a href="javascript:void(0);" class="menu-link menu-toggle"> 
					<i class="menu-icon tf-icons bx bx-id-card"></i>
					<div data-i18n="증명서">증명서</div>
				</a>
				<ul class="menu-sub">
					<li class="menu-item">
						<a href="/student/certificationList" class="menu-link">
							<div data-i18n="증명서발급">증명서발급</div>
						</a>
					</li>
					<li class="menu-item">
						<a href="/student/myCertificationList" class="menu-link">
							<div data-i18n="증명서 발급 내역">증명서 발급 내역</div>
						</a>
					</li>
				</ul>
			</li>

			<!-- 자격증 -->
			<li class="menu-item">
				<a href="javascript:void(0);" class="menu-link menu-toggle"> 
					<i class="menu-icon tf-icons bx bx-medal"></i>
					<div data-i18n="자격증">자격증</div>
				</a>
				<ul class="menu-sub">
					<li class="menu-item">
						<a href="/student/licenseForm" class="menu-link">
							<div data-i18n="자격증 등록">자격증 등록</div>
						</a>
					</li>
					<li class="menu-item">
						<a href="/student/myLicenseList" class="menu-link">
							<div data-i18n="보유 자격증 조회">보유 자격증 조회</div>
						</a>
					</li>
				</ul>
			</li>

		</c:if>
		
		<!-- 교수 -->
		<c:if test="${auth eq 'U0102' }">
			
			<!-- 마이페이지 -->
            <li class="menu-item">
              	<a href="/professor/mypage.do" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-user me-2"></i>
	                <div data-i18n="Account Settings">마이페이지</div>
              	</a>              
            </li>              
              
            <!-- 강의 -->  
            <li class="menu-item">
            	<c:if test="${empty param.lecNo }">
	              	<a href="/professor/lectureList.do" class="menu-link">
		                <i class="menu-icon tf-icons bx bx-file"></i>
		                <div data-i18n="Authentications">강의</div>
	              	</a>                            
            	</c:if>
                <c:if test="${not empty param.lecNo }">
	              	<a href="/professor/lectureList.do" class="menu-link">
		                <i class="menu-icon tf-icons bx bx-file"></i>
		                <div data-i18n="Authentications">강의</div>
	              	</a>                            
	              	<ul>
		                <li class="menu-item">
		                  	<a href="/professor/lectureDetail.do?lecNo=${param.lecNo}" class="menu-link">
		                    	<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">홈</div>
		                  	</a>
		                </li>
		                <li class="menu-item">
		                  	<a href="/professor/lectureDetail?lecNo=${param.lecNo}" class="menu-link" >
		                    	<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">강의상세</div>
		                  	</a>
		                </li>
		                <li class="menu-item">
		                  	<a href="/professor/selectStudentList.do?lecNo=${param.lecNo}" class="menu-link">
		                    	<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">참여자목록</div>
		                  	</a>
		                </li>
		                <li class="menu-item">
		                  	<a href="/attendance/attendanceList?lecNo=${param.lecNo}" class="menu-link" >
		                    	<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">출석관리</div>
		                  	</a>
		                </li>
		                <li class="menu-item">
		                  	<a href="/score/scoreStudent?lecNo=${param.lecNo}" class="menu-link" >
		                    	<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">성적관리</div>
		                  	</a>
		                </li>
		                <li class="menu-item">
		                  	<a href="/exam/examList?lecNo=${param.lecNo}" class="menu-link" >
		                  		<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">시험관리</div>
		                  	</a>
		                </li>
<!-- 		                <li class="menu-item"> -->
<%-- 		                  	<a href="/team/createTeam.do?lecNo=${param.lecNo}" class="menu-link" > --%>
<!-- 		                  		<i class="menu-icon tf-icons bx bx-minus"></i> -->
<!-- 		                    	<div data-i18n="Basic">팀관리</div> -->
<!-- 		                  	</a> -->
<!-- 		                </li> -->
		                <li class="menu-item">
		                  	<a href="/professor/selectAssignmentList.do?lecNo=${param.lecNo}" class="menu-link" >
		                  		<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">과제관리</div>
		                  	</a>
		                </li>
		                <li class="menu-item">
		                  	<a href="/lectureNotice/selectLectureNotice.do?lecNo=${param.lecNo}" class="menu-link" >
		                  		<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">강의공지</div>
		                  	</a>
		                </li>
		                <li class="menu-item">
		                  	<a href="/professor/selectLectureDataList.do?lecNo=${param.lecNo}" class="menu-link" >
		                  		<i class="menu-icon tf-icons bx bx-minus"></i>
		                   		<div data-i18n="Basic">강의자료실</div>
		                  	</a>
		                </li>
		                <li class="menu-item">
		                  	<a href="/online/onlineLecture?lecNo=${param.lecNo }" class="menu-link" >
		                  		<i class="menu-icon tf-icons bx bx-minus"></i>
		                    	<div data-i18n="Basic">화상강의</div>
		                  	</a>
		                </li>  
	              	</ul>                         
               	</c:if>              
            </li>
            
            <!-- 강의등록 -->
            <li class="menu-item">
              	<a href="/professor/lecSignUp" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-edit-alt"></i>
	                <div data-i18n="Misc">강의등록</div>
              	</a>
            </li>
            
            <!-- 시설예약 -->
            <li class="menu-item">
              	<a href="/student/facMain" class="menu-link">
	            	<i class="menu-icon tf-icons bx bx-buildings"></i>
	                <div data-i18n="Misc">시설예약</div>
              	</a>             
            </li>
            
            <!-- 상담 -->
            <li class="menu-item">
              	<a href="/professor/consultingList" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-message-rounded-dots"></i>
	                <div data-i18n="User interface">상담</div>
              	</a>              
            </li>

            <!-- 휴가 -->
            <li class="menu-item">
              	<a href="/vacation/vacationList" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-copy"></i>
	                <div data-i18n="Extended UI">휴가</div>
              	</a>              	
            </li>

         	<!-- 게시판 -->
            <li class="menu-item">
              	<a href="icons-boxicons.html" class="menu-link menu-toggle">
                	<i class="menu-icon tf-icons bx bx-crown"></i>
                	<div data-i18n="Boxicons">게시판</div>
              	</a>
              	<ul class="menu-sub">
					<li class="menu-item">
						<a href="/professor/notificationList" class="menu-link">
							<div data-i18n="공지게시판">공지게시판</div>
						</a>
					</li>
					<li class="menu-item">
						<a href="/professor/freeList" class="menu-link">
							<div data-i18n="자유게시판">자유게시판</div>
						</a>
					</li>
					<li class="menu-item">
						<a href="/professor/foodList" class="menu-link">
							<div data-i18n="Text Divider">맛집게시판</div>
						</a>
					</li>
				</ul>
            </li>     
         	
			
		</c:if>
		
		<!-- 관리자 -->
		<c:if test="${auth eq 'U0103' }">
		
			<!-- 마이페이지 -->
            <li class="menu-item">
              	<a href="/admin/mypage.do" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-user me-2"></i>
	                <div data-i18n="Account Settings">마이페이지</div>
              	</a>              
            </li>                    
              
            <!-- 과목관리 -->  
            <li class="menu-item">
              	<a href="/admin/subjectList" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
	                <div data-i18n="Authentications">과목관리</div>
              	</a>                            
            </li>
            
            <!-- 강의등록 -->
            <li class="menu-item">
              	<a href="/admin/lectureList" class="menu-link">
                	<i class="menu-icon tf-icons bx bx-file"></i>
                	<div data-i18n="Misc">강의관리</div>
              	</a>
            </li>
            
            <!-- 학사관리 -->
            <li class="menu-item">
              	<a href="javascript:void(0);" class="menu-link menu-toggle">
	                <i class="menu-icon tf-icons bx bx-cube-alt"></i>
	                <div data-i18n="Misc">학사관리</div>
             	</a>  
               	<ul class="menu-sub">              	
	              	<li class="menu-item">
	              		<a class="menu-link" href="/academic/main">
	              			<div>학사일정관리</div>
	              		</a>
	              	</li>              	
	              	<li class="menu-item">
	              		<a class="menu-link" href="/menu/menuList">
	              			<div>학식관리</div>
	              		</a>
	              	</li>              	
              	</ul>                
            </li>
            
            <!-- 회원관리 -->
            <li class="menu-item">
              	<a href="javascript:void(0);" class="menu-link menu-toggle">
	                <i class="menu-icon tf-icons bx bx-table"></i>
	                <div data-i18n="Basic">회원관리</div>
              	</a>      
              	<ul class="menu-sub">
	              	<li class="menu-item">
	              		<a href="/admin/stuList" class="menu-link">
	              			<div>인원관리</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a class="menu-link" href="/admin/breakList">
	              			<div>학적관리</div>
	              		</a>
	              	</li>              	
	              	<li class="menu-item">
	              		<a class="menu-link" href="/vacation/empVacationList">
	              			<div>휴가관리</div>
	              		</a>
	              	</li>              	
              	</ul>         
            </li>
            
            <!-- 게시판관리 -->
            <li class="menu-item">
              	<a href="javascript:void(0)" class="menu-link menu-toggle">
	                <i class="menu-icon tf-icons bx bx-box"></i>
	                <div data-i18n="User interface">게시판관리</div>
              	</a>              
              	<ul class="menu-sub">
	              	<li class="menu-item">
	              		<a href="/admin/list" class="menu-link">
	              			<div>공지사항</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a href="/admin/freeList" class="menu-link">
	              			<div>자유게시판</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a href="/admin/foodList" class="menu-link">
	              			<div>맛집게시판</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a href="/admin/ReportList" class="menu-link">
	              			<div>신고관리</div>
	              		</a>
              		</li>
              	</ul>
            </li>

            <!-- 시설관리 -->
            <li class="menu-item">
              	<a href="javascript:void(0)" class="menu-link menu-toggle">
	                <i class="menu-icon tf-icons bx bx-buildings"></i>
	                <div data-i18n="Extended UI">시설관리</div>
              	</a>
              	<ul class="menu-sub">                
                	<li class="menu-item">
	                  	<a href="/admin/facList" class="menu-link">
	                    	<div data-i18n="Text Divider">시설관리</div>
	                  	</a>
                	</li>
                	<li class="menu-item">
                  		<a href="/admin/facResList" class="menu-link">
                    		<div data-i18n="Text Divider">시설예약관리</div>
                  		</a>
                	</li>
              	</ul>
            </li>

			<!-- 등록금관리 -->
            <li class="menu-item">
              	<a href="icons-boxicons.html" class="menu-link menu-toggle">
	                <i class="menu-icon tf-icons bx bx-crown"></i>
	                
	                <div data-i18n="Boxicons">등록금관리</div>
              	</a>
              	<ul class="menu-sub">
	              	<li class="menu-item">
	              		<a href="/tuition/tuitionList" class="menu-link">
	              			<div >등록금 고지서 관리</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a href="/tuition/submitTuitionList" class="menu-link">
	              			<div>납부내역</div>
	              		</a>
	              	</li>
              	</ul>
            </li>
            
			<!-- 지도학생 -->
            <li class="menu-item">
              	<a href="icons-boxicons.html" class="menu-link menu-toggle">
	                <i class="menu-icon tf-icons bx bx-crown"></i>
	                <div data-i18n="Boxicons">장학금관리</div>
              	</a>
              	<ul class="menu-sub">
	              	<li class="menu-item">
	              		<a href="/admin/scholarshipList" class="menu-link">
	              			<div >장학종류</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a href="/admin/scholarshipRequestList" class="menu-link">
	              			<div>장학신청승인</div>
	              		</a>
	              	</li>              
              	</ul>
            </li>		

			<!-- 상담관리 -->
            <li class="menu-item">
              	<a href="/admin/consultingMain" class="menu-link">
                	<i class="menu-icon tf-icons bx bx-message-rounded-dots"></i>
                	<div data-i18n="Boxicons">상담관리</div>
              	</a>
            </li>  
            
			<!-- 증명서 관리 -->
            <li class="menu-item">
              	<a href="/admin/certificationList" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-id-card"></i>
	                <div data-i18n="Boxicons">증명서관리</div>
              	</a>
            </li>
            
			<!-- 봉사관리 -->
            <li class="menu-item">
              	<a href="/admin/volunteerList" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-detail"></i>
	                <div data-i18n="Boxicons">봉사관리</div>
              	</a>
            </li> 
			<!-- 학과관리 -->
            <li class="menu-item">
              	<a href="/admin/departmentList" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-crown"></i>
	                <div data-i18n="Boxicons">학과관리</div>
              	</a>
            </li> 

			<!-- 자격증관리 -->
            <li class="menu-item">
              	<a href="/admin/licenseList" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-medal"></i>
	                <div data-i18n="Boxicons">자격증관리</div>
              	</a>
            </li> 
            
            <!-- 통계 현황 관리 -->
            <li class="menu-item">
              	<a href="icons-boxicons.html" class="menu-link menu-toggle">
	                <i class="menu-icon tf-icons bx bx-id-card"></i>
	                <div data-i18n="Boxicons">통계 현황</div>
              	</a>
              	<ul class="menu-sub">
	              	<li class="menu-item">
	              		<a href="/admin/tuitionStatistics" class="menu-link">
	              			<div>등록금 납부/미납부 통계 현황</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a href="/admin/scholarshipStatistics" class="menu-link">
	              			<div>장학금 신청 현황</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a href="/admin/certificationStatistics" class="menu-link">
	              			<div>증명서 발급 현황</div>
	              		</a>
	              	</li>
	              	<li class="menu-item">
	              		<a href="/admin/licenseStatistics" class="menu-link">
	              			<div>자격증 신청 현황</div>
	              		</a>
	              	</li>
              	</ul>
            </li>
            
		
		</c:if>

	</ul>




</aside>
<!-- / Menu -->
<script>

</script>



























