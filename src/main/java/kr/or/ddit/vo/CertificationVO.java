package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CertificationVO {
	//--증명서
	private int rnum;				// 페이징처리를 위한
	private String cerNo;			// 증명서 번호
	private String cerName;			// 증명서명
	private String cerContent;		// 증명서내용
	private String fileGroupNo;		// 파일그룹번호
	private int cerCharge;			// 수수료금액
	
	//--증명서 발급
	private String cerPriNo;		// 증명서 발급 번호
	private String stuNo;			// 학번
	private String cerPriDate;		// 발급일자
	
	// 증명서 파일 처리
	private MultipartFile[] cerFile;
	private List<FileVO> cerFileList;
	
	public void setCerFile(MultipartFile[] cerFile) {  
		this.cerFile = cerFile;
		if(cerFile != null) {
			List<FileVO> cerFileList = new ArrayList<FileVO>();
			for(MultipartFile item : cerFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) 
					continue;
				FileVO cerFileVO = new FileVO(item);
				cerFileList.add(cerFileVO);
			}
			this.cerFileList = cerFileList;
		}
	}
	
	
}
