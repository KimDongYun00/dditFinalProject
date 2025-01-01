package kr.or.ddit.controller.admin;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import freemarker.core.ReturnInstruction.Return;
import kr.or.ddit.service.admin.inter.IAdminCommonService;
import kr.or.ddit.service.admin.inter.IAdminNotificationService;
import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminBoardController {

	@Inject
	private IAdminNotificationService service;

	@Inject
	private IFileService fileService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String AdminNotificationList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword, Model model) {

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

		return "sum/admin/board/adminNotificationList";

	}

	// 상세
	@RequestMapping(value = "/detail/{boNo}", method = RequestMethod.GET)
	public String adminDetail(@PathVariable("boNo") String boNo, Model model) {
		service.incrementView(boNo);
		BoardVO board = service.detail(boNo);
		
		 // 줄바꿈 문자를 <br> 태그로 변환
	    String formattedContent = board.getBoContent().replace("\n", "<br>").replace("\r", "<br>");
	    board.setBoContent(formattedContent);
	    
	    
		model.addAttribute("board", board);
		return "sum/admin/board/adminNotificationDetail";
	}

	// 일괄처리
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteBoards(@RequestParam("selectedIds") List<String> selectedIds, Model model) {
		for (String id : selectedIds) {
			service.deleteBoard(id);
		}
		model.addAttribute("message", "선택된 게시글이 삭제되었습니다!");
		return "redirect:/admin/list";
	}

	
	// 새 글 등록
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertBoard( Model model) {
		return "sum/admin/board/adminInsert";
	}

	// 새 글 등록
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertBoard(@RequestParam("boTitle") String boTitle, 
			@RequestParam("boContent") String boContent, @RequestParam("file") MultipartFile file, Model model) {
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		BoardVO board = new BoardVO();
		board.setBoTitle(boTitle); 
//		board.setEmpNo(empNo);
		board.setBoContent(boContent);
		board.setEmpNo(userVO.getUserNo());
		
		String fileGroupNo = service.getFileGroupNo();

		board.setFileGroupNo(fileGroupNo);
		
		if (!file.isEmpty()) {
			String fileName = file.getOriginalFilename();
			String saveFileName = UUID.randomUUID().toString() +"_" + fileName;
			String uploadDir = "C:/SVN/documents/file/notice";
			File uploadFile = new File(uploadDir, saveFileName);
			try {
				if (!uploadFile.getParentFile().exists()) {
					uploadFile.getParentFile().mkdirs();
				}
				file.transferTo(uploadFile);

				FileVO fileVO = new FileVO();
				fileVO.setFileGroupNo(fileGroupNo);
				fileVO.setFileNo(1);
				fileVO.setFileName(fileName);
				fileVO.setFileSaveName(saveFileName);
				fileVO.setFileSize(file.getSize());
				fileVO.setFileFancysize( Math.ceil( file.getSize()/1024.0) + "KB" );
				fileVO.setFileMime(file.getContentType());
				fileVO.setFileSavepath(uploadDir + "/" + saveFileName);
				
				fileService.insertNoticeFile(fileVO);
			} catch (IOException e) {
				e.printStackTrace();
				return "fail";
			}
		}

		service.insertBoard(board);
		model.addAttribute("message", "글이 등록되었습니다!");
		return "redirect:/admin/list";
	}

	// 게시글 수정 
	@ResponseBody
	@RequestMapping(value = "/updateAjax", method = RequestMethod.POST)
	public String updateBoardAjax(@RequestParam("boNo") String boNo, @RequestParam("boTitle") String boTitle,
			@RequestParam("boContent") String boContent, @RequestParam("fileGroupNo") String fileGroupNo,
			@RequestParam("file") MultipartFile file) {
		
		BoardVO board = new BoardVO();
		board.setBoNo(boNo);
		board.setBoTitle(boTitle);
		board.setBoContent(boContent);
		board.setFileGroupNo(fileGroupNo);

		if (!file.isEmpty()) {
			String fileName = file.getOriginalFilename();
			String saveFileName = UUID.randomUUID().toString() +"_" + fileName;
			String uploadDir = "C:/SVN/documents/file/notice";
			File uploadFile = new File(uploadDir, saveFileName);
			try {
				if (!uploadFile.getParentFile().exists()) {
					uploadFile.getParentFile().mkdirs();
				}
				file.transferTo(uploadFile);

				// 파일 정보를 FILE 테이블에 저장
				FileVO fileVO = new FileVO();
				fileVO.setFileGroupNo(fileGroupNo);
				fileVO.setFileNo(1);
				fileVO.setFileName(fileName);
				fileVO.setFileSaveName(saveFileName);
				fileVO.setFileSize(file.getSize());
				fileVO.setFileFancysize( Math.ceil( file.getSize()/1024.0) + "KB" );
				fileVO.setFileMime(file.getContentType());
				fileVO.setFileSavepath(uploadDir + "/" + saveFileName);
				
			} catch (IOException e) {
				e.printStackTrace();
				return "fail";
			}
		}

		service.updateBoard(board);
		return "success";
		
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
