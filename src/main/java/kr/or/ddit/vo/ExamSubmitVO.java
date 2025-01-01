package kr.or.ddit.vo;

import lombok.Data;

@Data
public class ExamSubmitVO {

	private String examSubNo;
	private String examQueNo;
	private String stuNo;
	private String examSubAnswer;
	private int examSubScore;
	
	private String[] answerArr;
	private String examNo;
}
