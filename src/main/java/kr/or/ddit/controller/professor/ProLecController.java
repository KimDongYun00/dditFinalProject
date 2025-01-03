package kr.or.ddit.controller.professor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.lecList.service.ILectureListService;
import kr.or.ddit.service.professor.inter.IProLectureService;
import kr.or.ddit.vo.AssignmentSubmitVO;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureDataVO;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/professor")
public class ProLecController {


	@Inject
	private ILectureListService service;
	
	@Inject
	private IProLectureService lectureService;

	@RequestMapping(value = "/lectureList.do", method = RequestMethod.GET)
	public String lectureList(Model model, LectureVO lectureVO) {
		log.info("lectureList 실행 !!!");
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();

		List<LectureVO> lectureList = lectureService.lectureList(userVO.getUserNo());
		model.addAttribute("lectureList", lectureList);
		
		return "sum/professor/lecture/lectureList";
	}

	// 강의 상세보기 시 게시판 3 개
	@RequestMapping(value = "/lectureDetail.do", method = RequestMethod.GET)
	public String lectureDetail(String lecNo, Model model) {
		// 해당 강의 모든 정보
		LectureVO lectureVO = new LectureVO();
		lectureVO = lectureService.selectLecture(lecNo);
		model.addAttribute("lectureVO", lectureVO);		
		// 강의 공지 게시판
		LectureNoticeVO lectureNoticeVO = new LectureNoticeVO();
		lectureNoticeVO.setLecNo(lecNo);
		List<LectureNoticeVO> lectureNoticeList = lectureService.selectLectureNotice(lecNo);
		model.addAttribute("lectureNoticeList", lectureNoticeList);

		// 과제 게시판
		AssignmentVO assignmentVO = new AssignmentVO();
		assignmentVO.setLecNo(lecNo);
		List<AssignmentVO> assignmentList = lectureService.selectAssignment(lecNo);
		model.addAttribute("assignmentList", assignmentList);

		// 시험 게시판
		ExamVO examVO = new ExamVO();
		examVO.setLecNo(lecNo);
		List<ExamVO> examList = lectureService.selectExam(lecNo);
		model.addAttribute("examList", examList);
		
		// 강의자료실
		List<Map<String, String>> lecDataList = service.selectLecData(lecNo);
		model.addAttribute("lecDataList", lecDataList);
 
		model.addAttribute("lecNo", lecNo);

		return "sum/professor/lecture/lectureDetail";
	}

	// 참여자 목록(페이징)
	@GetMapping("/selectStudentList.do")
	public String selectStudentList(String lecNo, Model model,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "stuNo") String searchType,
			@RequestParam(required = false) String searchWord) {
		log.info("selectStudentList 실행!!!!!!!!");
		PaginationInfoVO<CourseVO> pagingVO = new PaginationInfoVO<CourseVO>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setLecNo(lecNo);
		// 검색 기능 추가
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);

			// 검색 후, 목록 페이지로 이동할 때 검색된 내용을 적용시키기 위한 데이터 전달
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		log.info("1.pagingVO..{}", pagingVO);
		int totalRecord = lectureService.selectStudentCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<CourseVO> studentList = lectureService.selectStudentList(pagingVO);
		pagingVO.setDataList(studentList);

		log.info("2.pagingVO..{}", pagingVO);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("lecNo", lecNo);

		return "sum/professor/lecture/studentList";
	}

	@RequestMapping(value = "/selectAssignmentList.do", method = RequestMethod.GET)
	public String selectAssignmentList(String lecNo, Model model,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage) {

		log.info("selectAssignmentList 실행!!!!!!!!");
		PaginationInfoVO<AssignmentVO> pagingVO = new PaginationInfoVO<AssignmentVO>();

		pagingVO.setCurrentPage(currentPage);
		pagingVO.setLecNo(lecNo);
		
		int totalRecord = lectureService.selectAssignmentCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<AssignmentVO> assignmentList = lectureService.selectAssignmentList(pagingVO);
		pagingVO.setDataList(assignmentList);

		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("lecNo", lecNo);
		return "sum/professor/lecture/assignmentList";
	}
	
	@RequestMapping(value = "/selectAssignmentDetail.do", method = RequestMethod.GET)
	public String selectAssignmentDetail(String lecNo,String assNo, Model model,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage) {
		log.info("selectAssignmentDetail 실행!!!!!!!!");
		// 과제 상세보기
		AssignmentVO assignmentVO = new AssignmentVO();
		assignmentVO = lectureService.selectAssignmentDetail(assNo);
		model.addAttribute("assignmentVO", assignmentVO);
		
		PaginationInfoVO<CourseVO> pagingVO = new PaginationInfoVO<CourseVO>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setLecNo(lecNo);
		
		log.info("1.pagingVO..{}", pagingVO);
		int totalRecord = lectureService.selectStudentCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<CourseVO> studentList = lectureService.selectStudentList(pagingVO);
		pagingVO.setDataList(studentList);

		log.debug("학생리스트: {}",studentList);
		
		Map<String,String> subMap = new HashMap<String, String>();
		for (int i = 0; i < studentList.size(); i++) {
			StudentVO studentVO = studentList.get(i).getStudentVO();
			
			subMap.put("stuNo",studentVO.getStuNo());
			subMap.put("assNo",assNo);
			List<AssignmentSubmitVO> assignmentSubmitVOList = lectureService.selStuAss(subMap);
			for (int j = 0; j < assignmentSubmitVOList.size(); j++) {
				// 1. 파일 그룹 번호를 얻어온다 
				String fileGroupNo = assignmentSubmitVOList.get(j).getFileGroupNo();
				log.info("*********** no : {}", fileGroupNo);
				// 2. 그룹번호를 넘긴 파일리스트를 얻어온다.
				List<FileVO> assFileList = lectureService.selectFileList(fileGroupNo);
				// 3. 맵에 넣어준다. 
				log.info("assFileList => {}", assFileList);
				assignmentSubmitVOList.get(j).setAssFileList(assFileList);
			}
			
			
			studentVO.setAssignmentSubmitVOList(assignmentSubmitVOList);
			
		}
		log.info("2222..{}", studentList);
		model.addAttribute("pagingVO", pagingVO);

		return "sum/professor/lecture/assignmentDetail";
	}
	
	// 과제 점수 입력
	@ResponseBody
	@PostMapping("/updateAssignmentScore.do")
	public AssignmentSubmitVO updateAssignmentScore(@RequestBody AssignmentSubmitVO assignmentSubmitVO) {
		log.info("updateAssignmentScore->assignmentSubmitVO : " + assignmentSubmitVO);
		int result = lectureService.updateAssignmentScore(assignmentSubmitVO);
		log.info("updateAssignmentScore->result : " + result);

		return assignmentSubmitVO;
	}
	
	
	@GetMapping(value="/assignmentForm.do")
	public String assignmentForm() {
		log.info("assignmentForm() 실행...!");
		return "sum/professor/lecture/assignmentForm";
	}
	
	//과제 등록
	@PostMapping("/insertAssignment.do")
	public String insertAssignment(String lecNo, AssignmentVO assignmentVO, Model model,
			HttpServletRequest req) {
		String goPage = "";
		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(assignmentVO.getAssTitle())) { // 과제명 누락
			errors.put("assTitle", "과제명을 입력해주세요!");
		}
		if (StringUtils.isBlank(assignmentVO.getAssContent())) { // 과제 내용 누락
			errors.put("assContent", "내용을 입력해주세요!");
		}
		
		if (errors.size() > 0) {
			model.addAttribute("errors" , errors);
			model.addAttribute("assignmentVO", assignmentVO);
			goPage = "sum/professor/lecture/assignmentForm";
		}else { // 등록 성공
			assignmentVO.setLecNo(lecNo);
			ServiceResult result = lectureService.insertAssignment(req, assignmentVO);
			if (result.equals(ServiceResult.OK)) {// 등록 성공 assNo=ASS_20240042&lecNo=L0103
				goPage ="redirect:/professor/selectAssignmentDetail.do?assNo="+assignmentVO.getAssNo()+"&lecNo="+assignmentVO.getLecNo();
				// + "&lecNo=" + noticeVO.getLecNo();  
			}
		}
		return goPage;
	}
	
	@GetMapping("/updateAssignment.do")
	public String updateAssignmentForm(String lecNo, String assNo, AssignmentVO assignmentVO, Model model) {
		assignmentVO = lectureService.selectAssignmentDetail(assNo);
		
		model.addAttribute("assignmentVO", assignmentVO);
		model.addAttribute("status", "u");
		return "sum/professor/lecture/assignmentForm";
	}
	
	@PostMapping("/updateAssignment.do")
	public String updateAssignment(HttpServletRequest req, RedirectAttributes ra, String lecNo, String assNo, AssignmentVO assignmentVO, Model model) {
		log.info("updateAssignment() 실행!");
		String goPage = "";

		ServiceResult result = lectureService.updateAssignment(req, assignmentVO);
		if (result.equals(ServiceResult.OK)) { // 수정 성공
			ra.addFlashAttribute("message", "게시글 수정완료!");
			goPage = "redirect:/professor/selectAssignmentDetail.do?assNo=" + assignmentVO.getAssNo()+"&lecNo="+assignmentVO.getLecNo();
		} else { // 수정 실패
			model.addAttribute("status", "u");
			model.addAttribute("assignmentVO", assignmentVO);
			model.addAttribute("message", "수정에 실패 하였습니다.");
			goPage = "sum/notice/form";
		}

		return goPage;
	}

	@PostMapping( "/deleteAssignment.do")
	public String deleteAssignment(HttpServletRequest req, RedirectAttributes ra,@RequestParam String lecNo,@RequestParam String assNo, Model model) {
		log.info("noticeDelete() 실행...!");
		String goPage = "";

		ServiceResult result = lectureService.deleteAssignment(req, assNo);
		if (result.equals(ServiceResult.OK)) { // 삭제 성공
			goPage = "redirect:/professor/selectAssignmentList.do?lecNo="+lecNo;
		} else { // 삭제 실패
			goPage = "redirect:/professor/selectAssignmentDetail.do?assNo=" + assNo+"&lecNo="+lecNo;
		}

		return goPage;
	}
	
	// 강의 자료실  
	@GetMapping("/selectLectureDataList.do")
	public String selectLectureDataList(Model model,String lecNo, LectureDataVO lectureDataVO,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage) {
		
		PaginationInfoVO<LectureDataVO> pagingVO = new PaginationInfoVO<LectureDataVO>();
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setLecNo(lecNo);
		// 총 게시글 수를 얻어온다.
		int totalRecord = lectureService.selectLectureDataCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<LectureDataVO> lectureDataList = lectureService.selectLectureDataList(pagingVO);
		pagingVO.setDataList(lectureDataList);

		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("lecNo", lecNo);
		
		return "sum/professor/lecture/lectureDataList";
	}
	
	// 강의 자료실 상세보기 
	@GetMapping("/selectLectureDataDetail.do")
	public String selectLectureDataDetail(Model model, String lecDataNo) {
		LectureDataVO lectureDataVO = lectureService.selectLectureDataDetail(lecDataNo);
		
		log.info("!..{}", lectureDataVO);
		
		List<FileVO> fileList = lectureService.selectFileList(lectureDataVO.getFileGroupNo());
		model.addAttribute("lectureDataVO", lectureDataVO);
		model.addAttribute("fileList", fileList);
		return "sum/professor/lecture/lectureDataDetail";
	}
	
	@GetMapping(value="/lectureDataForm.do")
	public String lectureDataForm() {
		log.info("lectureDataForm() 실행...!");
		return "sum/professor/lecture/lectureDataForm";
	}
	
	@PostMapping("/insertLectureData.do")
	public String insertLectureData(String lecNo, LectureDataVO lectureDataVO, Model model, HttpServletRequest req) {
		String goPage= "";
		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(lectureDataVO.getLecDataTitle())) {
			errors.put("lecDataTitle", "제목을 입력해주세요!");
		}
		if (StringUtils.isBlank(lectureDataVO.getLecDataContent())) {
			errors.put("lecDataContent", "내용을 입력해주세요!");
		}
		if (errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("lectureDataVO", lectureDataVO);
			goPage = "sum/professor/lecture/lectureDataForm";
		}else { // 등록성공
			lectureDataVO.setLecNo(lecNo);
			ServiceResult result = lectureService.insertLectureData(req, lectureDataVO);
			if (result.equals(ServiceResult.OK)) {
				goPage ="redirect:/professor/selectLectureDataDetail.do?lecDataNo="+lectureDataVO.getLecDataNo()+"&lecNo="+lectureDataVO.getLecNo();
			}
		}
		
		return goPage;
	}
	
	@GetMapping("/updateLectureData.do")
	public String updateLectureDataForm(Model model ,String lecDataNo,  LectureDataVO lectureDataVO) {
		lectureDataVO = lectureService.selectLectureDataDetail(lecDataNo);
		
		log.info("!..{}", lectureDataVO);
		
		List<FileVO> fileList = lectureService.selectFileList(lectureDataVO.getFileGroupNo());
		model.addAttribute("lectureDataVO", lectureDataVO);
		model.addAttribute("status", "u");
		model.addAttribute("fileList", fileList);
		return "sum/professor/lecture/lectureDataForm";
	}
	
	@PostMapping("/updateLectureData.do")
	public String updateLectureData(HttpServletRequest req, RedirectAttributes ra,
			LectureDataVO lectureDataVO, Model model) {
		
		LectureDataVO currentLectureDataVO = lectureService.selectLectureDataDetail(lectureDataVO.getLecDataNo());
		log.debug("체크포인또 {}",lectureDataVO);
		
		lectureDataVO.setFileGroupNo(currentLectureDataVO.getFileGroupNo());
		
		String goPage = "";
		
		ServiceResult result = lectureService.updateLectureData(req, lectureDataVO);
		log.info("!..{}", result);
		if(result.equals(ServiceResult.OK)) {	// 수정 성공
			ra.addFlashAttribute("message", "게시글 수정 완료!");
			log.info("!..{}", result);
			goPage = "redirect:/professor/selectLectureDataDetail.do?lecDataNo="+lectureDataVO.getLecDataNo()+"&lecNo="+lectureDataVO.getLecNo();
		}else {	// 수정 실패
			model.addAttribute("status", "u");
			model.addAttribute("lectureDataVO", lectureDataVO);
			model.addAttribute("message", "수정에 실패하였습니다!");
			goPage = "sum/professor/lecture/lectureDataForm";
		}
		log.info("!..찾다{}", result);
		return goPage;
	}

	
	@PostMapping("/deleteLectureData.do")
	public String deleteLectureData(Model model,String lecNo, String lecDataNo, HttpServletRequest req ) {
		log.info("deleteLectureData() 실행...!");
		String goPage = "";

		ServiceResult result = lectureService.deleteLectureData(req, lecDataNo);
		if (result.equals(ServiceResult.OK)) { // 삭제 성공
			goPage = "redirect:/professor/selectLectureDataList.do?lecNo="+lecNo;
		} else { // 삭제 실패
			goPage = "redirect:/professor/selectLectureDataDetail.do?lecDataNo=" + lecDataNo+"&lecNo="+lecNo;
		}

		return goPage;
	}
	
	

}
