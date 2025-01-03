package kr.or.ddit.controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminCommonService;
import kr.or.ddit.service.admin.inter.IAdminDepartmentService;
import kr.or.ddit.service.admin.inter.IAdminMemberService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminMemberController {

	@Inject
	private IAdminMemberService memService;
	
	@Inject
	private IAdminDepartmentService deptService;
	
	@Inject
	private IAdminCommonService commonService;
	
	@RequestMapping(value = "/searchProfessor.do", method = RequestMethod.POST)
	public ResponseEntity<List<ProfessorVO>> searchProfessor(@RequestBody Map<String, String> map) {
		log.info("searchProfessor()...!");
		log.info("proName >> " + map.get("proName"));
		
		List<ProfessorVO> proList = memService.searchProfessor(map.get("proName"));
		for(ProfessorVO p : proList) log.info("proList >> " + p.toString());
		
		return new ResponseEntity<List<ProfessorVO>>(proList, HttpStatus.OK);
	}
	
	// 학생 정보 상세보기
	@RequestMapping(value="/stuDetail", method = RequestMethod.GET)	
	public String stuDetail(String stuNo, Model model) {
		log.info("stuNo");
		model.addAttribute("stuNo", stuNo);
		
		// 학생 정보
		StudentVO stuVO = memService.stuDetail(stuNo);
		model.addAttribute("stuVO", stuVO);
		
		// 학과 이름 리스트
		List<DepartmentVO> deptList = deptService.getDeptNameList();
		model.addAttribute("deptList", deptList);
				
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + stuVO.getComDetMNo());
		
		// 재적 상태 리스트
		List<CommonVO> codeName = memService.commonList("M01");		
		model.addAttribute("stuMCode", codeName);
		
		// 은행 선택 리스트
		List<CommonVO> bankList = commonService.getComDetailList("B01");
		model.addAttribute("bankList", bankList);
		
		return "sum/admin/member/stuDetail";
	}
	
	// 학생 정보 업데이트
	@RequestMapping(value="/stuUpdate", method = RequestMethod.POST)
	public String update(StudentVO stuVO, Model model, RedirectAttributes ra, HttpServletRequest req) {
		String goPage = "";		
		log.info("@@@@@@@ stuVO @@@@@" + stuVO);
		
		int cnt = memService.stuUpdate(stuVO, req);
		
		
		if(cnt > 0 ) { // 업데이트 성공
			ra.addFlashAttribute("msg", "수정에 성공했습니다.");
			goPage = "redirect:/admin/stuDetail?stuNo="+stuVO.getStuNo();
		}else {
			goPage= "redirect:/admin/stuDetail?stuNo=" + stuVO.getStuNo();
		}
		
		
		return goPage;
	}
	
	// 학생리스트
	@RequestMapping(value = "/stuList", method = RequestMethod.GET)
	public String stuList(
			  @RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, @RequestParam(required = false, defaultValue = "99") String searchType
			, @RequestParam(required = false) String searchWord
			, @RequestParam(required = false, defaultValue ="C99") String assNo			
			, Model model
			){
		
		PaginationInfoVO<StudentVO> pagingVO = new PaginationInfoVO<StudentVO>();
		pagingVO.setAssNo(assNo);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		List<DepartmentVO> deptL =  deptService.getDeptNameList();
		
		
		int totalRecord = memService.stuCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		List<StudentVO> dataList = memService.stuList(pagingVO);
		
		pagingVO.setDataList(dataList);
		model.addAttribute("deptL", deptL);
		model.addAttribute("searchType", searchType);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("assNo", assNo);
		
		return "sum/admin/member/stuList";
	}
	
	
	@RequestMapping(value="/stuInsertForm", method=RequestMethod.GET)
	public String stuForm(Model model) {
		
		// 학과 이름 리스트
		List<DepartmentVO> deptList = deptService.getDeptNameList();
		model.addAttribute("deptList", deptList);
		
		// 은행 선택 리스트
		List<CommonVO> bankList = commonService.getComDetailList("B01");
		model.addAttribute("bankList", bankList);
		
		return "sum/admin/member/stuInsertForm";
	}
	
	// 학생등록 
	// 학생 등록시 부모는 유저이기때문에 유저먼저 insert해야함
	@RequestMapping(value="/stuInsert", method=RequestMethod.POST)
	public String stuInsert(StudentVO stuVO, RedirectAttributes ra, Model model) {
		String goPage="";		
		
		String stuNo = memService.memInsert(stuVO);
		stuVO.setStuNo(stuNo);
		
		int cnt = memService.stuInsert(stuVO);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "등록이 완료되었습니다.");
			goPage = "redirect:/admin/stuList";				
			
		} else {
			model.addAttribute("stuVO", stuVO);
			goPage = "sum/admin/member/stuInsertForm";
			
			
		}		
		
		return goPage;
	}
	
	// 학생 일괄 등록 폼 페이지 이동
    @RequestMapping(value="/stuInsertAllForm", method=RequestMethod.GET)
    public String stuInsertAllForm() {
        return "sum/admin/member/stuInsertAllForm";
    }
 
    // 일괄 등록
    @PostMapping("/stuInsertAll")
    public String stuInsertAll(@RequestParam("file") MultipartFile file, RedirectAttributes ra) {
        try {
            List<StudentVO> students = memService.parseExcelFile(file);
            memService.insertAllStudents(students);
            ra.addFlashAttribute("msg", "학생 일괄 등록에 성공하였습니다!");
            return "redirect:/admin/stuList"; 
        } catch (IOException e) {
            ra.addFlashAttribute("msg", "fail");
            return "redirect:/admin/stuInsertAllForm"; 
        }
    }


	
	@RequestMapping(value="/stuDelete", method = RequestMethod.POST)
	public String stuDelete(String stuNo, RedirectAttributes ra) {
		int cnt = memService.stuDelete(stuNo);
		
		// 삭제 성공
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "삭제가 완료되었습니다.");
			return "redirect:/admin/stuList";
		
		// 삭제 실패
		} else {
			ra.addFlashAttribute("msg", "삭제에 실패했습니다.");
			return "redirect:/admin/stuDetail?proNo="+stuNo;
		}
	}
////////////////////////////////                교수                                           ////////////////////////////////	
	// 교수등록 
	// 교수 등록시 부모는 유저이기때문에 유저먼저 insert해야함
	@RequestMapping(value="/proInsert", method=RequestMethod.POST)
	public String stuInsert(ProfessorVO proVO, RedirectAttributes ra, Model model) {
		String goPage="";		
		
		int proUser = memService.memProInsert(proVO);		
		
		if(proUser > 0) {
			
			int cnt = memService.proInsert(proVO);

			if(cnt > 0) {
			ra.addFlashAttribute("msg", "등록이 완료되었습니다.");
			goPage = "redirect:/admin/proList";				
			}
			
		} else {
			model.addAttribute("proVO", proVO);
			goPage = "sum/admin/member/proInsertForm";
					
		}		
		
		return goPage;
	}

	// 교수 정보 상세보기/수정 폼
	@RequestMapping(value="/proDetail", method = RequestMethod.GET)	
	public String proDetail(String proNo, Model model) {
		log.info("proNo");
		model.addAttribute("proNo", proNo);
		
		// 교수 정보
		ProfessorVO proVO = memService.proDetail(proNo);
		model.addAttribute("proVO", proVO);
		
		// 학과 이름 리스트
		List<DepartmentVO> deptList = deptService.getDeptNameList();
		model.addAttribute("deptList", deptList);
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + proVO.getComDetMNo());
		
		// 재적 상태 리스트
		List<CommonVO> codeName = memService.commonList("M02");		
		model.addAttribute("proMCode", codeName);
		
		// 직위 상태 리스트
		List<CommonVO> proP = memService.commonList("P02");		
		model.addAttribute("proP", proP);
		
		// 은행 선택 리스트
		List<CommonVO> bankList = commonService.getComDetailList("B01");
		model.addAttribute("bankList", bankList);
		
		return "sum/admin/member/proDetail";
	}
	// 교수 등록 폼
	@RequestMapping(value="/proInsertForm", method=RequestMethod.GET)
	public String proForm(Model model) {
		
		// 학과 이름 리스트
		List<DepartmentVO> deptList = deptService.getDeptNameList();
		model.addAttribute("deptList", deptList);
		
		// 은행 선택 리스트
		List<CommonVO> bankList = commonService.getComDetailList("B01");
		model.addAttribute("bankList", bankList);
		
		return "sum/admin/member/proInsertForm";
	}
	
	// 교수 리스트
	@RequestMapping(value = "/proList", method = RequestMethod.GET)
	public String proList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchWord, Model model
			){
		
		PaginationInfoVO<ProfessorVO> pagingVO = new PaginationInfoVO<ProfessorVO>();
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		
		int totalRecord = memService.proCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		List<ProfessorVO> dataList = memService.proList(pagingVO);
		
		pagingVO.setDataList(dataList);

		// 직위 상태 리스트
		List<CommonVO> proP = memService.commonList("P02");		
		model.addAttribute("proP", proP);
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("searchWord", searchWord);
		
		return "sum/admin/member/proList";
	}
	
	
	// 교수 정보 업데이트
	@RequestMapping(value="/proUpdate", method = RequestMethod.POST)
	public String update(ProfessorVO proVO, Model model, RedirectAttributes ra, HttpServletRequest req) {
		String goPage = "";		
		log.info("@@@@@@@ proVO @@@@@" + proVO);
		
		int cnt = memService.proUpdate(proVO, req);
		
		
		if(cnt > 0 ) { // 업데이트 성공
			ra.addFlashAttribute("msg", "수정에 성공했습니다.");
			goPage = "redirect:/admin/proDetail?proNo="+ proVO.getProNo();
		}else {
			goPage= "redirect:/admin/proDetail?proNo=" + proVO.getProNo();
		}
		
		
		return goPage;
	}
	
	// 아이디 중복체크 만들었지만 아이디가 기본키라 못바꾸는거 같음?	
	@RequestMapping(value="/idCheck", method=RequestMethod.POST)
	public ResponseEntity<String> idcheck(String proNo){
		String msg = "";
		ResponseEntity<String> entity = null;
		
		log.info("@@@@@@@@@@@@@@@@@@@@proID======>> " + proNo);
		
		int count = memService.proIdCheck(proNo);
		
		if(count > 0) {
			
			entity = new ResponseEntity<String>(msg, HttpStatus.BAD_REQUEST);
		} else {
			
			entity = new ResponseEntity<String>(msg, HttpStatus.OK);
		}
		
		return entity;
	}
	
	// 교수 삭제
	@RequestMapping(value="/proDelete", method=RequestMethod.POST)
	public String deletePro(String proNo, Model model, RedirectAttributes ra) {
		
		int cnt = memService.proDelete(proNo);
		
		// 삭제 성공
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "삭제가 완료되었습니다.");
			return "redirect:/admin/proList";
		} else {
			ra.addFlashAttribute("msg", "삭제에 실패했습니다.");
			return "redirect:/admin/proDetail?proNo="+proNo;
		}		
		
	}
	
////////////////////////////////				 직원                                           ////////////////////////////////	
	// 직원 리스트
	
	// 직원 등록시 부모는 유저이기때문에 유저먼저 insert해야함
	@RequestMapping(value="/empInsert", method=RequestMethod.POST)
	public String empInsert(EmployeeVO empVO, RedirectAttributes ra, Model model) {
		String goPage="";		
		
		int empUser = memService.memEmpInsert(empVO);		
		
		if(empUser > 0) {
			
			int cnt = memService.empInsert(empVO);

			if(cnt > 0) {
				ra.addFlashAttribute("msg", "등록이 완료되었습니다.");
				goPage = "redirect:/admin/empList";				
			}
			
		} else {
			model.addAttribute("empVO", empVO);
			goPage = "sum/admin/member/empInsertForm";
					
		}		
		
		return goPage;
	}
	
	@RequestMapping(value="/empInsertForm", method=RequestMethod.GET)
	public String empForm(Model model) {
		
		// 부서 이름 리스트 동적
		List<CommonVO> department = commonService.getComDetailList("D01");
		model.addAttribute("department", department);
		
		// 은행 선택 리스트
		List<CommonVO> bankList = commonService.getComDetailList("B01");
		model.addAttribute("bankList", bankList);
		
		return "sum/admin/member/empInsertForm";
	}
		
	@RequestMapping(value = "/empList", method = RequestMethod.GET)
	public String empList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchWord, Model model
			){
		
		PaginationInfoVO<EmployeeVO> pagingVO = new PaginationInfoVO<EmployeeVO>();
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		
		int totalRecord = memService.empCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		List<EmployeeVO> dataList = memService.empList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		List<CommonVO> dept = commonService.getComDetailList("P01");
		
		model.addAttribute("dept", dept);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("pagingVO", pagingVO);
		
		
		return "sum/admin/member/empList";
	}
	
	// 직원 정보 상세보기
	@RequestMapping(value="/empDetail", method = RequestMethod.GET)	
	public String empDetail(String empNo, Model model) {
		log.info("empNo");
		model.addAttribute("empNo", empNo);
		
		// 직원 정보
		EmployeeVO empVO = memService.empDetail(empNo);
		model.addAttribute("empVO", empVO);
				
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + empVO.getComDetMNo());
		
		// 재적 상태 리스트
		List<CommonVO> codeName = memService.commonList("M02");		
		model.addAttribute("empMCode", codeName);
		
		// 은행 선택 리스트
		List<CommonVO> bankList = commonService.getComDetailList("B01");
		model.addAttribute("bankList", bankList);
		
		return "sum/admin/member/empDetail";
	}
	
	// 직원 정보 업데이트
	@RequestMapping(value="/empUpdate", method = RequestMethod.POST)
	public String empUpdate(EmployeeVO empVO, Model model, RedirectAttributes ra, HttpServletRequest req) {
		String goPage = "";		
		log.info("@@@@@@@ empVO @@@@@" + empVO);
		
		int cnt = memService.empUpdate(empVO, req);
		
		
		if(cnt > 0 ) { // 업데이트 성공
			ra.addFlashAttribute("msg", "수정에 성공했습니다.");
			goPage = "redirect:/admin/empDetail?empNo="+ empVO.getEmpNo();
		}else {
			goPage= "redirect:/admin/empDetail?empNo=" + empVO.getEmpNo();
		}
		
		
		return goPage;
	}
	
	// 직원 삭제
	@RequestMapping(value="/empDelete", method=RequestMethod.POST)
	public String empDelete(String empNo, Model model, RedirectAttributes ra) {
		
		int cnt = memService.empDelete(empNo);
		
		// 삭제 성공
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "삭제가 완료되었습니다.");
			return "redirect:/admin/empList";
		} else {
			ra.addFlashAttribute("msg", "삭제에 실패했습니다.");
			return "redirect:/admin/empDetail?empNo="+empNo;
		}				
	}
	
	
}


























