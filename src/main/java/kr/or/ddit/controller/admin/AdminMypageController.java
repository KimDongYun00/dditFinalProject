package kr.or.ddit.controller.admin;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.menu.service.MenuService;
import kr.or.ddit.service.admin.inter.IAdminMypageService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminMypageController {
	
	@Inject
	private IAdminMypageService mypageService;
	// 학식표 서비스
	@Inject	
	private MenuService service;
	
	// 관리자 로그인 시 초기화면
	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String mypage(Model model, RedirectAttributes ra, HttpSession session) {
		String goPage ="";
		
		// HttpSession 이용 방법
//		UserVO userVO = (UserVO)session.getAttribute("user");
		// 시큐리티 인증 시 
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		List<MenuVO> mList =  service.selectMenuDay("M");
		List<MenuVO> lList =  service.selectMenuDay("L");
		List<MenuVO> dList =  service.selectMenuDay("D");
		
		if(userVO != null) {
			model.addAttribute("mList", mList);
			model.addAttribute("lList", lList);
			model.addAttribute("dList", dList);
			EmployeeVO empVO = mypageService.selectAdmin(user.getUsername());
			session.setAttribute("empVO", empVO);
			goPage ="sum/admin/mypage/mypage";			
		}else {
			ra.addFlashAttribute("msg" , "로그인 후 사용가능합니다!");
			return "redirect:/common/login";
		}		
		return goPage;		
	}
	
	@RequestMapping(value = "/modify.do", method = RequestMethod.GET)
	public String modifyAdminForm(Model model) {
		// 세션에 정보가 있기 때문에 이 메소드는 페이지 이동만 시킨다.
		
		
		log.info("학생 정보 수정 창으로 이동@@@@@@@@@@@@@");		
		
		return "sum/admin/mypage/modify";
	}
	
	@RequestMapping(value = "/profileUpdate.do",method = RequestMethod.POST)
	public String modifyEmployee(RedirectAttributes ra,HttpServletRequest req, HttpSession session,
			EmployeeVO empVO, Model model) {
		log.info("modifyProfessor() 실행 !!!!!");
		String goPage ="";
		ServiceResult result = mypageService.profileUpdate(req, empVO);
		if (result.equals(ServiceResult.OK)) {
			EmployeeVO empVO1 = mypageService.selectAdmin(empVO.getEmpNo());
			log.info("result -->" + result);
			ra.addFlashAttribute("msg", "수정을 완료하였습니다!");
			session.setAttribute("empVO", empVO1);
						
			
			goPage = "redirect:/admin/modify.do";
			
		} else {
			log.info("result -->" +result);
			ra.addFlashAttribute("msg", "서버에러, 다시 시도해주세요!");
			model.addAttribute("empVO", empVO);
			return "sum/admin/mypage/modify";
		}
		
		return goPage;
	}
}

