package kr.or.ddit.controller.professor;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.service.professor.inter.INotificationService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/professor")
public class ProBoardController {
	
	@Inject
	private INotificationService service;
	
	@Inject
	private IFileService fileService;


	@RequestMapping(value = "/notificationList", method = RequestMethod.GET)
    public String notificationList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                   @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
                                   Model model) {
        // 한 화면에 보여질 게시글의 수
        int itemsPerPage = 10;

        Map<String, Object> map = new HashMap<>();
        // 현재 페이지 번호
        map.put("page", page);
        // 한 화면에 보여질 글의 수
        map.put("itemsPerPage", itemsPerPage);
        // 검색어
        map.put("keyword", keyword);

        // board 테이블의 전체 행의 수
        int totalItems = service.getBoardCount(map);

        // 전체 페이지 수 구하기
        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

        List<BoardVO> boardList = service.list(map);

        // 페이징 정보 설정
        PaginationInfoVO<BoardVO> paginationInfoVO = new PaginationInfoVO<>(itemsPerPage, 5);
        paginationInfoVO.setTotalRecord(totalItems);
        paginationInfoVO.setCurrentPage(page);

        model.addAttribute("boardList", boardList);
        model.addAttribute("paginationInfoVO", paginationInfoVO); // paginationInfoVO가 꼭 있어야 함
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "sum/professor/board/notificationList";
    }

	// 상세
	@RequestMapping(value = "/detail/{boNo}", method = RequestMethod.GET)
	public String announcementDetail(@PathVariable("boNo") String boNo, Model model) {
		service.incrementViewCount(boNo);
		BoardVO board = service.detail(boNo);
		model.addAttribute("board", board);
		return "sum/professor/board/notificationDetail";
	}
	
	// 페이징 처리에 검색 포함되어서 필요없음
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search(@RequestParam("keyword") String keyword, Model model) {
		List<BoardVO> searchResults = service.search(keyword);
		model.addAttribute("boardList", searchResults);
		model.addAttribute("keyword", keyword);
		return "sum/professor/board/notificationList";
	}
	
	 // 파일 다운로드
    @RequestMapping(value = "/downloadFile", method = RequestMethod.GET)
    public void downloadFile(@RequestParam("fileGroupNo") String fileGroupNo, HttpServletResponse response) {
        List<FileVO> fileList = fileService.getFileByFileGroupNo(fileGroupNo);

        if (fileList != null && !fileList.isEmpty()) {
            FileVO fileVO = fileList.get(0); // 첫 번째 파일 가져오기
            File file = new File(fileVO.getFileSavepath());

            if (file.exists()) {
                response.setContentType("application/octet-stream");
                response.setContentLength((int) file.length());

                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", fileVO.getFileName());
                response.setHeader(headerKey, headerValue);

                try (BufferedInputStream inStream = new BufferedInputStream(new FileInputStream(file));
                     BufferedOutputStream outStream = new BufferedOutputStream(response.getOutputStream())) {

                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = inStream.read(buffer)) != -1) {
                        outStream.write(buffer, 0, bytesRead);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                try {
                    response.getWriter().write("파일을 찾을 수 없습니다.");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            try {
                response.getWriter().write("파일을 찾을 수 없습니다.");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


}


