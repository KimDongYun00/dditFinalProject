package kr.or.ddit.lecnotice.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.lecnotice.service.ILectureNoticeService;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/lectureNotice")
public class LectureNoticeController {
	
	@Inject
	private ILectureNoticeService lecService;
	
	@GetMapping("/selectLectureNotice.do")
	public String selectLectureNotice(Model model, String lecNo,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage) {
		PaginationInfoVO<LectureNoticeVO> pagingVO = new PaginationInfoVO<LectureNoticeVO>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setLecNo(lecNo);
		
		int totalRecord = lecService.selectLectureNoticeCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<LectureNoticeVO> lectureNoticeList = lecService.selectLectureNoticeList(pagingVO);
		pagingVO.setDataList(lectureNoticeList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "sum/lectureNotice/lectureNoticeList";
	}
	
	@GetMapping("/selectLectureNoticeDetail.do")
	public String selectLectureNoticeDetail(String lecNotNo, Model model) {
		LectureNoticeVO lectureNoticeVO = lecService.selectLectureNoticeDetail(lecNotNo);
		model.addAttribute("lectureNoticeVO", lectureNoticeVO);
		
		return "sum/lectureNotice/lectureNoticeDetail";
	}
	
	@GetMapping("/insertLectureNotice.do")
	public String insertLectureNoticeForm(String lecNo, Model model) {
		
		model.addAttribute("lecNo",lecNo);
		return "sum/lectureNotice/lectureNoticeForm";
	}
	
	//강의공지사항 등록(비동기)
	//뷰(JSP)에서 비동기로 Controller로 요청 시 JSON타입의 string으로 옴 -> 받으려면 RequestBody -> return도 JSON으로 : ResponseBody
	@ResponseBody
	@PostMapping("/insertLectureNoticeAjax.do")
	public LectureNoticeVO insertLectureNoticeAjax(@RequestBody LectureNoticeVO lectureNoticeVO) {
		//insertLectureNoticeAjax->lectureNoticeVO : 
		//LectureNoticeVO(lecNotNo=null, lecNo=L0103, lecNotTitle=aaa, lecNotContent=<p>asdf</p>
		//				, lecNotDate=null, lecNotCnt=0, rnum=0)
		log.info("insertLectureNoticeAjax->lectureNoticeVO : " + lectureNoticeVO);
		
		//insert/update/delete의 return 타입 : int
		int result = this.lecService.insertLectureNotice(lectureNoticeVO);
		log.info("insertLectureNoticeAjax->result : " + result);
		
		//lectureNoticeVO{lecNotNo=LEC_NOT_20240022,lecNo=L0103,lecNotTitle=제목,lecNotContent=내용,lecNotDate=null,lecNotCnt=0}
		return lectureNoticeVO;
	}
	
	@GetMapping("/updateLectureNotice.do")
	public String  updateLectureNoticeForm(String lecNo, String lecNotNo, Model model) {
		LectureNoticeVO lectureNoticeVO = lecService.selectLectureNoticeDetail(lecNotNo);
		model.addAttribute("lectureNoticeVO", lectureNoticeVO);
		log.info("updateLectureNoticeForm->lectureNoticeVO : " + lectureNoticeVO);
		return "sum/lectureNotice/lectureNoticeUpdateForm";
	}
	
	
	@ResponseBody
	@PostMapping("/updateLectureNoticeAjax.do")
	public LectureNoticeVO updateLectureNoticeAjax(@RequestBody LectureNoticeVO lectureNoticeVO) {
	
		int result = this.lecService.updateLectureNotice(lectureNoticeVO);
		log.info("updateLectureNoticeAjax->result : " + result);
		
		return lectureNoticeVO;
	}
	
	
	@PostMapping( "/deleteLectureNotice.do")
	public String deleteLectureNotice(RedirectAttributes ra, String lecNo,String lecNotNo) {
		log.info("deleteLectureNotice() 실행...!");
		String goPage = "";

		int result = lecService.deleteLectureNotice(lecNotNo);
		if (result > 0) { // 삭제 성공
			goPage = "redirect:/lectureNotice/selectLectureNotice.do?lecNo="+lecNo;
		} else { // 삭제 실패
			goPage = "redirect:/lectureNotice/selectLectureNoticeDetail.do?lecNotNo=" + lecNotNo+"&lecNo="+lecNo;
		}

		return goPage;
	}
	
	
}
