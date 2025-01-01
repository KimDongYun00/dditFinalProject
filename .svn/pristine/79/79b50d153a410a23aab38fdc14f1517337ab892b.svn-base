<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 -->
	<sec:authentication property="principal.user" var="user" />
</sec:authorize>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학적 > 학적변경신청목록</h5>
				<hr class="mb-0"/>
				<div class="card-body">
					<div class="row mb-3">
						<div class="table-responsive text-nowrap"  style="overflow:hidden;">	
						
							<table class="table table-hover" style="text-align: center;">
								<thead>
									<tr>
										<th></th>
										<th>학번</th>
										<th>학기</th>
<!-- 										<th>신청내용</th> -->
										<th>처리종류</th>
										<th>처리상태</th>
										<th>상세보기</th>
									</tr>
								</thead>
								<tbody>	
									<c:if test="${empty breakList }">
										<tr>
											<td colspan="6">학적 신청 내용이 없습니다.</td>
										</tr>
									</c:if>
									<c:if test="${not empty breakList }">
										<c:forEach items="${breakList }" var="breakL" varStatus="status">
											<tr>
												<td>${status.index+1 }</td>
												<td>${breakL.stuNo }</td>
												<td>${breakL.year }년 ${breakL.semester }학기</td>											
	<%-- 											<td>${breakL.breContent }</td> --%>
												<td>
													<c:forEach items="${comM }" var="codeM">
														<c:if test="${codeM.comDetNo eq breakL.comDetMNo }">${codeM.comDetName }</c:if>
													</c:forEach>
												</td>
												<td>	
													<c:forEach items="${comC }" var="codeC">
														<c:if test="${codeC.comDetNo eq breakL.comDetCNo }">${codeC.comDetName }</c:if>
													</c:forEach>											
												</td>																
												
												<td>
													<a href="/student/breakDetail?breNo=${breakL.breNo }" 
													class="btn btn-outline-primary">상세보기</a>
												</td>
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="card-footer">
					<button	
                          type="button"
                          class="btn btn-primary"
                          data-bs-toggle="modal"
                          data-bs-target="#basicModal"
                        >
                          	등록
                        </button>
				</div>
			</div>
		</div>
	</div>		
</div>
				<!-- 모달창 -->
					<div class="col-lg-4 col-md-6">                      
                        <!-- Modal -->
                        <div class="modal fade" id="basicModal" tabindex="-1" aria-hidden="true">
                          <div class="modal-dialog" role="document">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel1">학적신청</h5>
                                <button
                                  type="button"
                                  class="btn-close"
                                  data-bs-dismiss="modal"
                                  aria-label="Close"
                                ></button>
                              </div>
                              <div class="modal-body">
                                <div class="row">
                                  <div class="col mb-3">
                                    <label for="stuNo" class="form-label">아이디</label>
                                    <input type="text" class="form-control" name="stuNo" id="stuNo" readonly="readonly" value="${user.stuVO.stuNo }" />
                                  </div>
                                </div>
                                <div class="row">
                                	<div class="col mb-3">
                                		<label for="comDetMNo" class="form-label">구분</label>
                                		<select class="form-select" name="comDetMNo" id="comDetMNo">
                                				<option value="99">선택</option>
                                			<c:forEach items="${comM }" var="comML">
                                				<option value="${comML.comDetNo }">${comML.comDetName }</option>
                                			</c:forEach>
                                		</select>
                                	</div>
                                </div>
                                <div class="row">
                                	<div class="input-group">
                                		<label for="year" class="input-group-text">년도</label>                                			
                                			<select id="year" name="year" class="form-select">          
												<option value="99">선택</option>
												<jsp:useBean id="now" class="java.util.Date" />
												<fmt:formatDate value="${now}" pattern="yyyy" var="startYear"/>
												<c:forEach begin="${startYear }" end="${startYear + 5}" var="year" step="1">
													<option value="${year}">${year}년</option>
												</c:forEach>
											</select>
                                		<label for="semester" class="input-group-text">학기</label>
                                		<select id="semester" name="semester" class="form-select">  
                                				<option value="99">선택</option>                              			
                                				<option value="1">1학기</option>
                                				<option value="2">2학기</option>                                			
                                		</select>	                                		
                                	</div>
                                </div>
                                <div class="row">
                                	<div class="col mb-3">
                                		<label for="breContent" class="form-label">사유</label>
                                		<textarea rows="5" class="form-control" id="breContent"></textarea>
                                	</div>
                                </div> 
                               
                              </div>
                              <div class="modal-footer">
                                <button id="closeModal" type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                  X
                                </button>                                
                                <button type="button" class="btn btn-primary" id="fastBtn">시연용</button>
                                <button type="button" class="btn btn-primary" id="saveBtn">신청</button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      
<script>
$(function(){
	var saveBtn = $("#saveBtn");
	var basicModal = $("#basicModal");
	
	$("#fastBtn").click(function(){
		$("#comDetMNo").val("M0102").prop("selected", true);
		$("#year").val("2024").prop("selected", true);
		$("#semester").val("2").prop("selected", true);
		$("#breContent").html("DDIT기업에 학생인턴 선정되서 한학기 잘 배우고 돌아오겠습니다.");
	});
	
	saveBtn.click(function(){		
		year = $("#year").val();
		semester = $("#semester").val();
		comDetMNo = $("#comDetMNo").val();
		breContent = $("#breContent").val();
		stuNo = $("#stuNo").val();
		var data = {
				year : year
			  , semester : semester
			  , comDetMNo : comDetMNo
			  , breContent : breContent
			  , stuNo : stuNo
		}
		console.log(stuNo);
		
		if(comDetMNo == '99'){
			alert("구분을 선택해주세요.");
			return false;
		}
		if(year == '99'){
			alert("년도를 선택해주세요.");
			return false;
		}
		if(semester == '99'){
			alert("학기를 선택해주세요.");
			return false;
		}
		if(breContent.length < 5){
			alert("사유가 너무 짧습니다. 제대로 입력해주세요.");
			return false;
		}
		if(confirm(
				"귀하의 학적 신청 정보는" + "\n"+ 
				"아이디 : " + stuNo  + "\n"+
				"년도/학기 : " + year + "년 " + semester + "학기 \n" +
				"구분 : " + $("#comDetMNo option:selected").text() +	"\n"	+		
				"사유 : " + breContent +"입니다." +"\n" +
				"이 상태로 신청을 완료하시겠습니까?"
				)){
			$.ajax({
				url : "/student/insertBreak",
				data : JSON.stringify(data),
				contentType : "application/json; charset=utf-8",
				type : "post",
				beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
			         xhr.setRequestHeader(header, token);
			    },
			    success : function(res){
			    	alert("학적 변경 신청이 완료되었습니다.");
			    	// reload시켜서 모달창 내용도 초기화 한다.
			    	location.reload(true);
			    }
			})			
			
			basicModal.modal("hide");		
		}
		
	});
})

</script>