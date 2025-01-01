package kr.or.ddit.controller.common;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.vo.FileVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/common")
public class FileDownloadController {

	@Inject
	private IFileService fileService;
	
	
	
	@RequestMapping(value = "/fileDownload.do", method = RequestMethod.GET)
	public View fileDownload(FileVO fileVO, ModelMap model) {
		
		FileVO file = fileService.getFileByFileNo(fileVO);
		fileService.increaseDownloadCount(fileVO);
		
		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("fileName", file.getFileName());
		fileMap.put("fileSize", file.getFileSize());
		fileMap.put("fileSavePath", file.getFileSavepath());
		model.addAttribute("fileMap", fileMap);
		
		return new FileDownloadView();
	}
	
	
	
	
} 
























