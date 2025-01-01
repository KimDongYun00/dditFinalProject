package kr.or.ddit.controller.admin;

import java.util.List;

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

import kr.or.ddit.service.admin.inter.IAdminLicenseService;
import kr.or.ddit.service.admin.inter.IAdminScholarshipService;
import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.service.common.impl.FileServiceImpl;
import kr.or.ddit.vo.CertificationVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LicenseVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminLicenseController {
	

	@Inject
	private IAdminLicenseService licenseService;
	
	@Inject
	private IAdminScholarshipService scholarshipService;
	
	@Inject
	private IFileService fileService;
	
	
	// 자격증 신청 목록 조회
    @RequestMapping(value = "/licenseList", method = RequestMethod.GET)
    public String licenseRequestList(
            @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
            @RequestParam(required = false) String searchStuId,
            @RequestParam(required = false) String searchDept,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchStuName,
            @RequestParam(required = false, defaultValue = "99") String searchStatus, Model model) {
        
    	//log.info("licenseRequestList()...! 자격증 신청 리스트 출력입니다.");

        PaginationInfoVO<LicenseVO> pagingVO = new PaginationInfoVO<>();

        pagingVO.setCurrentPage(currentPage);
        pagingVO.setSearchDept(searchDept); 		// 학과로 필터링
        pagingVO.setSearchType(searchType); 		// 장학금명으로 필터링
        pagingVO.setSearchStatus(searchStatus); 	// 처리 상태로 필터링
        pagingVO.setSearchStuId(searchStuId); 		// 학번으로 검색
        pagingVO.setSearchStuName(searchStuName); 	// 이름으로 검색

        // 총 게시글 수를 얻어온다.
        int totalRecord = licenseService.selectLicenseRequestCount(pagingVO);

        // 총 게시글 수 전달 후, 총 페이지 수를 설정
        pagingVO.setTotalRecord(totalRecord);
        List<LicenseVO> dataList = licenseService.selectLicenseRequestList(pagingVO);
        //log.info("pagingVO searchType >> " + pagingVO.getSearchType());
        for (LicenseVO d : dataList)
            log.info("dataList >> " + d.toString());
        pagingVO.setDataList(dataList);

        // 학과 목록을 가져와서 모델에 추가
        List<DepartmentVO> deptList = scholarshipService.getAllDepartments();
        
        // DB에 있는 모든 자격증 이름을 가져와서 모델에 추가
        List<LicenseVO> licenseTypeList = licenseService.getAllLicenseTypes();
        
        
        model.addAttribute("pagingVO", pagingVO);
        model.addAttribute("page", currentPage);
        model.addAttribute("searchDept", searchDept);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchStatus", searchStatus);
        model.addAttribute("searchStuId", searchStuId);
        model.addAttribute("searchStuName", searchStuName);
        model.addAttribute("deptList", deptList);
        model.addAttribute("licenseTypeList", licenseTypeList);

    
        return "sum/admin/license/licenseList";
    
    }
    
    // 자격증 신청 상세 조회
 	@RequestMapping(value = "/licenseRequestDetail", method = RequestMethod.GET)
 	public String licenseRequestDetail(Model model, String licNo) {
 		//log.info("licenseRequestDetail()...! 특정 신청 상세보기 버튼 클릭시 상세보기 입니다.");

 		LicenseVO licenseVO = licenseService.getLicenseRequestDetail(licNo);
 		model.addAttribute("licenseVO", licenseVO);

 		String fileGroupNo = licenseVO.getFileGroupNo();
 		
 		if(fileGroupNo !=  null) {	 // 파일 그룹 번호가 존재한다면
 			
 			List<FileVO> fileList = fileService.getFileByFileGroupNo(fileGroupNo);
 			model.addAttribute("fileList", fileList);
 		}
 		return "sum/admin/license/licenseRequestDetail";
 	}

    // 자격증 신청 개별 승인 처리
 	@RequestMapping(value = "/licenseRequestApprove", method = RequestMethod.POST)
 	@ResponseBody
 	public ResponseEntity<String> licenseRequestApprove(String licNo) {
 		
 		ResponseEntity<String> entity = null;
		int cnt = licenseService.licenseRequestApprove(licNo);
		
		if(cnt > 0) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
 	}

 	// 자격증 신청 개별 반려 처리
 	@RequestMapping(value = "/licenseRequestWait", method = RequestMethod.POST)
 	@ResponseBody
 	public ResponseEntity<String> licenseRequestWait(String licNo, String rejContent) {
 		ResponseEntity<String> entity = null;
 		LicenseVO licenseVO = new LicenseVO();
 		licenseVO.setLicNo(licNo);
 		licenseVO.setRejContent(rejContent);
 		
		int cnt = licenseService.licenseRequestWait(licenseVO);
		
		if(cnt > 0) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
 	}

 	// 자격증 신청 일괄 승인 처리
     @RequestMapping(value = "/licenseApproveAll", method = RequestMethod.POST)
     @ResponseBody
     public ResponseEntity<String> licenseApproveAll(@RequestBody List<String> selectedIds) {
         try {
             for (String licNo : selectedIds) {
            	 licenseService.licenseRequestAllApprove(licNo);
             }
             return ResponseEntity.ok("일괄 승인 처리 완료");
         } catch (Exception e) {
             log.error("일괄 승인 처리 중 오류 발생", e);
             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일괄 승인 처리 중 오류 발생");
         }
     }
    
   //-------------------------------------------------------------통계 관련
     // charJs를 위한 용도------------------------------------------------------------------------------------------
     // 자격증 신청 현황 통계 페이지
     @RequestMapping(value = "/licenseStatistics", method = RequestMethod.GET)
     public String licenseStatistics(Model model) {
         // 통계 현황 조회를 위한 증명서 발급 전체 데이터 끌어오기 
         List<LicenseVO> licenseList = licenseService.licenseStatistics();
         
         
         // 처리 상태에 대한 변수
         int approvedCount = 0;        // 승인
         int unApprovedCount = 0;  	  // 미승인
         int rejectedCount = 0;        // 반려
         
         
         // 자격증 종류에 대한 변수  
         int toeicCount = 0;			// 토익
         int tofelCount = 0;				// 토플
         int hskCount = 0;			// HSK
         int jlptCount = 0;			// JLPT
         
         for (LicenseVO request : licenseList) {    
        	 switch (request.getComdetCNo()) {
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
        	 
        	 switch (request.getLicName()) {    // 신청 내역에서 자격증 이름을 가지고 와서
                 case "TOEIC":           
                 	toeicCount++;    
                     break;
                 case "TOFEL":           
                	 tofelCount++;    
                	 break;
                 case "HSK":         
                	 hskCount++;    
                	 break;
                 case "JLPT":         
                	 jlptCount++;    
                	 break;
             }
             
         }

         model.addAttribute("approvedCount", approvedCount);			// 승인
         model.addAttribute("unApprovedCount", unApprovedCount);		// 미승인
         model.addAttribute("rejectedCount", rejectedCount);			// 반려
         
         model.addAttribute("toeicCount", toeicCount);	
         model.addAttribute("tofelCount", tofelCount);	
         model.addAttribute("hskCount", hskCount);			
         model.addAttribute("jlptCount", jlptCount);
         
         
         return "sum/admin/license/licenseStatistics";
     }
     
}
