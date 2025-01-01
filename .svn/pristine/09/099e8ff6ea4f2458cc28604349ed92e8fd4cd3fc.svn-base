package kr.or.ddit.service.admin.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AdminFoodBoardMapper;
import kr.or.ddit.service.admin.inter.IAdminFoodBoardService;
import kr.or.ddit.vo.FoodBoardVO;

@Service
public class AdminFoodboardServiceImpl implements IAdminFoodBoardService {

	@Inject 
	private AdminFoodBoardMapper mapper;

	@Override
	public List<FoodBoardVO> foodList(Map<String, Object> map) {
		return mapper.foodList(map);
	}

	@Override
	public FoodBoardVO detail(String foodNo) {
		return mapper.detail(foodNo);
	}

	@Override
	public void foodboardInsert(FoodBoardVO foodboardVO) {
		mapper.foodboardInsert(foodboardVO);
	}

	@Override
	public List<FoodBoardVO> searchFood(String keyword) {
		return mapper.searchFood(keyword);
	}

	@Override
	public void foodBoardUpdate(FoodBoardVO foodBoardVO) {
		mapper.foodBoardUpdate(foodBoardVO);
	}

	@Override
	public void foodBoardDelete(FoodBoardVO foodBoardVO) {
		mapper.foodBoardDelete(foodBoardVO);
	}

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
		return true;
	}

	@Override
	public int getRecommendCount(String foodNo) {
		return mapper.getRecommendCount(foodNo);
	}

	@Override
	public int getFoodBoardCount(Map<String, Object> map) {
		return mapper.getFoodBoardCount(map);
	}




}
