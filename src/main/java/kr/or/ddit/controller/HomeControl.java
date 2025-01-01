package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.service.common.IUserLoginService;
import kr.or.ddit.vo.BoardVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeControl {
	
	@Inject
	private IUserLoginService iUserLoginService;
	
	 // 서버부팅하자마자	 메인페이지로 이동하기
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Model model) {
    	// 날짜별로 데이터를 가져오는데 이걸 5개만 보내고 싶을때
    	List<BoardVO> noticeBoard =  iUserLoginService.selectNotice();
    	
    	List<BoardVO> noticeBoardList = new ArrayList<BoardVO>();
    	
    	for (int i = 0; i < 4; i++) {
			noticeBoardList.add(noticeBoard.get(i));
			log.info("noticeBoardList == > " + noticeBoardList.get(i));
		}
    	
    	
    	model.addAttribute("resultBoard", noticeBoardList);
    	
        return "common/login";
    }
}






