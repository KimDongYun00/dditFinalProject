package kr.or.ddit.sbreak.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.sbreak.service.BreakService;
import kr.or.ddit.service.common.CommonCodeService;
import kr.or.ddit.vo.BreakVO;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.YearSemesterVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/student")
public class StuBreakController {
	
	@Inject
	private BreakService service;
	@Inject
	private CommonCodeService codeService;
	
	// 학생 휴학 신청 폼
	@RequestMapping(value="/breakDetail", method = RequestMethod.GET)
	public String stuBreakForm(String breNo, Model model) {
		BreakVO breakVO = service.breakDetail(breNo);
		
		// 승인정보 가져오기
		List<CommonVO> comC = codeService.getComDetailList("C01");
		// 학적상태 가져오기
		List<CommonVO> comM = codeService.getComDetailList("M01");
		model.addAttribute("breakVO", breakVO);
		model.addAttribute("comC", comC);
		model.addAttribute("comM", comM);
		return "sum/break/breakDetail";
	}
	
	// 학생 휴학 신청 목록	
	@RequestMapping(value="/breakList", method = RequestMethod.GET)
	public String stuBreakList(Model model) {
		// 커스텀유저에서 내 정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		// 이게 내 session에 저장되어 있는 아이디 를 아래 리스트 파라미터로 넣어준다.
		user.getUsername();
		// 내 아이디에 해당하는 학적 신청 목록을 불러오고
		List<BreakVO> breakList =  service.selectBreakList(user.getUsername());
		// 모델에 저장
		model.addAttribute("breakList", breakList);
		// 승인정보 가져오기
		List<CommonVO> comC = codeService.getComDetailList("C01");
		// 학적상태 가져오기
		List<CommonVO> comM = codeService.getComDetailList("M01");
		
		model.addAttribute("comC", comC);
		model.addAttribute("comM", comM);
		// 뷰로 리턴
		return "sum/break/breakList";
	}
	
	// 학적 변경 신청
	@RequestMapping(value="/insertBreak", method = RequestMethod.POST)
	public ResponseEntity<String> insertBreak(@RequestBody Map<String, String> map){
		ResponseEntity<String> entity = null;
		
		String stuNo = map.get("stuNo");
		String breContent = map.get("breContent");
		String year = map.get("year");
		String semester = map.get("semester");
		String comDetMNo = map.get("comDetMNo");
		BreakVO breakVO = new BreakVO();
		breakVO.setComDetMNo(comDetMNo);
		breakVO.setYear(year);
		breakVO.setSemester(semester);
		breakVO.setStuNo(stuNo);
		breakVO.setBreContent(breContent);
		
		int cnt = service.insertBreak(breakVO);
		
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 학적신청 삭제
	@RequestMapping(value="/deleteBreak", method = RequestMethod.POST)
	public String deleteBreak(String breNo, RedirectAttributes ra, Model model) {
		String goPage = "";
		
		int cnt = service.deleteBreak(breNo);
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "학적 변경 신청 내역을 삭제 완료했습니다.");
			goPage = "redirect:/student/breakList";
		} else {
			model.addAttribute("msg", "알 수 없는 이유로 삭제를 실패했습니다.");
			goPage= "sum/break/breakDetail?breNo="+breNo;
		}
		return goPage;
	}
	
	// 학적신청 변경
	@RequestMapping(value="/updateBreak", method = RequestMethod.POST)
	public String updateBreak(BreakVO breakVO, RedirectAttributes ra, Model model) {
		String goPage = "";
		
		int cnt = service.updateBreak(breakVO);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "학적 변경 신청 내역을 수정 완료했습니다.");
			goPage = "redirect:/student/breakDetail?breNo=" + breakVO.getBreNo();
		} else {
			model.addAttribute("msg", "알 수 없는 이유로 수정을 실패했습니다.");
			model.addAttribute("breakVO", breakVO);
			goPage= "sum/break/breakDetail?breNo="+breakVO.getBreNo();
		}
		return goPage;
	}
}
