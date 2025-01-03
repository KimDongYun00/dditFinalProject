package kr.or.ddit.assignment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.assignment.service.IAssignmentService;
import kr.or.ddit.vo.AssignmentSubmitVO;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/assignment")
public class AssignmentController {
	
	@Inject
	private IAssignmentService service;
	
	@RequestMapping(value = "/selectAssignmentList.do", method = RequestMethod.GET)
	public String selectAssignmentList(String lecNo, Model model,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage) {
		CustomUser user = 
				(CustomUser)(SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		UserVO userVO = user.getUser();
		
		PaginationInfoVO<AssignmentVO> pagingVO = new PaginationInfoVO<AssignmentVO>();
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setLecNo(lecNo);
		
		int totalRecord = service.selectAssignmentCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<AssignmentVO> assignmentList = service.selectAssignmentList(pagingVO);
		Map<String, String> subMap = new HashMap<String, String>();
		for (int i = 0; i < assignmentList.size(); i++) {
			// 학생 번호 가져오기 
			subMap.put("stuNo", userVO.getUserNo());
			subMap.put("assNo", assignmentList.get(i).getAssNo());
			
			int assSubmit = service.countSubmit(subMap);
			
			if(assSubmit > 0) {
				assignmentList.get(i).setAssSubmit("제출");
			}else {
				assignmentList.get(i).setAssSubmit("미제출");
			}
			
		}
		
		pagingVO.setDataList(assignmentList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("lecNo", lecNo);
		
		log.info("리스트 확인  {}", pagingVO);
		return "sum/lecAssignment/list";
	} 
	
	@GetMapping("/selectAssignmentDetail.do")
	public String selectAssignmentDetail(String lecNo,String assNo, Model model,
			@RequestParam(name = "page", required = false, defaultValue = "1")int currentPage){
		AssignmentVO assignmentVO = new AssignmentVO();
		assignmentVO = service.selectAssignmentDetail(assNo);
		assignmentVO.setLecNo(lecNo);
		model.addAttribute("assignmentVO", assignmentVO);
		
		CustomUser user = 
				(CustomUser)(SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		UserVO userVO = user.getUser();
		
		AssignmentSubmitVO assignmentSubmitVO = new AssignmentSubmitVO();
		assignmentSubmitVO.setStuNo(userVO.getUserNo());
		assignmentSubmitVO.setAssNo(assNo);
		
		assignmentSubmitVO = service.selectAssignmentSubmit(assignmentSubmitVO);
		
		log.debug("assignmentSubmitVO {}", assignmentSubmitVO);
		log.debug("service {}", service);
		if(assignmentSubmitVO != null) {
			List<FileVO> fileList = service.selectFileList(assignmentSubmitVO.getFileGroupNo());
			model.addAttribute("fileList", fileList);
		} 
		
		
		model.addAttribute("assignmentSubmitVO",assignmentSubmitVO);
		
		return "sum/lecAssignment/detail";
	}
	
	// 과제 제출
	@ResponseBody
	@PostMapping("/insertAssignmentSubmit.do")
	public ResponseEntity<String> insertAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO) {
		log.info("insertAssignmentSubmit->assignmentSubmitVO : " + assignmentSubmitVO);
		int result = service.insertAssignmentSubmit(assignmentSubmitVO);
		log.info("result : " + result);
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		
	}
	
	// 과제 수정
	@ResponseBody
	@PostMapping("/updateAssignmentSubmit.do")
	public ResponseEntity<String> updateAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO) {
		log.info("updateAssignmentSubmit->assignmentSubmitVO : " + assignmentSubmitVO);
		int result = service.updateAssignmentSubmit(assignmentSubmitVO);
		log.info("result : " + result);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		
	}
	
	

}
