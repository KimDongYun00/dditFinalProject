package kr.or.ddit.service.professor.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.FoodBoardMapper;
import kr.or.ddit.service.professor.inter.IFoodBoardService;
import kr.or.ddit.vo.FoodBoardVO;

@Service
public class ProFoodBoardServiceImpl implements IFoodBoardService {

	@Inject
	private FoodBoardMapper mapper;

	@Override
	public List<FoodBoardVO> foodList() {
		return mapper.foodList();
	}

	@Override
	public FoodBoardVO detail(String foodNo) {
		return mapper.detail(foodNo);
	}
	
	// 등록
	@Override
	public void foodboardInsert(FoodBoardVO foodboardVO) {
		mapper.foodboardInsert(foodboardVO);
	}

	// 검색
	@Override
	public List<FoodBoardVO> searchFood(String keyword) {
		return mapper.searchFood(keyword);
	}

	// 수정
	@Override
	public void foodBoardUpdate(FoodBoardVO foodBoardVO) {
		mapper.foodBoardUpdate(foodBoardVO);

	}

	// 삭제
	@Override
	public void foodBoardDelete(FoodBoardVO foodBoardVO) {
		mapper.foodBoardDelete(foodBoardVO);

	}

	
	// 추천
	@Override
	public boolean recommendFood(String foodNo, String userNo) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("foodNo", foodNo);
	    params.put("userNo", userNo);

	    int count = mapper.checkIfAlreadyRecommended(params);
	    if (count > 0) {
	        return false;
	    }

	    mapper.insertRecommendation(params);
//	    mapper.updateRecommendCount(foodNo);	// 추천 수 업데이트
	    return true;
	}
	
	// 추천 수
	public int getRecommendCount(String foodNo) {
	    return mapper.getRecommendCount(foodNo);
	}


	// 페이지
	@Override
	public List<FoodBoardVO> foodList(Map<String, Object> map) {
		return mapper.foodList(map);
	}

	// 페이지
	@Override
	public int getFoodBoardCount(Map<String, Object> map) {
		return mapper.getFoodBoardCount(map);
	}
	

}
