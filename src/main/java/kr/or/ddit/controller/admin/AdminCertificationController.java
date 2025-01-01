package kr.or.ddit.controller.admin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminCertificationService;
import kr.or.ddit.vo.CertificationPrintVO;
import kr.or.ddit.vo.CertificationVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

// 관리자 - 증명서 발급 관리
@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminCertificationController {

	@Inject
	private IAdminCertificationService certificationService;

	// 증명서 종류 출력
	@RequestMapping(value = "/certificationList", method = RequestMethod.GET)
	public String certificationList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "99") String searchType, Model model) {
		log.info("증명서 종류 리스트 출력 메서드 ");

		PaginationInfoVO<CertificationVO> pagingVO = new PaginationInfoVO<CertificationVO>();

		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		// pagingVO.setSearchWord("test"); // 검색 기능 추가시 바뀌어야할 부분

		// 총 게시글 수를 얻어온다.
		int totalRecord = certificationService.selectCertificationCount(pagingVO);

		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<CertificationVO> dataList = certificationService.selectCertificationList(pagingVO);
		log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		for (CertificationVO d : dataList)
			log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)

		model.addAttribute("searchType", searchType);
		model.addAttribute("pagingVO", pagingVO);
		return "sum/admin/certification/certificationList";
	}

	/*
	// 증명서 발급 활성화/비활성화 처리
    @RequestMapping(value = "/updateCertificationStatus", method = RequestMethod.POST)
    @ResponseBody
    public String updateCertificationStatus(@RequestParam("cerNo") String cerNo, 
                                            @RequestParam("status") boolean status) {
        log.info("증명서 상태 변경...!");

        boolean success = certificationService.updateCertificationStatus(cerNo, status);

        return "{\"success\": " + success + "}";
    }
	
	 */
	
	// 상세보기 클릭시 pdf를 읽어와서 띄워줘야함

	// 증명서 종류 등록 페이지 이동
	@RequestMapping(value = "/certificationInsertForm", method = RequestMethod.GET)
	public String  certificationInsertForm() {
		log.info("certificationInsertForm()....! 증명서 등록 폼 실행...!");
		return "sum/admin/certification/certificationInsertForm";
	}

	// 증명서 종류 등록 처리
	@RequestMapping(value = "/certificationInsert", method = RequestMethod.POST)
	public String certificationInsert(CertificationVO certificationVO, RedirectAttributes redirectAttributes) {
		log.info("certificationInsert()....! 증명서 등록 실행...!");
		
		certificationService.insertCertification(certificationVO);
		redirectAttributes.addFlashAttribute("msg", "증명서가 성공적으로 등록되었습니다.");
		
		return "redirect:/admin/certificationList"; // 등록 후 증명서 목록 페이지로 리다이렉트
	}
	
	// 증명서 종류 상세보기
	@RequestMapping(value = "/certificationDetail", method = RequestMethod.GET)
	public String certificationDetail(Model model, String cerNo) {

		CertificationVO certificationVO = certificationService.certificationDetail(cerNo);

		model.addAttribute("certification", certificationVO);

		return "sum/admin/certification/certificationDetail";
	}

	// 증명서 종류 수정
	@RequestMapping(value = "/certificationUpdate", method = RequestMethod.POST)
	public String certificationUpdate(CertificationVO certificationVO, RedirectAttributes ra) {
	    String goPage = "";
	    log.info("수정 요청 수신: " + certificationVO);

	    int cnt = certificationService.certificationUpdate(certificationVO);
	    log.info("수정 결과: " + cnt);

	    String cerNo = certificationVO.getCerNo();
	    if (cnt > 0) {
	        log.info("수정 성공!!!!!!!!!!!!!!!!!!!!!");
	        ra.addFlashAttribute("msg", "증명서 수정이 완료되었습니다.");
	        goPage = "redirect:/admin/certificationDetail?cerNo=" + cerNo;
	    } else {
	        log.info("수정 실패!!!!!!!!!!!!!!!");
	        goPage = "redirect:/admin/certificationList"; // 변경
	    }
	    return goPage;
	}


	
	// 성적 증명서 템플릿 등록
    @RequestMapping(value = "/templateUpload", method = RequestMethod.POST)
    public String templateUpload(@RequestParam("templateName") String templateName,
                                 @RequestParam("templateFile") MultipartFile templateFile,
                                 RedirectAttributes redirectAttributes) {
        log.info("templateUpload()....! 증명서 템플릿 업로드 실행...!");

        try {
            CertificationVO certificationVO = new CertificationVO();
            certificationVO.setCerName(templateName);
           // certificationVO.setTemplateFile(templateFile);
           // certificationService.uploadTemplate(certificationVO);
            redirectAttributes.addFlashAttribute("msg", "템플릿이 성공적으로 업로드되었습니다.");
        } catch (Exception e) {
            log.error("템플릿 업로드 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("msg", "템플릿 업로드 중 오류가 발생했습니다.");
        }

        return "redirect:/admin/certificationList";
    }
	
  //-------------------------------------------------------------통계 관련
    // charJs를 위한 용도------------------------------------------------------------------------------------------
    // 증명서 발급 현황 통계 페이지
    @RequestMapping(value = "/certificationStatistics", method = RequestMethod.GET)
    public String certificationStatistics(Model model) {
        // 통계 현황 조회를 위한 증명서 발급 전체 데이터 끌어오기 
        List<CertificationVO> certificationList = certificationService.certificationStatistics();
        List<CertificationPrintVO> certificationPrintList = certificationService.selectByDepartment();
        
        // 증명서 종류에 대한 변수
        int enrollmentCount = 0;			// 재학 증명서
        int gradeCount = 0;					// 성적 증명서
        int graduationCount = 0;			// 졸업 증명서
        
        int ad=0;			// 광고홍보학과
        int ee=0;  		// 전자공학과
        int phil=0;		// 철학과
        int it=0;			// 정보통신학과
        int chem=0;		// 화학과
        int cs=0;			// 컴퓨터공학과
        int kor=0;			// 국어국문학과
        int astro=0;		// 천문학과
        int design=0;		// 시각디자인학과
        
        for (CertificationVO request : certificationList) {    
            switch (request.getCerName()) {    // 신청 내역에서 증명서 이름을 가지고 와서
                case "재학증명서":            // 재학 증명서일 경우
                	enrollmentCount++;    
                    break;
                case "성적증명서":            // 성적 증명서일 경우
                	gradeCount++;
                    break;
                case "졸업증명서":            // 졸업 증명서일 경우
                	graduationCount++;
                    break;
            }
        }

        for (CertificationPrintVO req : certificationPrintList) {
        	switch (req.getDeptName()) {	//학과별
			case "광고홍보학과":
				ad++;
				break;
			case "전자공학과":
				ee++;
				break;
			case "철학과":
				phil++;
				break;
			case "정보통신학과":
				it++;
				break;
			case "화학과":
				chem++;
				break;
			case "컴퓨터공학과":
				cs++;
				break;
			case "국어국문학과":
				kor++;
				break;
			case "천문학과":
				astro++;
				break;
			case "시각디자인학과":
				design++;
				break;
			}
        }
        
        model.addAttribute("enrollmentCount", enrollmentCount);	
        model.addAttribute("gradeCount", gradeCount);	
        model.addAttribute("graduationCount", graduationCount);			
        
        model.addAttribute("ad", ad);			
        model.addAttribute("ee", ee);			
        model.addAttribute("phil", phil);			
        model.addAttribute("it", it);			
        model.addAttribute("chem", chem);			
        model.addAttribute("cs", cs);			
        model.addAttribute("kor", kor);			
        model.addAttribute("astro", astro);			
        model.addAttribute("design", design);			
        
        return "sum/admin/certification/certificationStatistics";
    }
    
	
	
}
