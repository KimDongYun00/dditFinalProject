package kr.or.ddit.controller.admin;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminFacilityService;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.FacilityReserveVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminFacController {
	
	@Inject
	private IAdminFacilityService facilityService;
	
	@RequestMapping(value = "/facList", method = RequestMethod.GET)
	public String facList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "99") String searchType,
			Model model) {
		log.info("시설 리스트 출력 메서드 ");
		
//		List<FacilityVO> facilityList =  facilityService.selectFacility();
		
		PaginationInfoVO<FacilityVO> pagingVO = new PaginationInfoVO<FacilityVO>();

		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord("test");
		
		// 총 게시글 수를 얻어온다.
		int totalRecord = facilityService.selectFacilityCount(pagingVO);	// 35개
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<FacilityVO> dataList =  facilityService.selectFacilityList(pagingVO);
		log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("pagingVO", pagingVO);
		return "sum/admin/facility/facList";
	}
	
	@RequestMapping(value="/facInsert", method = RequestMethod.GET)
	public String facInsertForm(String facTypeNo, Model model) {
		log.info("시설 등록 폼 메소드 실행...!");
		log.info("시설타입은? " + facTypeNo);
		List<BuildingVO> buildingList = facilityService.selectBuildingList();
		model.addAttribute("facTypeNo", facTypeNo);
		model.addAttribute("build", buildingList);
		return "sum/admin/facility/facInsert";
	}
		
	@RequestMapping(value = "/facInsert", method = RequestMethod.POST)	
	public String facInsert(FacilityVO facilityVO, RedirectAttributes ra, HttpServletRequest req) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + facilityVO);
		String goPage="";
		int cnt = facilityService.insertFacility(facilityVO, req);
		
		if(cnt > 0) {
			log.info("등록 성공!!!!!!!!!!!!!!!!!!!!!");
			ra.addFlashAttribute("msg", "등록이 완료되었습니다.");
			goPage = "redirect:/admin/facDetail?facNo="+facilityVO.getFacNo();
		} else {		
			log.info("등록 실패!!!!!!!!!!!!!!!");
			goPage = "sum/admin/facility/facList";
		}
		return goPage;
	}
	
	@RequestMapping(value="/facDetail", method = RequestMethod.GET)
	public String facDetail(String facNo, Model model) {
		
		FacilityVO facility = facilityService.facDetail(facNo);
		List<BuildingVO> buildingList = facilityService.selectBuildingList();
		
		model.addAttribute("build", buildingList);
		model.addAttribute("facility", facility);
		
		return "sum/admin/facility/facDetail";
	}
	
	@RequestMapping(value="/facUpdate", method = RequestMethod.POST)
	public String facUpdate(FacilityVO facilityVO, RedirectAttributes ra, HttpServletRequest req) {
		String goPage = "";
		log.info("facilityVO ++++++++++++++++++++++++++++++++" + facilityVO);
		
		int cnt = facilityService.updateFacility(facilityVO, req);
		
		if(cnt > 0) {
			log.info("수정 성공!!!!!!!!!!!!!!!!!!!!!");
			ra.addFlashAttribute("msg", "수정이 완료되었습니다.");
			goPage = "redirect:/admin/facDetail?facNo="+facilityVO.getFacNo();
		} else {		
			log.info("등록 실패!!!!!!!!!!!!!!!");
			goPage = "sum/admin/facility/facList";
		}
		return goPage;
	}
	
	@RequestMapping(value="/facDelete", method = RequestMethod.POST)
	public String facDelete(String facNo, RedirectAttributes ra) {
		String goPage="";
		int cnt = facilityService.deleteFacility(facNo);
		if(cnt > 0) {
			log.info("삭제 성공!!!!!!!!!!!!!!!!!!!!!");
			ra.addFlashAttribute("msg", "삭제가 완료되었습니다.");
			goPage = "redirect:/admin/facList";
		} else {		
			log.info("삭제 실패!!!!!!!!!!!!!!!");
			goPage = "redirect:/admin/facDetail?facNo="+facNo;
		}
		return goPage;
	}
	
	@RequestMapping(value = "/facList.do", method = RequestMethod.POST)
	public ResponseEntity<List<FacilityVO>> facilityListByBuilding(@RequestBody Map<String, String> map, Model model){
		log.info("facilityListByBuilding()...!");
		log.info("buiNo >> " + map.get("buiNo"));
		log.info("facTypeNo >> " + map.get("facTypeNo"));
		
//		List<FacilityVO> facList = facilityService.getLecRoomFacilityListByBuiNo(map.get("buiNo"));
		List<FacilityVO> facList = facilityService.getFacilityListByMap(map);
		for(FacilityVO d : facList) log.info("facList >> " + d.toString());
		
		return new ResponseEntity<List<FacilityVO>>(facList, HttpStatus.OK);
	}
	
	// 시설예약 리스트
	@RequestMapping(value="/facResList", method = RequestMethod.GET)
	public String facilityReserveList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
		  , @RequestParam(required = true, defaultValue = "C99") String searchType
		  , @RequestParam(required = false, defaultValue = "C99") String searchLecType
		  , @RequestParam(required = false, defaultValue = "99") String searchOnoff
		  , @RequestParam(required = false) String searchWord
		  , Model model) {
		log.info("List출력!");		
		
		PaginationInfoVO<FacilityReserveVO> pagingVO = new PaginationInfoVO<FacilityReserveVO>();

		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSearchLecType(searchLecType);
		pagingVO.setSearchOnoff(searchOnoff);
		
		// 총 게시글 수를 얻어온다.
		int totalRecord = facilityService.selectFacResCount(pagingVO);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<FacilityReserveVO> dataList =  facilityService.selectFacResList(pagingVO);
		log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		for(FacilityReserveVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchLecType", searchLecType);
		model.addAttribute("searchOnoff", searchOnoff);
		
		model.addAttribute("pagingVO", pagingVO);
		// 건물 동적 검색어 처리
		List<BuildingVO> buiList = facilityService.selectBuildingList();
		model.addAttribute("buiList", buiList);
		
		return "sum/admin/facility/facResList";
	}
	
	// 상세내역보기
	@RequestMapping(value="/facResDetail", method = RequestMethod.GET)
	public String facResDetail(String facResNo, Model model) {
		FacilityReserveVO facResVO = facilityService.facResRead(facResNo);
		
		model.addAttribute("facResVO", facResVO);
		
		return "sum/admin/facility/facResDetail";
	}
	
	// 한개 승인처리
	@RequestMapping(value="/facResApprove", method = RequestMethod.POST)
	public ResponseEntity<String> facResApprove(String facResNo){
		ResponseEntity<String> entity = null;
		int cnt = facilityService.facResApprove(facResNo);
		
		if(cnt > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 반려 처리 메서드
	@RequestMapping(value="/facResReject", method = RequestMethod.POST)
	public ResponseEntity<String> facResReject(String facResNo, String rejContent){
		ResponseEntity<String> entity = null;
		
		FacilityReserveVO facVO = new FacilityReserveVO();
		facVO.setFacResNo(facResNo);
		facVO.setRejContent(rejContent);
		int cnt = facilityService.facResReject(facVO);
		
		
		return entity;
	}
	
	// 일괄 승인 메서드
	@RequestMapping(value="/facResAgree", method = RequestMethod.POST)
	public ResponseEntity<String> facResAgree(@RequestBody Map<String, List<String>> map){
		
		List<String> facResNoList = map.get("selectedIds");
		
		
		for(String s : facResNoList) {
			log.info("시설예약 아이디 => " + s.toString() );
			facilityService.facResAllAgree(s.toString());
		}		
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
}
























