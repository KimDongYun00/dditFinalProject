<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>신고게시판 > 상세보기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f6f9;
}

.card {
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	background-color: #fff;
}

.card-header {
	color: black;
	border-bottom: none;
	border-radius: 8px 8px 0 0;
}

.card-body {
	background-color: #fff;
	padding: 20px;
}

.form-group {
	margin-bottom: 1rem;
}

.form-group label {
	font-size: 1.25rem;
}

.form-control-plaintext {
	padding-left: 0;
}

.border {
	border-radius: 4px;
}
</style>
</head>
<body>
	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="py-3 mb-4" style="font-weight: bold; padding-left: 20px;">신고
			상세보기</h4>
		<div class="row">
			<div class="col-xl-12">
				<div class="card mb-4 bg-white">
					<h5 class="card-header">신고 상세 정보</h5>
					<hr class="my-0">
					<div class="card-body">
						<div class="form-group row">
							<label class="col-sm-2 col-form-label" for="repNo"><font
								size="4">신고번호</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="repNo" id="repNo"
									value="${report.repNo}" readonly="readonly">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label" for="userNo"><font
								size="4">사용자번호</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="userNo"
									id="userNo" value="${report.userNo}" readonly="readonly">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label" for="repReason"><font
								size="4">신고사유</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="repReason"
									id="repReason" value="${report.repReason}" readonly="readonly">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label" for="repDate"><font
								size="4">신고일</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="repDate"
									id="repDate" value="${report.repDate}" readonly="readonly">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label" for="boardPkNo"><font
								size="4">게시판기본키</font></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="boardPkNo"
									id="boardPkNo" value="${report.boardPkNo}" readonly="readonly">
							</div>
						</div>
					</div>
					<div class="card-footer">
						<a href="${pageContext.request.contextPath}/admin/ReportList"
							class="btn btn-primary">목록으로</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(function() {
			$("#listBtn")
					.on(
							'click',
							function() {
								location.href = "${pageContext.request.contextPath}/admin/ReportList";
							});
		});
	</script>
</body>
</html>