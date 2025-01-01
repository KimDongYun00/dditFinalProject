package kr.or.ddit.controller.student;

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

import kr.or.ddit.service.admin.inter.IAdminFacilityService;
import kr.or.ddit.service.student.facility.IStuFacService;
import kr.or.ddit.vo.FacilityReserveVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/student")
public class StuFacController {
	
	@Inject
	private IStuFacService service;
	
	@Inject
	private IAdminFacilityService facilityService;
	
	@RequestMapping(value="/facDetail", method=RequestMethod.GET)
	public String facDetail(Model model, String facNo) {
		log.info("facDetail 실행...!");
		log.info("시설번호 : " + facNo);
		
		FacilityVO facVO = service.selectDetail(facNo); 
		
		model.addAttribute("facVO", facVO);
		
		return "sum/student/fac/facDetail";
	}
	
	@RequestMapping(value = "/facMain", method = RequestMethod.GET)
	public String facStuList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = true, defaultValue = "999") String searchType,
			Model model) {
		log.info("시설 리스트 출력 메서드 ");
		
//		List<FacilityVO> facilityList =  facilityService.selectFacility();
		
		PaginationInfoVO<FacilityVO> pagingVO = new PaginationInfoVO<FacilityVO>();

		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		
		// 총 게시글 수를 얻어온다.
		int totalRecord = facilityService.selectFacilityCount(pagingVO);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<FacilityVO> dataList =  facilityService.selectFacilityList(pagingVO);
		log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		for(FacilityVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("pagingVO", pagingVO);
		return "sum/student/fac/facList";
	}
	
	// 시설예약
	@ResponseBody
	@RequestMapping(value="/facilityReserve", method = RequestMethod.POST)
	public ResponseEntity<String> facilityReserve(@RequestBody Map<String, String> map) {
		
		ResponseEntity<String> entity = null;
		String title = map.get("title");
		String start = map.get("start");
		String end = map.get("end");
		String stuNo = map.get("stuNo");
		String facNo = map.get("facNo");
		Integer number = Integer.valueOf(map.get("number"));
		log.info("메소드는 실행 되는건가???????????????????????????");
		log.info("title === > " + title);
		log.info("start === > " + start);
		log.info("end === > " + end);
		log.info("stuNo === > " + stuNo);
		log.info("facNo === > " + facNo);
		
		// 시간비교 하기위해		
	
		String startTime = start.substring(0,16);
		String endTime = end.substring(0,16);
		log.info("startTime!!!!!!!!!! : " + startTime + "                endTime!!!!!!!!! : " + endTime);
		// 12:00 13:00
		// 11:00 12:00        if (12:00 >= 11:00 || 11:00 >= 12:00)
		// 13:00 14:00
		FacilityReserveVO facReserveVO = new FacilityReserveVO();
		facReserveVO.setFacNo(facNo);			// 시설번호
		facReserveVO.setUserNo(stuNo);			// 유저ID
		facReserveVO.setFacResSdate(startTime);		// 시작일
		facReserveVO.setFacResEdate(endTime);		// 끝난일
		facReserveVO.setFacResPurpose(title);	// 이용목적
		facReserveVO.setFacResNum(number);
		
		int cnt = service.facilityStuReserve(facReserveVO);
		
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		else {
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	// 예약목록 가져오는 메소드
	@ResponseBody
	@RequestMapping(value="/facreserveList", method = RequestMethod.POST)
	public ResponseEntity<List<FacilityReserveVO>> facStuReserveList(String facNo){
		ResponseEntity<List<FacilityReserveVO>> entity = null;
		log.info("facNo ==? "+facNo);
		List<FacilityReserveVO> facresVO =  service.facilityStuReserveList(facNo);
		
		
		if (facresVO != null) {
			entity = new ResponseEntity<List<FacilityReserveVO>>(facresVO, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<List<FacilityReserveVO>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;		
	}
	
	@RequestMapping(value="/facStuResDelete", method = RequestMethod.POST)
	public ResponseEntity<String> facStuResDelete(String facResNo){
		ResponseEntity<String> entity = null;
		int cnt = service.facStuResDelete(facResNo);
		
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
