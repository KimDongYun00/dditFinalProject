package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CertificationPrintVO {

	private int rnum;
	private String cerPriNo;		// 증명서 발급 번호
	private String cerNo;			// 증명서 번호
	private String stuNo;			// 학생 학번
	private String cerPriDate;	// 증명서 발급일자
	private String deptName; 	//학과
	
}
