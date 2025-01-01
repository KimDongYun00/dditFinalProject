<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>아이디/비밀번호 찾기</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/images/대덕대학교로고_아이콘.ico" />
	
 <style>
        @font-face {
            font-family: 'Jal_Haru';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.0/Jal_Haru.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
        body {
            margin: 0;
            padding: 0;
            background: url('/resources/images/메인페이지_대학 이미지.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Jal_Haru', sans-serif; /* 폰트 적용 */
        }
        .bottom-center {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
        }
        .card-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
        }
        .card {
            margin: 10px;
            flex: 1 1 45%;
            border-radius: 15px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .white-section {
            background-color: white;
            padding: 20px;
            border-radius: 15px;
            margin-top: 20px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            display: flex;
            justify-content: center;
            align-items: center;
        }
        #goBackToLogin {
            width: 260px;
            float: right;
		    position: relative;
		    left: -40%;
        }
        #findPwBtn{
        	float: right;
		    position: relative;
		    left : 20%;		  
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center min-vh-100">

    <div class="container">
        <div class="row justify-content-center card-container">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h4 class="mb-2 text-center">아이디 찾기</h4>
                        <form id="findIdForm" action="/common/findId" method="post">
                            <div class="mb-3">
                                <label for="userType" class="form-label">사용자 유형</label>
                                <select class="form-select" id="userType" name="userType">
                                    <option value="student">학생</option>
                                    <option value="professor">교수</option>
                                    <option value="admin">교직원</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="userName" class="form-label">이름</label>
                                <input type="text" class="form-control" id="userName" name="userName" placeholder="예)홍길동" />
                            </div>
                            <div class="mb-3">
                                <label for="userBirth" class="form-label">생년월일</label>
                                <input type="text" class="form-control" id="userBirth" name="userBirth" placeholder="예)950921" />
                            </div>
                            <div class="mb-3">
                                <label for="userEmail" class="form-label">이메일</label>
                                <input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="예)email@example.com" />
                            </div>
                            <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}" />                            
                            <button type="submit" class="btn btn-primary d-grid w-100">아이디 찾기</button>                            
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h4 class="mb-2 text-center">비밀번호 찾기</h4>
                        <form id="findPwForm" action="/common/findPw" method="post">
                            <div class="mb-3">
                                <label for="pwUserType" class="form-label">사용자 유형</label>
                                <select class="form-select" id="pwUserType" name="userType">
                                    <option value="student">학생</option>
                                    <option value="professor">교수</option>
                                    <option value="admin">교직원</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="pwUserId" class="form-label">학번/사번</label>
                                <input type="text" class="form-control" id="pwUserId" name="userId" placeholder="예)202403123" />
                            </div>
                            <div class="mb-3">
                                <label for="pwUserBirth" class="form-label">생년월일</label>
                                <input type="text" class="form-control" id="pwUserBirth" name="userBirth" placeholder="예)950921" />
                            </div>
                            <div class="mb-3">
                                <label for="pwUserEmail" class="form-label">이메일</label>
                                <input type="text" class="form-control" id="pwUserEmail" name="userEmail" placeholder="예)email@example.com" />
                            </div>
                            <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-primary d-grid w-100">비밀번호 찾기</button>
                        </form>
                    </div>
                </div>
            </div>
            <br><hr>
        <div class="">    
	         <button style="float: left;" id="findIdBtn" class="btn btn-primary">시연용</button>   
	         <button type="button" id="goBackToLogin" class="btn btn-dark" onclick="location.href='/common/login'">로그인 화면으로 돌아가기</button>
	         <button id="findPwBtn" class="btn btn-primary">시연용</button>
	    </div>     
        </div>
    </div>
</body>
<script type="text/javascript">
$(function(){
	$("#findIdBtn").click(function(){
		$("#userName").val("김동윤");
		$("#userBirth").val("001117");
		$("#userEmail").val("rasbet3@naver.com");		
	})
	$("#findPwBtn").click(function(){
		$("#pwUserId").val("20220001");
		$("#pwUserBirth").val("001117");
		$("#pwUserEmail").val("rasbet3@naver.com");		
	})
})
</script>
</html>
