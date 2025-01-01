package kr.or.ddit.menu.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.menu.service.MenuService;
import kr.or.ddit.vo.MenuVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/menu")
public class MenuController {
	
	@Inject	
	private MenuService service;
	
	@RequestMapping(value="/menuList")
	public String menuList(Model model) {
		
		List<MenuVO> mList =  service.selectMenuDay("M");
		List<MenuVO> lList =  service.selectMenuDay("L");
		List<MenuVO> dList =  service.selectMenuDay("D");
		model.addAttribute("mList", mList);
		model.addAttribute("lList", lList);
		model.addAttribute("dList", dList);
		
		return "sum/menu/menu";
	}
	
	@RequestMapping(value="/insertMenu", method = RequestMethod.POST)
	public ResponseEntity<String> insertMenu(@RequestBody Map<String, List<String>> map) {
		MenuVO mMenuVO = new MenuVO();	// 아침메뉴
		MenuVO lMenuVO = new MenuVO();	// 점심메뉴
		MenuVO dMenuVO = new MenuVO();	// 저녘메뉴
		
		
		List<MenuVO> menuList =  service.selectMenu();

		// 메뉴 리스트가 있다면 메뉴리스트를 전체 삭제하고
		if(menuList != null) {
			service.deleteMenu();			
		}
		
		// 새로 인서트한다.
		for (int i = 0; i < map.get("mmL").size(); i++) {
			String mMenu = map.get("mmL").get(i);
			int mPrice =   Integer.valueOf(map.get("mpL").get(i));
			String lMenu = (String) map.get("lmL").get(i);
			int lPrice = Integer.valueOf(map.get("lpL").get(i));
			String dMenu = (String) map.get("dmL").get(i);
			int dPrice = Integer.valueOf(map.get("dpL").get(i));
			String day = "W010"+Integer.valueOf(i+1);

			mMenuVO.setMenuFood(mMenu);
			mMenuVO.setMenuPrice(mPrice);
			mMenuVO.setMenuDay("M");
			mMenuVO.setComDetWNo(day);
			service.insertMenu(mMenuVO);
			
			lMenuVO.setMenuFood(lMenu);
			lMenuVO.setMenuPrice(lPrice);
			lMenuVO.setMenuDay("L");
			lMenuVO.setComDetWNo(day);
			service.insertMenu(lMenuVO);
			
			dMenuVO.setMenuFood(dMenu);
			dMenuVO.setMenuPrice(dPrice);
			dMenuVO.setMenuDay("D");
			dMenuVO.setComDetWNo(day);
			service.insertMenu(dMenuVO);
		}
		
				
		
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
}
