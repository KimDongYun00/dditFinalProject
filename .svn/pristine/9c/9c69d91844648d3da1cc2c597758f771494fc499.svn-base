package kr.or.ddit.evaluate.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.evaluate.service.IEvaluateService;
import kr.or.ddit.service.admin.inter.IAdminLectureService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.LectureEvaluateQuestionVO;
import kr.or.ddit.vo.LectureEvaluateVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/evaluate")
public class EvaluateController {

	@Inject
	private IAdminLectureService lecService;
	
	@Inject
	private IEvaluateService evaService;
	
	@RequestMapping(value = "/evaluateLecture", method = RequestMethod.GET)
	public String evaluateLecture(String lecNo, Model model, RedirectAttributes ra) {
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		if(userVO.getStuVO() != null) {
			StudentVO stuVO = userVO.getStuVO();
			LectureEvaluateVO lecEvaVO = new LectureEvaluateVO();
			lecEvaVO.setStuNo(stuVO.getStuNo());
			lecEvaVO.setLecNo(lecNo);
			int check = evaService.checkEvaluate(lecEvaVO);
			if(check > 0) {
				ra.addFlashAttribute("msg", "이미 강의평가를 완료했습니다!");
				return "redirect:/lectureList/lectureDetail.do?lecNo="+lecNo;
			} 
		}
		LectureVO lectureVO = lecService.getLectureByLecNo(lecNo);
		List<LectureEvaluateQuestionVO> queList = evaService.getEvaQueList();
		model.addAttribute("lectureVO", lectureVO);
		model.addAttribute("queList", queList);
		
		return "sum/evaluate/evaluateLecture";
	}
	
	@RequestMapping(value = "/submitEvaluate", method = RequestMethod.POST)
	public String submitEvaluate(String lecNo, LectureEvaluateVO lecEvaVO, RedirectAttributes ra) {
		log.info("lecEvaVO >> {}", lecEvaVO);
		
		int check = evaService.checkEvaluate(lecEvaVO);
		if(check > 0) {
			ra.addFlashAttribute("msg", "이미 강의평가를 완료했습니다!");
		} else {
			int result = evaService.insertLecEva(lecEvaVO);
			if(result > 0) {
				ra.addFlashAttribute("msg", "상의평가 제출완료!");
			} else {
				ra.addFlashAttribute("msg", "상의평가 제출실패!");
			}
		}
		return "redirect:/lectureList/lectureDetail.do?lecNo="+lecNo;
	}
	
	
	
	
	
	
	
	
	
	
}




























