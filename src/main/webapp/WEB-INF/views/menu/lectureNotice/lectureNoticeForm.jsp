  <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<style type="text/css">
input{
	margin-bottom: 20px;
}
</style>
</head>
<body>
	
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">
			<!-- Form controls -->
			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-dark">
							<div class="card-header">
								<h3 class="card-title">강의공지등록</h3>
								<div class="card-tools"></div>
							</div>
							<form id="insertForm">
								<input type="hidden" name="lecNo" value="${param.lecNo }">
							
								<div class="card-body">
									<div class="form-group">
										<label>공지명</label> 
										<input type="text" id="lecNotTitle" name="lecNotTitle" class="form-control"
											placeholder="제목을 입력해주세요" value="" required >
									</div>
									
									<div class="form-group">
										<label>내용</label>
										<textarea id="lecNotContent" name="lecNotContent" class="form-control" rows="14" required ></textarea>
									</div>
								</div>
								<sec:csrfInput />
							<div class="card-footer bg-white">
								<div class="row">
									<div class="col-12">
										<!-- 멋진 이철희 교수님꺼 -->
<!-- 										<input type="submit" value="저장" id="addBtn" class="btn btn-primary float-right"> -->
										<input type="button" value="저장" id="insertBtn" class="btn btn-primary float-right" />
										<input type="button" value="목록" id="listBtn" class="btn btn-secondary float-right">
									</div>
								</div>
							</div>
						 </form>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	<script>
		// 전역 변수/ 전역 함수 선언
		const header = '${_csrf.headerName}';
		const token =  '${_csrf.token}';
		const insertForm = document.querySelector("#insertForm"); // $("#insertForm")[0]
		const listBtn = $("#listBtn");
		const addBtn = $("#addBtn");
		const cancelBtn = $("#cancelBtn");

		// submit 버튼 누르면 발생
		insertForm.onsubmit = function(){
			event.preventDefault();  // 일단 전송 막기
			var content = CKEDITOR.instances.lecNotContent.getData();
			if(!content.trim()){
				alert("내용을 입력해주세요!");
				CKEDITOR.instances.lecNotContent.focus();
				return;
			}

			alert("체에킁!!!");
			
			var params = params = $("#insertForm").serialize();
			
			// AJAX
			$.ajax({
				type:"post",
				url:"/lectureNotice/insertLectureNotice.do",
				contentType:"application/json;charset=utf-8",
				data:params,
				dataType:"text",             // JSON.parse(서버가돌려준값)
				beforeSend: function(xhr) {
            		xhr.setRequestHeader(header, token);
    			},
				success:function(res){
					console.log("체크:",res)
				
				},
				error: function (xhr, status, error) {
        			console.log("code: " + xhr.status)
        			console.log("message: " + xhr.responseText)
        			console.log("error: " + error);
    			}
			})
		}
		
		//document 내의 모든 요소가 메모리에 올라간 후에 실행
		$(function(){
			CKEDITOR.replace("lecNotContent", {
				//filebrowserUploadUrl: '${pageContext.request.contextPath}/imageUpload.do?${_csrf.parameterName}=${_csrf.token}'
			});
			CKEDITOR.config.height = "350px";
			
			
			/*
			//강의공지사항 등록(비동기)
			//뷰(JSP)에서 비동기로 Controller로 요청 시 JSON타입의 string으로 옴 -> 받으려면 RequestBody -> return도 JSON으로 : ResponseBody
			*/
			$("#insertBtn").on("click",function(){
				console.log("개똥이");
				
				//공지명
				let lecNotTitle = $("#lecNotTitle").val();
				//ckeditor 안에 있는 내용을 태그 포함해서 다 가져오기
				let lecNotContent = CKEDITOR.instances.lecNotContent.getData();
				// param : ?lecNo=L0103
				// param.lecNo : L0103
				let lecNo = $("input[name='lecNo']").val();
				
				//JSON오브젝트
				let data = {
					"lecNo":lecNo,
					"lecNotTitle":lecNotTitle,
					"lecNotContent":lecNotContent
				};
				//오브젝트는 ,
				/*
				{"lecNo": "L0103","lecNotTitle": "aaa","lecNotContent": "<p>asdf</p>\n"}
				*/
				console.log("data : ", data);
				
				//아작나써유..(피)씨다타써
				//가는타입 : contentType
				//오는타입 : dataType 
				$.ajax({
					url:"/lectureNotice/insertLectureNoticeAjax.do",
					contentType:"application/json;charset=utf-8",
					data:JSON.stringify(data),
					type:"post",
					dataType:"json",
					success:function(result){
						//result의 타입 : LectureNoticeVO
						/*
						{"lecNotNo": LEC_NOT_20240031,"lecNo": "L0103","lecNotTitle": "aaa","lecNotContent": "<p>asdf</p>\n",
						    "lecNotDate": null,"lecNotCnt": 0,"rnum": 0}
						*/
						console.log("result : ", result);
						
						location.href="/lectureNotice/selectLectureNoticeDetail.do?lecNotNo="+result.lecNotNo+"&lecNo="+result.lecNo;
					}
				});
			});
			
			/*
			addBtn.on("click", function(){
				var title = $("#lecNotTitle").val();
				var content = CKEDITOR.instances.lecNotContent.getData();
				
				if(title == null || title == ""){
					alert("제목을 입력해주세요!");
					$("#assTitle").focus();
					return false;
				}
				
				if(content == null || content == ""){
					alert("내용을 입력해주세요!");
					$("#assContent").focus();
					return false;
				}
				
				if($(this).val() == "수정"){
					assignForm.attr("action", "/professor/updateAssignment.do");
				}
				
				assignForm.submit();
			});
			*/   
			
			
			listBtn.on("click", function(){
				location.href = "/lectureNotice/selectLectureNotice.do?lecNo=${param.lecNo}";
			});
			
		});
		</script>
</body>
</html>