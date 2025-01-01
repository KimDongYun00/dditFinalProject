<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<sec:authentication property="principal" var="prc" />
<c:set value="${prc.user.comDetUNo }" var="auth" />
<c:set value="" var="username"/>
<c:if test="${auth eq 'U0101' }">
	<c:set value="${prc.user.stuVO.stuName }" var="username"/>
</c:if>
<c:if test="${auth eq 'U0102' }">
	<c:set value="${prc.user.profVO.proName }" var="username"/>
</c:if>
<c:if test="${auth eq 'U0103' }">
	<c:set value="${prc.user.empVO.empName }" var="username"/>
</c:if>


<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">화상상담</h4>
	<div class="row mb-5">
		<div class="col-md-6 col-lg-12 mb-3">
		
			<div class="card mb-4 bg-white">
				<div class="card-header">
					<button type="button" class="btn btn-secondary" id="newBtn">새로고침</button>
					<c:if test="${auth ne 'U0101' }">
						<button type="button" class="btn btn-primary" style="float:right;"
							data-bs-toggle="modal" data-bs-target="#modalOnline">상담등록</button>
					</c:if>
				</div>
				<hr class="my-0">
				<div class="card-body table-responsive text-nowrap">
    				<table class="table table-hover">
						<thead>
							<tr>
								<th width="45%">제목</th>
								<th width="10%">인원</th>
								<th width="15%">생성일시</th>
								<th width="10%">참여하기</th>
								<c:if test="${auth ne 'U0101' }">
									<th width="10%">삭제하기</th>
								</c:if>
							</tr>
						</thead>
						<tbody id="tbody">
							<tr>
								<c:if test="${auth ne 'U0101' }">
									<td colspan="6">상담이 없습니다.</td>
								</c:if>
								<c:if test="${auth eq 'U0101' }">
									<td colspan="5">상담이 없습니다.</td>
								</c:if>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 화상수업 등록 Modal -->
	        <div class="modal fade" id="modalOnline" tabindex="-1" aria-hidden="true">
	           	<div class="modal-dialog" role="document">
	              	<div class="modal-content">
	                	<div class="modal-header">
	                  		<h5 class="modal-title" id="modalOnlineLabel" 
	                  			style="font-weight:bold;">화상상담 등록</h5>
	                  		<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                	</div>
	               		<div class="modal-body">
		                  	<div class="row mb-3">
	                      		<input type="hidden" class="form-control" id="conNo" value="${conNo }">
		                    	<div class="col-sm-12">
		                      		<label for="roomTitle" class="form-label">제목</label>
		                      		<input type="text" class="form-control" id="roomTitle">
		                      	</div>
		                    	<div class="col-sm-6">
		                      		<label for="maxJoinCount" class="form-label">입장가능인원(최대16명)</label>
		                      		<input type="text" class="form-control" id="maxJoinCount">
		                      	</div>
		                    	<div class="col-sm-6">
		                      		<label for="durationMinutes" class="form-label">유지시간</label>
		                      		<input type="text" class="form-control" id="durationMinutes">
		                      	</div>
		                	</div>
	         			</div>
	         			<div class="modal-footer">
	         				<button type="button" id="registerBtn" class="btn btn-primary">등록</button>
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
	
token = $("meta[name='_csrf']").attr("content");
header = $("meta[name='_csrf_header']").attr("content");

$(function(){
	
	var newBtn = $("#newBtn");
	var registerBtn = $("#registerBtn");
	
	function onlineList(){
		$.ajax({
			type : 'post',
			url : "/online/roomList",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			dataType : 'json',
			success : function(res) {
				var html = "";
				$.each(res, function(i,v){
					if((v.roomTitle+"").indexOf("_") != -1 && v.roomTitle.split("_")[0] == "CON"){
						var title = v.roomTitle.substring(4);
						console.log(title);
						if(title.indexOf("_") != -1 && (title.split("_")[0] + "_" + title.split("_")[1]) == $("#conNo").val()){
							var index1 = title.indexOf("_");
							var index2 = title.indexOf("_", index1+1);
							title = title.substring(index2+1);
							var date = new Date(v.startDate);
							var year = date.getFullYear(); // 2023
							var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 06
							var day = date.getDate().toString().padStart(2, '0'); // 18
							var dateString = year + '-' + month + '-' + day;
							html += "<tr data-roomId='"+v.roomId+"'>"
							 	+ "<td>"+title+"</td>"
							 	+ "<td>"+v.currJoinCnt+" / "+v.maxJoinCnt+"</td>"
							 	+ "<td>"+dateString+"</td>"
							 	+ "<td><button type='button' class='btn btn-sm btn-primary enterRoom'>참여하기</button></td>"
							 	<c:if test="${auth ne 'U0101' }">
								 	+ "<td><button type='button' class='btn btn-sm btn-danger deleteBtn'>삭제하기</button></td>"
							 	</c:if>
							 + "</tr>";
						}
					}
				});	
				if(html.length != 0){
					$("#tbody").html(html);
				}
			}
		});
	}
	
	function enterRoom(roomId, username){
		$.ajax({
			type : 'post',
			url : "/online/enterRoom?roomId="+roomId+"&username="+username,
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			success : function(res) {
				res = JSON.parse(res);
				console.log(res);
				window.open(res.data.url);
			}
		});
	}
	
	function deleteRoom(roomId){
		$.ajax({
			type : 'post',
			url : "/online/deleteRoom?roomId="+roomId,
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			success : function(res) {
				res = JSON.parse(res);
				console.log(res);
				if(res.resultCode == 'GRM_200'){
					alert("삭제성공!");
				} else{
					alert("삭제실패!");
				}
				onlineList();
			}
		});
	}
	
	onlineList();
	
	newBtn.on('click', function(){
		location.href="";
	});
	
	$(document).on('click', '.enterRoom', function(){
		var roomId = $(this).parents('tr').attr("data-roomId");
		var username = '${username }';
		enterRoom(roomId, username);
	});
	
	$(document).on('click', '.deleteBtn', function(){
		var roomId = $(this).parents('tr').attr("data-roomId");
		deleteRoom(roomId);
	});
	
	registerBtn.on('click',function(){
		$("#modal3Btn").trigger('click');
		var roomTitle = "CON_" + $("#conNo").val() + "_" + $("#roomTitle").val();
		var maxJoinCount = $("#maxJoinCount").val();
		var durationMinutes = $("#durationMinutes").val();
		$("#roomTitle").val("");
		$("#maxJoinCount").val("");
		$("#durationMinutes").val("");
		$.ajax({
			type : 'post',
			url : "/online/createRoom?roomTitle="+roomTitle+
					"&maxJoinCount="+maxJoinCount+
					"&durationMinutes="+durationMinutes,
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			success : function(res) {
				res = JSON.parse(res);
				console.log(res);
				if(res.resultCode == 'GRM_200'){
					alert("등록성공!");
				} else{
					alert("등록실패!");
				}
				onlineList();
			}
		});
	});
	
});

</script>






















