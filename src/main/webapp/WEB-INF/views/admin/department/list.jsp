<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">학과관리</h4>
	<div class="row">
		<div class="col-xl-12">
			<div class="col-sm-2">
				<select class="form-select" id="colSelect">
					<option value="">==전체==</option>
					<c:forEach items="${colleageList }" var="colleage">
						<option value="${colleage.colNo }">${colleage.colName }</option>
					</c:forEach>
				</select>
			</div>
		</div>
		
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<h5 class="card-header">학과</h5>
				<hr class="my-0">
				<div class="table-responsive text-nowrap">
    				<table class="table table-hover">
      					<thead>
        					<tr>
					          	<th width="25%">학과명</th>
					          	<th width="20%">학과장</th>
					          	<th width="20%">학과전화번호</th>
					          	<th width="20%">학과위치</th>
					          	<th width="10%"></th>
					     	</tr>
      					</thead>
      					<tbody class="table-border-bottom-0" id="tbody">
      					</tbody>
   	 				</table>
  				</div>
				<div class="card-footer">
					<!-- 등록 버튼 -->
					<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
				</div>
			</div>
		</div>
		<form action="/admin/departmentInsertForm" method="post" id="insertForm">
			<input type="hidden" name="colNo" id="colNo1">
			<sec:csrfInput/>
		</form>
		<form action="/admin/departmentDetail" method="post" id="detailForm">
			<input type="hidden" name="colNo" id="colNo2">
			<input type="hidden" name="deptNo" id="deptNo">
			<sec:csrfInput/>
		</form>
	</div>
</div>

<meta id="_csrf" name="_csrf" content="${_csrf.token }">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">

<script type="text/javascript">

$(function(){
	
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	
	var colSelect = $("#colSelect");
	var insertBtn = $("#insertBtn");
	var insertForm = $("#insertForm");
	var detailForm = $("#detailForm");
	
	var colData = {
		colNo : colSelect.val()
	};
	
	$.ajax({
		url : "/admin/departmentList.do",
		type : "post",
		beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
			xhr.setRequestHeader(header, token);
		},
		data : JSON.stringify(colData),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log("result : " + res);
			
			$(".deptList").remove();
			var html = "";
			
			$.each(res, function(i, v){
				console.log(i +"res > " + v.deptName);
				html += "<tr class='deptList'>" +
  							"<td><span class='fw-medium'>"+v.deptName+"</span></td>" +
  							"<td>"+v.proName+"</td>" +
  							"<td>"+v.deptCall+"</td>" +
  							"<td>"+v.buiFacName+"</td>" +
  							"<td><button class='btn btn-sm btn-outline-primary detailBtn' data-no2='"+v.colNo+"' data-no='"+v.deptNo+"'>상세보기</button></td>" +
  						"</tr>";
			});
			
			$("#tbody").html(html);
		}
	});
	
	colSelect.on('change', function(){
		console.log("colSelect change...!");
		console.log("colNo > " + colSelect.val());
		
		var colData = {
			colNo : colSelect.val()
		};
		
		console.log("colData > " + colData.colNo)
		
		$.ajax({
			url : "/admin/departmentList.do",
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(colData),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				console.log("result : " + res);
				
				$(".deptList").remove();
				var html = "";
				
				$.each(res, function(i, v){
					console.log(i +"res > " + v.deptName);
					html += "<tr class='deptList'>" +
	  							"<td><span class='fw-medium'>"+v.deptName+"</span></td>" +
	  							"<td>"+v.proName+"</td>" +
	  							"<td>"+v.deptCall+"</td>" +
	  							"<td>"+v.buiFacName+"</td>" +
	  							"<td><button class='btn btn-sm btn-outline-primary detailBtn' data-no2='"+v.colNo+"' data-no='"+v.deptNo+"'>상세보기</button></td>" +
	  						"</tr>";
				});
				
				$("#tbody").html(html);
			}
		});
	});
	
	insertBtn.on('click', function(){
		$("#colNo1").val(colSelect.val());
		if($("#colNo1").val() == ""){
			alert("학과구분을 선택해주세요!");
			return false;
		}
		insertForm.submit();
	});
	
	$(document).on('click', '.detailBtn', function(){
		console.log("click detailBtn");
		$("#colNo2").val($(this).data('no2'));
		$("#deptNo").val($(this).data('no'));
		detailForm.submit();
	});
	
});
</script>
















    