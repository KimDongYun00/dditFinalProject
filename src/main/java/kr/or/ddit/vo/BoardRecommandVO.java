package kr.or.ddit.vo;

import lombok.Data;

@Data
public class BoardRecommandVO {
	private String boRecNo; 	// 추천수
	private String userNo;		// 사용자 
	private String boardPkNo;	// 게시판

}
