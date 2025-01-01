package kr.or.ddit.menu.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.MenuMapper;
import kr.or.ddit.vo.MenuVO;

@Service
public class MenuServiceImpl implements MenuService {
	@Inject
	private MenuMapper mapper;
	
	@Override
	public void insertMenu(MenuVO menuVO) {
		mapper.insertMenu(menuVO);
	}

	@Override
	public List<MenuVO> selectMenu() {
		return mapper.selectMenu();
	}

	@Override
	public void deleteMenu() {
		mapper.deleteMenu();
	}

	@Override
	public List<MenuVO> selectMenuDay(String menuDay) {
		
		return mapper.selectMenuDay(menuDay);
	}

}
