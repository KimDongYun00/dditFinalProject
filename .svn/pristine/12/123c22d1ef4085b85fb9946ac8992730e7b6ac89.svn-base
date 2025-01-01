<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card bg-white">
		<h4 class="card-header">상담 > 상담상세</h4>
		<hr class="mb-0">
		<div class="card-body">
		
			<div class="row mb-3">
				<div class="col-md-6">
                  <div class="card mb-4">
                    <h5 class="card-header">상담상세</h5>
                    <div class="card-body">
                      <div class="mb-3 row">
                        
                        <label for="conTitle" class="col-md-2 col-form-label">상담명</label>
                        
                        <div class="col-md-10">
                        
                          <input class="form-control" type="text" value="${consultingVO.conTitle }" id="conTitle" readonly/>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="stuNo" class="col-md-2 col-form-label">학번</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" value="${consultingVO.stuNo }" id="stuNo" readonly/>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="stuName" class="col-md-2 col-form-label">이름</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" readonly="readonly" id="stuName" value="${consultingVO.studentVO.stuName }"/>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="comDetNNo" class="col-md-2 col-form-label">상담구분</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" readonly="readonly" 
                          value='<c:if test="${consultingVO.comDetNNo eq 'N0101' }">진로</c:if><c:if test="${consultingVO.comDetNNo eq 'N0102' }">학업</c:if><c:if test="${consultingVO.comDetNNo eq 'N0103' }">휴학</c:if><c:if test="${consultingVO.comDetNNo eq 'N0104' }">기타</c:if>'
                          id="comDetNNo" />
                        </div>
                      </div>   
                                         
                      <div class="mb-3 row">
                        <label for="html5-tel-input" class="col-md-2 col-form-label">전화번호</label>
                        <div class="col-md-10">
                          <input class="form-control" type="tel" readonly value="${consultingVO.studentVO.stuPhone }" id="html5-tel-input" />
                        </div>
                      </div>        
                     
                      <div class="mb-3 row">
                        <label for="html5-date-input" class="col-md-2 col-form-label">상담일자</label>                        
                        <div class="col-md-10">
                          <input class="form-control" type="text" readonly value="${consultingVO.conDate }" id="html5-date-input" />
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-month-input" class="col-md-2 col-form-label">대면/비대면</label>
                        <c:if test="${consultingVO.conOnoff eq 'Y' }">
	                        <div class="col-md-10"> 
	                          <input class="form-control" readonly type="text" value='<c:if test="${consultingVO.conOnoff eq 'Y' }">대면</c:if><c:if test="${consultingVO.conOnoff eq 'N' }">비대면</c:if>' id="html5-month-input" />
	                        </div>
                        </c:if>
                        <c:if test="${consultingVO.conOnoff eq 'N' }">
	                        <div class="col-md-7"> 
	                          <input class="form-control" readonly type="text" value='<c:if test="${consultingVO.conOnoff eq 'Y' }">대면</c:if><c:if test="${consultingVO.conOnoff eq 'N' }">비대면</c:if>' id="html5-month-input" />
	                        </div>
	                        <div class="col-md-3">
		                        <button style="float:right;" type="button" class="btn btn-primary" id="onlineBtn">화상상담</button>
	                        </div> 
                        </c:if>
                      </div>     
                    </div>
                  </div>
                </div>
                
				<div class="col-md-6">
					<div class="mb-3 row">
                        <label for="exampleFormControlSelect1" class="col-md-2 col-form-label">상담상태</label>
                        <div class="col-md-10"> 
                          <input class="form-control" readonly type="text" value='<c:if test="${consultingVO.comDetSNo eq 'S0103' }">진행</c:if><c:if test="${consultingVO.comDetSNo eq 'S0102' }">대기</c:if><c:if test="${consultingVO.comDetSNo eq 'S0101' }">완료</c:if>' id="html5-month-input" />
                        </div>
                    </div> 
					<div>
	                    <label for="exampleFormControlTextarea1" class="form-label">상담내용</label>
	                    <textarea readonly="readonly" class="form-control" id="conContent" rows="5" name="conContent">${consultingVO.conContent}</textarea>
                    </div>
					<div>
						<form action="/professor/consultingUpdate" method="post" id="conForm">
							<sec:csrfInput/>
							<input type="hidden" name="conNo" value="${consultingVO.conNo}" id="conNo">
	                        <label for="exampleFormControlTextarea1" class="form-label">상담결과</label>
	                        <textarea class="form-control" id="conResult" rows="5" name="conResult">${consultingVO.conResult}</textarea>
                        </form>
                    </div>
                    <div class="mt-5">
                    	<c:choose>
                    		<c:when test="${consultingVO.comDetSNo eq 'S0101' }">
                    			<button id="modifyBtn" class="btn btn-primary">수정</button>
                    		</c:when>
                    		<c:otherwise>
		                    	<button class="btn btn-primary" id="submitBtn">제출</button>                    		
                    		</c:otherwise>
                    	</c:choose>
                    	<button class="btn btn-primary" id="listBtn">목록</button>
                    	<button class="btn btn-danger" id="deleteBtn">삭제</button>
                    </div>
                    <form action="/professor/deleteConsulting" method = "post" id="deleteForm">
                    	<sec:csrfInput/>
                    	<input type="hidden" name="conNo" value="${consultingVO.conNo }">
                    </form>
				</div>				
			</div>
		</div>
	</div>
</div>

<script>
$(function(){
	$("#listBtn").click(function(){
		location.href="/professor/consultingList";
	});
	
	$("#submitBtn").click(function(){
		var conResult = $("#conResult").val();
		
		if(conResult.length < 15){
			alert("상담 결과를 15자 이상 입력해주세요...");
			return false;
		}
		
		$("#conForm").submit();
	});
	
	$("#deleteBtn").click(function(){
		if(confirm('정말로 상담 내역을 삭제하시겠습니까?')){
			$("#deleteForm").submit();
		}
	})
	
	$("#onlineBtn").on('click', function(){
		location.href="/online/onlineConsulting?conNo="+$("#conNo").val();
	});
})
</script>

















