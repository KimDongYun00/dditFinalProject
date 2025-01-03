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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminDepartmentService;
import kr.or.ddit.service.admin.inter.IAdminSubjectService;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminSubjectController {
	
	@Inject
	private IAdminSubjectService subService;  
	
	@Inject
	private IAdminDepartmentService deptService;  

	@RequestMapping(value = "/subjectInsertForm", method = RequestMethod.GET)
	public String subjectInsertForm(Model model) {
		log.info("subjectInsertForm()...!");
		
		List<DepartmentVO> deptList = deptService.getDeptNameList();
		model.addAttribute("deptList", deptList);
		
		return "sum/admin/subject/subjectInsertForm";
	}
	
	@RequestMapping(value = "/insertSubject.do", method = RequestMethod.POST)
	public String subjectInsert(SubjectVO subjectVO) {
		log.info("subjectInsert()...!");
		log.info("subject >> " + subjectVO.toString());
		
		subService.insertSubject(subjectVO);
		
		return "redirect:/admin/subjectList";
	}
	
	@RequestMapping(value = "/subjectList", method = RequestMethod.GET)
	public String subjectList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "99") String searchType,
			Model model) {
		log.info("subjectList()...!");
		
		PaginationInfoVO<SubjectVO> pagingVO = new PaginationInfoVO<SubjectVO>();
		
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		
		// 총 게시글 수를 얻어온다.
		int totalRecord = subService.selectSubjectCount(pagingVO);
		log.info("totalRecord >> " + totalRecord);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<SubjectVO> dataList =  subService.getSubjectList(pagingVO);
		log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		for(SubjectVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		List<DepartmentVO> deptList = deptService.getDeptNameList();
		for(DepartmentVO d: deptList)  log.info("deptList >> " + d.toString());
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("deptList", deptList);
		
		return "sum/admin/subject/subjectList";
	}
	
	@RequestMapping(value = "/subjectAvailable.do", method = RequestMethod.POST)
	public ResponseEntity<String> subjectAvailable(@RequestBody SubjectVO subVO, RedirectAttributes ra){
		log.info("subjectAvailable()...!");
		log.info("getComDetVNo >> " + subVO.getComDetVNo());
		log.info("getSubNo >> " + subVO.getSubNo());
		
		subService.updateAvailable(subVO);
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	
	@RequestMapping(value = "/subjectDetail", method = RequestMethod.GET)
	public String subjectDetail(String subNo, Model model) {
		log.info("subjectDetail()...!");
		log.info("subNo >> " + subNo);
		
		SubjectVO subjectVO = subService.getSubjectBySubNo(subNo);
		model.addAttribute("subjectVO", subjectVO);
		
		return "sum/admin/subject/subjectDetail";
	}
	
	@RequestMapping(value = "/deleteSubject", method = RequestMethod.POST)
	public String subjectDelete(String subNo) {
		log.info("subjectDelete()...!");
		log.info("subNo >> " + subNo);
		
		subService.subjectDelete(subNo);
		
		return "redirect:/admin/subjectList";
	}
	
	
	@RequestMapping(value = "/updateSubject",method = RequestMethod.POST)
	public String updateSubject(SubjectVO subjectVO) {
		log.info("updateSubject()...!");
		log.info("subjectVO >> " + subjectVO.toString());
		
		subService.subjectUpdate(subjectVO);
		
		return "redirect:/admin/subjectDetail?subNo="+subjectVO.getSubNo();
	}
	
	
	@RequestMapping(value = "/searchSubject.do", method = RequestMethod.POST)
	public ResponseEntity<List<SubjectVO>> searchSubject(@RequestBody SubjectVO subVO) {
		log.info("searchSubject()...!");
		log.info("subVO >> " + subVO.getSubName());
		
		List<SubjectVO> subjectList = subService.searchSubject(subVO.getSubName());
		for(SubjectVO s : subjectList) log.info("subjectList >> " + s.toString());
		
		return new ResponseEntity<List<SubjectVO>>(subjectList, HttpStatus.OK);
	}
	
	
	
	
}
















