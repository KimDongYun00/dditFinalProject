package kr.or.ddit.vo;

import lombok.Data;

@Data
public class LectureNoticeVO {
	private String lecNotNo;
	private String lecNo;
	private String lecNotTitle;
	private String lecNotContent;
	private String lecNotDate;
	private int lecNotCnt;
	private int rnum;
}
