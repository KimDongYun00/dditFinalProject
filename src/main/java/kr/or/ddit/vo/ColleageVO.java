package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ColleageVO {
	private String colNo;				// 단과대학번호
	private String proNo;				// 교번
	private String colName;				// 단과대학명
	private String colExplain;			// 단과대설명
	private String colCall;				// 단과대 전화번호
	
	private List<String> deptList;		// 단과대 소속 학과번호
}


















