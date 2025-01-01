<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>


<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-sm-4">
			<div class="card mb-4">
				<div class="card-header d-flex align-items-center justify-content-between">
					 <img class="col-sm-12" src="${pageContext.request.contextPath }${stuVO.stuImg}" id="thumImg" alt="프로필이미지" style="height: 400px;">
				</div>
				<div class="card-body">
					<div class="row mb-3">					
						<table class="col-sm-11 table table-borderless">
							<tbody>
								<tr>
									<td class="text-end" style="width:25%;"><small class="text-light fw-semibold">이름</small></td>
									<td class="py-3"><p class="mb-0">${stuVO.stuName }</p></td>
								</tr>
								<tr>	
									<td class="text-end"><small class="text-light fw-semibold">학번</small></td>
									<td class="py-3"><p class="mb-0">${stuVO.stuNo }</p></td>
								</tr>
								<tr>	
									<td class="text-end"><small class="text-light fw-semibold">학과</small></td>
									<td class="py-3"><p class="mb-0">${stuVO.deptName }</p></td>
								</tr>
								<tr>	
									<td class="text-end"><small class="text-light fw-semibold">학년</small></td>
									<td class="py-3"><p class="mb-0">${stuVO.stuYear } 학년</p></td>
								</tr>
								<tr>	
									<td class="text-end"><small class="text-light fw-semibold">전화번호</small></td>
									<td class="py-3"><p class="mb-0">${stuVO.stuPhone }</p></td>
								</tr>
								<tr>	
									<td class="text-end"><small class="text-light fw-semibold">주소</small></td>
									<td class="py-3"><p class="mb-0">${stuVO.stuAdd1 } ${stuVO.stuAdd2 }</p></td>
								</tr>
								<tr>	
									<td class="text-end"><small class="text-light fw-semibold">이메일</small></td>
									<td class="py-3"><p class="mb-0">${stuVO.stuEmail }</p></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-8">
			
           <div class="card">
             <h5 class="card-header">정보수정</h5>
             <hr class="my-0">
             <div class="card-body">
                    <form action="/admin/stuUpdate" method="post" enctype="multipart/form-data" id="formData">
                      <sec:csrfInput/>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="basic-default-name"><font size="3">프로필사진</font></label>
                          <div class="col-sm-10">
                            <input type="file" class="form-control" name="imgFile" id="imgFile"/>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="basic-default-name"><font size="3">학번/사번</font></label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control" name="stuNo" id="basic-default-name" value="${stuVO.stuNo }" readonly />
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="basic-default-company"><font size="3">학과</font></label>
                          <div class="col-sm-10">
                          
                           <select name="deptNo" class="form-select">
                           		
                           		<c:forEach items="${deptList }" var="dept">
                           		<option value="${dept.deptNo }" <c:if test="${stuVO.deptNo eq dept.deptNo }">selected</c:if>>${dept.deptName }</option>
                           		</c:forEach>
                           </select>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="basic-default-email"><font size="3">Email</font></label>
                          <div class="col-sm-10">
                            <div class="input-group input-group-merge">
                              <input
                                type="text"
                                id="basic-default-email"
                                class="form-control"
                                name="stuEmail" value="${stuVO.stuEmail }"
                              />
                              <span class="input-group-text" id="basic-default-email2">@gmail.com</span>
                            </div>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="basic-default-phone"><font size="3">전화번호</font></label>
                          <div class="col-sm-10">
                            <input
                              type="text"
                              id="basic-default-phone"
                              class="form-control phone-mask"
                              name="stuPhone" value="${stuVO.stuPhone }"
                            /> 
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="postCode"><font size="3">우편번호</font></label>
                          <div class="col-sm-3">
                            <input
                              id="postCode"
                              class="form-control"     
                              type="text"
                              name="stuPostcode" value="${stuVO.stuPostcode }"
                            ></input>
                          </div>
                          <div class="col-sm-3">
                          	<input type="button" value="우편번호찾기" id="postFind" class="btn btn-primary" onclick="sample6_execDaumPostcode()">
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="add1"><font size="3">주소</font></label>
                          <div class="col-sm-10">
                            <input
                              id="add1"
                              class="form-control"
                              type="text"
                               name="stuAdd1" value="${stuVO.stuAdd1 }"
                            ></input>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="add2"><font size="3">상세주소</font></label>
                          <div class="col-sm-10">
                            <input
                              id="add2"
                              class="form-control"        
                              type="text"
                              name="stuAdd2" value="${stuVO.stuAdd2 }"
                            ></input>
                          </div>
                        </div>
                        
                        <!-- 학생이 개인정보 수정할때는 필요 없는 기능 -->
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="deptNo"><font size="3">학적상태</font></label>
                          <div class="col-sm-10">
                            <select name=comDetMNo class="form-select" id="deptNo">
                            	<c:forEach items="${stuMCode }" var="MCode">
                            		<option value="${MCode.comDetNo }" <c:if test="${stuVO.comDetMNo eq MCode.comDetNo}">selected</c:if>>${MCode.comDetName }</option>
                            	</c:forEach>
                            </select>
                          </div>
                        </div>
                        <!-- 학생이 개인정보 수정할때는 필요 없는 기능 -->
                        
                        
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="comDetBNo"><font size="3">은행</font></label>
                          <div class="col-sm-10">
                          	<select name="comDetBNo" class="form-select" id="deptNo">
                            	<c:forEach items="${bankList }" var="MCode">
                            		<option value="${MCode.comDetNo }" <c:if test="${stuVO.comDetMNo eq MCode.comDetNo}">selected</c:if>>${MCode.comDetName }</option>
                            	</c:forEach>
                            </select>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="stuAccount"><font size="3">계좌번호</font></label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control" id="stuAccount" name="stuAccount" value="${stuVO.stuAccount }">
                          </div>
                        </div>
                        
                        
                        <div class="row justify-content-end">
                          <div class="col-sm-10">
                            <button type="button" id="modifyBtn" class="btn btn-primary">수정하기</button>
                            <button type="button" id="deleteBtn" class="btn btn-danger">삭제하기</button>
                            <button type="button" id="listBtn" class="btn btn-primary">목록으로</button>
                          </div>
                        </div>
                      </form>
                      <form action="/admin/stuDelete" method="post" id="deleteForm">
                      	<sec:csrfInput/>
                      	<input type="hidden" name="stuNo" value="${stuVO.stuNo }">
                      </form>
                    </div>
           </div>
         </div>
              
		</div>
	</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
	var modifyBtn = $("#modifyBtn");
	var listBtn = $("#listBtn");
	var formData = $("#formData");
	var imgFile = $("#imgFile");
	var thumImg = $("#thumImg");
	
	$("#deleteBtn").click(function(){
		if(confirm('정말로 삭제하시겠습니까?')){
			$("#deleteForm").submit();
		}
	})
	
	listBtn.click(function(){
		location.href="/admin/stuList";
	});

	modifyBtn.click(function(){
		phone = $("#basic-default-phone").val();
		if(phone == null || phone ==""){
			alert("전화번호를 입력해주세요.");
			return false;
		}
		
		formData.submit();
	});
	
	//프로필 이미지 선택 이벤트(Open파일을 통해 이미지 파일을 선택하면 이벤트 발생)
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
	
})


function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
        	// onclick시 상세주소 초기화
        	$("#add2").val("");
        	
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
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("add1").value = extraAddr;
            
            } else {
                document.getElementById("add1").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postCode').value = data.zonecode;
            document.getElementById("add1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("add2").focus();
        }
    }).open();
}


// 이미지 파일인지 체크
function isImageFile(file){
	var ext = file.name.split(".").pop().toLowerCase();		// 파일명에서 확장자를 가져온다.
	return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;	
	
	// 3항연산자.. ? 앞에 ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) 조건문이 참이면
	// 이미지파일이 아니라는 것이니 (===-1이 배열내에서 아무것도 존재하지 않을때 리턴하는 값이라 함) :기준으로 앞에있는 값이 리턴
	// 조건문이 거짓이면 : 기준으로 뒤에있는 true를 반환
}
</script>
