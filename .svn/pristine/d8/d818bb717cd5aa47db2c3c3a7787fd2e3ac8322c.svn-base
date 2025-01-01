package kr.or.ddit.controller.admin;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminScholarshipService;
import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ScholarshipVO;
import lombok.extern.slf4j.Slf4j;

// 관리자 - 장학금관리
@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminScholarshipController {

	@Inject
	private IAdminScholarshipService scholarshipService;
	
	@Inject
	private IFileService fileService;

	// 장학 종류 리스트
	@RequestMapping(value = "/scholarshipList", method = RequestMethod.GET)
	public String scholarshipList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "99") String searchType, 
			 @RequestParam(required = false) String searchWord, Model model) {
		//log.info("장학 종류 리스트 출력 메서드 ");

		PaginationInfoVO<ScholarshipVO> pagingVO = new PaginationInfoVO<ScholarshipVO>();

		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);

		// 총 게시글 수를 얻어온다.
		int totalRecord = scholarshipService.selectScholarshipCount(pagingVO);

		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<ScholarshipVO> dataList = scholarshipService.selectScholarshipList(pagingVO);
		//log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		//for (ScholarshipVO d : dataList)
			//log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)

		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("pagingVO", pagingVO);
		return "sum/admin/scholarship/scholarshipMain";
	}

	// 장학 종류 등록 폼 실행
	@RequestMapping(value = "/scholarshipInsertForm", method = RequestMethod.GET)
	public String scholarshipInsertForm(Model model) {
		model.addAttribute("scholarshipVO", new ScholarshipVO());
		return "sum/admin/scholarship/scholarshipInsertForm";
	}

	// 장학 종류 세부 조회
	@RequestMapping(value = "/scholarshipDetail", method = RequestMethod.GET)
	public String scholarshipDetail(Model model, String schNo) {

		//log.info("scholarshipRequestDetail()...! 특정 신청 상세보기 버튼 클릭시 상세보기 입니다.");

		List<ScholarshipVO> scholarshipVO = scholarshipService.scholarshipDetail(schNo);

		//log.info("####################################");
		//log.info("@@@@@@@@@@@requestNo : " + schNo);
		//log.info("scholarshipVO" + scholarshipVO);

		model.addAttribute("scholarshipVO", scholarshipVO);

		return "sum/admin/scholarship/scholarshipDetail";
	}

	// 장학 종류 등록
	@RequestMapping(value = "/scholarshipInsert", method = RequestMethod.POST)
	public String scholarshipInsert(ScholarshipVO scholarshipVO, RedirectAttributes ra, HttpServletRequest req) {

		log.info("!!!!!!!!!!!!!!" + scholarshipVO);
		String goPage = "";

		int cnt = scholarshipService.scholarshipInsert(scholarshipVO);

		if (cnt > 0) {
			    log.info("장학금 종류 등록 성공!");
		        ra.addFlashAttribute("msg", "신규 장학금 등록이 완료되었습니다.");
		        ra.addFlashAttribute("success", true);
		        goPage = "redirect:/admin/scholarshipDetail?schNo=" + scholarshipVO.getSchNo();
		} else {
			log.info("장학금 종류 등록 실패!!!");
			goPage = "sum/admin/scholarship/scholarshipMain";
		}
		return goPage;

	}
	
	// 장학 종류 수정
	@RequestMapping(value="/scholarshipUpdate", method = RequestMethod.POST)
	public String scholarshipUpdate(ScholarshipVO scholarshipVO, RedirectAttributes ra) {
		String goPage = "";
		log.info("########################################################################");
		log.info("scholarshipVO ++++++++++++++++++++++++++++++++" + scholarshipVO);
		log.info("schNo: " + scholarshipVO.getSchNo());

		int cnt = scholarshipService.scholarshipUpdate(scholarshipVO);
		
		if(cnt > 0) {
			log.info("수정 성공!!!!!!!!!!!!!!!!!!!!!");
			ra.addFlashAttribute("msg", "장학금 수정이 완료되었습니다.");
			goPage = "redirect:/admin/scholarshipDetail?schNo="+scholarshipVO.getSchNo();
		} else {		
			log.info("수정 실패!!!!!!!!!!!!!!!");
			goPage = "sum/admin/scholarship/scholarshipMain";
		}
		return goPage;
	}
	

	// 장학 종류 삭제
	@RequestMapping(value = "/deleteScholarship", method = RequestMethod.POST)
	public String deleteScholarship(String schNo, RedirectAttributes ra) {
		String goPage = "";
		//log.info("deleteScholarship()...! 장학 종류 삭제 요청입니다. 장학금 번호: " + schNo);

		int cnt = scholarshipService.deleteScholarship(schNo);

		if (cnt > 0) {
			log.info("장학금 종류 삭제 성공!");
			ra.addFlashAttribute("msg", "장학금 삭제가 완료되었습니다.");
			goPage = "redirect:/admin/scholarshipMain";
		} else {
			log.info("장학금 종류 삭제 실패!!!");
			goPage = "redirect:/admin/scholarshipDetail?schNo=" + schNo;
		}
		return goPage;

	}

	// 장학 신청 관련-------------------------------------------------------

    // 장학 신청 목록 조회
    @RequestMapping(value = "/scholarshipRequestList", method = RequestMethod.GET)
    public String scholarshipRequestList(
            @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchStuId,
            @RequestParam(required = false) String searchDept,
            @RequestParam(required = false) String searchStuName,
            @RequestParam(required = false) String searchName,
            @RequestParam(required = false, defaultValue = "99") String searchStatus,
            @RequestParam(required = false, defaultValue = "99") int searchYear, Model model) {
        //log.info("scholarshipRequestList()...! 장학금 신청 리스트 출력입니다.");

        PaginationInfoVO<ScholarshipVO> pagingVO = new PaginationInfoVO<>();

        pagingVO.setCurrentPage(currentPage);
        pagingVO.setSearchType(searchType); // 장학금 종류(선차감, 후지급)로 필터링
        pagingVO.setSearchName(searchName); // 장학금명으로 필터링
        pagingVO.setSearchDept(searchDept); // 학과로 필터링
        pagingVO.setSearchStatus(searchStatus); // 처리 상태로 필터링
        pagingVO.setSearchStuId(searchStuId); // 학번으로 검색
        pagingVO.setSearchStuName(searchStuName); // 이름으로 검색
 
        // 총 게시글 수를 얻어온다.
        int totalRecord = scholarshipService.selectScholarshipRequestCount(pagingVO);

        // 총 게시글 수 전달 후, 총 페이지 수를 설정
        pagingVO.setTotalRecord(totalRecord);
        List<ScholarshipVO> dataList = scholarshipService.selectScholarshipRequestList(pagingVO);
       // log.info("pagingVO searchType >> " + pagingVO.getSearchType());
       // for (ScholarshipVO d : dataList)
           // log.info("dataList >> " + d.toString());
        pagingVO.setDataList(dataList);

        // 장학금 목록을 가져와서 모델에 추가
        List<ScholarshipVO> scholarshipList = scholarshipService.getScholarshipList();
        model.addAttribute("scholarshipList", scholarshipList);

        // 학과 목록을 가져와서 모델에 추가
        List<DepartmentVO> deptList = scholarshipService.getAllDepartments();
        model.addAttribute("deptList", deptList);

        model.addAttribute("pagingVO", pagingVO);
        model.addAttribute("page", currentPage);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchDept", searchDept);
        model.addAttribute("searchStatus", searchStatus);
        model.addAttribute("searchStuId", searchStuId);
        model.addAttribute("searchStuName", searchStuName);
        model.addAttribute("searchName", searchName);

        return "sum/admin/scholarship/scholarshipRequestMain";
    }

	// 장학 신청 세부 조회
	@RequestMapping(value = "/scholarshipRequestDetail", method = RequestMethod.GET)
	public String scholarshipRequestDetail(Model model, @RequestParam String schRecNo) {
		//log.info("scholarshipRequestDetail()...! 특정 신청 상세보기 버튼 클릭시 상세보기 입니다.");

		ScholarshipVO scholarshipVO = scholarshipService.getScholarshipRequestDetail(schRecNo);

		String fileGroupNo = scholarshipVO.getFileGroupNo();
		
		log.info("fileGroupNo : ========> " + fileGroupNo);
		
		if(fileGroupNo != null) {
			List<FileVO> fileList = fileService.getFileByFileGroupNo(fileGroupNo);
			model.addAttribute("fileList",fileList);
			log.info("fileList : =================> " + fileList.toString());
		}
		
		log.info("fileList : =================> " + fileGroupNo);
		
		//log.info("####################################");
		//log.info("@@@@@@@@@@@requestNo : " + schRecNo);
		//log.info("scholarshipVO" + scholarshipVO);

		model.addAttribute("scholarshipVO", scholarshipVO);

		return "sum/admin/scholarship/scholarshipRequestDetail";
	}

	// 장학 신청 개별 승인 처리
	@RequestMapping(value = "/scholarshipRequestApprove", method = RequestMethod.POST)
	public String scholarshipRequestApprove(@RequestParam String schRecNo, Model model) {
		//log.info("scholarshipRequestApprove()..! 상세 페이지 내에서 장학 신청 승인 처리 입니다.");

		boolean isApproved = scholarshipService.scholarshipRequestApprove(schRecNo);

		if (isApproved) {
			model.addAttribute("message", "success");
		} else {
			model.addAttribute("message", "error");
		}

		return "redirect:/admin/scholarshipRequestDetail?schRecNo=" + schRecNo;
	}

	// 장학 신청 개별 반려 처리
	@RequestMapping(value = "/scholarshipRequestWait", method = RequestMethod.POST)
	public String scholarshipRequestWait(@RequestParam String schRecNo, @RequestParam(name="rejContent") String rejContent, Model model) {
		//log.info("scholarshipRequestWait()..! 상세 페이지 내에서 장학 신청 반려 처리 입니다.");
		
		boolean isApproved = scholarshipService.scholarshipRequestWait(schRecNo, rejContent);

		if (isApproved) {
			model.addAttribute("message", "success");
		} else {
			model.addAttribute("message", "error");
		}

		return "redirect:/admin/scholarshipRequestDetail?schRecNo=" + schRecNo;
	}
	
	
	// 장학금 신청 일괄 승인 처리
    @RequestMapping(value = "/scholarshipApproveAll", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> scholarshipApproveAll(@RequestBody List<String> selectedIds) {
        try {
            for (String schRecNo : selectedIds) {
                scholarshipService.scholarshipRequestApprove(schRecNo);
            }
            return ResponseEntity.ok("일괄 승인 처리 완료");
        } catch (Exception e) {
            log.error("일괄 승인 처리 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일괄 승인 처리 중 오류 발생");
        }
    }
	
    //-------------------------------------------------------------통계 관련
    // charJs를 위한 용도------------------------------------------------------------------------------------------
    // 장학금 처리 현황 통계 페이지
    @RequestMapping(value = "/scholarshipStatistics", method = RequestMethod.GET)
    public String scholarshipStatistics(Model model) {
        // 총 신청 건수를 조회하여 승인 상태별로 카운트
        // 통계 현황 조회를 위한 장학금 신청 전체 데이터 끌어오기 
        List<ScholarshipVO> scholarshipList = scholarshipService.scholarshipStatistics();
        
        // 처리 상태에 대한 변수
        int approvedCount = 0;        // 승인
        int unApprovedCount = 0;  	  // 미승인
        int rejectedCount = 0;        // 반려

        // 장학금 종류에 대한 변수
        int gradeCount = 0;			// 성적 장학금
        int workCount = 0;			// 근로 장학금
        int volunteerCount = 0;		// 봉사 장학금
        int achievementCount = 0;	// 성취 장학금
        int topCount = 0;			// 수석 장학금
        int welfareCount = 0;			// 복지 장학금
        
        
        for (ScholarshipVO request : scholarshipList) {    // 
            switch (request.getComDetCNo()) {    // 신청 내역에서 처리 상태 코드를 가지고 와서 
                case "C0201":            // 승인일 경우
                    approvedCount++;    
                    break;
                case "C0202":            // 미승인일 경우
                    unApprovedCount++;
                    break;
                case "C0203":            // 반려일 경우
                    rejectedCount++;
                    break;
            }
            
            switch (request.getSchName()) {
			case "성적 장학금":
				 gradeCount++;
				break;
			case "근로 장학금":
				workCount++;
				break;
			case "봉사 장학금":
				volunteerCount++;
				break;
			case "성취 장학금":
				achievementCount++;
				break;
			case "수석 장학금":
				topCount++;
				break;
			case "복지 장학금":
				welfareCount++;
				break;

			}
            
        }

        model.addAttribute("approvedCount", approvedCount);			// 승인
        model.addAttribute("unApprovedCount", unApprovedCount);		// 미승인
        model.addAttribute("rejectedCount", rejectedCount);			// 반려
        
        model.addAttribute("gradeCount", gradeCount);				
        model.addAttribute("workCount", workCount);			
        model.addAttribute("volunteerCount", volunteerCount);			
        model.addAttribute("achievementCount", achievementCount);			
        model.addAttribute("topCount", topCount);			
        model.addAttribute("welfareCount", welfareCount);			
        
        return "sum/admin/scholarship/scholarshipStatistics";
    }
    
    
}
