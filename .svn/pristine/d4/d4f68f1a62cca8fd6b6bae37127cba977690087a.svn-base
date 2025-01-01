package kr.or.ddit.controller.admin;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.admin.inter.AdminVolunteerService;
import kr.or.ddit.service.student.inter.StudentVolunteerService;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminVolunteerController {
	
	@Inject	
	private AdminVolunteerService service;
	
	@Inject
	private StudentVolunteerService stuService;
	
	@RequestMapping(value = "/volunteerList", method = RequestMethod.GET)
	public String volunteerList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "99") String searchType, 
			@RequestParam(required = false, defaultValue = "99") String searchLecType, 
			@RequestParam(required = false, defaultValue = "1") int searchScore,
			@RequestParam(required = false, defaultValue = "") String searchWord,
			Model model) {
		log.info("volunteerList 실행... !");
		
		// 리스트 목록
		PaginationInfoVO<VolunteerVO> pagingVO = new PaginationInfoVO<VolunteerVO>();

		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchLecType(searchLecType);
		pagingVO.setSearchScore(searchScore);
		pagingVO.setSearchWord(searchWord);		

		// 총 게시글 수를 얻어온다.
		int totalRecord = service.selectCount(pagingVO);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		
		List<VolunteerVO> dataList =  service.selectList(pagingVO);
		log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		for(VolunteerVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchLecType", searchLecType);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchScore", searchScore);
		model.addAttribute("searchWord", searchWord);
		
		model.addAttribute("pagingVO", pagingVO);
		
		// serarchType2를 동적으로 처리하기 위해 model에 dept 를 저장해서 넘김
		List<DepartmentVO> deptList = service.selectDept();
		model.addAttribute("deptList", deptList);
		
		return "sum/admin/volunteer/volunteerList"; 
	}
	
	// 봉사 신청 일괄 승인 처리
	@RequestMapping(value = "/volunteerAgree", method = RequestMethod.POST)
	public ResponseEntity<String> volunteerAgree(@RequestBody Map<String, List<String>> map) {
		log.info("volunteerAgree()...! 봉사 일괄처리입니다.");
		List<String> volunteerNoList =  map.get("selectedIds");
		
		
		for(String s : volunteerNoList) {
			log.info("봉사 아이디 => " + s.toString() );
			service.volunteerAgree(s.toString());
		}					

		return new ResponseEntity<String>("OK", HttpStatus.OK); // 처리 후 목록 페이지로 리다이렉트
	}
	
	// 학생 신청 상세 정보
	@RequestMapping(value="/volunteerDetail", method=RequestMethod.GET)
	public String voluteerDatail(String volNo, Model model) {
		log.info("ddddddddddd volunteerDetail 실행 ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		VolunteerVO volunteerVO = service.volunteerDetail(volNo);
		model.addAttribute("volunteerVO", volunteerVO);
		
		if(volunteerVO.getFileGroupNo() != null) {
			List<FileVO> fileList =  stuService.getFileByFileGroupNo(volunteerVO.getFileGroupNo());
			model.addAttribute("fileList", fileList);
		}
		
		return "sum/admin/volunteer/volunteerDetail";
	}
	
	// 승인 ajax
	@RequestMapping(value="/volunteerApprove", method=RequestMethod.POST)
	public ResponseEntity<String> volunteerApprove(String volNo){
		ResponseEntity<String> entity = null;
		
		int cnt = service.volunteerApprove(volNo);
		
		if(cnt > 0) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 반려 ajax
	@RequestMapping(value="/volunteerReject", method=RequestMethod.POST)
	public ResponseEntity<String> volunteerReject(String rejContent, String volNo){
		ResponseEntity<String> entity = null;
		VolunteerVO volunteerVo = new VolunteerVO();
		volunteerVo.setRejContent(rejContent);
		volunteerVo.setVolNo(volNo);
		int cnt = service.volunteerReject(volunteerVo);
		
		if(cnt > 0) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
