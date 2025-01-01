<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<style>

.card-header {
	background : #dddddd;
	padding : 1% 2% 0% 2%;
	border-radius: 10px;
}

.searchWord{
	color : black;
	font-size : 1.2rem;
	text-align : center;
}

#searchBtn {
	font-weight : bold;
	background:skyblue;
}

.hoverColor{
	background:skyblue;
}

</style>



<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="py-3 mb-4" style="font-weight:bold; padding-left:20px;">강의관리</h4>
	<div class="row">
		<div class="col-xl-12">
			<div class="card mb-4 bg-white">
				<div class="card-header">
					<form action="" method="get" id="searchFrm">
						<sec:csrfInput/>
						<input type="hidden" name="page" id="page">
						<div class="row mb-3" id="searchDiv">
							
							<div class="col-sm-12">
								<div class="input-group">
									<label class="input-group-text" for="searchYear">년도/학기</label>
									<c:set value="${pagingVO.searchYear }" var="year"/>
									<c:if test="${year eq '99' }">
										<c:set value="" var="year"/>
									</c:if>
									<c:set value="${pagingVO.searchSemester }" var="semester"/>
									<c:if test="${semester eq '99' }">
										<c:set value="" var="semester"/>
									</c:if>
									<input class="form-control" type="text" name="searchYear" id="searchYear" 
										placeholder="year" value="${year }">
									<input class="form-control" type="text" name="searchSemester" id="searchSemester" 
										placeholder="semester" value="${semester }">
									<label class="input-group-text" for="searchScore">학점</label>
									<select class="form-select" name="searchScore" id="searchScore">
										<option></option>
										<option value="2" <c:if test="${pagingVO.searchScore == 2 }">selected='selected'</c:if>>2학점</option>
										<option value="3" <c:if test="${pagingVO.searchScore == 3 }">selected='selected'</c:if>>3학점</option>
									</select>
									<label class="input-group-text" for="searchAge">학년</label>
									<select class="form-select" name="searchAge" id="searchAge">
										<option></option>
										<option value="1" <c:if test="${pagingVO.searchAge == 1 }">selected='selected'</c:if>>1학년</option>
										<option value="2" <c:if test="${pagingVO.searchAge == 2 }">selected='selected'</c:if>>2학년</option>
										<option value="3" <c:if test="${pagingVO.searchAge == 3 }">selected='selected'</c:if>>3학년</option>
										<option value="4" <c:if test="${pagingVO.searchAge == 4 }">selected='selected'</c:if>>4학년</option>
										<option value="5" <c:if test="${pagingVO.searchAge == 5 }">selected='selected'</c:if>>5학년</option>
									</select>
									<label class="input-group-text" for="searchOnoff">대면여부</label>
									<select class="form-select" name="searchOnoff" id="searchOnoff">
										<option></option>
										<option value="Y" <c:if test="${pagingVO.searchOnoff == 'Y' }">selected='selected'</c:if>>대면</option>
										<option value="N" <c:if test="${pagingVO.searchOnoff == 'N' }">selected='selected'</c:if>>비대면</option>
									</select>
									<label class="input-group-text" for="searchConType">승인여부</label>
									<select class="form-select" name="searchConType" id="searchConType">
										<option></option>
										<c:forEach items="${comCNoList }" var="comCon">
											<option value="${comCon.comDetNo }"
												<c:if test="${comCon.comDetNo eq pagingVO.searchConType }">
													selected='selected'
												</c:if>>
												${comCon.comDetName }
											</option>
										</c:forEach>
									</select>
								</div>
								<div class="input-group">
									<label class="input-group-text" for="searchLecType">강의구분</label>
									<select class="form-select" name="searchLecType" id="searchLecType">
										<option></option>
										<c:forEach items="${comLNoList }" var="comLec">
											<option value="${comLec.comDetNo }" 
												<c:if test="${comLec.comDetNo eq pagingVO.searchLecType }">
													selected='selected'
												</c:if>>
												${comLec.comDetName }
											</option>
										</c:forEach>
									</select>
									<select class="form-select" name="searchType" id="searchType">
										<option value="1" <c:if test="${pagingVO.searchType == 1 }">selected='selected'</c:if>>강의명</option>
										<option value="2" <c:if test="${pagingVO.searchType == 2 }">selected='selected'</c:if>>교수명</option>
									</select>
									<input class="form-control" style="width:60%;" name="searchWord" id="searchWord">
									<button class="btn btn-outline" id="searchBtn">검색</button>
								</div>
							</div>
						
						</div>
					</form>
				</div>
				<hr class="my-0">
				<div class="table-responsive text-nowrap">
    				<table class="table table-hover" style="overflow:hidden;">
      					<thead>
        					<tr>
					          	<th width="10%">강의구분</th>
					          	<th width="25%">강의명</th>
					          	<th width="15%">교수명</th>
					          	<th width="10%">수강학년</th>
					          	<th width="10%">학점</th>
					          	<th width="15%">년도/학기</th>
					          	<th width="10%">대면여부</th>
					          	<th width="10%">승인여부</th>
					     	</tr>
      					</thead>
      					<tbody class="table-border-bottom-0" id="tbody">
      						<c:choose>
      							<c:when test="${pagingVO.dataList ne null}">
		      						<c:forEach items="${pagingVO.dataList }" var="lecture" varStatus="status">
			      						<tr>
			      							<td>${lecture.comDetLName }</td>
			      							<td class="lecNo" data-no="${lecture.lecNo }">${lecture.lecName }</td>
			      							<td>${lecture.proName }</td>
			      							<td>${lecture.lecAge }</td>
			      							<td>${lecture.lecScore }</td>
			      							<td>${lecture.year } / ${lecture.semester }</td>
			      							<td>${lecture.lecOnoff }</td>
			      							<td>${lecture.comDetCName }</td>
			      						</tr>      						
			      					</c:forEach>
      							</c:when>
      							<c:otherwise>
      								<tr>
      									<td colspan="7">없음</td>
      								</tr>
      							</c:otherwise>
      						</c:choose>
      					</tbody>
   	 				</table>
  				</div>
  				<form action="" method="get" id="searchForm">
  					<sec:csrfInput/>
  					<input type="hidden" name="page" id="page">
  				</form>
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



<script>

$(function(){
	
	var insertBtn = $("#insertBtn");
	var searchBtn = $("#searchBtn");
	var searchForm = $("#searchForm");
	var pagingDiv = $("#pagingDiv");
	
	pagingDiv.on("click", "a", function(event){
		event.preventDefault();	// a태그의 href속성 이벤트를 꺼준다.
		var pageNo = $(this).data("page");	// pageNo 전달
		
		// 검색 시 사용할 form태그 안에 넣어준다.
		// 검색 시 사용할 form 태그를 활용해서 검색도하고 페이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	searchBtn.on('click', function(){
		
		var year = $("#searchYear").val();
		var semester = $("#searchSemester").val();
		
		if(year != "" && (2000 > year || 2024 < year)){
			alert("2000~2024사이의 년도만 검색 가능합니다.");
			return false;
		}
		
		if(semester != "" && (1 > semester || 2 < semester)){
			alert("1~2학기만 검색 가능합니다.");
			return false;
		}
		
		searchFrm.submit();
	});
	
	insertBtn.on('click', function(){
		location.href="/admin/lectureInsertForm";
	});
	
	$(".lecNo").on('click', function(){
		console.log("lecNo click!");
		
		var lecNo = $(this).attr("data-no");
		
		location.href="/admin/lectureDetail?lecNo="+lecNo;
	});
	
	
});

</script>






















