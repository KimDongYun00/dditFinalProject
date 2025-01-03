<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">시설관리</h4>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">시설등록</h5>
				<hr class="my-0">
				
				<div class="col-11 text-center" style="height:300px;">										
						<img alt="이미지삽입" src="${pageContext.request.contextPath }/resources/images/기본 이미지.jpg" id="thumImg" style="height:280px;">					
				</div>
				
				<hr class="my-0">
				<div class="card-body">
					<form action="/admin/facInsert" method="post" id="formData" enctype="multipart/form-data">
						<sec:csrfInput/>			
						
								<label class="custom-file-label" for="imgFile">썸네일 이미지를 선택해주세요</label>
								<input type="file" name="imgFile" id="imgFile" class="form-control" >
										
						<div class="row mb-3">
							<!-- 아마도 여기에 프로필 이미지 삽입 -->						
							<label class="col-sm-2 col-form-label" for="facTypeNo"><font size="4">시설타입</font></label>
							<div class="col-sm-10">
								<div class="form-controller">
									
										<select name="facTypeNo" id="selectType" class="form-select">
											<option>전체</option>
											<option value="1" <c:if test="${facTypeNo eq '1' }">selected</c:if>>강의실</option>
											<option value="2" <c:if test="${facTypeNo eq '2' }">selected</c:if>>회의실</option>
											<option value="3" <c:if test="${facTypeNo eq '3' }">selected</c:if>>운동시설</option>
											<option value="4" <c:if test="${facTypeNo eq '4' }">selected</c:if>>사무실</option>
										</select>
																		
								</div>
							</div>
							
							<label class="col-sm-2 col-form-label" for="facName"><font size="4">시설명</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="facName" id="facName">
							</div>
							
							<label class="col-sm-2 col-form-label" for="buiNo"><font size="4">건물 선택</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="buiNo" id="buiNo">
								<c:forEach items="${build }" var="building">
									<option value="${building.buiNo }">${building.buiName }</option>								
								</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="facMax"><font size="4">사용인원</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="facMax" id="facMax" placeholder="숫자만입력해주세요">
							</div>
							
						</div>
					</form>
				</div>
				<hr class="my-0">
				<div class="card-footer">
					<!-- 목록 버튼 -->
					<button type="button" class="btn btn-primary" id="listBtn">목록</button>
					<!-- 등록 버튼 -->
					<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	var listBtn = $("#listBtn");
	var insertBtn = $("#insertBtn");
	var imgFile = $("#imgFile");
	var thumImg = $("#thumImg");
	var selectType = $("#selectType");
	
	
	listBtn.on("click", function(){
		location.href="/admin/facList";
	})
	
	insertBtn.on("click", function(){
		facMax = $("#facMax").val();
		numberCheck = /[0-9]/;
		if(!numberCheck.test(facMax) ){
			alert("사용인원은 숫자만 입력 가능합니다.");
			return false;
		}
		if($("#selectType option:checked").text() == '전체'){
			alert("시설타입을 선택해 주세요!");
			return false;
		}
		
		
		$("#formData").submit();
	})
	
	// 프로필 이미지 선택 이벤트(Open파일을 통해 이미지 파일을 선택하면 이벤트 발생)
	imgFile.on("change", function(event){
		var file = event.target.files[0];	// 내가 선택한 파일(우리는 이미지)가 담겨있다.
		
		if(isImageFile(file)){	// 이미지 파일이라면
			var reader = new FileReader();
			reader.onload = function(e){
				// 프로필 이미지 Element에 src 경로로 result를 셋팅한다.
				// 이미지 파일 데이터가 base64인코딩 형태로 변형된 데이터가 src경로에 설정된다.
				thumImg.attr("src", e.target.result);
			}
			reader.readAsDataURL(file);		// base64인코딩된 설정된 값으로 reader.onload에서 꺼내준다.
		}else{	// 이미지 파일이 아니라면
			alert("이미지 파일을 선택해 주세요,..");
		}
	});
	
	// 이미지 파일인지 체크
	function isImageFile(file){
		var ext = file.name.split(".").pop().toLowerCase();		// 파일명에서 확장자를 가져온다.
		return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;	
		
		// 3항연산자.. ? 앞에 ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) 조건문이 참이면
		// 이미지파일이 아니라는 것이니 (===-1이 배열내에서 아무것도 존재하지 않을때 리턴하는 값이라 함) :기준으로 앞에있는 값이 리턴
		// 조건문이 거짓이면 : 기준으로 뒤에있는 true를 반환
	}
</script>