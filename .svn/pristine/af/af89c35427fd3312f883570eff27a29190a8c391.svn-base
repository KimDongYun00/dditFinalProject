<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 -->
	<sec:authentication property="principal.user" var="user" />
</sec:authorize>
<!DOCTYPE html>
<!-- Navbar -->
          <nav
            class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
            id="layout-navbar"
          >
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
              <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
              </a>
            </div>

            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">

              <ul class="navbar-nav flex-row align-items-center ms-auto">
          
          		<li class="nav-item navbar">
          			<div id="weather_icon"></div>
          			<div id="weather_description"></div>
          		</li>	
                <!-- 유저 -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                      <!-- 프로필이미지 -->
                      <img src="${pageContext.request.contextPath }<c:choose>
											                         	<c:when test="${user.comDetUNo eq 'U0101'}">${stuVO.stuImg }</c:when>   
											                         	<c:when test="${user.comDetUNo eq 'U0102'}">${profVO.proImg }</c:when>   
											                         	<c:when test="${user.comDetUNo eq 'U0103'}">${empVO.empImg }</c:when>   
											                        	<c:otherwise>/resources/images/기본프로필.jpg</c:otherwise>
											                        </c:choose>                      
                      " alt class="w-px-40  rounded-circle" />                         
                    </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="#">
                        <div class="d-flex">
                          <div class="flex-shrink-0 me-3">
                            <div class="avatar avatar-online">
                              <img src="${pageContext.request.contextPath }
                              <c:choose>
		                         	<c:when test="${user.comDetUNo eq 'U0101'}">${stuVO.stuImg }</c:when>   
		                         	<c:when test="${user.comDetUNo eq 'U0102'}">${profVO.proImg }</c:when>   
		                         	<c:when test="${user.comDetUNo eq 'U0103'}">${empVO.empImg }</c:when>   
		                        	<c:otherwise>/resources/images/기본프로필.jpg</c:otherwise>
		                      </c:choose> 
                              " alt class="w-px-40  rounded-circle" />
                            </div>
                          </div>
                          
                          <div class="flex-grow-1">
                            <span class="fw-semibold d-block">
                            	<c:if test="${user.comDetUNo eq 'U0102'}">${profVO.proName }<br>${profVO.proNo }</c:if>
                            	<c:if test="${user.comDetUNo eq 'U0101'}">${stuVO.stuName }<br>${stuVO.stuNo }</c:if>
                            	<c:if test="${user.comDetUNo eq 'U0103'}">${empVO.empName }<br>${empVO.empNo }</c:if>
                            </span>                          
                          </div>
                        </div>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <c:if test="${user.comDetUNo eq 'U0101'}"> 
	                      <a class="dropdown-item" href="/student/mypage.do">
	                        <i class="bx bx-user me-2"></i>
	                        <span class="align-middle">마이페이지</span>
	                      </a>
                      </c:if>
                      <c:if test="${user.comDetUNo eq 'U0102'}"> 
	                      <a class="dropdown-item" href="/professor/mypage.do">
	                        <i class="bx bx-user me-2"></i>
	                        <span class="align-middle">마이페이지</span>
	                      </a>
                      </c:if>
                      <c:if test="${user.comDetUNo eq 'U0103'}"> 
	                      <a class="dropdown-item" href="/admin/mypage.do">
	                        <i class="bx bx-user me-2"></i>
	                        <span class="align-middle">마이페이지</span>
	                      </a>
                      </c:if>
                    </li>
                    
                    <!-- 로그아웃 -->
                    <li>
                      <form action="/logout" method="post">
	                      <button type="submit" class="dropdown-item">
	                        <i class="bx bx-power-off me-2"></i>
	                        <span class="align-middle">로그아웃</span>
	                        <sec:csrfInput/>
	                      </button>
                      </form>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
          </nav>
          <!-- / Navbar -->
<script>
//날씨 api - 대전

var apiURI ='http://api.openweathermap.org/data/2.5/weather?q=seoul,kr&APPID=adffed75754f1020bd0c37393562a05c'; 
// 	"http://api.openweathermap.org/data/2.5/weather?q=daejeon&appid=adffed75754f1020bd0c37393562a05c&lang=kr";
$.ajax({
    url: apiURI,
    dataType: "json",
    type: "GET",
    // ajax를 통해 resp에는 수많은 json데이터들이 있다 자세한건 위에 uri를 클릭해보면 나온다.
    success: function(resp) {	       
        var $Temp = Math.floor(resp.main.temp- 273.15) + 'º<br>' + resp.weather[0].main;	// 현재 온도		    
		var html ='<img  src= "http://openweathermap.com/img/w/'+ resp.weather[0].icon +'.png" alt="' + resp.weather[0].description + '"/>'
        var icon ='<img  src= "http://openweathermap.org/img/w/'+ resp.weather[0].icon +'.png" alt="' + resp.weather[0].description + '"/>' 	
        $('#weather_icon').html(html);	// 아이콘
        $('#weather_description').append($Temp);	// 현재 온도           
        minTemp =  Math.floor(resp.main.temp_min - 273.15);	// 온도는 켈빈온도 기준으로 나오기 때문에 273.15를 해줘야 우리 기온이다
        maxTemp =  Math.floor(resp.main.temp_max - 273.15);	// 온도는 켈빈온도 기준으로 나오기 때문에 273.15를 해줘야 우리 기온이다
        // 최고, 최저, 평균온도는 현재 돈을 내야 구현가능한듯..
//         console.log("최저 기운은 ? : " +최저기온 + " 최고 기운은 ? : " + 최고기운);
    }
})
</script>          