package kr.or.ddit.academic.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.academic.service.AcademicService;
import kr.or.ddit.vo.AcademicCalendarVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.YearSemesterVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/academic")
public class AcademicController {
	@Inject	
	private AcademicService service;
	
	@RequestMapping("/main")
	public String academicMain(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage, Model model) {
		
		PaginationInfoVO<YearSemesterVO> pagingVO = new PaginationInfoVO<YearSemesterVO>();
		pagingVO.setScreenSize(5);
		pagingVO.setCurrentPage(currentPage);
		// 5개만 볼래
		
		int totalRecord = service.getYearCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		// 학사 연도 관리를 위해 데이터를 가져와야 한다.
		List<YearSemesterVO> dataList = service.getYearSemester(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("dataList", dataList);
		return "sum/academic/academicCalendar";
	}
	
	@RequestMapping(value="/insert", method = RequestMethod.POST)
	public ResponseEntity<String> academicInsert(@RequestBody AcademicCalendarVO acaVO){
		ResponseEntity<String> entity = null;
		log.info("acaVO ==================> "+acaVO);
		int cnt = service.acaInsert(acaVO);
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/acaList", method = RequestMethod.GET)
	public ResponseEntity<List<AcademicCalendarVO>> academicList(){
		ResponseEntity<List<AcademicCalendarVO>> entity = null;
		List<AcademicCalendarVO> acaList = service.acaList();
		if(acaList != null) {
			entity = new ResponseEntity<List<AcademicCalendarVO>>(acaList, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<List<AcademicCalendarVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/acaRead", method=RequestMethod.GET)
	public ResponseEntity<AcademicCalendarVO> acaRead(String acaNo){
		ResponseEntity<AcademicCalendarVO> entity = null;
		AcademicCalendarVO acaVO = service.acaRead(acaNo);
		if(acaVO != null) {
			entity = new ResponseEntity<AcademicCalendarVO>(acaVO, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<AcademicCalendarVO>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/modify", method = RequestMethod.POST)
	public ResponseEntity<String> academicModify(@RequestBody AcademicCalendarVO acaVO){
		ResponseEntity<String> entity = null;
		int cnt = service.acaModify(acaVO);
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/delete", method = RequestMethod.POST)
	public ResponseEntity<String> academicDelete(String acaNo){
		ResponseEntity<String> entity = null;
		int cnt = service.acaDelete(acaNo);
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/user", method = RequestMethod.GET)
	public String academicUser() {
		return "sum/academic/academicUser";
	}
	
	@RequestMapping(value="/yearSemesterInsert", method = RequestMethod.POST)
	public String yearSemesterInsert(YearSemesterVO ysVO, Model model, RedirectAttributes ra) {
		String goPage="";
		int cnt = service.yearSemesterInsert(ysVO);
		
		if(cnt > 0 ) {
			ra.addFlashAttribute("msg", "학년,학기 등록이 완료됐습니다.");
			goPage = "redirect:/academic/main";
		} else {
			model.addAttribute("ysVO", ysVO);
			goPage = "sum/academic/main";
		}
		
		return goPage;
	}
	@RequestMapping(value="/yearSemesterUpdate", method = RequestMethod.POST)
	public String yearSemesterUpdate(YearSemesterVO ysVO, Model model, RedirectAttributes ra) {
		String goPage="";
		int cnt = service.yearSemesterUpdate(ysVO);
		if(cnt > 0 ) {
			ra.addFlashAttribute("msg", "학년,학기 수정이 완료됐습니다.");
			goPage = "redirect:/academic/main";
		} else {
			model.addAttribute("ysVO", ysVO);
			goPage = "sum/academic/main";
		}
		return goPage;
	}
}
