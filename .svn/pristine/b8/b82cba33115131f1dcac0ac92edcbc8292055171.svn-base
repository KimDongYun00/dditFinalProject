package kr.or.ddit.controller.professor;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.professor.inter.IFreeBoardService;
import kr.or.ddit.vo.FreeBoardVO;
import kr.or.ddit.vo.FreeCommentVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ReportVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/professor")
public class ProFreeBoardController {
	@Inject
	BCryptPasswordEncoder bcryptPasswordEncoder;

	@Inject
	private IFreeBoardService service;

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

		return "sum/professor/board/freeboardList";
	}

	@RequestMapping(value = "/freeDetail/{freeNo}", method = RequestMethod.GET)
	public String freeboardDetail(@PathVariable("freeNo") String freeNo, Model model) {
		String encodedPwd = bcryptPasswordEncoder.encode("1234");
		log.info("freeboardDetail->encodedPwd : " + encodedPwd);

		service.incrementViewCount(freeNo);
		FreeBoardVO freeboardVO = service.detail(freeNo);
		List<FreeCommentVO> commentList = service.getCommentsByFreeNo(freeNo);
		model.addAttribute("freeboard", freeboardVO);
		model.addAttribute("commentList", commentList);
		return "sum/professor/board/freeboardDetail";
	}

	@RequestMapping(value = "/freeSearch", method = RequestMethod.GET)
	public String search(@RequestParam("keyword") String keyword, Model model) {
		List<FreeBoardVO> searchResults = service.search(keyword);
		model.addAttribute("freeboardList", searchResults);
		model.addAttribute("keyword", keyword);
		return "sum/professor/board/freeboardList";
	}

	@RequestMapping(value = "/freeWrite", method = RequestMethod.GET)
	public String freeboardWriteForm() {
		return "sum/professor/board/freeboardInsert";
	}

	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/freeWrite", method = RequestMethod.POST)
	public String freeboardWrite(FreeBoardVO freeboardVO, Model model, Principal principal) {
		String userNo = principal.getName();
		freeboardVO.setUserNo(userNo);
		service.freeboardInsert(freeboardVO);
		model.addAttribute("message", "새 글 등록이 완료되었습니다!");
		return "redirect:/professor/freeList";
	}

	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/freeCommentInsert", method = RequestMethod.POST)
	public String freeComment(FreeCommentVO freeCommentVO, Model model, Principal principal) {
		String user_no = principal.getName();
		freeCommentVO.setUserNo(user_no);
		freeCommentVO.setFcWriter("익명");
		service.freecommentInsert(freeCommentVO);
		model.addAttribute("message", "댓글 등록이 완료되었습니다!");
		return "redirect:/professor/freeDetail/" + freeCommentVO.getFreeNo();
	}

	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/freeCommentUpdate", method = RequestMethod.POST)
	public String freeCommentUpdate(FreeCommentVO freeCommentVO, Model model, Principal principal) {
		String userNo = principal.getName();
		freeCommentVO.setUserNo(userNo);
		freeCommentVO.setFcWriter("익명");
		service.freeCommentUpdate(freeCommentVO);
		model.addAttribute("message", "댓글 수정이 완료되었습니다!");
		return "redirect:/professor/freeDetail/" + freeCommentVO.getFreeNo();
	}

	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/freeCommentDelete", method = RequestMethod.POST)
	public String freeCommentDelete(FreeCommentVO freeCommentVO, Model model, Principal principal) {
		String userNo = principal.getName();
		freeCommentVO.setUserNo(userNo);
		service.freeCommentDelete(freeCommentVO);
		model.addAttribute("message", "댓글 삭제가 완료되었습니다!");
		return "redirect:/professor/freeDetail/" + freeCommentVO.getFreeNo();
	}

	// 게시글 수정
	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@ResponseBody
	@RequestMapping(value = "/freeUpdate", method = RequestMethod.POST)
	public FreeBoardVO freeboardUpdate(@RequestBody FreeBoardVO freeboardVO, Principal principal) {
		String userNo = principal.getName();
		freeboardVO.setUserNo(userNo);
		service.freeboardUpdate(freeboardVO);
		return freeboardVO;
	}

	// 게시글 삭제
	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/freeDelete", method = RequestMethod.POST)
	public String freeboardDelete(@RequestParam("freeNo") String freeNo, Model model, Principal principal) {
		String userNo = principal.getName();
		service.freeboardDelete(freeNo, userNo);
		model.addAttribute("message", "게시글이 삭제되었습니다!");
		return "redirect:/professor/freeList";
	}

	
	@PreAuthorize("hasRole('ROLE_PROFESSOR')")
	@RequestMapping(value = "/report", method = RequestMethod.POST)
	public String reportBoard(@RequestParam("boardPkNo") String boardPkNo,
	                          @RequestParam("repReason") String repReason,
	                          Principal principal,
	                          Model model) {
	    String userNo = principal.getName();
	    ReportVO reportVO = new ReportVO();
	    reportVO.setUserNo(userNo);
	    reportVO.setRepReason(repReason);

	    SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	    String currentDate = date.format(new Date());
	    reportVO.setRepDate(currentDate);

	    reportVO.setBoardPkNo(boardPkNo);
	    reportVO.setComDetxNo("X0101");

	    service.reportInsert(reportVO);

	    model.addAttribute("message", "신고가 정상적으로 완료되었습니다!");
	    return "redirect:/professor/freeDetail/" + boardPkNo;
	}

}


