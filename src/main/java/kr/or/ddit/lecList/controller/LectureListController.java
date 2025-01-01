package kr.or.ddit.lecList.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.lecList.service.ILectureListService;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lectureList")
public class LectureListController {

	@Inject
	private ILectureListService service;
	
	// 강의 리스트
	@GetMapping("/lectureList.do")
	public String selectLectureList(Model model, CourseVO courseVO, Principal principal) {
		if(principal==null) {//로그인 안되었다면
			return "redirect:/common/login";
		}
		
		log.info("selectLectureList: lectureVO {} ", courseVO);
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		log.info("selectLectureList: userVO {} ", userVO);
		
		List<CourseVO> lectureList = service.selectLectureList(userVO.getUserNo());
		model.addAttribute("lectureList", lectureList);
		
		return "sum/lectureList/list";
	}
	
	// 강의 상세보기 시 게시판 3 개
	@RequestMapping(value = "/lectureDetail.do", method = RequestMethod.GET)
	public String lectureDetail(String lecNo, Model model) {
		// 해당 강의 모든 정보
		LectureVO lectureVO = new LectureVO();
		lectureVO = service.selectLecture(lecNo);
		model.addAttribute("lectureVO", lectureVO);

		// 강의 공지 게시판
		LectureNoticeVO lectureNoticeVO = new LectureNoticeVO();
		lectureNoticeVO.setLecNo(lecNo);
		List<LectureNoticeVO> lectureNoticeList = service.selectLectureNotice(lecNo);
		model.addAttribute("lectureNoticeList", lectureNoticeList);

		// 과제 게시판
		AssignmentVO assignmentVO = new AssignmentVO();
		assignmentVO.setLecNo(lecNo);
		List<AssignmentVO> assignmentList = service.selectAssignment(lecNo);
		model.addAttribute("assignmentList", assignmentList);

		// 시험 게시판
		ExamVO examVO = new ExamVO();
		examVO.setLecNo(lecNo);
		List<ExamVO> examList = service.selectExam(lecNo);
		model.addAttribute("examList", examList);
		
		// 강의자료실
		List<Map<String, String>> lecDataList = service.selectLecData(lecNo);
		model.addAttribute("lecDataList", lecDataList);

		model.addAttribute("lecNo", lecNo);

		return "sum/lectureList/lectureDetail";
	}
}


















