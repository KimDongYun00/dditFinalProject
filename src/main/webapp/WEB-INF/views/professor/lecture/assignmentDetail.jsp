<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>




<body>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">

			<h2 class="fw-bold py-3 mb-4">과제관리</h2>
			<div class="col-lg">
				<div class="card">
					<div class="card-body">
						<h3>
							<b>${assignmentVO.assTitle }</b>
						</h3>
						<div id="date row">
							<div class="col-sm-2">
								<fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${assignmentVO.assRegdate}" />
								<fmt:formatDate var="regdate" pattern="yyyy-MM-dd" value="${regdate}" />
								<span>등록일 : ${regdate}</span>
							</div>
							<div class="col-sm-2">
								<fmt:parseDate var="edate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${assignmentVO.assEdate}" />
								<fmt:formatDate var="edate" pattern="yyyy-MM-dd HH:mm" value="${edate}"/>
								<span>마감일시 : ${edate}</span>
							</div>
							<div class="col-sm-2">
								<span>최대점수 : ${assignmentVO.assMaxscore}</span>
							</div>
						</div>
					</div>
					
					<hr class="m-0" />
					<div class="card-body">
						<h5>${assignmentVO.assContent }</h5>
					</div>
					<div class="card-footer">
			        	<input type="button" id="deleteBtn" value="삭제" class="btn btn-danger" style="float:right;">
			        	<input type="button" id="modifyBtn" value="수정" class="btn btn-primary" style="float:right;">
					</div>
				</div>
			</div>
			<div class="container mt-5">
	        	<form action="/professor/deleteAssignment.do" method="post" id="delForm">
		        	<div style="float: right;">
		        		<input type="hidden" name="assNo" value="${assignmentVO.assNo }" >
		        		<input type="hidden" name="lecNo" value="${assignmentVO.lecNo }" >
		        	</div>
	        		<sec:csrfInput />
	        	</form>
			</div>
			
			<div class="card">
				<div class="table-responsive text-nowrap">
					<table class="table table-hover">
						<thead>
							<tr style="text-align: center;">
								<th width="10%;">학번</th>
								<th width="10%;">이름</th>
								<th width="15%;">내용</th>
								<th width="15%;">제출일시</th>
								<th width="15%;">파일</th>
								<th width="10%;">상태</th>
								<th width="20%;" style="text-align: center;">점수</th>
							</tr>
						</thead>
						<tbody class="table-border-bottom-0">
							<c:set var="courseVO" value="${pagingVO.dataList}"/>
							<c:forEach var="list" items="${courseVO}">
								<tr style="text-align: center;">
								    <td>${list.stuNo}</td>
								    <td>${list.studentVO.stuName}</td>
								    <td style="text-align: left;">
								    	<c:if test="${empty list.studentVO.assignmentSubmitVOList}"> </c:if> 
								    	<c:if test="${not empty list.studentVO.assignmentSubmitVOList}">${list.studentVO.assignmentSubmitVOList[0].assSubComment }</c:if>
								    </td>
								    <td>
								        <fmt:parseDate var="regdate" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${list.studentVO.assignmentSubmitVOList[0].assSubDate}" />
								 	    <fmt:formatDate var="regdate" pattern="yyyy-MM-dd HH:mm" value="${regdate}" />
								    	<c:if test="${empty list.studentVO.assignmentSubmitVOList}"> </c:if> 
								    	<c:if test="${not empty list.studentVO.assignmentSubmitVOList}">${regdate}</c:if>
								    </td>
								    <td style="text-align: left;">
								    	<c:if test="${empty list.studentVO.assignmentSubmitVOList}"> </c:if> 
								    	<c:if test="${not empty list.studentVO.assignmentSubmitVOList}">
								    		<c:forEach items="${list.studentVO.assignmentSubmitVOList[0].assFileList }" var="file">
                              				<a href="/common/fileDownload.do?fileGroupNo=${file.fileGroupNo}&fileNo=${file.fileNo}"> 
												${file.fileName }
											<i class="bi bi-file-earmark-arrow-down"></i>
											</a><br>
										</c:forEach>
								    	</c:if>
								    </td>
								    <td>
								    	<c:if test="${empty list.studentVO.assignmentSubmitVOList}"><font color="red">미제출 </font></c:if> 
								    	<c:if test="${not empty list.studentVO.assignmentSubmitVOList}"><font color="green">제출완료 </font> </c:if>
								    </td>
								    <td>
 									    <form>
 									    	<div class="input-group">
												<input type="hidden" name="assNo" value="${assignmentVO.assNo }" >
								        		<input type="hidden" name="lecNo" value="${assignmentVO.lecNo }" >
												<input type="text" class="form-control" name="assSubScore" value="${list.studentVO.assignmentSubmitVOList[0].assSubScore }" max="${assignmentVO.assMaxscore}" >
												<button type="button" class="btn btn-primary clsInsertBtn" data-ass-sub-no="${list.studentVO.assignmentSubmitVOList[0].assSubNo}">저장</button>
 									    	</div>
 									    </form>
									</td>
 								</tr>		
 							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="card-footer clearfix" id="pagingArea">
					${pagingVO.pagingHTML }
				</div>
				<form id="pageInfo">
					<input type="hidden" name="page" id="page"> 
					<input type="hidden" name="lecNo" value="${param.lecNo }">
					<input type="hidden" name="assNo" value="${param.assNo }">
					<sec:csrfInput />
				</form>
				<!--/ Hoverable Table rows -->
			</div>


		</div>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
	$(document).on("keyup", "input[name^=assSubScore]", function() {
	    var val= $(this).val();
		var max = ${assignmentVO.assMaxscore};
		
	    if(val.replace(/[0-9]/g, "").length > 0) {
	        alert("숫자만 입력해 주십시오.");
	        $(this).val('');
	    }
	
	    if(val > max) {
	        alert("최대점수 범위내로 입력해 주십시오.");
	        $(this).val('');
	    }
	});
	
	$(function() {
		var pagingArea = $("#pagingArea");
		var pageInfo = $("#pageInfo");
		var modifyBtn = $("#modifyBtn");
		var deleteBtn = $("#deleteBtn");
		var insertBtn = $("#insertBtn");
		
		
		//점수 저장 버튼 클릭
		//<button class="btn btn-primary clsInsertBtn" data-ass-sub-no="ASS_SUB_20240001">저장</button>
		$(".clsInsertBtn").on("click",function(){
			//this : 클래스 중에서 클릭한 바로 그것
			let assSubNo = $(this).data("assSubNo");//ASS_SUB_20240001
			console.log("assSubNo : " + assSubNo);
			
			let assSubScore = $(this).parent().children("input[name='assSubScore']").val();
			console.log("assSubScore : " + assSubScore);
			
			let lecNo = $(this).parent().children("input").eq(1).val();
			console.log("lecNo : " + lecNo);
			
			//JSON오브젝트
			let data = {
				"assSubNo":assSubNo,	
				"assSubScore":assSubScore,	
				"lecNo":lecNo	
			};
			console.log("data : ", data);
			
			$.ajax({
				url:"/professor/updateAssignmentScore.do",
				contentType:"application/json;charset:utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					Swal.fire({
                        title: '저장완료',
                        text: '저장이 완료되었습니다.',
                        icon: 'success',
                        confirmButtonText: '확인'
                    })
					console.log("result : ", result);
				}
			});
		});
		
		modifyBtn.on("click", function(){
			location.href="/professor/updateAssignment.do?lecNo=${param.lecNo}&assNo=${param.assNo}"
		})
		
		deleteBtn.on("click", function(){
			if(confirm("정말로 삭제하시겠습니까?")){
		         delForm.submit();
		     }
		})
		
/* 		insertBtn.on("click", function(){
			console.log("클릭!");
			alert("저장 ");
			scoreForm.submit();
			
		}) */
		
		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page");
			// 검색시 사용할 form 태그안에 넣어준다. 
			// 검색시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
			pageInfo.find("#page").val(pageNo);
			pageInfo.submit();
		})

	})
</script>
</html>
