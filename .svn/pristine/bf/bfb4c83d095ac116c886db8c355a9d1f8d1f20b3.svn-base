<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				<h5 class="card-header">휴가 > 휴가신청목록</h5>
				<hr class="mb-0"/>
				<div class="card-body">
					<div class="row mb-3">
						<div class="table-responsive text-nowrap"  style="overflow:hidden;">	
						
							<table class="table table-hover" style="text-align: center;">
								<thead>
									<tr>
										<th></th>
										<th>아이디</th>
										<th>이름</th>
										<th>목적</th>
										<th>신청일자</th>
										<th>시작일자</th>
										<th>끝난일자</th>
										<th>상태</th>
										<th>상세보기</th>
									</tr>									
								</thead>
								<tbody>
									<c:if test="${empty vacList }">
										<tr>
											<td colspan="8">휴가 신청 내역이 없습니다.</td>
										</tr>
									</c:if>
									<c:forEach items="${vacList }" var="vac">
										<tr>
											<td></td>
											<td>${vac.userNo }</td>
											<td>${vac.proName }</td>
											<td style="text-align: left;">${vac.vacContent }</td>
											<td>${vac.vacRegdate }</td>
											<td>${vac.vacSdate }</td>
											<td>${vac.vacEdate }</td>
											
											<td>
												<c:forEach items="${comC }" var="comCcode">
													<c:if test="${comCcode.comDetNo eq vac.comDetCNo }">${comCcode.comDetName }</c:if>
												</c:forEach>												
											</td>
											<td>
												<a href="/vacation/vacationDetail?vacNo=${vac.vacNo }&flag=Y" 
												class="btn btn-outline-primary">상세보기</a>
											</td>
										</tr>		
									</c:forEach>							
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
                          id="saveBtn2"
                          style="float:right;"
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
                                    <input type="text" class="form-control" name="userNo" id="userNo" readonly="readonly" value="${user.profVO.proNo }" />
                                  </div>
                                </div>
                                <div class="row">
                                	<div class="col mb-3">
	                                    <label for="stuNo" class="form-label">이름</label>
	                                    <input type="text" class="form-control" name="proName" id="proName" readonly="readonly" value="${user.profVO.proName }" />
                                    </div>
                                </div>
                                <div class="row">
                                	<div class="input-group">
                                		<label for="vacSdate" class="input-group-text">시작일자</label>                                			
                                		<input type="date" name="vacSdate" id="vacSdate" class="form-control">	
                                		<label for="vacEdate" class="input-group-text">끝난일자</label>
                                		<input type="date" name="vacEdate" id="vacEdate" class="form-control">	                                		
                                	</div>
                                </div>
                                <div class="row">
                                	<div class="col mb-3">
                                		<label for="breContent" class="form-label">목적</label>
                                		<textarea rows="5" name="vacContent" class="form-control" id="vacContent"></textarea>
                                	</div>
                                </div> 
                               
                              </div>
                              <div class="modal-footer">
                                <button id="closeModal" type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                  X
                                </button>
                                <button type="button" class="btn btn-primary" id="saveBtn">신청</button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
<script>
$(function(){
	$("#saveBtn2").click(function(){
// 		userNo = $("#userNo").val();
// 		vacSdate = $("#vacSdate").val();
// 		vacEdate = $("#vacEdate").val();
// 		vacContent = $("#vacContent").val();	
		
// 		data = {
// 				userNo : userNo
// 			,	vacSdate : vacSdate
// 			,	vacEdate : vacEdate
// 			,	vacContent : vacContent
// 		}
		
// 		$.ajax({
			
// 		})
		location.href="/vacation/vacationForm";
	})
});
</script>					
					
		
		
		
		
	
