<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<h4 class="card-header">봉사 > 봉사신청내역</h4>
		<hr class="mb-0">
		
		<div class="card-body">
			
			<div class="row">
				<div class="table-responsive text-nowrap">
					<table class="table table-hover" style="text-align: center;">
						<thead>							
							<tr>								
								<th>학번</th>	
								<th>이름</th>	
								<th>봉사장소</th>	
								<th>봉사인정시간</th>	
								<th>봉사신청일자</th>	
								<th>봉사승인여부</th>	
								<th></th>	
							</tr>							
						</thead>
						<tbody>
						
							<c:choose>
								<c:when test="${empty volunteerList or volunteerList eq null}">
									<tr>
										<td colspan="6" style="text-align: center;">신청한 봉사 내역이 없습니다... 내역을 등록해주세요</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${volunteerList }" var="volunteer" varStatus="status">
										<tr>											
											<td>${volunteer.stuNo}</td>
											<td>${stuVO.stuName}</td>
											<td>${volunteer.volName }</td>
											<td>${volunteer.volTime }</td>
											<td>${volunteer.volRegdate }</td>
											<td>
												<c:if test="${volunteer.comDetCNo eq 'C0101'}"><font color="green">승인</font></c:if>
												<c:if test="${volunteer.comDetCNo eq 'C0102'}"><font color="red">미승인</font></c:if>
												<c:if test="${volunteer.comDetCNo eq 'C0103'}"><font color="blue">반려</font></c:if>								
											</td>
											<td>
												<a class="btn btn-outline-primary detailBtn" 
												href="/student/volunteerDetail?volNo=${volunteer.volNo }&flag=Y">상세정보</a>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>	
							</c:choose>
						</tbody>
					</table>	
				</div>
			</div>
			<br>
			<div align="right">
				<input type="button" class="btn btn-primary" value="등록" id="insertBtn">
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
	var insertBtn = $("#insertBtn");
	
	
	insertBtn.click(function(){
		location.href="/student/volunteerForm";
	});
})
</script>