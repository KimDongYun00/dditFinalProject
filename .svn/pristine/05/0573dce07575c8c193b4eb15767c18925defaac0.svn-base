package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ScholarshipVO {
	private int rnum;			// 페이징처리를 위한
	private String schNo; 		// 장학금번호
	private String schName;		// 장학금이름
	private String schContent; 	// 장학 내용
	private String schReq; 		// 장학조건
	private int schAmount; 		// 장학금액
	private String schType; 	// 장학종류(선차감)
	private int schMax; 		// 장학수혜가능총인원수
	private String fileGroupNo; // 파일그룹번호
	
	// 신청 내역
	private String schRecNo; 	// 장학금수혜번호
	private String stuNo; 		// 학번
	private String stuName;		// 학생이름
	private String schRecDate; 	// 수혜일자
	private String comDetCNo; 	// 승인처리여부
	private String year; 		// 년도
	private String semester; 	//학기
	private String rejContent; 	// 반려사유
	private String schAplDate;	// 신청일자
	
	// 학과 관련
	private String deptNo;    	// 학과 번호
    private String deptName;  	// 학과 이름
    
    // 장학금 파일 처리
 	private MultipartFile[] schFile;
 	private List<FileVO> schFileList;

 	public void setSchFile(MultipartFile[] schFile) {
 		this.schFile = schFile;
 		if (schFile != null) {
 			List<FileVO> schFileList = new ArrayList<FileVO>();
 			for (MultipartFile item : schFile) {
 				if (StringUtils.isBlank(item.getOriginalFilename()))
 					continue;
 				FileVO scholarshipFileVO = new FileVO(item);
 				schFileList.add(scholarshipFileVO);
 			}
 			this.schFileList = schFileList;
 		}
 	}

}
