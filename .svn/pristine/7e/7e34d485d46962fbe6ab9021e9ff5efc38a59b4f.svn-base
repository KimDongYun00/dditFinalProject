<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<form action="/student/volunteerInsert" method="post" id="formData" enctype="multipart/form-data">
	<input type="hidden" name="volNo" value="${volunteerVO.volNo }">
	<input type="hidden" name="fileGroupNo" value="${volunteerVO.fileGroupNo }">
	<sec:csrfInput/>
	<div class="card">
		<h4 class="card-header">봉사 > 봉사신청</h4>
		<div class="row mb-3">
			<div class="col-6">
				<div class="card mb-4">
					<h5 class="card-header">봉사신청</h5>
					<div class="card-body">
						<label class="col-2 col-form-label" for="stuNo"><font size="4">아이디</font></label>
						<div class="col-10">						
							<input type="text" class="form-control" name="stuNo" id="stuNo"
								value="${stuVO.stuNo }" readonly="readonly">
						</div>					
						
						<label class="col-2 col-form-label" for="stuName"><font size="4">이름</font></label>
						<div class="col-10">						
							<input type="text" class="form-control" name="stuName" id="stuName"
								value="${stuVO.stuName }" readonly="readonly">
						</div>					
						
						<label class="col-2 col-form-label" for="volName"><font size="4">봉사명</font></label>
						<div class="col-10">
							<input type="text" class="form-control" name="volName" id="volName" value="${volunteerVO.volName }">
						</div>
						<label class="col-2 col-form-label" for="volContent"><font size="4">봉사내용</font></label>
						<div class="col-10">
							<textarea rows="10" class="form-control" name="volContent" id="volContent">${volunteerVO.volContent }</textarea>
						</div>
						
						<label class="col-2 col-form-label" for="lecMax"><font size="4">파일첨부</font></label>
						<div class="col-sm-10">
							<input type="file" class="form-control" name="lecFile" id="lecFile">
						</div>
						<div class="row mb-3">
							<c:if test="${empty fileList }">
								<label class="col-sm-12 col-form-label" id="fileLabel">							
									<a class="link-primary" href="#">											 
									</a>
								</label>									
							</c:if>
							<c:if test="${not empty fileList }">
								<c:forEach items="${fileList }" var="file">
									<label class="col-sm-12 col-form-label" id="fileLabel">
										첨부파일 : 
										<a class="link-primary" href="/common/fileDownload.do?fileGroupNo=${file.fileGroupNo }&fileNo=${file.fileNo}&${_csrf.parameterName}=${_csrf.token}">
											${file.fileName} 
										</a>										
									</label>						
								</c:forEach>							
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card mb-4">
					<div class="card-header"> 
						<c:if test="${not empty volunteerVO.comDetCNo}">
							<label class="col-12 col-form-label"><font size="4">상태 : <c:if test="${volunteerVO.comDetCNo eq 'C0101'}">승인</c:if><c:if test="${volunteerVO.comDetCNo eq 'C0102'}">미승인</c:if><c:if test="${volunteerVO.comDetCNo eq 'C0103'}">반려</c:if></font></label>
						</c:if>
					</div>
					<div class="card-body">
						<label class="col-2 col-form-label" for="volTime"><font size="3">봉사인정시간</font></label>
						<div class="col-10">
							<input class="form-select" type="number" name="volTime" placeholder="숫자로 입력해 주세요 ex) 6" id="volTime" value="${volunteerVO.volTime }">							
						</div>
					
						<label class="col-2 col-form-label" for="volSdate"><font size="3">봉사시작일자</font></label>
						<div class="col-10">
							<input type="date" class="form-control" name="volSdate" id="volSdate" value="${volunteerVO.volSdate }">
						</div>
					
						<label class="col-2 col-form-label" for="volEdate"><font size="3">봉사끝난일자</font></label>
						<div class="col-10">
							<input class="form-control" type="date" name="volEdate" id="volEdate" value="${volunteerVO.volEdate }"/>
						</div>					
						
						<c:if test="${volunteerVO.comDetCNo eq 'C0103' }">
							<label class="col-2 col-form-label" for="rejContent"><font size="4">반려이유</font></label>
							<div class="col-10">
								<textarea rows="10" class="form-control" name="rejContent" id="rejContent">${volunteerVO.rejContent }</textarea>
							</div>
						</c:if>					
					
					</div>
					<div class="card-footer" align="right">
						<!-- 등록 버튼 -->													
						<c:if test="${empty volunteerVO.comDetCNo }">
							<button type="button" class="btn btn-primary" id="fastBtn">시연용</button>
							<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
						</c:if>
							<input type="button" class="btn btn-primary" value="목록" id="listBtn">
						
						<c:if test="${volunteerVO.comDetCNo eq 'C0102'}">
							<button type="button" class="btn btn-primary" id="modifyBtn">수정</button>	
							<input type="button" class="btn btn-danger" value="삭제" id="deleteBtn">
						</c:if>	
					</div>
				</div>
			</div>		
		</div>				
		
	</div>
	</form>	
</div>
<form method="post" action="/student/deleteVolunteer" id="deleteForm">
	<sec:csrfInput/>
	<input type="hidden" value="${volunteerVO.volNo }" name="volNo">
</form>
<script>
$(function(){
	var insertBtn = $("#insertBtn");
	var listBtn = $("#listBtn");
	
	$("#fastBtn").click(function(){
		$("#volName").val("도서관 봉사");	// 제목
		$("#volContent").val("도서관 청소, 책 정리, 책 출 반납 도우미");	// 내용
		$("#volTime").val("6");	// 시간
		$("#volSdate").val("2024-06-06");	// 시작일자
		$("#volEdate").val("2024-06-30");	// 끝난일자	
	})
	
	// 파일 첨부변경시 보이는 태그 다르게 하기 위해
	var fileLabel = $("#fileLabel");
	// 파일 첨부파일 변경시
	$("#lecFile").on("change", function(){
		fileName = $("#lecFile").val();
		fileNameLen = fileName.length;
		realFileName = fileName.substring(12, fileNameLen);
// 		fileLabel.prepend("첨부파일 : ");
		fileLabel.find("a:eq(0)").html(realFileName);
		
		// 수정시에 다운로드 못하게
		fileLabel.find("a:eq(0)").attr("href", "#");
	});
	
	// 리스트 페이지 이동
	listBtn.click(function(){
		location.href="/student/volunteerList";
	});
	
	// 등록처리
	insertBtn.click(function(){
		startDate = $("#volSdate").val();
		endDate = $("#volEdate").val();
		if(startDate > endDate){
			alert("끝난일자는 시작일자보다 먼저 올 수 없습니다.");
			return false;
		}
		
		$("#formData").submit();
	});
	
	// 미승인된거 삭제 처리
	$("#deleteBtn").click(function(){
		if(confirm('정말 봉사 신청 내역을 삭제 하시겠습니까?')){
			$("#deleteForm").submit();
		}
	});
	
	// 승인일때는 모두 반려 처리
	if('${volunteerVO.comDetCNo}' != null || '${volunteerVO.comDetCNo}' != ''){
		if ('${volunteerVO.comDetCNo}' == 'C0101') {
			$("textarea").prop("readonly", true);	
			$("input").prop("readonly", true);
		} 
		
		if('${volunteerVO.comDetCNo}' == 'C0103'){
			$("textarea").prop("readonly", true);
			$("input").prop("readonly", true);
		}
	}
	
	$("#modifyBtn").click(function(){
		$("#formData").attr("action", "/student/volunteerModify");
		$("#formData").submit();
	})
	
})
</script>		