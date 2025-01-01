package kr.or.ddit.service.admin.inter;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.FoodBoardVO;

public interface IAdminFoodBoardService {

	// 목록
	public List<FoodBoardVO> foodList(Map<String, Object> map);

	// 상세
	public FoodBoardVO detail(String foodNo);

	// 등록
	public void foodboardInsert(FoodBoardVO foodboardVO);

	// 검색
	public List<FoodBoardVO> searchFood(String keyword);

	// 수정
	public void foodBoardUpdate(FoodBoardVO foodBoardVO);

	// 삭제
	public void foodBoardDelete(FoodBoardVO foodBoardVO);

	// 추천
	public boolean recommendFood(String foodNo, String userNo);

	// 추천 수 조회
	public int getRecommendCount(String foodNo);

	// 페이징 전체 행 개수
	public int getFoodBoardCount(Map<String, Object> map);


}
