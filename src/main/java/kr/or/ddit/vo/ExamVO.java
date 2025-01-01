package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ExamVO {
	private String examNo;
	private String lecNo;
	private String comDetHNo;
	private String examName;
	private String examContent;
	private String examDate;
	private String examTime;
	private int examLimit;
	private String examRegdate;
	
	private ExamQuestionVO[] examQueArr;
	private List<ExamQuestionVO> examQueList;
	
	private String lecName;
	private String comDetHName;
}
