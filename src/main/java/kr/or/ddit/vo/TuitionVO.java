package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class TuitionVO {
	
	private String tuiNo;
	private String deptNo;
	private int tuiPayment;
	private String comDetBNo;
	private String tuiAccount;
	private String tuiSdate;				// 납부 시작 일자
	private String tuiEdate;				// 납부 끝 일자
	private String year;
	private String semester;
	
	private String bankName;				// 은행 이름
	private String deptName;
	
	// 등록급 납부 현황 조회를 위한
	private String tuiPayYn;	// 납부 여부
	
	private List<TuitionPaymentVO> tuiPayList;
}



















