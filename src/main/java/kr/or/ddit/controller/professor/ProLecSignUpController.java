package kr.or.ddit.controller.professor;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.admin.inter.IAdminCommonService;
import kr.or.ddit.service.admin.inter.IAdminFacilityService;
import kr.or.ddit.service.admin.inter.IAdminLectureService;
import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.service.professor.inter.IProMypageService;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureTimetableVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserVO;
import kr.or.ddit.vo.YearSemesterVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/professor")
public class ProLecSignUpController {

	@Inject
	private IProMypageService proService;

	@Inject
	private IAdminCommonService commonService;
	
	@Inject
	private IAdminLectureService lecService;

	@Inject
	private IAdminFacilityService facilityService;

	@Inject
	private IFileService fileService;

//	@Inject
//	private IYearSemesterService ysService;
	
	
	@RequestMapping(value = "/lecSignUp", method = RequestMethod.GET)
	public String proSignUpHome(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "") String searchConType,
			@RequestParam(required = false, defaultValue = "99") int searchYear,
			@RequestParam(required = false, defaultValue = "99") int searchSemester,
			Model model) {
		log.info("proSignUpHome()...!");
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		ProfessorVO proVO = proService.selectProfessor(userVO.getUserNo());
		
		PaginationInfoVO<LectureVO> pagingVO = new PaginationInfoVO<LectureVO>();
		
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		
		pagingVO.setSearchWord(proVO.getProNo());				// 검색어
		pagingVO.setSearchConType(searchConType);				// 승인여부
		
		pagingVO.setSearchYear(searchYear);				// 년도
		pagingVO.setSearchSemester(searchSemester);		// 학기
		
		// 총 게시글 수를 얻어온다.
		int totalRecord = lecService.selectProLectureCount(pagingVO);
		log.info("totalRecord >> " + totalRecord);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<LectureVO> dataList =  lecService.getProLectureList(pagingVO);
		for(LectureVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		List<CommonVO> comCNoList = commonService.getComDetailList("C01");
		List<String> yearList = lecService.getYearList();
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("comCNoList", comCNoList);
		model.addAttribute("yearList", yearList);
		model.addAttribute("proVO", proVO);
		
		return "sum/professor/lecSignUp/home";
	}
	
	@RequestMapping(value = "/lectureSignUp", method = RequestMethod.POST)
	public String lectureSignUp(Model model, String proNo) {
		log.info("lectureSignUp()...!");
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		ProfessorVO proVO = proService.selectProfessor(userVO.getUserNo());
		
		List<BuildingVO> builingList = facilityService.getBuildingList();
		List<BuildingVO> facilityList = facilityService.getLecRoomFacilityList();
		List<CommonVO> lecTypeList = commonService.getComDetailList("L01");
		List<LectureVO> proLecList = lecService.getProLectureListByProVO(proVO);
		
		model.addAttribute("builingList", builingList);
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("lecTypeList", lecTypeList);
		model.addAttribute("type", "insert");
		model.addAttribute("proVO", proVO);
		model.addAttribute("proLecList", proLecList);
		
		return "sum/admin/lecture/lectureInsertForm";
	}
	
	@RequestMapping(value = "/getProLec.do", method = RequestMethod.POST)
	public ResponseEntity<LectureVO> getProLec(String lecNo){
		
		LectureVO lecVO = lecService.getLectureByLecNo(lecNo);
		
		return new ResponseEntity<LectureVO>(lecVO, HttpStatus.OK);
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
		model.addAttribute("type", "professor");
		
		return "sum/admin/lecture/lectureDetail";
	}
	
	
}





























