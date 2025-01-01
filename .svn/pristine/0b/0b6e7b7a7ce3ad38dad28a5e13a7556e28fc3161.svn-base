<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<style>
td{
	color : black;
}
</style>


<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">과목관리</h4>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<div class="card-header">
					<form action="" method="get" id="searchFrm">
						<sec:csrfInput/>
						<input type="hidden" name="page" id="page">
						<select class="form-select" style="width:20%;" name="searchType" id="searchSel">
							<option value="99">===전체===</option>
							<c:forEach items="${deptList }" var="dept">
								<option value="${dept.deptNo }"
									<c:if test="${dept.deptNo eq pagingVO.searchType }">selected='selected'</c:if>>${dept.deptName }</option>
							</c:forEach>
						</select>
					</form>
					<form action="/admin/deleteSubject" method="post" id="deleteFrm">
						<sec:csrfInput/>
						<input type="hidden" name="subNo" id="delSubNo">
					</form>
				</div>
				<hr class="my-0">
				<div class="card-body">
					<div class="table-responsive text-nowrap">
	    				<table class="table table-hover">
	      					<thead>
	        					<tr>
						          	<th width="20%">과목번호</th>
						          	<th width="25%">과목이름</th>
						          	<th width="25%">학과이름</th>
						          	<th width="15%">개설가능여부</th>
						          	<th width="15%"></th>
						     	</tr>
	      					</thead>
	      					<tbody class="table-border-bottom-0" id="tbody">
	      						<c:forEach items="${pagingVO.dataList }" var="subject">
	      							<tr>
	      								<td class="subNo">${subject.subNo }</td>
	      								<td class="subName">${subject.subName }</td>
	      								<td>${subject.deptName }</td>
	      								<td>
	      									<c:if test="${subject.comDetVNo eq 'V0101' }">
		      									<input type="checkbox" name="comDetVNo" value="${subject.comDetVNo }" 
		      										style="margin-left:20px;" class="subCheck" checked="checked">
											</c:if>
	      									<c:if test="${subject.comDetVNo eq 'V0102' }">
		      									<input type="checkbox" name="comDetVNo" value="${subject.comDetVNo }" 
		      										style="margin-left:20px;" class="subCheck" >
											</c:if>
	      								</td>
	      								<td>
											<button class="btn btn-sm btn-secondary deleteBtn" type="button">삭제</button>
										</td>
	      							</tr>
	      						</c:forEach>
	      					</tbody>
	   	 				</table>
	  				</div>
				</div>
				<div class="card-footer">
					<div class="row">
		  				<div class="col-md-8" id="pagingDiv">
		  					${pagingVO.pagingHTML }
		  				</div>
		  				<div class="col-md-4">
							<button type="button" style="float:right;" class="btn btn-primary" id="insertBtn">등록</button>
		  				</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<meta id="_csrf" name="_csrf" content="${_csrf.token }">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">

<script type="text/javascript">

$(function(){
	
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	
	var insertBtn = $("#insertBtn");
	var pagingArea = $("#pagingArea");
	var searchFrm = $("#searchFrm");
	var searchSel = $("#searchSel");
	
	insertBtn.on('click', function(){
		location.href="/admin/subjectInsertForm";
	});
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchFrm.find("#page").val(pageNo);
		searchFrm.submit();
	});
	
	searchSel.on('change', function(){
		searchFrm.submit();
	});
	
	$(".subCheck").on('change', function(){
		console.log("subCheck click...!");
		
		if($(this).val() == "V0101") $(this).val("V0102");
		else $(this).val("V0101");
		
		var checkData = {
				comDetVNo : $(this).val(),
				subNo : $(this).parents('tr').find('.subNo').text()
		};
		
		$.ajax({
			url : "/admin/subjectAvailable.do",
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(checkData),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				console.log("result : " + res);
			}
		});
	});
	
	$('.subName').on('click', function(){
		console.log("subject click...!");
		location.href="/admin/subjectDetail?subNo="+$(this).prev().text();
	});
	
	$('.subName').hover(function(){
		$(this).css("color", "blue");
	}, function(){
		$(this).css("color", "black");
	});
	
	$(".deleteBtn").on('click', function(){
		console.log("deleteBtn click...!");
		
		if(!confirm("삭제하시겠습니까?")) return false;
		
		console.log($(this).parents("tr").find(".subNo").text());
		$("#delSubNo").val($(this).parents("tr").find(".subNo").text());
		$("#deleteFrm").submit();
	});
	
});

</script>
















