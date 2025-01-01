<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="card mb-4 bg-white">
			<h5 class="card-header">인원관리 > 교수등록</h5>
			<div class="col-sm-3">
				<select id="selectbox" class="form-select">
					<option value="stu">학생</option>
					<option selected>교수</option>
					<option value="admin">직원</option>
				</select>
			</div>
			<hr class="my-0">
			<div class="card-body">
				<div class="table-responsive text-nowrap"  style="overflow:hidden;">
					<form action="/admin/proInsert" method="post" id="insertForm" >	
					<sec:csrfInput/>
						<div class="row mb-3">							
							
							<label class="col-sm-2 col-form-label" for="proNo"><font size="4">아이디</font></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="proNo" id="proNo">
								<font id="idCheck"></font>
							</div>
							<div class="col-sm-2">
								<input type="button" id="idCheckBtn" value="중복체크" class="btn btn-primary">
							</div>
							
							<label class="col-sm-2 col-form-label" for="proName"><font size="4">이름</font></label>
							<div class="col-sm-10">								
								<input type="text" class="form-control" name="proName" id="proName">
							</div>
														
							<label class="col-sm-2 col-form-label" for="deptNo"><font size="4">학과</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="deptNo" id="deptNo">
									<c:forEach items="${deptList }" var="dept">
										<option value="${dept.deptNo }">${dept.deptName }</option>
									</c:forEach>
								</select>
							</div>

							
							<label class="col-sm-2 col-form-label" for="comDetGNo"><font size="4">성별</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="comDetGNo" id="comDetGNo">
										<option value="G0101" class="facOption">남자</option>
										<option value="G0102" class="facOption">여자</option>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="proRegno"><font size="4">주민번호</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="proRegno" id="proRegno" placeholder="000000-0000000" oninput="hypenReg(this)" maxlength="14">
							</div>										
						
							<label class="col-sm-2 col-form-label" for="proPostcode"><font size="4">우편번호</font></label>
							<div class="col-sm-7">
								<input type="text" class="form-control" name="proPostcode" id="proPostcode">
							</div>
							<div class="col-sm-3">
								<input type="button" class="btn btn-primary" onclick="sample6_execDaumPostcode()" value="우편번호검색">
							</div>
						
							<label class="col-sm-2 col-form-label" for="proAdd1"><font size="4">주소</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="proAdd1" id="proAdd1">
							</div>
							
							<label class="col-sm-2 col-form-label" for="proAdd2"><font size="4">상세주소</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="proAdd2" id="proAdd2">
							</div>
							
							<label class="col-sm-2 col-form-label" for="proPhone"><font size="4">전화번호</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="proPhone" id="proPhone" placeholder="010-0000-0000" oninput="hypenTel(this)" maxlength="13">
							</div>
							<label class="col-sm-2 col-form-label" for="stuEmail"><font size="4">이메일</font></label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="proEmail" id="proEmail">
							</div>
							
							<label class="col-sm-2 col-form-label" for="comDetBNo"><font size="4">은행</font></label>
							<div class="col-sm-10">
								<select class="form-select" name="comDetBNo" id="comDetBNo">
									<c:forEach items="${bankList }" var="bank">
									<option value="${bank.comDetNo }">${bank.comDetName }</option>
									</c:forEach>
								</select>
							</div>
							
							<label class="col-sm-2 col-form-label" for="proAccount"><font size="4">계좌</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="proAccount" id="proAccount">
							</div>
							
							<label class="col-sm-2 col-form-label" for="proSdate"><font size="4">입사일자</font></label>
							<div class="col-sm-10">
								<input type="date" class="form-control" name="proSdate" id="proSdate">
							</div>
						</div>
					</form>
					<div align="right">
						<input type="button" id="insertBtn" value="등록" class="btn btn-primary">						
						<input type="button" id="listBtn" value="목록" class="btn btn-primary">
					</div>					
				</div>
			</div>
			
		</div>
	</div>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
	var insertBtn = $("#insertBtn");
	var idCheckBtn = $("#idCheckBtn");
	var listBtn = $("#listBtn");
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	
	listBtn.click(function(){
		location.href="/admin/proList";
	});
	// 아이디 중복체크
	idCheckBtn.click(function(){
		var proNo = $("#proNo").val();		

		$.ajax({
			url : "/admin/idCheck",
			type : "post",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		         xhr.setRequestHeader(header, token);
		    },
			data : {proNo : proNo},
			success : function(res){				
				$("#idCheck").html("사용이 가능한 아이디입니다.").css("color", "green");
				flag = true;
			},
			error : function(xhr){
				$("#idCheck").html("이미 사용중인 아이디 입니다.").css("color", "red");
				flag = false;
			}
		});
		
		
	});
	
	insertBtn.click(function(){
		name = $("#proName").val();
		if(name == "" || name == null){
			alert("이름을 입력해 주세요.");
			return false;
		}
		
		// 010-0000-0000
		let phone = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		proPhone = $("#proPhone").val();
		if(!phone.test(proPhone)){
			alert("전화번호 형식이 올바르지 않습니다. 다시 입력해주세요.");
			return false;
		}
		
		proAccount= $("#proAccount").val();
		if(proAccount == "" || proAccount == null){
			alert("계좌번호를 입력해 주세요.");
			return false;
		}
		
		$("#insertForm").submit();
		
	});
	
	$("#selectbox").on("change", function(){
		if($("#selectbox option:selected").text() == "학생"){
			location.href="/admin/stuInsertForm";
		}	
		if($("#selectbox option:selected").text() == "직원"){
			location.href="/admin/empInsertForm";
		}	
	})
})
const hypenReg = (target) => {
	target.value = target.value
	.replace(/[^0-9]/g, '')
	.replace(/^(\d{0,6})(\d{0,7})$/g, '$1-$2')
	.replace(/-{1,2}$/g, '');
}

// 다음 우편번호
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
        	// onclick시 상세주소 초기화
        	$("#proAdd2").val("");
        	
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
                document.getElementById("proAdd1").value = extraAddr;
            
            } else {
                document.getElementById("proAdd1").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('proPostcode').value = data.zonecode;
            document.getElementById("proAdd1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("proAdd2").focus();
        }
    }).open();
}

const hypenTel = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}
</script>