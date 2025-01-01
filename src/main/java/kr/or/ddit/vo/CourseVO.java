package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CourseVO {
	private String couNo;
	private String lecNo;
	private String stuNo;
	private int couLast;
	private int couMiddle;
	private int couAssignment;
	private int couExam;
	private int couAttendance;
	private int couAttitude;
	private int couTotal;
	private double couScore;
	private String couYn;
	
	//과목 테이블 데이터 
	private String lecName;
	private String year;
	private String semester;
	private String lecAge;
	
	private StudentVO studentVO;
	private String[] stuScoreArr;
}
