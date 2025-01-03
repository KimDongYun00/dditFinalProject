<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<h4 class="card-header">상담 > 상담등록</h4>
		<hr class="mb-0">
		<div class="card-body">
			<form action="/professor/consultingInsert" method="post" id="insertForm" >
				<sec:csrfInput/>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="conTitle"><font size="4">상담주제</font></label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="conTitle" id="conTitle" value="${con.conTitle }">
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label"><font size="4">학생</font></label>		
					<input type="hidden" name="stuNo" id="stuNo" value="${con.conNo }">
					<input type="hidden" name="proNo" id="proNo" value="${con.proNo }">
					<div class="col-sm-9">		
		            	<input type="text" class="form-control" name="stuName" id="stuName" placeholder="검색어를 입력하세요." value="${con.stuName }">
		            </div>
		            <div class="col-sm-1">
		            	<input type="button" class="btn btn-info" value="찾기" id="showModal">
		            </div>             
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="conDate"><font size="4">상담구분</font></label>
					<div class="col-sm-10">
						<select name="comDetNNo" class="form-select">
							<c:forEach items="${common }" var="com">
								<option value="${com.comDetNo }">${com.comDetName }</option>
							</c:forEach>
						</select>
					</div>				
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="conContent"><font size="4">상담내용</font></label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="10" name="conContent" id="conContent">${con.conContent }</textarea>
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="conDate"><font size="4">상담일</font></label>
					<div class="col-sm-10">
						<input type="date" class="form-control" name="conDate" id="conDate" value="${con.conDate }">
					</div>
				</div>	
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="conOnoff"><font size="4">대면여부</font></label>
					<div class="col-sm-10">
						<select name="conOnoff" class="form-select">
							<option value="Y">대면</option>
							<option value="N">비대면</option>
						</select>
					</div>				
				</div>	
			</form>
			<input type="button" value="등록" class="btn btn-primary" id="insertBtn">
			<input type="button" value="목록" class="btn btn-primary" id="listBtn">
		</div>
	</div>
</div>

<div class="modal fade" id="modalStu" tabindex="-1" aria-hidden="true">
  	<div class="modal-dialog" role="document">
     	<div class="modal-content">
       	<div class="modal-header">
         	<h5 class="modal-title" id="modalProLabel" 
         		style="font-weight:bold;">학생 검색</h5>
               	<button type="button" id="modal3Btn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
            <div class="modal-body">
                <div class="row mb-3">
                  	<div class="col-sm-12">
                    	<label for="searchProName" class="form-label">이름</label>
                    	<input type="text" class="form-control" id="searchstuName" name="stuName">
                    </div>
                   	<div class="col-sm-12 table-responsive text-nowrap">
    					<table class="table table-hover">
      						<thead>
        						<tr>	
					          		<th width="">학번</th>					          	
					          		<th width="">이름</th>
					          		<th width="">전화번호</th>
					     		</tr>
      						</thead>
      						<tbody class="table-border-bottom-0" id="tbody_stu">
      						
      						</tbody>
						</table>
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
	var now_utc = Date.now() // 지금 날짜를 밀리초로
	// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
	var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
	// new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
	var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
	document.getElementById("conDate").setAttribute("min", today);
	
	$("#exampleDataList").on("keyup",function(){		
		$("#searchForm").submit();
	});
	
	$("#showModal").click(function(){
		$("#modalStu").modal("show");
	});
	
	$("#listBtn").click(function(){
		location.href="/professor/consultingList";
	})
	
	$("#insertBtn").click(function(){
		conTitle = $("#conTitle").val();
		stuName = $("#stuName").val();
		conContent = $("#conContent").val();
		conDate = $("#conDate").val();
		
		if(conTitle == null || conTitle == ""){
			alert("상담명을 입력해주세요.");
			return false;
		}
		if(stuName == null || stuName == ""){
			alert("상담할 학생을 입력해주세요.");
			return false;
		}
		if(conContent == null || conContent == ""){
			alert("상담내용을 입력해주세요.");
			return false;
		}
		if(conDate == null || conDate == ""){
			alert("상담일을 입력해주세요.");
			return false;
		}
		
		$("#insertForm").submit();
	})
	
	$("#searchstuName").on("input", function(){
		if($("#searchstuName").val().trim() == "") return false;
		
		var student = {
				stuName : $("#searchstuName").val()
		}
		$.ajax({
			url:"/professor/search",
			type : "post",
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(student),
			success : function(res){
				$(".searchStuList").remove();
				var html = "";
				
				$.each(res, function(i, v){
					console.log(i +" >> " + v.proName);
					
					html += "<tr class='searchStuList'>" +
								"<td class='searchStuNo'>"+v.stuNo+"</span></td>" +						
								"<td class='searchStuName'>"+v.stuName+"</td>" +
								"<td>"+v.stuPhone+"</td>" +
							"</tr>";
				});
				
				$("#tbody_stu").append(html);
			}
		});
	});
	
	$(document).on('click', '.searchStuList', function(){		
		var searchStuNo = $(this).find('.searchStuNo').text();
		var searchStuName = $(this).find('.searchStuName').text();
				
		$("#stuNo").val(searchStuNo);
		$("#stuName").val(searchStuName);
		
		$("#modalStu").click();
		$("#searchStuName").val("");
		$(".searchStuList").remove();
	});
})
</script>