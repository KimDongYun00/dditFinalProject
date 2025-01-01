


package kr.or.ddit.controller.student;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.service.student.inter.IStuLicenseService;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LicenseVO;
import kr.or.ddit.vo.ScholarshipVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

// 학생 - 자격증
@Controller
@Slf4j
@RequestMapping("/student")
public class StuLicenseController {

	@Inject
	private IStuLicenseService service;
	
	@Inject
	private IFileService fileService;
	
	 // 자격증 등록 폼 실행
    @RequestMapping(value = "/licenseForm", method = RequestMethod.GET)
    public String insertLicenseForm(Model model) {
        return "sum/student/license/licenseForm";
    }

    // 자격증 등록 
    @RequestMapping(value = "/insertLicense", method = RequestMethod.POST)
    public String insertLicense(LicenseVO licenseVO, RedirectAttributes redirectAttributes) {
        log.info("insertLicense()....! 자격증 등록 실행...!");
        log.info("insertLicense()->licenseVO : " + licenseVO);//*****

        // 자격증 등록 서비스 호출
        boolean success = service.insertLicense(licenseVO);

        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "자격증이 성공적으로 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "자격증 등록 중 오류가 발생했습니다.");
        }

        return "redirect:/student/licenseForm"; // 등록 후 자격증 목록 페이지로 리다이렉트
    }

    // 내가 신청한 자격증 목록 조회 
    @RequestMapping(value = "/myLicenseList", method = RequestMethod.GET)
    public String myLicenseList(Model model, Principal principal) {
        log.info("신청한 자격증 내역 조회...!");

        String stuNo = principal.getName();

        log.info("로그인한 userId : " + stuNo);
        
        List<LicenseVO> licenseList = service.myLicenseList(stuNo);
        
        model.addAttribute("licenseList", licenseList);
        
        return "sum/student/license/myLicenseList";
    }
    
    // 내가 신청한 자격증 내역 수정
 	@RequestMapping(value="/licenseUpdate", method =RequestMethod.POST)
 	public String licenseUpdate(LicenseVO licenseVO, RedirectAttributes ra, Model model) {
 		String goPage ="";
 		
 		int cnt = service.licenseUpdate(licenseVO);
 		
 		if(cnt > 0) {
 			ra.addFlashAttribute("msg", "자격증 수정이 완료되었습니다.");
 			goPage = "redirect:/student/licenseDetail?licNo="+ licenseVO.getLicNo();
 		} else {
 			model.addAttribute("msg", "서버 오류, 잠시후 시도해주세요.");
 			model.addAttribute("licenseVO", licenseVO);
 			goPage = "sum/student/license/licenseForm";
 		}
 		
 		return goPage;
 	}
    
    // 내가 신청한 자격증 내역 삭제
    @RequestMapping(value="/licenseDelete", method = RequestMethod.POST)
	public String licenseDelete(String licNo, RedirectAttributes ra, Model model) {
		String goPage="";
		
		int cnt = service.licenseDelete(licNo);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "삭제 처리가 완료되었습니다.");
			goPage = "redirect:/student/myLicenseList";
		} else {
			model.addAttribute("licNo", licNo);
			model.addAttribute("msg", "알 수 없는 이유로 삭제에 실패했습니다.");
			goPage = "sum/student/license/licenseForm";
		}
		return goPage;
	}
    
    // 자격증 상세보기
 	@RequestMapping(value = "/licenseDetail", method = RequestMethod.GET)
 	public String licenseDetail(Model model, @RequestParam String licNo) {
 		//log.info("학생 입장에서 자격증 상세 보기 조회...!");

 		LicenseVO licenseVO = service.licenseDetail(licNo);
 		model.addAttribute("licenseVO", licenseVO);
 		
 		String fileGroupNo = licenseVO.getFileGroupNo();
 		
 		log.info("fileGroupNo : =======>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + fileGroupNo);
 		
 		if(fileGroupNo != null) {
 			
 			List<FileVO> fileList = fileService.getFileByFileGroupNo(fileGroupNo);
 			model.addAttribute("fileList",fileList);
 		}
 			
 		return "sum/student/license/licenseDetail";
 	}
   
}
	

