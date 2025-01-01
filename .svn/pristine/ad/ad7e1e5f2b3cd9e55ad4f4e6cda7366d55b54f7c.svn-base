<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<div class="card-header">
			<h5>금주 식단표</h5>
			<hr>
		</div>
		<div class="card-body">
			<table class="table table-hover" style="text-align: center;">
				<tr>
					<th></th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
					<th>일</th>
				</tr>	
				<tr>  
					<th>아침</th>
					<c:forEach items="${mList }" var ="mor">					
						<td>${mor.menuFood } ${mor.menuPrice }원</td>	
					</c:forEach>				
				</tr>			
				<tr>
					<th>점심</th>
					<c:forEach items="${lList }" var ="lan">					
						<td>${lan.menuFood } ${lan.menuPrice }원</td>	
					</c:forEach>					
				</tr>			
				<tr>
					<th>저녘</th>
					<c:forEach items="${dList }" var ="din">					
						<td>${din.menuFood } ${din.menuPrice }원</td>	
					</c:forEach>					
				</tr>			
			</table>
		</div>
		<div class="card-footer"></div>
	</div>
	
	<div class="row mb-3"></div>
	<div class="card"> 
		<div class="card-header">
			<h4>금주 식단표 수정폼</h4>
			<hr>		
		</div>
		<div class="card-body">
			<div class="row mb-3">
			<form action="/menu/menuInsert" method = "post" id="menuForm">
			<table class="table table-hover">
				<thead>
					<tr style="text-align: center;">
						<th width="5%"></th>	
						<th colspan="">월요일</th>
						
						<th colspan="">화요일</th>
							
						<th colspan="">수요일</th>
							
						<th colspan="">목요일</th>	
						<th colspan="">금요일</th>	
						<th colspan="">토요일</th>	
						<th colspan="">일요일</th>	
					</tr>	
				</thead>
							
				<tbody>
					<tr>
						<th>아침</th>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="mm1" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="mp1" value=""></td>											
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="mm2" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="mp2" value=""></td>						
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="mm3" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="mp3" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="mm4" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="mp4" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="mm5" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="mp5" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="mm6" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="mp6" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="mm7" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="mp7" value=""></td>
					</tr>
					<tr>
						<th>점심</th>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="lm1" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="lp1" value=""></td>											
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="lm2" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="lp2" value=""></td>						
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="lm3" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="lp3" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="lm4" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="lp4" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="lm5" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="lp5" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="lm6" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="lp6" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="lm7" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="lp7" value=""></td>
					</tr>
					<tr>
						<th>저녘</th>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="dm1" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="dp1" value=""></td>											
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="dm2" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="dp2" value=""></td>						
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="dm3" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="dp3" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="dm4" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="dp4" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="dm5" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="dp5" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="dm6" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="dp6" value=""></td>
						<td class="">메뉴 : <input placeholder="메뉴입력" type="text" class="form-control" name="dm7" value="">가격 : <input placeholder="가격입력" type="number" class="form-control" name="dp7" value=""></td>
					</tr>
				</tbody>
				
			</table>
			</form>							
			</div>
		</div>
		<div class="card-footer" align="right">
			<button class="btn btn-primary" id="modifyBtn">수정</button>
		</div>
	</div>
	

</div>
<script>
$(function(){
	var mmL = [];
	var mpL = [];
	var lmL = [];
	var lpL = [];
	var dmL = [];
	var dpL = [];
	
	// 수정 버튼 클릭시
	$("#modifyBtn").click(function(){
		for(var i=1; i<=7; i++){
			mm = $('input[name=mm'+i+']').val();
			mp = $('input[name=mp'+i+']').val();
			lm = $('input[name=lm'+i+']').val();
			lp = $('input[name=lp'+i+']').val();
			dm = $('input[name=dm'+i+']').val();
			dp = $('input[name=dp'+i+']').val();
			
			if(mm == null || mm == ""){
				swal("내용 입력 x","비어있는 내용이 있습니다.", "error");
				return false;
			}
			if(mp == null || mp == ""){
				swal("내용 입력 x","비어있는 내용이 있습니다.", "error");
				return false;
			}
			if(lm == null || lm == ""){
				swal("내용 입력 x","비어있는 내용이 있습니다.", "error");
				return false;
			}
			if(lp == null || lp == ""){
				swal("내용 입력 x","비어있는 내용이 있습니다.", "error");
				return false;
			}
			if(dm == null || dm == ""){
				swal("내용 입력 x","비어있는 내용이 있습니다.", "error");
				return false;
			}
			if(dp == null || dp ==  ""){
				swal("내용 입력 x","비어있는 내용이 있습니다.", "error");
				return false;
			}
			mmL.push(mm);
			mpL.push(mp);
			lmL.push(lm);
			lpL.push(lp);
			dmL.push(dm);
			dpL.push(dp);
		}
// 			console.log(mmL + mpL + lmL + lpL + dmL + dpL);
		
		data = {
					mmL : mmL
				,	mpL : mpL
				,	lmL : lmL
				,	lpL : lpL
				,	dmL : dmL
				,	dpL : dpL			
			}
		
		$.ajax({
			url : "/menu/insertMenu",
			data : JSON.stringify(data),
			type : "post",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			contentType : "application/json; charset=utf-8",
			success : function(res){
				swal("메뉴 변경 성공", "메뉴 변경 작업이 완료되었습니다.", "success")
				.then(function(){
					location.reload(true);					
				});
			}
		})
	});
	
})
</script> 