package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class LectureDataVO {
	private String lecDataNo;
	private String lecNo;
	private String lecDataTitle;
	private String lecDataContent;
	private String lecDataRegdate;
	private int lecDataCnt;
	private String fileGroupNo;
	private int rnum;
	
	private MultipartFile[] lecFile;
	private List<FileVO> lecFileList;
	
	public void setLecFile(MultipartFile[] lecFile) {  
		this.lecFile = lecFile;
		if(lecFile != null) {
			List<FileVO> lecFileList = new ArrayList<FileVO>();
			for(MultipartFile item : lecFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) continue;
				FileVO lecFileVO = new FileVO(item);
				lecFileList.add(lecFileVO);
			}
			this.lecFileList = lecFileList;
		}
	}
}
