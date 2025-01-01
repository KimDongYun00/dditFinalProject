package kr.or.ddit.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.admin.inter.IAdminFreeBoardService;
import kr.or.ddit.vo.FreeBoardVO;
import kr.or.ddit.vo.FreeCommentVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminFreeBoardController {

	@Inject
	private IAdminFreeBoardService service;

	@RequestMapping(value = "/freeList", method = RequestMethod.GET)
	public String freeboardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword, Model model) {
		// 한 화면에 보여질 게시글의 수
		int itemsPerPage = 10;

		Map<String, Object> map = new HashMap<>();
		// 현재 페이지 번호
		map.put("page", page);
		// 한 화면에 보여질 글의 수
		map.put("itemsPerPage", itemsPerPage);
		// 검색어
		map.put("keyword", keyword);

		// freeboard 테이블의 전체 행의 수
		int totalItems = service.getFreeBoardCount(map);

		// 전체 페이지 수 구하기
		int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

		List<FreeBoardVO> freeboardList = service.freeList(map);

		// 페이징 정보 설정
		PaginationInfoVO<FreeBoardVO> paginationInfoVO = new PaginationInfoVO<>(itemsPerPage, 5);
		paginationInfoVO.setTotalRecord(totalItems);
		paginationInfoVO.setCurrentPage(page);

		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("paginationInfoVO", paginationInfoVO); // paginationInfoVO가 꼭 있어야 함
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "sum/admin/board/adminFreeboardList";
	}

	// 상세
	@RequestMapping(value = "/freeDetail/{freeNo}", method = RequestMethod.GET)
	public String freeboardDetail(@PathVariable("freeNo") String freeNo, Model model) {
		service.incrementViewCount(freeNo);
		FreeBoardVO freeboardVO = service.detail(freeNo);
		List<FreeCommentVO> commentList = service.getCommentsByFreeNo(freeNo);
		model.addAttribute("freeboard", freeboardVO);
		model.addAttribute("commentList", commentList);
		return "sum/admin/board/adminFreeboardDetail";
	}

	// 새 글 등록
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/freeWrite", method = RequestMethod.GET)
	public String freeboardWriteForm() {
		return "sum/admin/board/adminFreeboardInsert";
	}

//    @PreAuthorize("hasRole('ROLE_ADMIN')")
//    @RequestMapping(value = "/freeWrite", method = RequestMethod.POST)
//    public String freeboardWrite(FreeBoardVO freeboardVO, Model model) {
//        service.freeboardInsert(freeboardVO);
//        model.addAttribute("message", "새 글 등록이 완료되었습니다!");
//        return "redirect:/admin/freeList";
//    }

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/freeWrite", method = RequestMethod.POST)
	public String freeboardWrite(FreeBoardVO freeboardVO, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		String userNo = user.getUsername();
		String freeWriter = user.getUsername();

		freeboardVO.setUserNo(userNo);
		freeboardVO.setFreeWriter(freeWriter);

		service.freeboardInsert(freeboardVO);
		model.addAttribute("message", "새 글 등록이 완료되었습니다!");
		return "redirect:/admin/freeList";
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/freeUpdate", method = RequestMethod.POST)
	public String freeboardUpdate(FreeBoardVO freeboardVO, Model model) {
		service.freeboardUpdate(freeboardVO);
		model.addAttribute("message", "글 수정이 완료되었습니다!");
		return "redirect:/admin/freeDetail/" + freeboardVO.getFreeNo();
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/freeDelete", method = RequestMethod.POST)
	public String freeboardDelete(@RequestParam("freeNo") String freeNo, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		String userNo = user.getUsername();
		String freeWriter = user.getUsername();

		service.freeboardDelete(freeNo);
		model.addAttribute("message", "게시글이 삭제되었습니다!");
		return "redirect:/admin/freeList";
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/freeDeleteMultiple", method = RequestMethod.POST)
	public String freeboardDeleteMultiple(@RequestParam("freeNoList") List<String> freeNoList, Model model) {
		for (String freeNo : freeNoList) {
			service.freeboardDelete(freeNo);
		}
		model.addAttribute("message", "선택한 게시글들이 삭제되었습니다!");
		return "redirect:/admin/freeList";
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/freeCommentInsert", method = RequestMethod.POST)
	public String freeCommentInsert(FreeCommentVO freeCommentVO, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		String userNo = user.getUsername();
		String fcWriter = user.getUsername();

		freeCommentVO.setUserNo(userNo);
		freeCommentVO.setFcWriter(fcWriter);

		service.freecommentInsert(freeCommentVO);
		model.addAttribute("message", "댓글 등록이 완료되었습니다!");
		return "redirect:/admin/freeDetail/" + freeCommentVO.getFreeNo();
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/freeCommentUpdate", method = RequestMethod.POST)
	public String freeCommentUpdate(FreeCommentVO freeCommentVO, Model model) {
		service.freeCommentUpdate(freeCommentVO);
		model.addAttribute("message", "댓글 수정이 완료되었습니다!");
		return "redirect:/admin/freeDetail/" + freeCommentVO.getFreeNo();
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/freeCommentDelete", method = RequestMethod.POST)
	public String freeCommentDelete(FreeCommentVO freeCommentVO, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		String userNo = user.getUsername();
		freeCommentVO.setUserNo(userNo);

		service.freeCommentDelete(freeCommentVO);
		model.addAttribute("message", "댓글 삭제가 완료되었습니다!");
		return "redirect:/admin/freeDetail/" + freeCommentVO.getFreeNo();
	}

}
