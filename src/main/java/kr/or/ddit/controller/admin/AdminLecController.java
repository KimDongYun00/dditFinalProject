package kr.or.ddit.controller.admin;

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

import kr.or.ddit.service.admin.inter.IAdminCommonService;
import kr.or.ddit.service.admin.inter.IAdminFacilityService;
import kr.or.ddit.service.admin.inter.IAdminLectureService;
import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureTimetableVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminLecController {

	
	@Inject
	private IAdminLectureService lecService;

	@Inject
	private IAdminFacilityService facilityService;

	@Inject
	private IAdminCommonService commonService;
	
	@Inject
	private IFileService fileService;
	
	
	
	@RequestMapping(value = "/lectureList", method = RequestMethod.GET)
	public String lectureList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String searchWord,
			@RequestParam(required = false, defaultValue = "") String searchLecType,
			@RequestParam(required = false, defaultValue = "") String searchConType,
			@RequestParam(required = false, defaultValue = "99") int searchScore,
			@RequestParam(required = false, defaultValue = "") String searchOnoff,
			@RequestParam(required = false, defaultValue = "99") int searchYear,
			@RequestParam(required = false, defaultValue = "99") int searchSemester,
			@RequestParam(required = false, defaultValue = "99") int searchAge,
			Model model) {
		log.info("lectureList()...!");
		
		PaginationInfoVO<LectureVO> pagingVO = new PaginationInfoVO<LectureVO>();
		
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		
		pagingVO.setSearchType(searchType);				// 강의명인지 교수명인지
		pagingVO.setSearchWord(searchWord);				// 검색어
		pagingVO.setSearchLecType(searchLecType);		// 강의구분
		pagingVO.setSearchConType(searchConType);		// 승인여부
		pagingVO.setSearchScore(searchScore);			// 학점
		pagingVO.setSearchOnoff(searchOnoff);			// 대면/비대면
		pagingVO.setSearchYear(searchYear);				// 년도
		pagingVO.setSearchSemester(searchSemester);		// 학기
		pagingVO.setSearchAge(searchAge);				// 학년
		
		// 총 게시글 수를 얻어온다.
		int totalRecord = lecService.selectLectureCount(pagingVO);
		log.info("totalRecord >> " + totalRecord);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<LectureVO> dataList =  lecService.getLectureList(pagingVO);
		for(LectureVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		List<CommonVO> comLNoList = commonService.getComDetailList("L01");
		List<CommonVO> comCNoList = commonService.getComDetailList("C01");
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("comLNoList", comLNoList);
		model.addAttribute("comCNoList", comCNoList);
		
		return "sum/admin/lecture/lectureList";
	}
	
	@RequestMapping(value = "/lectureInsertForm", method = RequestMethod.GET)
	public String lectureInsertForm(Model model) {
		log.info("lectureInsertForm()...!");
		
		List<BuildingVO> builingList = facilityService.getBuildingList();
		List<BuildingVO> facilityList = facilityService.getLecRoomFacilityList();
		List<CommonVO> lecTypeList = commonService.getComDetailList("L01");
		
		model.addAttribute("builingList", builingList);
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("lecTypeList", lecTypeList);
		model.addAttribute("type", "insert");
		
		return "sum/admin/lecture/lectureInsertForm";
	}
	// 파일 업로드
	@RequestMapping(value = "/lectureInsert", method = RequestMethod.POST)
	public String lectureInsert(LectureVO lectureVO, String type) {
		log.info("lectureInsert()...!");
		log.info("lectureVO >> " + lectureVO.toString());
		log.info("proNo >> " + lectureVO.getProNo());
		log.info("subNo >> " + lectureVO.getSubNo());
		
		String goPage = "";
		
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		if(userVO.getComDetUNo().equals("U0102")) {
			lectureVO.setComDetCNo("C0102");
			goPage = "redirect:/professor/lecSignUp";
		} else {
			lectureVO.setComDetCNo("C0101");
			goPage = "redirect:/admin/lectureList";
		}
		
		lecService.insertLecture(lectureVO);
		lecService.insertLectureTime(lectureVO);
		
		return goPage;
	}
	
	@RequestMapping(value = "/timeList.do", method = RequestMethod.POST)
	public ResponseEntity<Map<String, List<LectureTimetableVO>>> lectureTimeList(@RequestBody LectureVO lectureVO){
		log.info("lectureTimeList()...!");
		log.info("facNo >> " + lectureVO.getFacNo());
		log.info("proNo >> " + lectureVO.getProNo());
		log.info("year >> " + lectureVO.getYear());
		log.info("semester >> " + lectureVO.getSemester());
		
		Map<String, List<LectureTimetableVO>> timeListMap = new HashMap<String, List<LectureTimetableVO>>();
		List<LectureTimetableVO> lecTimeList = lecService.getLectureTimeList(lectureVO);
		List<LectureTimetableVO> proTimeList = lecService.getProfessorTimeList(lectureVO);
		timeListMap.put("lecTimeList", lecTimeList);
		timeListMap.put("proTimeList", proTimeList);
		log.info("lecTimeList" + lecTimeList);
		
		return new ResponseEntity<Map<String, List<LectureTimetableVO>>>(timeListMap, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/myLecTimeList.do", method = RequestMethod.POST)
	public ResponseEntity<List<LectureTimetableVO>> myLecTimeList(String type){
		log.info("lectureTimeList()...!");
		
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		List<LectureTimetableVO> lecTimeList = null;
		if(type.equals("stu")) {
			StudentVO stuVO = userVO.getStuVO();
			lecTimeList = lecService.getMyLecTimeList(stuVO);
		} else if(type.equals("pro")) {
			ProfessorVO proVO = userVO.getProfVO();
			lecTimeList = lecService.getProLecTimeList(proVO.getProNo());
		}
		return new ResponseEntity<List<LectureTimetableVO>>(lecTimeList, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/lectureDetail", method = RequestMethod.GET)
	public String lectureDetail(String lecNo, Model model) {
		log.info("lectureDetail()...!");
		log.info("lecNo >> " + lecNo);
		
		LectureVO lectureVO = lecService.getLectureByLecNo(lecNo);
		List<FileVO> fileList = null;
		String fileGroupNo = lectureVO.getFileGroupNo() == null ? null : lectureVO.getFileGroupNo();
		if(!StringUtils.isEmpty(fileGroupNo)) {
			fileList = fileService.getFileByFileGroupNo(fileGroupNo);
			lectureVO.setLecFileList(fileList);
		}
		List<LectureTimetableVO> lecTimeList = lecService.getLectureTime(lecNo);
		
		model.addAttribute("lectureVO", lectureVO);
		model.addAttribute("lecTimeList", lecTimeList);
		
		return "sum/admin/lecture/lectureDetail";
	}
	
	@RequestMapping(value = "/lectureUpdateForm", method = RequestMethod.POST)
	public String lectureUpdateForm(String lecNo, Model model) {
		log.info("lectureUpdateForm()...!");
		
		List<BuildingVO> builingList = facilityService.getBuildingList();
		List<BuildingVO> facilityList = facilityService.getLecRoomFacilityList();
		List<CommonVO> lecTypeList = commonService.getComDetailList("L01");
		
		model.addAttribute("builingList", builingList);
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("lecTypeList", lecTypeList);
		model.addAttribute("type", "update");
		
		LectureVO lectureVO = lecService.getLectureByLecNo(lecNo);
		List<FileVO> fileList = null;
		String fileGroupNo = lectureVO.getFileGroupNo() == null ? null : lectureVO.getFileGroupNo();
		if(!StringUtils.isEmpty(fileGroupNo)) {
			fileList = fileService.getFileByFileGroupNo(fileGroupNo);
			lectureVO.setLecFileList(fileList);
		}
		List<LectureTimetableVO> lecTimeList = lecService.getLectureTime(lecNo);
		
		model.addAttribute("lectureVO", lectureVO);
		model.addAttribute("lecTimeList", lecTimeList);
		
		return "sum/admin/lecture/lectureInsertForm";
	}
	
	@RequestMapping(value = "/lectureUpdate", method = RequestMethod.POST)
	public String lectureUpdate(LectureVO lectureVO) {
		log.info("lectureVO >> " + lectureVO.toString());
		log.info("proNo >> " + lectureVO.getProNo());
		log.info("subNo >> " + lectureVO.getSubNo());
		
		lecService.updateLecture(lectureVO);
		lecService.updateLectureTime(lectureVO);
		
		return "redirect:/admin/lectureDetail?lecNo="+lectureVO.getLecNo();
	}
	
	@RequestMapping(value = "/lectureConfirm", method = RequestMethod.POST)
	public String lectureConfirm(String lecNo) {
		log.info("lectureConfirm()...!");
		
		lecService.lectureConfirm(lecNo);
		
		return "redirect:/admin/lectureDetail?lecNo="+lecNo;
	}
	
	@RequestMapping(value = "/lectureReject", method = RequestMethod.POST)
	public String lectureReject(String lecNo, String rejContent) {
		log.info("lectureReject()...!");
		
		Map<String, String> reject = new HashMap<String, String>();
		reject.put("lecNo", lecNo);
		reject.put("rejContent", rejContent);
		lecService.lectureReject(reject);
		
		return "redirect:/admin/lectureDetail?lecNo="+lecNo;
	}
	
	@RequestMapping(value = "/lectureUnConfirm", method = RequestMethod.POST)
	public String lectureUnConfirm(String lecNo) {
		log.info("lectureUnConfirm()...!");
		
		lecService.lectureUnConfirm(lecNo);
		
		return "redirect:/admin/lectureDetail?lecNo="+lecNo;
	}
	
	@RequestMapping(value = "/lectureDelete", method = RequestMethod.POST)
	public String lectureDelete(String lecNo) {
		log.info("lectureDelete()...!");
		
		lecService.lectureDelete(lecNo);
		
		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();

		if(userVO.getComDetUNo().equals("U0101")) {
			
			return "redirect:/";
		} else if(userVO.getComDetUNo().equals("U0102")) {
			
			return "redirect:/professor/lectureList.do";
		} else {
			return "redirect:/admin/lectureList";
		}
	}
	
	
	
	
}



























