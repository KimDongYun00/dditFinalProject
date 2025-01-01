package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AssignmentSubmitVO {
	private String assSubNo;
	private String assNo;
	private String stuNo;
	private String assSubComment;
	private int assSubScore;
	private String assSubDate;
	private String fileGroupNo;
	private String lecNo;
	
	private StudentVO studentVO; // 교수 Mapper에서 조인하기 위해 만들어둠
	
	private MultipartFile[] assFile;
	private List<FileVO> assFileList;
	
	private String[] delFileNo; // 삭제할 파일 번호 
	
	public void setAssFile(MultipartFile[] assFile) {  
		this.assFile = assFile;
		if(assFile != null) {
			List<FileVO> assFileList = new ArrayList<FileVO>();
			for(MultipartFile item : assFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) continue;
				FileVO assFileVO = new FileVO(item);
				assFileList.add(assFileVO);
			}
			this.assFileList = assFileList;
		}
	}
}
