package kr.or.ddit.vo;

import lombok.Data;

@Data
public class LectureTimetableVO {
	private String lecTtNo;
	private String lecNo;
	private String comDetWNo;
	private String comDetTNo;
	
	private String comDetTName;
	private String lecName;
	private String buiName;
	private String facName;
}
