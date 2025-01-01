package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class LectureVO {
	private String lecNo;
	private String proNo;
	private String subNo;
	private String facNo;
	private String lecName;
	private String lecExplain;
	private int lecMax;
	private int lecNow;
	private String lecOnoff;
	private int lecAge;
	private int lecScore;
	private String comDetLNo;
	private String comDetCNo;
	private String fileGroupNo;
	private String year;
	private String semester;
	private int lecMidRate;
	private int lecLastRate;
	private int lecAssRate;
	private int lecExamRate;
	private int lecAdRate;
	private int lecAtRate;
	private String rejContent;
	
	private String proName;
	private String comDetLName;
	private String comDetCName;
	private String buiName;
	private String facName;
	private String subName;
	
	private String[] lectureTimes;
	
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























