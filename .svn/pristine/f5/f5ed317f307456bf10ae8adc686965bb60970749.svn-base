package kr.or.ddit.tuition.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminCommonService;
import kr.or.ddit.service.admin.inter.IAdminDepartmentService;
import kr.or.ddit.service.common.IYearSemesterService;
import kr.or.ddit.service.student.inter.IStuScholarshipService;
import kr.or.ddit.tuition.service.ITuitionService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ScholarshipVO;
import kr.or.ddit.vo.TuitionPaymentVO;
import kr.or.ddit.vo.TuitionVO;
import kr.or.ddit.vo.UserVO;
import kr.or.ddit.vo.YearSemesterVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/tuition")
public class TuitionController {
	
	@Inject
	private IStuScholarshipService schService;
	
	@Inject
	private IYearSemesterService ysService;
	
	@Inject
	private IAdminCommonService comService;
	
	@Inject
	private IAdminDepartmentService deptService;

	@Inject
	private ITuitionService tuiService;
	
	@RequestMapping(value = "/tuitionList", method = RequestMethod.GET)
	public String tuitionManage(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "") String searchWord,
			@RequestParam(required = false, defaultValue = "99") int searchYear,
			@RequestParam(required = false, defaultValue = "99") int searchSemester,
			Model model) {
		
		PaginationInfoVO<TuitionVO> pagingVO = new PaginationInfoVO<TuitionVO>();
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchWord(searchWord);				// 검색어
		pagingVO.setSearchYear(searchYear);				// 년도
		pagingVO.setSearchSemester(searchSemester);		// 학기
		
		int totalRecord = tuiService.selectTuitionCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<TuitionVO> dataList = tuiService.getTuitionList(pagingVO);
		pagingVO.setDataList(dataList);
		
		List<String> yearList = tuiService.getYearList();
		List<DepartmentVO> deptList = deptService.getDeptNameList();
		List<CommonVO> bankList = comService.getComDetailList("B01");	//은행코드
		List<YearSemesterVO> ysList = ysService.getAllYear();
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("yearList", yearList);
		model.addAttribute("deptList", deptList);
		model.addAttribute("bankList", bankList);
		model.addAttribute("ysList", ysList);
		
		return "sum/tuition/tuitionList";
	}
	
	@RequestMapping(value = "/insertTuition", method = RequestMethod.POST)
	public String insertTuition(TuitionVO tuiVO, RedirectAttributes ra) {
		
		int cnt = tuiService.insertTuition(tuiVO);
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "등록성공!");
		} else {
			ra.addFlashAttribute("msg", "등록실패");
		}
		
		return "redirect:/tuition/tuitionList";
	}
	
	@RequestMapping(value = "/updateTuition", method = RequestMethod.POST)
	public String updateTuition(TuitionVO tuiVO, RedirectAttributes ra) {
		
		int cnt = tuiService.updateTuition(tuiVO);
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "수정성공!");
		} else {
			ra.addFlashAttribute("msg", "수정실패");
		}
		
		return "redirect:/tuition/tuitionList";
	}
	
	@RequestMapping(value = "/deleteTuition", method = RequestMethod.POST)
	public String deleteTuition(TuitionVO tuiVO, RedirectAttributes ra) {
		
		int cnt = tuiService.deleteTuition(tuiVO);
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "삭제성공!");
		} else {
			ra.addFlashAttribute("msg", "삭제실패");
		}
		
		return "redirect:/tuition/tuitionList";
	}
	
	@RequestMapping(value = "/submitTuitionList", method = RequestMethod.GET)
	public String submitTuitionList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "") String searchStuName,
			@RequestParam(required = false, defaultValue = "") String searchStuId,
			@RequestParam(required = false, defaultValue = "0") int searchYear,
			@RequestParam(required = false, defaultValue = "1") int searchSemester,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String searchStatus,
			Model model) {
		
		List<YearSemesterVO> yearList = ysService.getAllYear();
		
		PaginationInfoVO<TuitionVO> pagingVO = new PaginationInfoVO<TuitionVO>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchStuName(searchStuName);		
		pagingVO.setSearchStuId(searchStuId);
		if(searchYear == 0) {
			searchYear = Integer.parseInt(yearList.get(0).getYsYear());
		}
		pagingVO.setSearchYear(searchYear);				// 년도
		pagingVO.setSearchSemester(searchSemester);		// 학기
		pagingVO.setSearchType(searchType);				// 납부 완료상태
		pagingVO.setSearchStatus(searchStatus);			// 납부 구분(일시불, 할부) 
		
		int totalRecord = tuiService.submitTuitionListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<TuitionVO> dataList =  tuiService.submitTuitionList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("yearList", yearList);
		
		return "sum/tuition/submitList";
	}
	
	@RequestMapping(value = "/tuitionSubmit", method = RequestMethod.GET)
	public String submitTuitionPage(Model model) {
		
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		if(userVO.getComDetUNo().equals("U0101")) {
			TuitionVO tuiVO = tuiService.getTuitionByStuNo(userVO.getStuVO().getStuNo());
			List<TuitionVO> tuiList = tuiService.getTuiPayListByStuNo(userVO.getStuVO().getStuNo());
			List<ScholarshipVO> scholarList = schService.getStuTuitionScholarShipList(userVO.getStuVO().getStuNo());
			model.addAttribute("tuiVO", tuiVO);
			model.addAttribute("tuiList", tuiList);
			model.addAttribute("scholarList", scholarList);
		} else if(userVO.getComDetUNo().equals("U0102")){
			 
		} else if(userVO.getComDetUNo().equals("U0103")){
			
		} else {
			
		}
		
		return "sum/tuition/tuitionSubmit";
	}
	
	@RequestMapping(value = "/submitTuition", method = RequestMethod.POST)
	public String submitTuition(TuitionPaymentVO tuiPayVO, String submitType, RedirectAttributes ra) {
		log.info("tuiPayVO >> {}", tuiPayVO);
		
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		if(userVO.getComDetUNo().equals("U0101")) {
			tuiPayVO.setStuNo(userVO.getStuVO().getStuNo());
		}
		
		int cnt1 = tuiService.checkTuitionSubmit(tuiPayVO,submitType);
		if(cnt1 == 2) {					// 할부로 납부한 내역이 있을 경우
			ra.addFlashAttribute("msg", "이미 등록금을 할부로 납부한 내역이 존재합니다!");
		} else if(cnt1 == 1) {			// 일시불로 납부한 내역이 있을 경우
			ra.addFlashAttribute("msg", "이미 등록금을 일시불로 납부한 내역이 존재합니다!");
		} else {						// 납부한 내역이 없을 경우
			if(submitType.equals("1")) {		// 일시불로 납부할 경우
				int cnt2 = tuiService.submit1Tuition(tuiPayVO);
				if(cnt2 > 0) {
					ra.addFlashAttribute("msg", "등록금을 일시불로 납부완료 했습니다!");
				} else {
					ra.addFlashAttribute("msg", "등록금을 일시불로 납부실패 했습니다!");
				}
			} else {							// 할부로 납부할 경우
				int cnt2 = tuiService.submit2Tuition(tuiPayVO);
				if(cnt2 > 0) {
					ra.addFlashAttribute("msg", "등록금을 할부로 납부완료 했습니다!");
				} else {
					ra.addFlashAttribute("msg", "등록금을 할부로 납부실패 했습니다!");
				}
			}
		}
		
		return "redirect:/tuition/tuitionSubmit";
	}
	
	@RequestMapping(value = "/tuitionDetail.do", method = RequestMethod.POST)
	public ResponseEntity<TuitionVO> tuitionDetail(String tuiNo){
		
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		TuitionVO tuiVO = null;
		if(userVO.getComDetUNo().equals("U0101")) {
			TuitionPaymentVO tuiPayVO = new TuitionPaymentVO();
			tuiPayVO.setStuNo(userVO.getStuVO().getStuNo());
			tuiPayVO.setTuiNo(tuiNo);
			tuiVO = tuiService.getTuitionDetail(tuiPayVO);
		}
		
		return new ResponseEntity<TuitionVO>(tuiVO, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/submitDetail.do", method = RequestMethod.POST)
	public ResponseEntity<TuitionVO> submitDetail(String tuiPayNo){
		
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		TuitionVO tuiVO = null;
		if(userVO.getComDetUNo().equals("U0103")) {
			tuiVO = tuiService.getTuitionDetail(tuiPayNo);
		}
		
		return new ResponseEntity<TuitionVO>(tuiVO, HttpStatus.OK);
	}
	
	
}
















