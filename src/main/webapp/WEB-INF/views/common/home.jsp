<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
  <title>로그인</title>

  <!-- Favicon -->
  <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />

  <!-- Icons. Uncomment required icon fonts -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/fonts/boxicons.css" />

  <!-- Core CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />

  <!-- Vendors CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/apex-charts/apex-charts.css" />

  <!-- Page CSS -->

  <!-- Helpers -->
  <script src="${pageContext.request.contextPath }/resources/assets/vendor/js/helpers.js"></script>

  <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
  <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
  <script src="${pageContext.request.contextPath }/resources/assets/js/config.js"></script>


    <meta charset="UTF-8">
    <title>대덕대학교 학사관리시스템</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: url('/resources/images/메인페이지_대학 이미지.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
        }
        .login-container {
            width: 700px;
            height: 400px;
            padding: 50px;
            background: rgba(255, 255, 255, 0.8);
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            text-align: center;
        }
        .login-container h2 {
            margin-top: 0;
            margin-bottom: 70px;
        }
        .login-container a {
            display: block;
            margin-top: 10px;
            text-align: center;
            color: #333;
            text-decoration: none;
        }
        .login-container a:hover {
            text-decoration: underline;
        }
        .announcement {
            margin-top: 20px;
        }
        .announcement li {
            list-style: none;
            margin-bottom: 10px;
        }
        
    </style>
</head>
<body>
    <div class="login-container">
        <h2>대덕대학교 학사관리시스템</h2>
            <button  type="button" onclick="location.href='/common/login'" class="btn btn-primary d-grid w-100">로그인</button>
        <div class="announcement">
            <h3>공지사항</h3>
            <ul>
            	<c:forEach items="${resultBoard }" var="board">
	                <li>
	                	<a href="/admin/detail{${board.boNo }}">
	                		${board.boTitle }
	                	</a>	                	
	                </li>            	
            	</c:forEach>
                
            </ul>
        </div>
    </div>
</body>
</html>