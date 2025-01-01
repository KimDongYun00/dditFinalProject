package kr.or.ddit.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.admin.inter.IAdminFreeBoardService;
import kr.or.ddit.service.admin.inter.IAdminReportBoardService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ReportVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminReportController {

	@Inject
	private IAdminReportBoardService service;
	
	@Inject
	private IAdminFreeBoardService freeBoardService;

	@RequestMapping(value = "/ReportList", method = RequestMethod.GET)
	public String reportList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword, Model model) {

		int itemsPerPage = 10;
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("itemsPerPage", itemsPerPage);
		map.put("keyword", keyword);

		int totalItems = service.getReportCount(map);
		int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
		List<ReportVO> reportList = service.list(map);

		PaginationInfoVO<ReportVO> paginationInfoVO = new PaginationInfoVO<>(itemsPerPage, 5);
		paginationInfoVO.setTotalRecord(totalItems);
		paginationInfoVO.setCurrentPage(page);

		model.addAttribute("reportList", reportList);
		model.addAttribute("paginationInfoVO", paginationInfoVO);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "sum/admin/board/reportList";
	}

	// 상세
//	@RequestMapping(value = "/ReportDetail/{repNo}", method = RequestMethod.GET)
//	public String reportDetail(@PathVariable("repNo") String repNo, Model model) {
//		ReportVO report = service.detail(repNo);
//		model.addAttribute("report", report);
//		return "sum/admin/board/reportDetail";
//	}
	@RequestMapping(value = "/ReportDetail", method = RequestMethod.GET)
	@ResponseBody
	public ReportVO reportDetail(@RequestParam("repNo") String repNo) {
		return service.detail(repNo);
	}

	// 삭제 1
//	@RequestMapping(value = "/deleteReportAndFreeBoard", method = RequestMethod.POST)
//	@ResponseBody
//	public String deleteReportAndFreeBoard(@RequestParam("repNo") String repNo) {
//		service.deleteReportAndFreeBoard(repNo);
//		return "success";
//	}
	// 삭제 update로 수정 2
//	@RequestMapping(value = "/deleteReportAndFreeBoard", method = RequestMethod.POST)
//	@ResponseBody
//	public String deleteReportAndFreeBoard(@RequestParam("repNo") String repNo) {
//	    service.updateReportStatus(repNo);
//	    return "success";
//	}
	
	// 위에 삭제 메서드 update로 수정 ->  신고글 숨기기
	
	@RequestMapping(value = "/deleteReportAndFreeBoard", method = RequestMethod.POST)
	@ResponseBody
	public String deleteReportAndFreeBoard(@RequestParam("repNo") String repNo) {
	    ReportVO report = service.detail(repNo);
	    service.updateReportStatus(repNo);
	    freeBoardService.hideFreeBoard(report.getBoardPkNo()); // 자유게시판 글 숨기기
	    return "success";
	}
	
	




}