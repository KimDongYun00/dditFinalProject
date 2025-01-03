package kr.or.ddit.controller.student;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.student.inter.StudentVolunteerService;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/student")
public class StuVolunteerController {	
	
	@Inject
	private StudentVolunteerService service;
	
	// 내 봉사 신청 내역 보여주는 메소드	
	@RequestMapping(value="/volunteerList", method = RequestMethod.GET)
	public String volunteerList(Model model, HttpSession session) {
		
		// 로그인하면 내 세션정보가 등록되어있을것이다...
		StudentVO stuVO = (StudentVO) session.getAttribute("stuVO");
		
		log.info("stuNo =======================> " + stuVO.getStuNo());
		
		// 내 봉사 목록을 불러오기 stuVO에서 stuNo가져와서 쿼리 진행
		List<VolunteerVO> volunteerList = service.selectVolunteer(stuVO.getStuNo()); 
		
		// 가져온 리스트를 저장한다.
		model.addAttribute("volunteerList", volunteerList);
		
		return "sum/student/volunteer/volunteerList";
	}
	
	// 봉사내역 상세정보
	@RequestMapping(value="/volunteerDetail")
	public String volunteerDetail(String flag, Model model, String volNo) {
		
		VolunteerVO volunteerVO = service.detailVolunteer(volNo);
		if(volunteerVO.getFileGroupNo() != null) {
			List<FileVO> fileList =  service.getFileByFileGroupNo(volunteerVO.getFileGroupNo());
			model.addAttribute("fileList", fileList);
		}
		
		model.addAttribute("volunteerVO", volunteerVO);
		model.addAttribute("flag", flag);
		
		return "sum/student/volunteer/volunteerForm";
	}
	
	// 봉사 등록 폼 
	@RequestMapping(value="/volunteerForm", method = RequestMethod.GET)
	public String volunteerForm(Model model, String volNo, String flag) {
		
		log.info("volNo??===> " + volNo);
		log.info("flag?? ======> " + flag);
		if(flag != null && flag != "") {
			VolunteerVO volunteerVO = service.detailVolunteer(volNo); 
			model.addAttribute("volunteerVO", volunteerVO);
			model.addAttribute("flag", flag);			
		}
		
		return "sum/student/volunteer/volunteerForm";
	}
	
	// 봉사 신청 
	@RequestMapping(value="/volunteerInsert", method = RequestMethod.POST)
	public String volunteerInserT(VolunteerVO volunteerVO, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		int cnt = service.insertVolunteeR(volunteerVO);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "봉사 등록 신청이 완료되었습니다.");
			goPage = "redirect:/student/volunteerDetail?volNo="+volunteerVO.getVolNo()+"&flag=Y";
		} else {
			ra.addFlashAttribute("msg", "서버 오류, 다시 시도해주세요");
			model.addAttribute("volunteerVO", volunteerVO);
			goPage = "sum/student/volunteer/volunteerForm";
		}
		
		return goPage;
	}	
	
	// 봉사 활동 내역 수정
	@RequestMapping(value="/volunteerModify", method =RequestMethod.POST)
	public String volunteerUpdate(VolunteerVO volunteerVO, RedirectAttributes ra, Model model) {
		String goPage ="";
		
		int cnt = service.updateVolunteer(volunteerVO);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "봉사활동 수정이 완료되었습니다.");
			goPage = "redirect:/student/volunteerDetail?volNo="+volunteerVO.getVolNo()+"&flag=Y";
		} else {
			model.addAttribute("msg", "서버 오류, 잠시후 시도해주세요.");
			model.addAttribute("volunteerVO", volunteerVO);
			model.addAttribute("flag", "Y");
			goPage = "sum/student/volunteer/volunteerForm";
		}
		
		return goPage;
	}
	
	
	// 봉사활동내역삭제
	@RequestMapping(value="/deleteVolunteer", method = RequestMethod.POST)
	public String deleteVolunteer(String volNo, RedirectAttributes ra, Model model) {
		String goPage="";
		
		int cnt = service.deleteVolunteer(volNo);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "삭제 처리가 완료되었습니다.");
			goPage = "redirect:/student/volunteerList";
		} else {
			model.addAttribute("volNo", volNo);
			model.addAttribute("msg", "알 수 없는 이유로 삭제에 실패했습니다.");
			goPage = "sum/student/volunteer/volunteerForm";
		}
		return goPage;
	}
}
