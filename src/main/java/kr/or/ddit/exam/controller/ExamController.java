package kr.or.ddit.exam.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.exam.service.IExamService;
import kr.or.ddit.service.professor.inter.IProLectureService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.ExamQuestionVO;
import kr.or.ddit.vo.ExamSubmitVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/exam")
public class ExamController {

	@Inject
	private IProLectureService lectureService;
	
	@Inject
	private IExamService examService;
	
	
	
	@RequestMapping(value = "/examList", method = RequestMethod.GET)
	public String examList(
			@RequestParam(required = false, defaultValue = "") String searchType, 
			String lecNo, Model model) {
		log.info("examList()...!");
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		String auth = userVO.getComDetUNo();
		String goPage = "";
		
		PaginationInfoVO<ExamVO> pagingVO = new PaginationInfoVO<ExamVO>();
		pagingVO.setSearchType(searchType);
		pagingVO.setLecNo(lecNo);
		
		List<ExamVO> examList = examService.getExamListByLecNo(pagingVO);
		model.addAttribute("examList", examList);
		model.addAttribute("lecNo", lecNo);
		model.addAttribute("searchType", searchType);
//		model.addAttribute("auth", auth);
		
		if(auth.equals("U0101")) {
			goPage = "sum/exam/examList";
		} else if(auth.equals("U0102")) {
			goPage = "sum/exam/examList";
		} else {
			
		}
		
		return goPage;
	}
	
	@RequestMapping(value = "/examInsertForm", method = RequestMethod.GET)
	public String examInsertForm(String lecNo, Model model) {
		log.info("examInsertForm()...!");
		
		LectureVO lectureVO = lectureService.selectLecture(lecNo);
		model.addAttribute("lecVO", lectureVO);
		
		return "sum/exam/examInsertForm";
	}
	
	@RequestMapping(value = "/examInsert", method = RequestMethod.POST)
	public String examInsert(ExamVO examVO) {
		log.info("examInsert()...!");
		
		examVO.setExamDate(examVO.getExamDate()+" "+examVO.getExamTime().replace("_", ":"));
		examService.insertExam(examVO);
		
		return "redirect:/exam/examList?lecNo="+examVO.getLecNo();
	}
	
	@RequestMapping(value = "/examDetail", method = RequestMethod.GET)
	public String examDetail(String examNo, Model model) {
		log.info("examDetail()...!");
		
		ExamVO examVO = examService.getExamDetail(examNo);
		int totalScore = 0;
		for(ExamQuestionVO que : examVO.getExamQueList()) {
			totalScore += que.getExamQueScore();
		}
		List<StudentVO> studentList = examService.getStudentExamList(examNo);
		List<ExamSubmitVO> studentSubmitList = examService.getStudentExamSubmitList(examNo);
		model.addAttribute("examVO", examVO);
		model.addAttribute("totalScore", totalScore);
		model.addAttribute("studentList", studentList);
		model.addAttribute("studentSubmitList", studentSubmitList);
		
		return "sum/exam/examDetail";
	}
	
	@RequestMapping(value = "/examDelete", method = RequestMethod.POST)
	public String examDelete(String examNo, String lecNo, RedirectAttributes ra) {
		log.info("examDelete()...!");
		
		int cnt = examService.deleteExam(examNo);
		if(cnt == 1) {
			ra.addFlashAttribute("msg", "삭제되었습니다");
		} else {
			ra.addFlashAttribute("msg", "오류 발생");
		}
		
		return "redirect:/exam/examList?lecNo="+lecNo;
	}
	
	@RequestMapping(value = "/updateForm", method = RequestMethod.POST)
	public String examUpdateForm(String examNo, String lecNo, Model model) {
		log.info("examUpdateForm()...!");
		
		ExamVO examVO = examService.getExamDetail(examNo);
		examVO.setExamTime(examVO.getExamDate().substring(11, 16));
		examVO.setExamDate(examVO.getExamDate().substring(0, 10));
		LectureVO lectureVO = lectureService.selectLecture(lecNo);
		model.addAttribute("examVO", examVO);
		model.addAttribute("lecVO", lectureVO);
		
		return "sum/exam/examInsertForm";
	}
	 
	@RequestMapping(value = "/examUpdate", method = RequestMethod.POST)
	public String examUpdate(ExamVO examVO, RedirectAttributes ra) {
		log.info("examUpdate()...!");
		
		examVO.setExamDate(examVO.getExamDate()+" "+examVO.getExamTime().replace("_", ":"));
		examService.updateExam(examVO);
		
		return "redirect:/exam/examDetail?examNo="+examVO.getExamNo();
	}
	
	@RequestMapping(value = "/examSolve", method = RequestMethod.GET)
	public String examSolve(String examNo, Model model, RedirectAttributes ra) {
		log.info("examSolve()...!");
		
		ExamVO examVO = examService.getExamDetail(examNo);
		model.addAttribute("examVO", examVO);
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		StudentVO stuVO = userVO.getStuVO();
		ExamSubmitVO submitVO = new ExamSubmitVO();
		submitVO.setExamNo(examNo);
		submitVO.setStuNo(stuVO.getStuNo());
		// 시험을 봤는지(true) 안봣는지(false)
		boolean flag = examService.checkSubmit(submitVO);
		
		if(flag) {
			ra.addFlashAttribute("msg", "이미 본 시험입니다!");
			return "redirect:/exam/examDetail?examNo="+examNo;
		}
		
		return "sum/exam/examSolve";
	}
	
	@RequestMapping(value = "/examSubmit", method = RequestMethod.POST)
	public String examSubmit(ExamSubmitVO submitVO, String examNo, String lecNo) {
		log.info("examSubmit()...!");
		
		examService.submitStudentAnswer(submitVO, examNo);
		
		return "redirect:/exam/examList?lecNo="+lecNo;
	}
	
	@RequestMapping(value = "/examSubmitCheck", method = RequestMethod.POST)
	public String examSubmitCheck(ExamSubmitVO examSubVO, Model model) {
		log.info("examSubmitCheck()...!");
		
		ExamVO examVO = examService.getExamDetail(examSubVO.getExamNo());
		List<ExamSubmitVO> submitList = examService.getStuExamSubList(examSubVO);
		model.addAttribute("examVO", examVO);
		model.addAttribute("submitList", submitList);
		
		return "sum/exam/examSolve";
	}
	
	
	
	
}




























