package kr.or.ddit.controller.common;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView {
	
	@Override
	protected void renderMergedOutputModel(
			Map<String, Object> model, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Map<String, Object> fileMap = (Map<String, Object>)model.get("fileMap");
		
		File saveFile = new File(fileMap.get("fileSavePath").toString());
		String fileName = (String)fileMap.get("fileName");
		
		// 요청 Header 정보등 중, User-Agent 영역 안에 여러 키워드 정보들을 가지고
		// 특정 키워드가 포함되어 있는지를 체크해서 파일명의 출력 인코딩 부분을 설정한다.
		// 사용 브라우저 또는 현상에 따라 발생하는 알고리즘 이므로, 내가 사용하게 되는 브라우저의 버전이나 얻어온
		// Header 정보들의 값에 따라 차이가 발생할 수 있다.
		// 사용자 환경에 따른 처리 (Chrome인지 뭐인지)
		String agent = request.getHeader("User-Aget");
		if(StringUtils.containsIgnoreCase(agent, "msie") || 
				StringUtils.containsIgnoreCase(agent, "trident")) {	// IE, Chrome
			fileName = URLEncoder.encode(fileName, "UTF-8");
		} else {	// firefox, chrome
			fileName = new String(fileName.getBytes(), "ISO-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
		response.setHeader("Content-length", fileMap.get("fileSize").toString());
		
		// try(){} : try with resources
		// () 안에 명시한 객체는 finally로 최종 열린 객체에 대한 close를 처리하지 않아도 자동 close가 이루어진다.
		try (
			OutputStream os = response.getOutputStream();
		){
			FileUtils.copyFile(saveFile, os);	// 파일 다운로드
		}
		
	}

	
	
	
	
	
	
	
	
	
}

























