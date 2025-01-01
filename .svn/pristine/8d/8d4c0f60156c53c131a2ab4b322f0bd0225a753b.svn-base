package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.FoodBoardVO;

public interface AdminFoodBoardMapper {
	
	public List<FoodBoardVO> foodList(Map<String, Object> map);

	public FoodBoardVO detail(String foodNo);

	// 등록
	public void foodboardInsert(FoodBoardVO foodboardVO);

	// 검색
	public List<FoodBoardVO> searchFood(String keyword);

	// 수정
	public void foodBoardUpdate(FoodBoardVO foodBoardVO);

	// 삭제
	public void foodBoardDelete(FoodBoardVO foodBoardVO);

	// 추천 여부 체크
	public int checkIfAlreadyRecommended(Map<String, Object> params);

	// 추천 등록
	public void insertRecommendation(Map<String, Object> params);

	// 추천 수 조회
	public int getRecommendCount(String foodNo);

	// 페이징
	public int getFoodBoardCount(Map<String, Object> map);

	
}
