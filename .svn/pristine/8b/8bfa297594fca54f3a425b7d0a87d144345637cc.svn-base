package kr.or.ddit.controller.admin;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.or.ddit.service.admin.inter.IAdminFoodBoardService;
import kr.or.ddit.vo.FoodBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminFoodBoardController {

	@Inject
	private IAdminFoodBoardService service;

	// ★ 페이징 처리
	@RequestMapping(value = "/foodList", method = RequestMethod.GET)
	public String foodboardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword, Model model) {
		int itemsPerPage = 10;

		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("itemsPerPage", itemsPerPage);
		map.put("keyword", keyword);

		int totalItems = service.getFoodBoardCount(map);
		int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

		List<FoodBoardVO> foodboardList = service.foodList(map);

		PaginationInfoVO<FoodBoardVO> paginationInfoVO = new PaginationInfoVO<>(itemsPerPage, 5);
		paginationInfoVO.setTotalRecord(totalItems);
		paginationInfoVO.setCurrentPage(page);

		model.addAttribute("foodboardList", foodboardList);
		model.addAttribute("paginationInfoVO", paginationInfoVO);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "sum/admin/board/adminFoodboardList";
	}

	/// 상세
	@RequestMapping(value = "/foodDetail/{foodNo}", method = RequestMethod.GET)
	public String foodboardDetail(@PathVariable("foodNo") String foodNo, Model model) {
		//238
		log.info("foodBoardDetail->foodNo : " + foodNo);
		FoodBoardVO foodboardVO = service.detail(foodNo);
		model.addAttribute("foodboard", foodboardVO);
		return "sum/admin/board/adminFoodboardDetail";
	}

	// 등록
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/foodInsert", method = RequestMethod.GET)
	public String foodboardWriteForm() {
		return "sum/admin/board/adminFoodboardInsert";
	}

	// 등록
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/foodInsert")
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
		return "sum/admin/board/adminFoodboardList";
	}

	// 수정
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/foodBoardUpdate")
	@ResponseBody
	public Map<String, Object> foodboardUpdate(@RequestBody FoodBoardVO foodBoardVO, Principal principal) {
		String userNo = principal.getName();
		foodBoardVO.setUserNo(userNo);

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
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/foodBoardDelete/{foodNo}")
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
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/recommend/{foodNo}")
	@ResponseBody
	public Map<String, Object> recommendFood(@PathVariable("foodNo") String foodNo, Principal principal) {
		String userNo = principal.getName();
		Map<String, Object> response = new HashMap<>();
		try {
			boolean success = service.recommendFood(foodNo, userNo);
			if (success) {
				int recommendCount = service.getRecommendCount(foodNo);
				response.put("status", "success");
				response.put("message", "추천이 완료되었습니다!");
				response.put("recommendCount", recommendCount);
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
	
	// 체크박스 삭제
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/foodBoardDeleteMulti")
	@ResponseBody
	public Map<String, Object> foodboardDeleteMulti(@RequestParam("foodNos") List<String> foodNos, Principal principal) {
	    String userNo = principal.getName();

	    Map<String, Object> response = new HashMap<>();
	    try {
	        for (String foodNo : foodNos) {
	            FoodBoardVO foodBoardVO = new FoodBoardVO();
	            foodBoardVO.setFoodNo(foodNo);
	            foodBoardVO.setUserNo(userNo);
	            service.foodBoardDelete(foodBoardVO);
	        }
	        response.put("status", "success");
	        response.put("message", "선택한 게시글 삭제가 완료되었습니다!");
	    } catch (Exception e) {
	        response.put("status", "fail");
	        response.put("message", "선택한 게시글 삭제에 실패했습니다.");
	    }

	    return response;
	}

	



}
