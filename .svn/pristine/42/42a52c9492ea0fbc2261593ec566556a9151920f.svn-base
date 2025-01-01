<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>로그인</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	background: url('/resources/images/메인페이지_대학 이미지.jpg') no-repeat center
		center fixed;
	background-size: cover;
	font-family: Arial, sans-serif;
}

.announcement{
	height: 350px;
}
</style>

<!-- Favicon -->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/images/대덕대학교로고_아이콘.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet" />

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/vendor/css/core.css"
	class="template-customizer-core-css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/vendor/css/theme-default.css"
	class="template-customizer-theme-css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/vendor/libs/apex-charts/apex-charts.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script
	src="${pageContext.request.contextPath }/resources/assets/vendor/js/helpers.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script
	src="${pageContext.request.contextPath }/resources/assets/js/config.js"></script>
<c:if test="${not empty error }">	
	<script>
		alert("${error}");
	</script>
</c:if>
</head>
<body
	class="d-flex justify-content-center align-items-center min-vh-100">

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<h1 align="center" style="color:black;text-shadow: -1px 0px rgb(25, 60, 119), 0px 1px rgb(25, 60, 119), 1px 0px rgb(25, 60, 119), 0px -1px rgb(25, 60, 119);">
					대덕대학에 오신걸 환영합니다!
				</h1>
				<br>
				<br> 
				<br>
			</div>
			<div class="col-md-2"></div>
			<div class="col-md-6">
				<div class="card">
					<div class="card-body">
						<h3 class="mb-2 text-center">로그인</h3>
						<form id="loginForm" class="mb-3" method="post" action="/login">
							<div class="mb-3">
								<label for="id" class="form-label">학번/사번</label> <input
									type="text" class="form-control" id="personalId"
									name="username" placeholder="학번/사번을 입력해주세요." autofocus
									onkeypress="login(event)" /><br> <span id="idErr"></span>
							</div>
							<div class="mb-3 form-password-toggle">
								<label for="pw" class="form-label">비밀번호</label> <input
									type="password" id="personalPw" class="form-control"
									name="password"
									placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
									aria-describedby="password" autofocus onkeypress="login(event)" /><br>
								<span id="pwErr"></span>
							</div>
							<div class="mb-3">
								<button class="btn btn-primary d-grid w-100" type="button"
									id="loginBtn">로그인</button>
							</div>
							<sec:csrfInput />
						</form>

						<p class="text-center">
							<a href="/common/findIdPw"><span>학번/사번찾기 | 비밀번호찾기</span></a><br><br> 
							<a href="#" id="aStudent"><span>학생로그인</span></a>
							<a id="aProfessor" href="#"><span> | 교수로그인</span></a>
							<a id="aEmployee" href="#"><span> | 직원로그인</span></a>							
						</p>

					</div>
				</div>
			</div>

		</div>
	</div>

</body>
<script type="text/javascript">
// enterKEy로 로그인하기
function login(e){
	// enterKey 는 코드가 13이다 따라서 if문 조건은 enterkey를 눌럿을때 true
	// 이 방식의 단점은 input 태그에서 엔터를 눌러야 이 처리를 해준다는것..(밖에서 엔터를 치면 아무것도 적용이 안된다.)
    if(e.keyCode == 13){
    	var personalId = $("#personalId").val();
		var personalPw = $("#personalPw").val();
		var idErr = $("#idErr");
		var pwErr = $("#pwErr");

		if (personalId == null || personalId == "") {
			idErr.html("학번/사번을 입력해주세요!").css("color", "#c91010");
			return false;
		}
		if (personalPw == null || personalPw == "") {
			pwErr.html("비밀번호를 입력해주세요!").css("color", "#c91010");
			return false;
		}
    	
    	
    	$("#loginForm").submit();
    }
 }
$(function(){	
		var loginBtn = $("#loginBtn");
		var loginForm = $("#loginForm");
		
		$("#aStudent").on("click",function(){
			$("#personalId").val("20220001");
			$("#personalPw").val("1234");
		});
		$("#aProfessor").on("click",function(){
			$("#personalId").val("p22");
			$("#personalPw").val("881212");
		});
		$("#aEmployee").on("click",function(){
			$("#personalId").val("admin");
			$("#personalPw").val("1234");
		});
		
		loginBtn.on("click", function() {
			var personalId = $("#personalId").val();
			var personalPw = $("#personalPw").val();
			var idErr = $("#idErr");
			var pwErr = $("#pwErr");

			if (personalId == null || personalId == "") {
				idErr.html("학번/사번을 입력해주세요!").css("color", "red");
				return false;
			}
			if (personalPw == null || personalPw == "") {
				pwErr.html("비밀번호를 입력해주세요!").css("color", "red");
				return false;
			}

			loginForm.submit();

		});
		
		// 안쓰는 함수 같아서 주석처리
// 		function findId() {
// 			if (findIdForm.memName.value == "") {
// 				alert("이름을 입력해 주세요.");
// 				findIdForm.memName.focus();
// 				return;
// 			}
// 			if (findIdForm.memPhone.value == "") {
// 				alert("핸드폰번호를 입력해 주세요.");
// 				findIdForm.memPhone.focus();
// 				return;
// 			}
			
// 			var memName =$("#findmemName").val();
// 			var memPhone =$("#findmemPhone").val();
			
// 			var sendData="memName="+memName+'&memPhone='+memPhone;
			
			
// 			$.ajax({
// 				url : "findId",
// 				method : "post",
// 				data : sendData,
// 				dataType : "text",
// 				success : function(text) {
// 					if (text != null) {
// 						$("#result_id").html("아이디 = "+text);
// 					} else {
// 						$("#result_id").html("해당정보가 없습니다.");
// 					}
// 				},
// 				error : function(xhr) {
// 					alert("에러코드 = " + xhr.status);
// 				}
// 			});
// 		}		
		
})		
		
</script>
</html>
