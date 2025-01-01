package kr.or.ddit.vo;

import lombok.Data;

@Data
public class LectureEvaluateVO {

	private String couNo;
	private long lecEvaScore;
	private String lecEvaContent;
	private String lecEvaQueNo;
	
	private String[] lecEvaContentArr;
	private String lecNo;
	private String stuNo;
}
