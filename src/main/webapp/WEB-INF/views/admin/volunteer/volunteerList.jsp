<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<h4 class="card-header">봉사 > 봉사신청내역</h4>
		<hr class="mb-0">
        <div class="card-header searchHeader">
			<form action="" id="searchForm">
				<div class="row mb-3">
					<div class="input-group">
						<sec:csrfInput/>		
						<input type="hidden" name="page" id="page">
						<label class="input-group-text" for="searchType">승인여부선택</label>			
						<select class="form-select" name="searchType" id="searchType">							
							<option value="99">전체</option>
							<option value="C0101" <c:if test="${searchType eq 'C0101' }">selected</c:if>>승인</option>
							<option value="C0102" <c:if test="${searchType eq 'C0102' }">selected</c:if>>미승인</option>
							<option value="C0103" <c:if test="${searchType eq 'C0103' }">selected</c:if>>반려</option>
						</select>
						
						<label class="input-group-text" for="searchLecType">학과선택</label>
						<select class="form-select" name="searchLecType" id="searchType2">						
							<!-- 과를 동적으로 넣어주자 -->
								<option value="99">전체</option>
							<c:forEach items="${deptList }" var="dept">								
								<option value="${dept.deptNo }" <c:if test="${searchLecType eq dept.deptNo }">selected</c:if>>${dept.deptName }</option>								
							</c:forEach>
						</select>
						
						<label class="input-group-text" for="searchScore">검색타입</label>
						<select class="form-select" name="searchScore">
							<option value="1" <c:if test="${searchScore eq '1' }">selected</c:if>>이름</option>
							<option value="2" <c:if test="${searchScore eq '2' }">selected</c:if>>학번</option>							
						</select>
						<input type="text" placeholder="검색어를 입력하세요." name="searchWord" class="form-control" style="width:40%;" value="${searchWord }">						
						<button class="btn btn-primary" id="searchBtn" type="button">검색</button>
					</div>
				</div>
			</form>
		</div>						
		<div class="card-body">
			<div class="row">
				<div class="table-responsive text-nowrap">
					<table class="table table-hover" style="text-align: center;">
						<thead>							
							<tr>
								<th><input type="checkbox" id="allSelect"></th>
								<th>학번</th>	
								<th>이름</th>	
								<th>학과</th>	
								<th>봉사장소</th>	
								<th>봉사인정시간</th>	
								<th>봉사신청날짜</th>	
								<th>봉사승인여부</th>	
								<th></th>	
							</tr>							
						</thead>
						<tbody>
						 <c:set value="${pagingVO.dataList }" var="volunteerList"/>							
							<c:choose>
								<c:when test="${empty volunteerList or volunteerList eq null}">
									<tr>
										<td colspan="6" style="text-align: center;">신청한 봉사 내역이 없습니다...</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${volunteerList }" var="volunteer" varStatus="status">
										<tr>
											<td><input type="checkbox" name="volunteerAgree" data-num="${volunteer.volNo }" value="${volunteer.comDetCNo }"></td>
											<td>${volunteer.stuNo}</td>
											<td>${volunteer.stuName}</td>
											<td>${volunteer.deptName}</td>
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
												href="/admin/volunteerDetail?volNo=${volunteer.volNo }">상세정보</a>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>	
							</c:choose>
						</tbody>
					</table>	
				</div>
			</div>
			<div class="card-footer" align="right">
  				<div class="card-footer clearfix" id="pagingArea">
                  ${pagingVO.pagingHTML }
               </div>
			<br>
			<input class="btn btn-primary" type="button" value="일괄승인" id="agree"/>
            </div>   
		</div>
	</div>
</div>
<script>
$(function(){	
	var insertBtn = $("#insertBtn");

	
	var pagingArea = $("#pagingArea");
	var colSelect = $("#colSelect");
	var insertBtn = $("#insertBtn");
	var searchForm = $("#searchForm");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	$("#searchBtn").click(function(){
		
		searchForm.submit();
	});
	
	
	
	insertBtn.click(function(){
		location.href="/student/volunteerForm";
	});
	
	var allSelect = $("#allSelect");
	allSelect.click(function(){
		var allChecked = $(this).prop('checked');
	    $("input[name='volunteerAgree']").prop('checked', allChecked);		
	});
	
	// 일괄승인 이벤트
	$("#agree").click(function(){
		var selectedIds = [];
		
		
		$("input[name='volunteerAgree']:checked").each(function() {
            if($(this).val()=='C0102'){
				selectedIds.push($(this).data('num'));            	
            }            
        });		
		ID = {selectedIds : selectedIds}
		
        if (selectedIds.length === 0) {
            alert("승인 대기중인 항목을 선택해주세요.");
            return false;
        } 
        
        if (confirm("선택된 항목들을 일괄 승인처리할까요?")) {
            $.ajax({
                url: "/admin/volunteerAgree",
                type: "POST",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(ID),
                success: function(response) {
                    alert("선택된 항목들이 승인되었습니다.");
                    location.reload();
                },
                error: function(xhr) {
                    alert("승인 중 오류가 발생했습니다.");
                }
            });
        }
	});
})
</script>