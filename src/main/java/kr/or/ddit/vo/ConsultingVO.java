package kr.or.ddit.vo;

import lombok.Data;

@Data
public class ConsultingVO {
	private String conNo;
	private String stuNo;
	private String proNo;
	private String conTitle;
	private String conContent;
	private String conRegdate;
	private String conDate;
	private String conOnoff;
	private String comDetSNo;
	private String comDetNNo;
	private String conResult;
	
	//조인을 위해 임시로 넣는 데이터.. 학생이름, 교수 이름
	private String stuName;	// 학생
	private String proName;	// 교수
	
	private StudentVO studentVO;

	// rnum
	private int rnum;
}
