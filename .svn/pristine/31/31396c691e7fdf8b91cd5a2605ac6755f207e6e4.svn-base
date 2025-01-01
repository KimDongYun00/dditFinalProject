package kr.or.ddit.sbreak.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.sbreak.service.BreakService;
import kr.or.ddit.service.common.CommonCodeService;
import kr.or.ddit.vo.BreakVO;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Controller
@RequestMapping("/admin")
public class EmpBreakController {
	
	@Inject	
	private BreakService breakService;
	@Inject
	private CommonCodeService codeService;
	
	@RequestMapping(value="/breakList", method = RequestMethod.GET)
	public String empBreakList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "99") String searchType,	// 승인여부 value="C0101..."
			@RequestParam(required = false, defaultValue = "99") String searchLecType, // 학과 value="deptNo"
			@RequestParam(required = false, defaultValue = "") String searchWord, // 검색어
			@RequestParam(required = false, defaultValue = "1") int searchScore,  // value="1, 2", 이름 or id 
			Model model) {
		
		// 학과랑 이름으로 검색?
		PaginationInfoVO<BreakVO> pagingVO = new PaginationInfoVO<BreakVO>();
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSearchLecType(searchLecType);
		pagingVO.setSearchScore(searchScore);
		
		// 검색 후, 목록 페이지로 이동 할 때 검색된 내용을 적용시키기 위한 데이터 전달.
		model.addAttribute("searchType", searchType);		// 학과
		model.addAttribute("searchLecType", searchLecType);	// 이름
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchScore", searchScore);
		
		// 학과를 동적으로 (select)로 가져올 데이터
		List<DepartmentVO> deptList = breakService.selDepartment();
		model.addAttribute("deptList", deptList);
		// 학적 상태 리스트
		List<CommonVO> mList = codeService.getComDetailList("M01");
		List<CommonVO> cList = codeService.getComDetailList("C01");
		
		model.addAttribute("mList", mList);
		model.addAttribute("cList", cList);
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		// 총 게시글 수를 얻어온다.
		int totalRecord = breakService.selEmpBreakCount(pagingVO);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<BreakVO> dataList =  breakService.selEmpBreakList(pagingVO);
		
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "sum/break/empBreakList";
	}
	
	@RequestMapping(value="/breakDetail", method = RequestMethod.GET)
	public String empDetail(String breNo, Model model) {
		BreakVO breakVO =  breakService.breakDetail(breNo);
		
		// 승인정보 가져오기
		List<CommonVO> comC = codeService.getComDetailList("C01");
		// 학적상태 가져오기
		List<CommonVO> comM = codeService.getComDetailList("M01");
		
		model.addAttribute("breakVO", breakVO);
		model.addAttribute("comC", comC);
		model.addAttribute("comM", comM);
		
		return "sum/break/breakDetail";
	}
	// 반려처리
	@ResponseBody
	@RequestMapping(value="/rejectBreak", method = RequestMethod.POST)
	public ResponseEntity<String> breakReject(String rejContent, String breNo, Model model) {
		ResponseEntity<String> entity = null;
		BreakVO breVO = new BreakVO();
		
		breVO.setRejContent(rejContent);
		breVO.setBreNo(breNo);
		
		int cnt = breakService.rejectBreak(breVO);
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//승인처리
	@RequestMapping(value="/approveBreak")
	public ResponseEntity<String> approveBreak(BreakVO breakVO){
		ResponseEntity<String> entity = null;
		
		int cnt = breakService.approveBreak(breakVO);
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
