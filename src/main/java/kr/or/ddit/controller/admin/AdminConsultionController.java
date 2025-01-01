package kr.or.ddit.controller.admin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminConsultingService;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminConsultionController {

	@Inject
	private IAdminConsultingService consultingService;
	
	@RequestMapping(value="/consultingMain", method = RequestMethod.GET)
	public String consultingMain(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "student") String searchType,
			@RequestParam(required = true, defaultValue = "C1") String assNo, 
			@RequestParam(required = false, defaultValue = "") String searchWord,
			Model model) {
		
		// 상담 내역 조회 쿼리 필요		
		PaginationInfoVO<ConsultingVO> pagingVO = new PaginationInfoVO<ConsultingVO>();
		pagingVO.setAssNo(assNo);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		// 검색 후, 목록 페이지로 이동 할 때 검색된 내용을 적용시키기 위한 데이터 전달.
		model.addAttribute("assNo", assNo);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		
		
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		// 총 게시글 수를 얻어온다.
		int totalRecord = consultingService.selectConsultingCount(pagingVO);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<ConsultingVO> dataList =  consultingService.selectConsultingList(pagingVO);
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		log.info("datListdatListdatListdatListdatList " + dataList);
		for(ConsultingVO c : dataList) {
			log.info("LLLLLLLLLLLLLLLLLLLL => " + c.getConNo());
		}
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "sum/admin/consulting/consultingMain";
	}
	
	@RequestMapping(value= "/consultingDetail", method = RequestMethod.GET)
	public String consultingDetail(String conNo, Model model) {
		log.info("@@@@@@@@@@conNo => " + conNo);
		
		ConsultingVO consulting =  consultingService.selectConsultingDetail(conNo);
		model.addAttribute("consulting" , consulting);
		return "sum/admin/consulting/consultingDetail";
	}
	
	@RequestMapping(value="/updateConsulting", method = RequestMethod.POST)
	public String updateConsulting(ConsultingVO consultingVO, Model model, RedirectAttributes ra) {
		String goPage = "";
		log.info("업데이트문에서 받아온  consultingVO ==> " + consultingVO);
		
		int cnt = consultingService.updateConsulting(consultingVO); 
				
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "상담 상태 변경을 완료하셨습니다.");
			goPage = "redirect:/admin/consultingDetail?conNo="+consultingVO.getConNo();
		} else {
			goPage = "sum/admin/consulting/consultingDetail";
		}
		return goPage;
	}
	
	@RequestMapping(value="/deleteConsulting", method = RequestMethod.POST)
	public String deleteConsulting(ConsultingVO consultingVO, RedirectAttributes ra){
		String goPage = "";
		int cnt = consultingService.deleteConsulting(consultingVO.getConNo());
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "상담 내역 삭제를 완료하셨습니다.");
			goPage = "redirect:/admin/consultingMain";
		} else {
			ra.addFlashAttribute("msg", "알 수 없는 이유로 삭제를 할 수 없습니다.");
			goPage = "sum/admin/consulting/consultingDetail?conNo=" + consultingVO.getConNo();
		}
		return goPage;
	}
}
