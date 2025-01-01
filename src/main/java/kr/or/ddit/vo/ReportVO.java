package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVO {
	private int rnum; // 행번호 추가
	private String repNo; // 사용자번호 X0101
	private String userNo; // 신고번호 X01
	private String repReason; // 신고사유 욕설신고
	private String repDate; // 신고일시 SYSDATE
	private String boardPkNo; // 게시판기본키
	private String comDetxNo; // 공통코드신고


}
