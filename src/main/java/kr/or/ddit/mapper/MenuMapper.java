package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.MenuVO;

public interface MenuMapper {

	public void insertMenu(MenuVO menuVO);

	public List<MenuVO> selectMenu();

	public void deleteMenu();

	public List<MenuVO> selectMenuDay(String menuDay);

}
