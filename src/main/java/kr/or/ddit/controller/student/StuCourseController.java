package kr.or.ddit.controller.student;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.mapper.IAdminMemberMapper;
import kr.or.ddit.service.admin.inter.IAdminCommonService;
import kr.or.ddit.service.admin.inter.IAdminLectureService;
import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.service.common.IYearSemesterService;
import kr.or.ddit.service.student.inter.IStuCourseService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import kr.or.ddit.vo.YearSemesterVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/student")
public class StuCourseController {


	@Inject
	private IAdminLectureService lecService;
	
	@Inject
	private IAdminCommonService commonService;
	
	@Inject
	private IAdminMemberMapper memService;
	
	@Inject
	private IYearSemesterService ysService;
	
	@Inject
	private IFileService fileService;
	
	@Inject
	private IStuCourseService couService;
	
	
	
	@RequestMapping(value = "/preCourse", method = RequestMethod.GET)
	public String courseCart(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String searchWord,
			@RequestParam(required = false, defaultValue = "L0101") String searchLecType,
			@RequestParam(required = false, defaultValue = "99") int searchScore,
			@RequestParam(required = false, defaultValue = "") String searchOnoff,
			@RequestParam(required = false, defaultValue = "99") int searchAge,
			String type, Model model) {
		log.info("courseCart()...!"); 
		
		PaginationInfoVO<LectureVO> pagingVO = new PaginationInfoVO<LectureVO>();
		
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		
		pagingVO.setSearchType(searchType);				// 강의명인지 교수명인지
		pagingVO.setSearchWord(searchWord);				// 검색어
		pagingVO.setSearchLecType(searchLecType);		// 강의구분
		pagingVO.setSearchScore(searchScore);			// 학점
		pagingVO.setSearchOnoff(searchOnoff);			// 대면/비대면
		pagingVO.setSearchAge(searchAge);				// 학년
		
		
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		StudentVO studentVO = userVO.getStuVO();
		pagingVO.setSearchDeptNo(studentVO.getDeptNo());
		pagingVO.setSearchStudent(studentVO.getStuNo());

		YearSemesterVO yearSemesterVO = ysService.getYearSemester();
		log.info("ysService.getYearSemester() >> " + ysService.getYearSemester());
		pagingVO.setSearchYear(Integer.parseInt(yearSemesterVO.getYsYear()));				// 년도
		pagingVO.setSearchSemester(Integer.parseInt(yearSemesterVO.getYsSemester()));		// 학기
		
		List<LectureVO> dataList =  lecService.getCourseList(pagingVO);
		for(LectureVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		
		List<LectureVO> myCourseCartList = lecService.getMyCourseCartList(pagingVO);
		
		List<CommonVO> comLNoList = commonService.getComDetailList("L01");
		List<CommonVO> comCNoList = commonService.getComDetailList("C01");
		
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("courseCartList", myCourseCartList);
		model.addAttribute("comLNoList", comLNoList);
		model.addAttribute("comCNoList", comCNoList);
		model.addAttribute("yearSemesterVO", yearSemesterVO);
		model.addAttribute("studentVO", studentVO);
		
		return "student/course/preCourse";
	}

	@RequestMapping(value = "/course", method = RequestMethod.GET)
	public String course(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String searchWord,
			@RequestParam(required = false, defaultValue = "L0101") String searchLecType,
			@RequestParam(required = false, defaultValue = "99") int searchScore,
			@RequestParam(required = false, defaultValue = "") String searchOnoff,
			@RequestParam(required = false, defaultValue = "99") int searchAge,
			String type, Model model) {
		log.info("course()...!"); 
		
		PaginationInfoVO<LectureVO> pagingVO = new PaginationInfoVO<LectureVO>();
		
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		
		pagingVO.setSearchType(searchType);				// 강의명인지 교수명인지
		pagingVO.setSearchWord(searchWord);				// 검색어
		pagingVO.setSearchLecType(searchLecType);		// 강의구분
		pagingVO.setSearchScore(searchScore);			// 학점
		pagingVO.setSearchOnoff(searchOnoff);			// 대면/비대면
		pagingVO.setSearchAge(searchAge);				// 학년
		
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		StudentVO studentVO = userVO.getStuVO();
		pagingVO.setSearchDeptNo(studentVO.getDeptNo());
		pagingVO.setSearchStudent(studentVO.getStuNo());

		YearSemesterVO yearSemesterVO = ysService.getYearSemester();
		log.info("ysService.getYearSemester() >> " + ysService.getYearSemester());
		pagingVO.setSearchYear(Integer.parseInt(yearSemesterVO.getYsYear()));				// 년도
		pagingVO.setSearchSemester(Integer.parseInt(yearSemesterVO.getYsSemester()));		// 학기
		
		List<LectureVO> dataList =  lecService.getCourseList(pagingVO);
		for(LectureVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		
		List<LectureVO> myCourseCartList = lecService.getMyCourseCartList(pagingVO);
		List<LectureVO> myCourseList = lecService.getMyCourseList(pagingVO);
		
		List<CommonVO> comLNoList = commonService.getComDetailList("L01");
		List<CommonVO> comCNoList = commonService.getComDetailList("C01");
		
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("courseCartList", myCourseCartList);
		model.addAttribute("courseList", myCourseList);
		model.addAttribute("comLNoList", comLNoList);
		model.addAttribute("comCNoList", comCNoList);
		model.addAttribute("yearSemesterVO", yearSemesterVO);
		model.addAttribute("studentVO", studentVO);
		return "student/course/course";
	}
	
	@RequestMapping(value = "/reserveCourseCart", method = RequestMethod.POST)
	public String reserveCourseCart(CourseVO courseVO) {
		log.info("reserveCourseCart()...!");
		
		lecService.reserveCourseCart(courseVO);
		
		return "redirect:/student/preCourse";
	}
	
	@RequestMapping(value = "/cancelCourseCart", method = RequestMethod.POST)
	public String cancelCourseCart(CourseVO courseVO) {
		log.info("cancelCourseCart()...!");
		
		lecService.cancelCourseCart(courseVO);
		
		return "redirect:/student/preCourse";
	}
	
	@RequestMapping(value = "/lectureDetail.do", method = RequestMethod.POST)
	public ResponseEntity<LectureVO> lectureDetail(@RequestBody Map<String, String> map){
		log.info("lectureDetail()...!", map.get("lecNo"));
		
		LectureVO lectureVO = lecService.getLectureByLecNo(map.get("lecNo"));
		List<FileVO> fileList = null;
		String fileGroupNo = lectureVO.getFileGroupNo() == null ? null : lectureVO.getFileGroupNo();
		if(!StringUtils.isEmpty(fileGroupNo)) {
			fileList = fileService.getFileByFileGroupNo(fileGroupNo);
			lectureVO.setLecFileList(fileList);
		}
		
		return new ResponseEntity<LectureVO>(lectureVO, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/courseInsert", method = RequestMethod.POST)
	public String courseInsert(CourseVO courseVO) {
		log.info("courseInsert()...!");
		log.info("courseVO >> ", courseVO.toString());
		
		couService.insertCourse(courseVO);
		int cnt = couService.hasCourseCart(courseVO);
		if(cnt > 0) {
			lecService.cancelCourseCart(courseVO);
		}
		
		return "redirect:/student/course";
	}
	
	@RequestMapping(value = "/courseCancel" ,method = RequestMethod.POST)
	public String courseCancel(CourseVO courseVO) {
		log.info("courseCancel()...!");
		log.info("courseVO >> ", courseVO.toString());
		
		lecService.cancelCourse(courseVO);
		
		return "redirect:/student/course";
	}
	
	
	
}






























