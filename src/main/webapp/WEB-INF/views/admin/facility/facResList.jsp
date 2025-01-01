<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<style>
	th, td{
		text-align: center;
	}
</style>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<h4 class="card-header">시설 > 시설예약정보</h4>
		<hr class="my-0"/>
		<div class="card-body">			
			<div class="row mb-3">
				<form action="" id="searchForm">
					<sec:csrfInput/>		
					<input type="hidden" name="page" id="page">
					<div class="input-group">
						<label class="input-group-text" for="searchType">승인여부선택</label>			
						<select class="form-select" name="searchType" id="searchType">							
							<option value="C99" <c:if test="${searchType eq '99' }">selected</c:if>>전체</option> 
							<option value="C0101" <c:if test="${searchType eq 'C0101' }">selected</c:if>>승인</option>
							<option value="C0102" <c:if test="${searchType eq 'C0102' }">selected</c:if>>대기</option>
							<option value="C0103" <c:if test="${searchType eq 'C0103' }">selected</c:if>>반려</option>
						</select>
						
						<label class="input-group-text" for="searchType2">건물명</label>
						<select class="form-select" name="searchLecType" id="searchType2">						
							<option value="C99">전체</option>
							<c:forEach items="${buiList }" var="bui">														
								<option <c:if test="${searchLecType eq bui.buiNo }">selected</c:if> value="${bui.buiNo }">${bui.buiName }</option>
							</c:forEach> 
						</select>
						
						<label class="input-group-text" for="searchType3">시설구분</label>
						<select class="form-select" name="searchOnoff" id="searchType3">
							<option value="99" <c:if test="${searchOnoff eq '99' }">selected</c:if>>전체</option>
							<option value="1" <c:if test="${searchOnoff eq '1' }">selected</c:if>>강의실</option>
							<option value="2" <c:if test="${searchOnoff eq '2' }">selected</c:if>>회의실</option>							
							<option value="3" <c:if test="${searchOnoff eq '3' }">selected</c:if>>운동시설</option>							
							<option value="4" <c:if test="${searchOnoff eq '4' }">selected</c:if>>사무실</option>							
						</select>
					</div>
				</form>	
			</div>
			<div class="row mb-3">
				<div class="table-responsive text-nowrap">
					<table class="table table-hover">
						<tr>
							<th><input type="checkbox" id="allSelect"></th>
							<th>번호</th>
							<th>시설구분</th>
							<th>건물명</th>
							<th>시설명</th>
							<th>아이디</th>
							<th>사용목적</th>
							<th>시작일자</th>
							<th>끝난일자</th>
							<th>승인여부</th>
							<th></th>
						</tr>
						<c:set value="${pagingVO.dataList }" var="facRes"/>
						<c:forEach items="${facRes }" var="fac">						
							<tr>
								<td><input type="checkbox" name="volunteerAgree" data-num="${fac.facResNo }" value="${fac.comDetCNo }"></td>
								<td>${fac.rnum }</td>
								<td>
									<c:choose>
		      							<c:when test="${fac.facTypeNo eq '1' }">
		      								강의실
		      							</c:when>
		      							<c:when test="${fac.facTypeNo eq '2' }">
		      								회의실
		      							</c:when>
		      							<c:when test="${fac.facTypeNo eq '3' }">
		      								운동시설      								
		      							</c:when>
		      							<c:when test="${fac.facTypeNo eq '4' }">
		      								사무실  								
		      							</c:when>
      								</c:choose>
								</td>
								<td>${fac.buiName }</td>
								<td>${fac.facName }</td>
								<td>${fac.userNo }</td> 								
								<td>${fac.facResPurpose }</td>
								<td class="sdate">${fn:replace(fac.facResSdate, 'T', ' ')}</td>
								<td class="edate">${fn:replace(fac.facResEdate, 'T', ' ')}</td>
								<td>
									<c:if test="${fac.comDetCNo eq 'C0101'}"><font color="green">승인</font></c:if>	
									<c:if test="${fac.comDetCNo eq 'C0102'}"><font color="red">대기</font></c:if>	
									<c:if test="${fac.comDetCNo eq 'C0103'}"><font color="blue">반려</font></c:if>	
								</td>
								<td>
									<a href="/admin/facResDetail?facResNo=${fac.facResNo }" class="btn btn-outline-primary">상세보기</a>
								</td>
							</tr>							
						</c:forEach>
					</table>
				</div>
				<div class="card-footer clearfix" id="pagingArea">
					${pagingVO.pagingHTML }
				</div>
			</div>		
		</div>
		<div class="card-footer" align="right">			                
			  <button type="button" class="btn btn-danger" id="agreeAllBtn">일괄승인</button>                
        </div>
	</div>
</div>			
<script>
$(function(){	
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	// 전체선택 이벤트
	var allSelect = $("#allSelect");
	allSelect.click(function(){
		var allChecked = $(this).prop('checked');
	    $("input[name='volunteerAgree']").prop('checked', allChecked);		
	});
	
	// 일괄승인 이벤트
	$("#agreeAllBtn").click(function(){
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
                url: "/admin/facResAgree",
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
	// 쿼리 검색
	$("#searchType").on("change", function(){
		searchForm.submit();
	})
	// 쿼리 검색
	$("#searchType2").on("change", function(){
		searchForm.submit();
	})
	// 쿼리 검색
	$("#searchType3").on("change", function(){
		searchForm.submit();
	})
})
</script>	