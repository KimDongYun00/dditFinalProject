package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

//import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.FoodBoardVO;

//@Mapper
public interface FoodBoardMapper {

	public List<FoodBoardVO> foodList();

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
	public int checkIfAlreadyRecommended(Map<String, Object> params);
	
	// 추천 등록
	public void insertRecommendation(Map<String, Object> params);
	
	// 추천 수 업데이트 
	public void updateRecommendCount(String foodNo);
	
	// 추천 수 조회 메서드
	public int getRecommendCount(String foodNo); 

	// 페이징 foodlist
	public List<FoodBoardVO> foodList(Map<String, Object> map);

	// 페이징 foodlist의 전체행개수
	public int getFoodBoardCount(Map<String, Object> map);



}
