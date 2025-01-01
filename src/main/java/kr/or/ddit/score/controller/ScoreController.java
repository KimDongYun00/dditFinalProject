package kr.or.ddit.score.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.controller.AttendanceController;
import kr.or.ddit.score.service.IScoreService;
import kr.or.ddit.service.admin.inter.IAdminLectureService;
import kr.or.ddit.service.common.IYearSemesterService;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import kr.or.ddit.vo.YearSemesterVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/score")
public class ScoreController {
	
	@Inject
	private IScoreService scoService;

	@Inject
	private IAdminLectureService lecService;
	
	@Inject
	private IYearSemesterService ysService;
	
	@RequestMapping(value = "/scoreStudent", method = RequestMethod.GET)
	public String scoreStudent(String lecNo, Model model) throws Exception {
		
		AttendanceController ac = new AttendanceController();
		int maxAttScore = ac.getAttendanceDayList(lecNo, lecService, ysService).size() * 2;
		List<Map<String, Object>> studentScoreList = scoService.getStudentScoreList(lecNo);
		for(int i=0;i<studentScoreList.size();i++) {
			int score = ((BigDecimal)studentScoreList.get(i).get("AD_SCORE")).intValue();
			int finalScore = (int)(100.0 * score / maxAttScore);
			studentScoreList.get(i).put("AD_SCORE", finalScore);
		}
		
		Map<String, Integer> scoreMap = new HashMap<String, Integer>();
		ExamVO examVO = new ExamVO();
		examVO.setLecNo(lecNo);
		// 중간고사
		examVO.setComDetHNo("H0101");
		scoreMap.put("midMaxScore", scoService.getMaxExamScore(examVO)==null?0:scoService.getMaxExamScore(examVO));
		examVO.setComDetHNo("H0102");
		scoreMap.put("lastMaxScore", scoService.getMaxExamScore(examVO)==null?0:scoService.getMaxExamScore(examVO));
		examVO.setComDetHNo("H0103");
		scoreMap.put("examMaxScore", scoService.getMaxExamScore(examVO)==null?0:scoService.getMaxExamScore(examVO));
		scoreMap.put("assMaxScore", scoService.getMaxAssScore(lecNo)==null?0:scoService.getMaxAssScore(lecNo));
		
		LectureVO lecVO = scoService.getLectureScoreDetail(lecNo);
		
		model.addAttribute("studentScoreList", studentScoreList);
		model.addAttribute("scoreMap", scoreMap);
		model.addAttribute("lecVO", lecVO);
		
		return "sum/score/scoreStudent";
	}
	
	@RequestMapping(value = "/saveScore", method = RequestMethod.POST)
	public String saveScore(CourseVO courseVO) {
		
		scoService.saveScore(courseVO);
		
		return "redirect:/score/scoreStudent?lecNo="+courseVO.getLecNo();
	}
	
	@RequestMapping(value = "/checkScore", method = RequestMethod.GET)
	public String checkScore(
			@RequestParam(name="year", required = false, defaultValue = "") String year
			,@RequestParam(name="semester", required = false, defaultValue = "") String semester
			,Model model) {
		
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		if(userVO.getStuVO() != null) {
			List<YearSemesterVO> yearList = ysService.getAllYear();
			StudentVO stuVO = userVO.getStuVO();
			Map<String, String> map = new HashMap<String, String>();
			map.put("stuNo", stuVO.getStuNo());
			map.put("year", year);
			map.put("semester", semester);
			List<Map<String, String>> scoreList = scoService.getStuScoreList(map);
			model.addAttribute("scoreList", scoreList);
			model.addAttribute("yearList", yearList);
			model.addAttribute("year", year);
			model.addAttribute("semester", semester);
		} else {
			return "redirect:/";
		}
		
		return "sum/score/scoreList";
	}
	
	@RequestMapping(value = "/manageAllScore", method = RequestMethod.GET)
	public String checkAllStudentScoreList(Model model) {
		
//		List<Map<String, String>> allScoreList = scoService.getAllScoreList();
//		model.addAttribute("allScoreList", allScoreList);
		
		return "sum/score/manageScore";
	}
	
	
}
























