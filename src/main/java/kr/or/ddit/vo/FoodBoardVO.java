package kr.or.ddit.vo;

import lombok.Data;

@Data
public class FoodBoardVO {
	private int rnum;//행번호
    private String foodNo;
    private String userNo;
    private String foodTitle;
    private String foodWriter;
    private String foodContent;
    private int foodCnt;
    private String foodDate;
    private String foodMapx;
    private String foodMapy;
    
    private int recommendCount; // 추천 수 필드 추가
}
