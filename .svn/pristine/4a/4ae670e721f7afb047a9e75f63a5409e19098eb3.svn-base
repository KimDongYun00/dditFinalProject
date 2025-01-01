<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




<style>

.examInfo div{
	margin: 0 0 25px 0;
}

.examInfo h5{
	float:right;
}

</style>


<!-- 시큐리티 회원권한 가져오기 -->
<sec:authentication property="principal" var="prc" />
<c:set value="${prc.user.comDetUNo }" var="auth" />

<c:if test="${auth eq null }">
	<h3>로그인정보가 필요합니다!</h3>
</c:if>

<c:if test="${msg ne null }">
	<script>alert("${msg }");</script>
</c:if>


<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">시험상세</h4>
	<button class="btn btn-primary" onclick="javascript:location.href='/exam/examList?lecNo=${examVO.lecNo}'">목록</button>
	<div class="row mb-5">
		<div class="col-md-6 col-lg-4 mb-3">
		
			<div class="card mb-4 bg-white">
				<h4 class="card-header">시험정보</h4>
				<hr class="my-0">
				<div class="card-body examInfo">
					<div>
						<span>시험명</span>
						<h5>${examVO.examName }</h5>
					</div>
					<div>
						<span>강의명</span>
						<h5>${examVO.lecName }</h5>
					</div>
					<div>
						<span>시험구분</span>
						<h5>${examVO.comDetHName }</h5>
					</div>
					<div>
						<span>시험내용</span>
						<div style="font-size:1.1rem; margin-top:10px;">${examVO.examContent }</div>
					</div>
					<div>
						<span>제한시간</span>
						<h5>${examVO.examLimit } (분)</h5>
					</div>
					<div>
						<span>시험일시</span>
						<h5>${examVO.examDate }</h5>
					</div>
					<div>
						<span>등록일시</span>
						<h5>
							<fmt:parseDate value="${examVO.examRegdate }" var="regDate" pattern="yyyy-MM-dd HH:mm"/>
				      		<fmt:formatDate value="${regDate }" pattern="yyyy-MM-dd HH:mm"/>
						</h5>
					</div>
				</div>
				<form action="/exam/updateForm" method="post" id="examFrm">
					<sec:csrfInput/>
					<input type="hidden" name="examNo" value="${examVO.examNo }" id="examNo">
					<input type="hidden" name="lecNo" value="${examVO.lecNo}">
				</form>
				<c:if test="${auth eq 'U0102' }">
					<div class="card-footer">
						<button class="btn btn-primary" type="button" id="updateBtn">수정</button>
						<button class="btn btn-danger" type="button" id="deleteBtn">삭제</button>
					</div>
				</c:if>
			</div>
			
		</div>
		
		<c:if test="${auth eq 'U0101' }">
			
			<div class="col-md-6 col-lg-8 mb-3">
			
				<div class="card mb-4 bg-white">
					<h4 class="card-header">시험보기</h4>
					<hr class="my-0">
					<div class="card-body">
						
					</div>
					<div class="card-footer">
						<button type="button" class="btn btn-primary" id="solveBtn">응시</button>
					</div>
				</div>
			</div>
			
		</c:if>
		
		<c:if test="${auth eq 'U0102' }">
			
			<div class="col-md-6 col-lg-8 mb-3">
			
				<div class="card mb-4 bg-white">
					<h4 class="card-header">시험제출</h4>
					<hr class="my-0">
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover" style="overflow:hidden;">
	      					<thead>
	        					<tr>
						          	<th width="20%">학번</th>
						          	<th width="25%">학과</th>
						          	<th width="20%">이름</th>
						          	<th width="10%">학년</th>
						          	<th width="10%">점수</th>
						          	<th width="15%">답안</th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:choose>
	      							<c:when test="${studentList ne null}">
			      						<c:forEach items="${studentList }" var="stu" varStatus="status">
				      						<tr>
				      							<td class="stuNo">${stu.stuNo }</td>
				      							<td>${stu.deptName }</td>
				      							<td>${stu.stuName }</td>
				      							<td>${stu.stuYear }</td>
				      							<c:set value="${false }" var="flag"/>
				      							<c:forEach items="${studentSubmitList }" var="submit">
				      								<c:if test="${submit.stuNo eq stu.stuNo }">
						      							<c:set value="${true }" var="flag"/>
						      							<td class="stuScore">${submit.examSubScore }/${totalScore }</td>
						      							<td>
						      								<button type="button" class="btn btn-sm btn-info subChkBtn">답안확인</button>
						      							</td>
				      								</c:if>
				      							</c:forEach>
				      							<c:if test="${flag eq false }">
					      							<td class="stuScore">0/${totalScore }</td>
				      								<td>제출X</td>
				      							</c:if>
				      						</tr>      						
				      					</c:forEach>
	      							</c:when>
	      							<c:otherwise>
	      								<tr>
	      									<td colspan="4">없음</td>
	      								</tr>
	      							</c:otherwise>
	      						</c:choose>
	      					</tbody>
	   	 				</table>
	  				</div>
				</div>
			</div>
			
		</c:if>
		
		<form action="/exam/examSubmitCheck" method="post" id="subChkFrm">
			<sec:csrfInput/>
			<input type="hidden" name="stuNo" id="stuNo">
			<input type="hidden" name="examNo" value="${examVO.examNo }">
		</form>
		
	</div>
</div>



<script>

$(function(){
	
	var examFrm = $("#examFrm");
	var updateBtn = $("#updateBtn");
	var deleteBtn = $("#deleteBtn");
	var solveBtn = $("#solveBtn");
	var subChkFrm = $("#subChkFrm");
	
	deleteBtn.on('click', function(){
		if(!confirm("정말 삭제하시겠습니까?")){
			return false;
		}
		
		examFrm.attr("action", "/exam/examDelete");
		examFrm.submit();
	});
	
	updateBtn.on('click', function(){
		examFrm.attr("action", "/exam/updateForm");
		examFrm.submit();
	});
	
	solveBtn.on('click', function(){
		
		location.href="/exam/examSolve?examNo="+$("#examNo").val();
	});
	
	$(".subChkBtn").on('click', function(){
		var stuNo = $(this).parents('tr').find(".stuNo").text();
		$("#stuNo").val(stuNo);
		subChkFrm.submit();
	});
	
});

</script>





























