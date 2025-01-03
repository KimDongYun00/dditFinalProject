<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 -->
	<sec:authentication property="principal.user" var="user" />
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보수정</title>
</head>
<body>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-3">
							<div class="card card-dark card-outline">
								<div class="card-header">
									<div class="card-title">
										<h4>내정보</h4>
									</div>
								</div>
								<div class="card-body">
									<div class="position-relative">
										<img id="profileImg"
											src="${pageContext.request.contextPath }${profVO.proImg }"
											alt="Photo 1" class="img-fluid">
										<div class="ribbon-wrapper ribbon-lg">
											<div class="ribbon bg-success text-lg">Profile</div>
										</div>
									</div>
									<div class="row mt-4">
										<div class="col-md-4 text-bold">교번</div>
										<div class="col-md-8">
											<sec:authentication property="principal.user.userNo" />
										</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">이름</div>
										<div class="col-md-8">${profVO.proName}</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">성별</div>
										<div class="col-md-8">${profVO.comDetGNo}</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">생년월일</div>
										<c:set value="${profVO.proRegno}" var="proBir"></c:set>
										<div class="col-md-8">${fn:substring(proBir,0,5) }</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">입사일자</div>
										<div class="col-md-8">${profVO.proSdate}</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">소속</div>
										<div class="col-md-8">${profVO.deptName}</div>
									</div>
									<div class="row mt-2">
										<c:set value="${profVO.comDetPNo}" var="comProDep" />
										<div class="col-md-4 text-bold">직위</div>
										<c:choose>
											<c:when test="${comProDep eq 'P0201' }">
												<div class="col-md-8">학과장</div>
											</c:when>
											<c:when test="${comProDep eq 'P0202' }">
												<div class="col-md-8">단과대장</div>
											</c:when>
											<c:otherwise>
												<div class="col-md-8"></div>
											</c:otherwise>
										</c:choose>

									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">학과 전화번호</div>
										<div class="col-md-8">${proDep.deptCall}</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9">
							<div class="card card-dark card-outline">
								<div class="card-header">
									<div class="row">
										<div class="col-md-10">
											<h4>개인정보 수정</h4>
										</div>
										<div class="col-md-2" align="right">
											<button type="button" class="btn btn-info" id="modifyBtn">수정하기</button>
										</div>
									</div>
								</div>
								<div class="card-body">
									<div class="tab-content">
										<div class="tab-pane active">
											<form id="submitForm" class="form-horizontal"
												action="/professor/profileUpdate.do"
												enctype="multipart/form-data" method="post">
												<input type="hidden" name="proNo"
													value="${profVO.proNo }">
												<div class="form-group row mb-3">
													<label class="col-sm-2 col-form-label">프로필이미지</label>
													<div class="col-md-10">
														<div class="custom-file">
															<input type="file" class="custom-file-input" id="imgFile"
																name="proFile">
														</div>
													</div>
												</div>
												<div class="form-group row mb-3">
													<label for="proEmail" class="col-sm-2 col-form-label">이메일</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="proEmail"
															name="proEmail" value="${profVO.proEmail}"
															placeholder="이메일을 입력해주세요.">
													</div>
												</div>
												<div class="form-group row mb-3">
													<label for="proPhone" class="col-sm-2 col-form-label">연락처</label>
													<div class="col-sm-10">
														<input type="tel" class="form-control" id="proPhone"
															name="proPhone" value="${profVO.proPhone}"
															placeholder="전화번호를 입력해주세요.">
													</div>
												</div>
												<div class="input-group mb-3">
													<label for="inputSkills" class="col-sm-2 col-form-label">주소</label>
													<div class="col-sm-10">
														<div class="input-group mb-3">
															<input type="text" class="form-control"
																value="${profVO.proPostcode}" id="proPostCode"
																name="proPostcode" placeholder="우편번호를 입력해주세요"> <span
																class="input-group-append">
																<button type="button" onclick="DaumPostcode()"
																	class="btn btn-secondary btn-flat">우편번호 찾기</button>
															</span>
														</div>
														<div class="input-group mb-3">
															<input type="text" class="form-control" id="proAdd1"
																name="proAdd1" value="${profVO.proAdd1}"
																placeholder="주소를 입력해주세요">
														</div>
														<div class="input-group mb-3">
															<input type="text" class="form-control" id="proAdd2"
																name="proAdd2" value="${profVO.proAdd2}"
																placeholder="상세주소를 입력해주세요">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label for="comDetBNo" class="col-sm-2 col-form-label">은행명</label>
													<c:set value="${profVO.comDetBNo }" var="bankNo" />
													<div class="col-sm-10">
														<select id="comDetBNo" name="comDetBNo" class="form-select">
															<option value="B0101"
																<c:if test="${bankNo eq 'B0101'}">selected</c:if>>국민</option>
															<option value="B0102"
																<c:if test="${bankNo eq 'B0102'}">selected</c:if>>우리</option>
															<option value="B0103"
																<c:if test="${bankNo eq 'B0103'}">selected</c:if>>신한</option>
															<option value="B0104"
																<c:if test="${bankNo eq 'B0104'}">selected</c:if>>농협</option>
														</select>
													</div>
												</div>
												<div class="form-group row">
													<label for="proAccount" class="col-sm-2 col-form-label">계좌번호</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="proAccount"
															name="proAccount" value="${profVO.proAccount}"
															placeholder="계좌번호를 입력해주세요.">
													</div>
												</div>
												<font color="red" id="errorText"></font>
												<sec:csrfInput />
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=665ba624d5aa4e2ea97e404ac484531f&libraries=services"></script>
<script type="text/javascript">
	$(function() {
		var imgFile = $("#imgFile"); // 프로필 이미지 선택 Element
		var profileImg = $("#profileImg"); // 프로필 이미지 태그
		var modifyBtn = $("#modifyBtn");
		var submitForm = $("#submitForm");

		modifyBtn.on("click", function() {
			var proEmail = $("#proEmail").val();
			var proPhone = $("#proPhone").val();
			var proPostCode = $("#proPostCode").val();
			var proAdd2 = $("#proAdd2").val();
			//		var comDetBNo = $("#comDetBNo").val(); 
			var proAccount = $("#proAccount").val();

			console.log("aaaaa")
			if (proEmail == null || proEmail == "") {
				$("#errorText").html("이메일을 입력해주세요!");
				return false;
			}
			if (proPhone == null || proPhone == "") {
				$("#errorText").html("연락처를 입력해주세요!");
				return false;
			}
			if (proPostCode == null || proPostCode == "") {
				$("#errorText").html("우편번호를 입력해주세요!");
				return false;
			}
			if (proAdd2 == null || proAdd2 == "") {
				$("#errorText").html("상세주소를 입력해주세요!");
				return false;
			}
			if (proAccount == null || proAccount == "") {
				$("#errorText").html("계좌번호를 입력해주세요!");
				return false;
			}
			alert("수정을 완료하였습니다!");
			submitForm.submit();
		})

		//프로필 이미지 선택 이벤트 (Open 파일을 통해 이미지 파일을 선택하면 이벤트 발생)
		imgFile.on("change", function(event) {
			var file = event.target.files[0]; // 내가 선택한 파일
			console.log(file)

			if (isImageFile(file)) {// 이미지 파일이라면
				var reader = new FileReader();
				reader.onload = function(e) {
					// 프로필 이미지 Element 에 src 경로로 result 를 셋팅한다.
					// 이미지 파일 데이터가 base64인코딩 형태로 변형된 데이터가 src 경로에 설정된다.
					profileImg.attr("src", e.target.result)
				}
				reader.readAsDataURL(file);
			} else {// 이미지 파일이 아니라면
				alert("이미지 파일을 선택해주세요!");
			}
		});
	});
	// 이미지 파일인지 체크
	function isImageFile(file) {
		var ext = file.name.split(".").pop().toLowerCase(); // 파일명에서 확장자를 가져온다. 
		return ($.inArray(ext, [ "jpg", "jpeg", "gif", "png" ]) === -1) ? false
				: true;
	}
	function DaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}

				}
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('proPostCode').value = data.zonecode;
				document.getElementById("proAdd1").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("proAdd2").focus();
			}
		}).open();
	}
</script>
</html>