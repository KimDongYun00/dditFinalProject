package kr.or.ddit.lecData.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.lecData.service.ILectureDataService;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureDataVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/lectureData")
public class LectureDataController {
	@Inject
	private ILectureDataService lectureService;

	// 강의 자료실
	@GetMapping("/selectLectureDataList.do")
	public String selectLectureDataList(Model model, String lecNo, LectureDataVO lectureDataVO,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage) {

		PaginationInfoVO<LectureDataVO> pagingVO = new PaginationInfoVO<LectureDataVO>();

		pagingVO.setCurrentPage(currentPage);
		pagingVO.setLecNo(lecNo);
		// 총 게시글 수를 얻어온다.
		int totalRecord = lectureService.selectLectureDataCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<LectureDataVO> lectureDataList = lectureService.selectLectureDataList(pagingVO);
		pagingVO.setDataList(lectureDataList);

		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("lecNo", lecNo);

		return "sum/lecData/lectureDataList";
	}

	// 강의 자료실 상세보기
	@GetMapping("/selectLectureDataDetail.do")
	public String selectLectureDataDetail(Model model, String lecDataNo) {
		LectureDataVO lectureDataVO = lectureService.selectLectureDataDetail(lecDataNo);

		log.info("!..{}", lectureDataVO);

		List<FileVO> fileList = lectureService.selectFileList(lectureDataVO.getFileGroupNo());
		log.info("!.fileList{}", fileList);
		model.addAttribute("lectureDataVO", lectureDataVO);
		model.addAttribute("fileList", fileList);
		return "sum/lecData/lectureDataDetail";
	}
}
