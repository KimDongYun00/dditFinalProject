package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class VolunteerVO {

	private String volNo;
	private String stuNo;
	private String volName;
	private String volContent;
	private int volTime;
	
	private String volRegdate;
	private String volSdate;
	private String volEdate;
	private String comDetCNo;
	private String fileGroupNo;
	private String rejContent;
	
	// 학생이름 사용하려고 가져옴
	private String stuName;
	// 학과이름
	private String deptName;
	
	// rnum
	private int rnum;
	
	// 파일 이름바꾸기 귀찮아서 그냥 가져와서 쓰겠다.
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
