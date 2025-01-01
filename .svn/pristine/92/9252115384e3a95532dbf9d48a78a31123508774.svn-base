package kr.or.ddit.vacation.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.sbreak.service.BreakService;
import kr.or.ddit.service.common.CommonCodeService;
import kr.or.ddit.vacation.service.VacationService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VacationVO;

@Controller
@RequestMapping("/vacation")
public class ProVacationController {
	
	@Inject
	private VacationService service;
	@Inject
	private BreakService breakService;
	@Inject
	private CommonCodeService codeService;
	
	@RequestMapping(value="/vacationList", method = RequestMethod.GET)
	public String proVacationList(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		List<VacationVO> vacList = service.selProVacationList(user.getUsername());
		model.addAttribute("vacList", vacList);
		List<CommonVO> comC =  codeService.getComDetailList("C01");
		model.addAttribute("comC", comC);
		
		return "sum/vacation/vacationList";
	}
	
	@RequestMapping(value="/vacationForm", method = RequestMethod.GET)
	public String proVacationForm() {
		
		return "sum/vacation/vacationForm";
	}
	
	@RequestMapping(value="/vacationInsert", method = RequestMethod.POST)
	public String proVacationInsert(VacationVO vacationVO, Model model, RedirectAttributes ra) {
		String goPage = "";
		int cnt = service.proVacationInsert(vacationVO);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "휴가 신청이 완료되었습니다.");
			goPage = "redirect:/vacation/vacationDetail?flag=Y&vacNo="+vacationVO.getVacNo();
		} else {
			model.addAttribute("msg", "알 수 없는 오류로 휴가 등록이 실패했습니다.");
			model.addAttribute("vac", vacationVO);
			goPage = "sum/vacation/vacationForm";
		}
		return goPage;
	}
	
	@RequestMapping(value="/vacationDetail", method = RequestMethod.GET)
	public String proVacationDetail(String vacNo, Model model) {
		VacationVO vac = service.proVacationDetail(vacNo);
		List<CommonVO> comC = codeService.getComDetailList("C01");
		model.addAttribute("vac", vac);
		model.addAttribute("flag", "Y");
		model.addAttribute("comC", comC);
		return "sum/vacation/vacationForm";
	}
	@RequestMapping(value="/vacationModify", method = RequestMethod.POST)
	public String vacationModify(VacationVO vacationVO, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		int cnt = service.proVacationUpdate(vacationVO);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "휴가 신청 변경이 완료되었습니다.");
			goPage = "redirect:/vacation/vacationDetail?flag=Y&vacNo="+vacationVO.getVacNo();
		} else {
			model.addAttribute("msg", "알 수 없는 오류로 휴가 신청 변경이 실패했습니다.");
			model.addAttribute("vac", vacationVO);
			goPage = "sum/vacation/vacationForm";
		}
		return goPage;
	}
	@RequestMapping(value="/vacationDelete", method = RequestMethod.POST)
	public String vacationDelete(String vacNo, RedirectAttributes ra, Model model) {
		String goPage="";
		int cnt = service.proVacationDelete(vacNo);
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "휴가 신청 내역 삭제가 완료되었습니다.");
			goPage = "redirect:/vacation/vacationList";
		} else {
			model.addAttribute("msg", "알 수 없는 오류로 삭제에 실패했습니다.");
			VacationVO vac = service.proVacationDetail(vacNo);
			model.addAttribute("vac", vac);
			model.addAttribute("flag", "Y");
			goPage = "sum/vacation/vacationForm";
		}
		return goPage;
	}
	
// ===================================================관리자 경우================================================
	@RequestMapping(value="/empVacationList", method = RequestMethod.GET)
	public String empVacationList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "C99") String searchType,	// 승인여부 value="C0101..."
			@RequestParam(required = false, defaultValue = "") String searchWord, // 검색어
			@RequestParam(required = false, defaultValue = "C99") String assNo,  // value="1, 2", 이름 or id 
			Model model) {
		
		// 페이징...
		// 학과랑 이름으로 검색?
		PaginationInfoVO<VacationVO> pagingVO = new PaginationInfoVO<VacationVO>();
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setAssNo(assNo);
		
		// 검색 후, 목록 페이지로 이동 할 때 검색된 내용을 적용시키기 위한 데이터 전달.
		model.addAttribute("searchType", searchType);		// 승인여부
		model.addAttribute("searchWord", searchWord);		// 검색어
		model.addAttribute("assNo", assNo);		// 이름orID
		
		// 학과를 동적으로 (select)로 가져올 데이터
		List<DepartmentVO> deptList = breakService.selDepartment();
		model.addAttribute("deptList", deptList);
		// 학적 상태 리스트
		List<CommonVO> mList = codeService.getComDetailList("M01");
		List<CommonVO> cList = codeService.getComDetailList("C01");
		
		model.addAttribute("mList", mList);
		model.addAttribute("cList", cList);
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		// 총 게시글 수를 얻어온다.
		int totalRecord = service.selEmpVacationCount(pagingVO);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<VacationVO> dataList =  service.selEmpVacationList(pagingVO);
		
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "sum/vacation/empVacationList";
	}
	
	@RequestMapping(value="/empVacationDetail", method = RequestMethod.GET)
	public String empVacDetail(String vacNo, Model model) {
		VacationVO vac = service.proVacationDetail(vacNo);
		List<CommonVO> comC = codeService.getComDetailList("C01");

		model.addAttribute("vac", vac);
		model.addAttribute("comC", comC);
		return "sum/vacation/empVacationDetail";
	}
	@RequestMapping(value="/rejectVacation", method = RequestMethod.POST)
	public ResponseEntity<String> rejectVacation(VacationVO vac) {
		ResponseEntity<String> entity = null;
		int cnt = service.rejectVacation(vac);
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value="/approveVacation", method = RequestMethod.POST)
	public ResponseEntity<String> approveVacation(String vacNo) {
		ResponseEntity<String> entity = null;
		int cnt = service.approveVacation(vacNo);
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
