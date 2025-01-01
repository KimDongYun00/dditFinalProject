package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class LicenseVO {
	private String rnum;  // 페이징 처리를 위한 
	private String licNo; // 자격증번호
	private String stuNo; // 학번
	private String licName; // 자격증명
	private String licContent; // 자격내용
	private String licLimit; // 유효기간
	private String licDate; // 발급날짜
	private String comdetCNo; // 공통코드_승인
	private String licRegdate; // 신청날짜
	private String fileGroupNo; // 파일그룹번호
	private String rejContent; // 반려사유
	
	// 자격증 신청 관련
	private String stuName; // 학생이름

	// 학과 관련
	private String deptNo; // 학과 번호
	private String deptName; // 학과 이름
	
	
	
	// 자격증 파일 처리
	private MultipartFile[] licFile;
	private List<FileVO> licFileList;

	public void setLicFile(MultipartFile[] licFile) {
		this.licFile = licFile;
		if (licFile != null) {
			List<FileVO> licFileList = new ArrayList<FileVO>();
			for (MultipartFile item : licFile) {
				if (StringUtils.isBlank(item.getOriginalFilename()))
					continue;
				FileVO licenseFileVO = new FileVO(item);
				licFileList.add(licenseFileVO);
			}
			this.licFileList = licFileList;
		}
	}
}
