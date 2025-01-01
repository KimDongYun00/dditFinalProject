package kr.or.ddit.controller.professor;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.professor.inter.IFoodBoardService;
import kr.or.ddit.vo.FoodBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/professor")
public class ProFoodBoardController {
	@Inject
	private IFoodBoardService service;

	// ★ 페이징 처리
	// required=false 는 /student/foodList 이어도 오류가 아님
	@RequestMapping(value = "/foodList", method = RequestMethod.GET)
	public String foodboardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword, Model model) {
		// 한 화면에 보여질 게시글의 수
		int itemsPerPage = 10;

		Map<String, Object> map = new HashMap<String, Object>();
		// 현재 페이지 번호
		map.put("page", page);
		// 한 화면에 보여질 글의 수
		map.put("itemsPerPage", itemsPerPage);
		// 검색어
		map.put("keyword", keyword);

		// foodboard 테이블의 전체 행의 수
		int totalItems = service.getFoodBoardCount(map);

		// 전체 페이지 수 구하기
		// 97행 / 게시글 10개씩 보이게 함 => 97 / 10 = 9.7 => 10페이지
		int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

		List<FoodBoardVO> foodboardList = service.foodList(map);

		// 5개 => [1] [2] [3] [4] [5]
		PaginationInfoVO<FoodBoardVO> paginationInfoVO = new PaginationInfoVO<FoodBoardVO>(itemsPerPage, 5);
		paginationInfoVO.setTotalRecord(totalItems);
		paginationInfoVO.setCurrentPage(page);

		model.addAttribute("foodboardList", foodboardList);
		model.addAttribute("paginationInfoVO", paginationInfoVO); // paginationInfoVO가 꼭있어야함 ★★★★★
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "sum/professor/board/foodboardList";
	}

	/// 상세
	@RequestMapping(value = "/foodDetail/{foodNo}", method = RequestMethod.GET)
	public String foodboardDetail(@PathVariable("foodNo") String foodNo, Model model, 
			Principal principal) {
		if(principal == null) {
			return "redirect:/common/login";
		}
		//foodboardDetail->foodNo : 238
		log.info("foodboardDetail->foodNo : " + foodNo);
		
		FoodBoardVO foodboardVO = service.detail(foodNo);
		log.info("foodboardDetail->foodboardVO : " + foodboardVO);
		
		model.addAttribute("foodboard", foodboardVO);
		return "sum/professor/board/foodboardDetail";
	}

	// 등록 
	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/foodInsert", method = RequestMethod.GET)
	public String foodboardWriteForm() {
		return "sum/professor/board/foodboardInsert";
	}

	// 등록
	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/foodInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> foodboardWrite(FoodBoardVO foodboardVO, Principal principal) {
		String userNo = principal.getName();
		
		foodboardVO.setUserNo(userNo);
		foodboardVO.setFoodWriter(userNo);
		Map<String, Object> response = new HashMap<>();
		try {
			service.foodboardInsert(foodboardVO);
			response.put("status", "success"); 
			response.put("message", "맛집 등록이 완료되었습니다!");
		} catch (Exception e) {
			response.put("status", "fail");
			response.put("message", "맛집 등록에 실패했습니다.");
		}
		return response;
	}

	// 검색
	@RequestMapping(value = "/foodSearch", method = RequestMethod.GET)
	public String searchFood(@RequestParam("keyword") String keyword, Model model) {
		List<FoodBoardVO> searchResults = service.searchFood(keyword);
		model.addAttribute("foodboardList", searchResults);
		return "sum/professor/board/foodboardList";
	}

	// 수정
	@PreAuthorize("hasRole('ROLE_STUDENT')")
	@RequestMapping(value = "/foodBoardUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> foodboardUpdate(@RequestBody FoodBoardVO foodBoardVO, Principal principal) {
		String userNo = principal.getName();
		foodBoardVO.setUserNo(userNo);

		/*
		 * FoodBoardVO(foodNo=41, userNo=12341234, foodTitle=asdsdsd2, foodWriter=null,
		 * foodContent=sdsdsd3 , foodCnt=0, foodDate=null, foodMapx=null, foodMapy=null,
		 * recommendCount=0)
		 */
		log.info("foodBoardVO : " + foodBoardVO);

		Map<String, Object> response = new HashMap<>();
		try {
			service.foodBoardUpdate(foodBoardVO);
			response.put("status", "success");
			response.put("message", "게시글 수정이 완료되었습니다!");
		} catch (Exception e) {
			response.put("status", "fail");
			response.put("message", "게시글 수정에 실패했습니다.");
		}

		return response;
	}

	// 삭제
	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/foodBoardDelete/{foodNo}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> foodboardDelete(@PathVariable("foodNo") String foodNo, Principal principal) {
		String userNo = principal.getName();
		FoodBoardVO foodBoardVO = new FoodBoardVO();
		foodBoardVO.setFoodNo(foodNo);
		foodBoardVO.setUserNo(userNo);

		Map<String, Object> response = new HashMap<>();
		try {
			service.foodBoardDelete(foodBoardVO);
			response.put("status", "success");
			response.put("message", "게시글 삭제가 완료되었습니다!");
		} catch (Exception e) {
			response.put("status", "fail");
			response.put("message", "게시글 삭제에 실패했습니다.");
		}

		return response;
	}

	// 추천
	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/recommend/{foodNo}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> recommendFood(@PathVariable("foodNo") String foodNo, Principal principal) {
		String userNo = principal.getName();
		Map<String, Object> response = new HashMap<>();
		try {
			boolean success = service.recommendFood(foodNo, userNo);
			if (success) {
				int recommendCount = service.getRecommendCount(foodNo); // 추천 수 조회
				response.put("status", "success");
				response.put("message", "추천이 완료되었습니다!");
				response.put("recommendCount", recommendCount); // 추천 수 추가
			} else {
				response.put("status", "fail");
				response.put("message", "이미 추천하였습니다!");
			}
		} catch (Exception e) {
			response.put("status", "fail");
			response.put("message", "추천에 실패했습니다.");
		}
		return response;
	}

}

