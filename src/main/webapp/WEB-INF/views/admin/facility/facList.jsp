<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!DOCTYPE html>
<meta id="_csrf" name="_csrf" content="${_csrf.token }">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">

<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">시설관리</h4>
	<div class="row">
		<div class="col-xl-12">
			<div class="col-sm-2">
				<form id="searchForm">
					<input type="hidden" name="page" id="page">
					<select class="form-select" id="colSelect" name="searchType">	
						<option value="99">전체</option>
						<option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>강의실</option>
						<option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>회의실</option>
						<option value="3" <c:if test="${searchType eq '3' }">selected</c:if>>운동시설</option>					
						<option value="4" <c:if test="${searchType eq '4' }">selected</c:if>>사무실</option>					
					</select>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
		
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">시설</h5>
				<hr c lass="my-0">
				<div class="table-responsive text-nowrap">
    				<table class="table table-hover">
      					<thead>
        					<tr>
        						<th width="10%"></th>
					          	<th width="20%">시설구분</th>
					          	<th width="20%">건물명</th>
					          	<th width="20%">시설명</th>
					          	<th width="20%">사용가능인원수</th>
					          	<th width="10%"></th>
					     	</tr>
      					</thead>
      					<tbody class="table-border-bottom-0" id="tbody">
      					 <c:set value="${pagingVO.dataList }" var="facList"/>
      					<c:forEach items="${facList }" var="facility" varStatus="status">
      						<tr>
      							<td>${facility.rnum }</td>
      							<td>
      								<c:choose>
		      							<c:when test="${facility.facTypeNo eq '1' }">
		      								강의실
		      							</c:when>
		      							<c:when test="${facility.facTypeNo eq '2' }">
		      								회의실
		      							</c:when>
		      							<c:when test="${facility.facTypeNo eq '3' }">
		      								운동시설      								
		      							</c:when>
		      							<c:when test="${facility.facTypeNo eq '4' }">
		      								사무실  								
		      							</c:when>
      								</c:choose>
								</td>
      							<td>${facility.buiName }</td>
      							<td>${facility.facName }</td>
      							<td>${facility.facMax }</td>
      							<td>      								
      								<a class='btn btn-outline-primary detailBtn' href='/admin/facDetail?facNo=${facility.facNo }'>상세보기</a>
      							</td>
      						</tr>      						
      					</c:forEach>
      					</tbody>
   	 				</table>
  				</div>
  				<div class="card-footer" align="right">
  				<div class="card-footer clearfix" id="pagingArea">
                  ${pagingVO.pagingHTML }
               </div>
                  <div class="card-footer">
					<!-- 등록 버튼 -->
					<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
					</div>
               </div>
               
  				
				
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
	   
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	
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
	
	colSelect.on("change", function(){
		searchForm.submit();
// 		if($('#colSelect option:selected').text() == '전체'){
// 			location.reload();			
// 		}
		
// 		let colType1 = { 
// 				facTypeNo : colSelect.val() 
// 		};
		
// 		$.ajax({
// 			url : "/admin/facList",
// 			type : "post",
// 			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
// 		         xhr.setRequestHeader(header, token);
// 		      },
// 			data : JSON.stringify(colType1),
// 			contentType : "application/json;charset=utf-8",
// 			success : function(res){
// 				let code = ""; 
// 				$.each(res, function(i, v){
// 					if(v.facTypeNo == '1'){
// 						v.facTypeNo = '강의실';
// 					}
// 					if(v.facTypeNo == '2'){
// 						v.facTypeNo = '회의실';
// 					}
// 					if(v.facTypeNo == '3'){
// 						v.facTypeNo = '운동시설';
// 					}
// 					code += "<tr>";
// 					code += "	<td>"+v.facTypeNo+"</td>";
// 					code += "	<td>"+v.buiName+"</td>";
// 					code += "	<td>"+v.facName+"</td>";
// 					code += "	<td>"+v.facMax+"</td>";
// 					code += "<td><a class='btn btn-outline-primary detailBtn' href='/admin/facDetail?facNo="+v.facNo+"'>상세보기</a></td>";
// 					code += "</tr>";					
// 				})
								
// 				$("#tbody").html("");				
// 				$("#tbody").html(code);
// 			},
// 			error : function(xhr){
// 				alert(xhr.status);
// 			}
// 		});
	});
	
	insertBtn.on("click", function(){		
		location.href="/admin/facInsert?facTypeNo="+colSelect.val();		
	});
	
});
</script>