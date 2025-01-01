<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>신고 게시판</title>
<meta id="_csrf" name="_csrf" content="${_csrf.token}">
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 50%;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>
</head>
<body>
	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="py-3 mb-4" style="font-weight: bold;">신고 게시판</h4>
		<div class="row">
			<div class="col-xl-12">
				<form id="searchForm">
					<input type="hidden" name="page" value="${param.page}" id="page">
					<div class="input-group input-group-sm mb-3" style="width: 300px;">
						<input type="text" name="keyword" class="form-control"
							value="${param.keyword}" placeholder="Search">
						<div class="input-group-append">
							<button type="button" id="btnSearch" class="btn btn-default">검색</button>
						</div>
						<sec:csrfInput />
					</div>
				</form>
			</div>
		</div>

		<div class="row">
			<div class="col-xl-12">
				<div class="card mb-4 bg-white">
					<h5 class="card-header">신고 목록</h5>
					<div class="table-responsive text-nowrap">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 6%">번호</th>
									<th style="width: 50%">사유</th>
									<th style="width: 12%">신고일</th>
									<th style="width: 12%">상세보기</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty reportList}">
										<c:forEach var="report" items="${reportList}"
											varStatus="status">
											<tr>
												<td>${report.rnum}</td>
												<td><c:out value="${report.repReason}" /></td>
												<td><c:out value="${report.repDate}" /></td>
												<td>
													<button type="button" class="btn btn-primary open-modal"
														data-repno="${report.repNo}">삭제</button>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="4" style="text-align: center;">신고된 게시글이
												없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>

						</table>
					</div>
					<div class="card-footer clearfix" align="right" id="pagingArea">
						${paginationInfoVO.pagingHTML}</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 모달 -->
	<div id="reportModal" class="modal">
		<div class="modal-content">
			<h5 class="modal-title" id="reportModalLabel">신고 상세 정보</h5>
			<div id="modalContent">
				<div class="form-group row">
					<label class="col-sm-4 col-form-label" for="repNo">신고번호</label>
					<div class="col-sm-8">
						<p id="modalRepNo" class="form-control-plaintext"></p>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 col-form-label" for="userNo">사용자번호</label>
					<div class="col-sm-8">
						<p id="modalUserNo" class="form-control-plaintext"></p>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 col-form-label" for="repReason">신고사유</label>
					<div class="col-sm-8">
						<p id="modalRepReason" class="form-control-plaintext"></p>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 col-form-label" for="repDate">신고일</label>
					<div class="col-sm-8">
						<p id="modalRepDate" class="form-control-plaintext"></p>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 col-form-label" for="boardPkNo">게시판기본키</label>
					<div class="col-sm-8">
						<p id="modalBoardPkNo" class="form-control-plaintext"></p>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 col-form-label" for="comDetxNo">공통코드신고</label>
					<div class="col-sm-8">
						<p id="modalComDetxNo" class="form-control-plaintext"></p>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary close">취소</button>
				<button type="button" class="btn btn-primary" id="deleteReportBtn">삭제</button>
			</div>
		</div>
	</div>

	<script>
		$(function() {
			$(".page-link").on("click", function(event) {
				event.preventDefault();
				let page = $(this).data("page");
				$("#page").val(page);
				$("#searchForm").submit();
			});

			$("#btnSearch").on("click", function() {
				$("#page").val(1);
				$("#searchForm").submit();
			});
		});
		
		$(function() {
		    $(".open-modal").on("click", function() {
		        var repNo = $(this).data('repno');
		        $.ajax({
		            url: '${pageContext.request.contextPath}/admin/ReportDetail',
		            type: 'GET',
		            data: { repNo: repNo },
		            success: function(data) {
		                $('#modalRepNo').text(data.repNo);
		                $('#modalUserNo').text(data.userNo);
		                $('#modalRepReason').text(data.repReason);
		                $('#modalRepDate').text(data.repDate);
		                $('#modalBoardPkNo').text(data.boardPkNo);
		                $('#modalComDetxNo').text(data.comDetxNo);
		                $('#deleteReportBtn').data('repno', repNo);
		                $("#reportModal").css("display", "block");
		            }
		        });
		    });

		    $(".close").on("click", function() {
		        $("#reportModal").css("display", "none");
		    });

		    $('#deleteReportBtn').on('click', function() {
		        var repNo = $(this).data('repno');
		        if (confirm('신고된 게시글을 삭제하시겠습니까?')) {
		            $.ajax({
		                url: '${pageContext.request.contextPath}/admin/deleteReportAndFreeBoard',
		                type: 'POST',
		                data: {
		                    repNo: repNo,
		                    _csrf: $('input[name="_csrf"]').val()
		                },
		                success: function() {
		                    $(`button[data-repno="\${repNo}"]`).text('내역보기');
		                    $("#reportModal").css("display", "none");
		                    $("#deleteReportBtn").hide(); // 취소 버튼 숨기기
		                }
		            });
		        }
		    });

		    $(window).on("click", function(event) {
		        if ($(event.target).is("#reportModal")) {
		            $("#reportModal").css("display", "none");
		        }
		    });
		});

	</script>
</body>
</html>