package kr.or.ddit.controller.student;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.service.student.inter.IStuScholarshipService;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.ScholarshipVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/student")
public class StuScholarshipController {

	@Inject
	private IStuScholarshipService scholarshipService;
	
	@Inject
	private IFileService fileService;
	

	// 장학 종류 조회
	@RequestMapping(value = "/scholarshipList", method = RequestMethod.GET)
	public String scholarshipList(Model model, @RequestParam(required = false) String type,
			@RequestParam(required = false) String searchName) {
		//log.info("학생 입장에서 장학 종류 조회...!");

		List<ScholarshipVO> scholarshipList = scholarshipService.scholarshipList();

		// 필터링 로직 추가
		if (type != null && !type.equals("전체")) {
			scholarshipList = scholarshipList.stream().filter(s -> s.getSchType().equals(type))
					.collect(Collectors.toList());
		}
		if (searchName != null && !searchName.isEmpty()) {
			scholarshipList = scholarshipList.stream()
					.filter(s -> s.getSchName().toLowerCase().contains(searchName.toLowerCase()))
					.collect(Collectors.toList());
		}

		model.addAttribute("scholarshipList", scholarshipList);
		model.addAttribute("selectedType", type);
		model.addAttribute("searchName", searchName);

		return "sum/student/scholarship/scholarshipList";
	}

	// 선차감 목록 조회
	@RequestMapping(value = "/preScholarshipList", method = RequestMethod.GET)
	public String preScholarshipList(Model model, @RequestParam(required = false) String searchName) {
		//log.info("학생 입장에서 선차감 장학 종류 조회...!");

		List<ScholarshipVO> scholarshipList = scholarshipService.preScholarshipList().stream()
				.filter(s -> s.getSchType().equals("선차감")).collect(Collectors.toList());

		if (searchName != null && !searchName.isEmpty()) {
			scholarshipList = scholarshipList.stream()
					.filter(s -> s.getSchName().toLowerCase().contains(searchName.toLowerCase()))
					.collect(Collectors.toList());
		}

		model.addAttribute("scholarshipList", scholarshipList);
		model.addAttribute("selectedType", "선차감");
		model.addAttribute("searchName", searchName);

		return "sum/student/scholarship/preScholarshipList";
	}

	// 후지급 목록 조회
	@RequestMapping(value = "/postScholarshipList", method = RequestMethod.GET)
	public String postScholarshipList(Model model, @RequestParam(required = false) String searchName) {
		//log.info("학생 입장에서 후지급 장학 종류 조회...!");

		List<ScholarshipVO> scholarshipList = scholarshipService.postScholarshipList().stream()
				.filter(s -> s.getSchType().equals("후지급")).collect(Collectors.toList());

		if (searchName != null && !searchName.isEmpty()) {
			scholarshipList = scholarshipList.stream()
					.filter(s -> s.getSchName().toLowerCase().contains(searchName.toLowerCase()))
					.collect(Collectors.toList());
		}

		model.addAttribute("scholarshipList", scholarshipList);
		model.addAttribute("selectedType", "후지급");
		model.addAttribute("searchName", searchName);

		return "sum/student/scholarship/postScholarshipList";
	}

	// 장학 종류 상세보기
	@RequestMapping(value = "/scholarshipDetail", method = RequestMethod.GET)
	public String scholarshipDetail(Model model, String schNo) {
		//log.info("학생 입장에서 장학 상세 보기 조회...!");

		List<ScholarshipVO> scholarshipVO = scholarshipService.scholarshipDetail(schNo);

		model.addAttribute("scholarshipVO", scholarshipVO);

		return "sum/student/scholarship/scholarshipDetail";
	}

	// 장학금 신청 폼 화면
	@RequestMapping(value = "/scholarshipRequestInsertForm", method = RequestMethod.GET)
	public String scholarshipRequestInsertForm(Model model, @RequestParam String schNo, Principal principal) {
		String stuNo = principal.getName(); // 신청자 ID = 로그인 한 USER
		ScholarshipVO scholarshipVO = scholarshipService.getScholarshipByNo(schNo); // 장학금번호로 장학금 이름 꺼내오기
		model.addAttribute("scholarshipVO", scholarshipVO);
		model.addAttribute("schNo", schNo);
		model.addAttribute("stuNo", stuNo);
		model.addAttribute("schName", scholarshipVO.getSchName());
		return "sum/student/scholarship/scholarshipInsertForm";
	}

	// 장학금 신청
	@RequestMapping(value = "/insertScholarshipRequest", method = RequestMethod.POST)
	public String insertScholarshipRequest(ScholarshipVO scholarshipVO, BindingResult result, Model model, Principal principal) {

		if (result.hasErrors()) {
			return "sum/student/scholarship/scholarshipInsertForm";
		}

		String stuNo = principal.getName(); // 장학금 신청 ID = 로그인 한 아이디

		scholarshipVO.setStuNo(stuNo); // 장학금 신청자 설정

		scholarshipService.insertScholarshipRequest(scholarshipVO);

		return "redirect:/student/scholarshipList";
	}
	

    // 본인의 장학금 수혜 전체 내역 조회
    @RequestMapping(value = "/myScholarshipList", method = RequestMethod.GET)
    public String myScholarshipList(Model model, 
                                    @RequestParam(required = false) String type,
                                    @RequestParam(required = false) String searchName,
                                    Principal principal) {
        //log.info("수혜받은 장학 내역 조회...!");

        String stuNo = principal.getName();

       //log.info("로그인한 userId : " + stuNo);
        
        List<ScholarshipVO> scholarshipList = scholarshipService.myScholarshipList(stuNo);
        
        // 필터링 로직 추가
        if (type != null && !type.equals("전체")) {
            scholarshipList = scholarshipList.stream()
                                             .filter(s -> {
                                                 switch (type) {
                                                     case "승인":
                                                         return "C0201".equals(s.getComDetCNo());
                                                     case "미승인":
                                                         return "C0202".equals(s.getComDetCNo());
                                                     case "반려":
                                                         return "C0203".equals(s.getComDetCNo());
                                                     default:
                                                         return true;
                                                 }
                                             })
                                             .collect(Collectors.toList());
        }
        if (searchName != null && !searchName.isEmpty()) {
            scholarshipList = scholarshipList.stream()
                                             .filter(s -> s.getSchName().toLowerCase().contains(searchName.toLowerCase()))
                                             .collect(Collectors.toList());
        }
        
        model.addAttribute("scholarshipList", scholarshipList);
        model.addAttribute("selectedType", type);
        model.addAttribute("searchName", searchName);
        
        return "sum/student/scholarship/myScholarshipList";
    }

	// 장학금 신청 내역 상세보기
	@RequestMapping(value = "/myRequestDetail", method = RequestMethod.GET)
	public String myScholarshipDetail(Model model, @RequestParam String schRecNo) {
		//log.info("학생 입장에서 자격증 상세 보기 조회...!");

		ScholarshipVO scholarshipVO = scholarshipService.myRequestDetail(schRecNo);
		model.addAttribute("scholarshipVO", scholarshipVO);
		
		String fileGroupNo = scholarshipVO.getFileGroupNo();
		
		log.info("fileGroupNo : =======>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + fileGroupNo);
		
		if(fileGroupNo != null) {
			List<FileVO> fileList = fileService.getFileByFileGroupNo(fileGroupNo);
			model.addAttribute("fileList",fileList);
			log.info("fileList : =================> " + fileList.toString());
		}
		
		log.info("fileList : =================> " + fileGroupNo);
		
			
		return "sum/student/scholarship/myScholarshipRequestDetail";
	}
	
	// 장학금 신청 내역수정
	@RequestMapping(value = "/scholarshipRequestUpdate", method = RequestMethod.POST)
	public String scholarshipRequestUpdate(ScholarshipVO scholarshipVO, RedirectAttributes ra) {
		String goPage = "";
		log.info("########################################################################");
		log.info("scholarshipVO ++++++++++++++++++++++++++++++++" + scholarshipVO);
		log.info("schNo: " + scholarshipVO.getSchNo());

		int cnt = scholarshipService.scholarshipRequestUpdate(scholarshipVO);

		if (cnt > 0) {
			log.info("수정 성공!!!!!!!!!!!!!!!!!!!!!");
			ra.addFlashAttribute("msg", "장학금 수정이 완료되었습니다.");
			goPage = "redirect:/student/myRequestDetail?schRecNo=" + scholarshipVO.getSchRecNo();
		} else {
			log.info("수정 실패!!!!!!!!!!!!!!!");
			goPage = "sum/student/scholarship/myScholarshipList";
		}
		return goPage;
	}
	
	// 장학금 신청 내역 삭제
	@RequestMapping(value = "/scholarshipRequestDelete", method = RequestMethod.POST)
	public String scholarshipRequestDelete(String schRecNo, RedirectAttributes ra, Model model) {
		String goPage = "";

		int cnt = scholarshipService.scholarshipRequestDelete(schRecNo);

		if (cnt > 0) {
			ra.addFlashAttribute("msg", "삭제 처리가 완료되었습니다.");
			goPage = "redirect:/student/myScholarshipList";
		} else {
			model.addAttribute("schRecNo", schRecNo);
			model.addAttribute("msg", "알 수 없는 이유로 삭제에 실패했습니다.");
			goPage = "sum/student/scholarship/scholarshipList";
		}
		return goPage;
	}

	// 장학금 승인 내역 조회
	@RequestMapping(value = "/approvedList", method = RequestMethod.GET)
	public String approvedList(Model model, String stuNo, Principal principal) {

		stuNo = principal.getName();
		List<ScholarshipVO> approvedList = scholarshipService.approvedList(stuNo);

		model.addAttribute("approvedList", approvedList);

		return "sum/student/scholarship/approvedList";
	}

	// 장학금 미승인 내역 조회
	@RequestMapping(value = "/unApprovedList", method = RequestMethod.GET)
	public String unApprovedList(Model model, String stuNo, Principal principal) {

		stuNo = principal.getName();
		List<ScholarshipVO> unApprovedList = scholarshipService.unApprovedList(stuNo);

		model.addAttribute("unApprovedList", unApprovedList);

		return "sum/student/scholarship/unApprovedList";
	}

	// 장학금 반려 내역 조회
	@RequestMapping(value = "/rejectedList", method = RequestMethod.GET)
	public String rejectedList(Model model, String stuNo, Principal principal) {

		stuNo = principal.getName();
		List<ScholarshipVO> rejectedList = scholarshipService.rejectedList(stuNo);

		model.addAttribute("rejectedList", rejectedList);

		return "sum/student/scholarship/rejectedList";
	}
	
	
}
