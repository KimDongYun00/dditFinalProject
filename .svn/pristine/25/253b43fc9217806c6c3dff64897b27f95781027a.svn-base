<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 재설정</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <meta id="_csrf" name="_csrf" content="${_csrf.token }">
	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">
	
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <style>
    	 body {
            margin: 0;
            padding: 0;
            background: url('/resources/images/메인페이지_대학 이미지.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
        }
        
    
    </style>
    <c:if test="${not empty msg }">
	    <script>    	
	    	alert("${msg}");
	    </script>
    </c:if>
</head>
<body class="d-flex justify-content-center align-items-center min-vh-100">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <div class="card">
          <div class="card-body">
            <h4 class="mb-2 text-center">비밀번호 재설정</h4>
            <form id="resetPwForm" action="/common/resetPassword" method="post">
            	<sec:csrfInput/>
              <div class="mb-3">
				<label for="tempPw" class="form-label">임시비밀번호</label>
				<input type="password" class="form-control" id="tempPw" name="tempPw" placeholder="임시비밀번호를 입력해주세요." required/>              	
              </div>	
              <div class="mb-3">
                <label for="newPassword" class="form-label">새 비밀번호</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="새 비밀번호를 입력해주세요." required/>
              </div>
              <div class="mb-3">
                <label for="confirmPassword" class="form-label">비밀번호 확인</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력해주세요." required/>
              </div>
              <input type="hidden" id="userId" name="userId" value="${userId}"/>
              <button type="button" id="submitBtn" class="btn btn-primary d-grid w-100" style="background-color: #193C77; border-color: none;">비밀번호 재설정</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
<c:if test="${not empty msg1 }">
<script type="text/javascript">
	swal("${msg1}", "${msg2}", "${msg3}");
</script>
</c:if>
<script type="text/javascript">
$(function() {
	token = $("meta[name='_csrf']").attr("content");
    header = $("meta[name='_csrf_header']").attr("content");
   
	var selectTempPw = "";
//     $.ajax({
// 		url : "/common/tempPwSel",
// 		type : "post",
// 		data : {userId : $("#userId").val()},
// 		beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
// 	         xhr.setRequestHeader(header, token);
// 	    },
// 	    success : function(res){
// 	    	selectTempPw = res.userPw;
// 	    }
// 	}); 뻘짓했다.    
    
    $("#submitBtn").on("click", function(e) {
        var newPassword = $("#newPassword").val();
        var confirmPassword = $("#confirmPassword").val();		
		
// 		if(selectTempPw !== $("#tempPw").val){
// 			swal("임시비밀번호", "발급된 임시비밀번호가 다릅니다. 다시 확인해주세요.", "error");
// 			e.preventDefault();
// 		} 복호화를해서 저기 뭐시기야 디비에서 비교 한다.
        if (newPassword !== confirmPassword) {
            swal("비밀번호","비밀번호가 일치하지 않습니다. 다시 확인해주세요.", "error");
            return false;
        }
        $("#resetPwForm").submit();
    });
});
</script>
</html>
