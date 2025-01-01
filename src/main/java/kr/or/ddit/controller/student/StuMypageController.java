package kr.or.ddit.controller.student;

import java.security.Principal;
import java.util.Map;

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
import kr.or.ddit.service.admin.inter.IAdminGraReqService;
import kr.or.ddit.service.student.inter.IStuMypageService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.GraReqVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/student")
public class StuMypageController {

	@Inject
	private IStuMypageService mypageService;
	
	@Inject
	private IAdminGraReqService graService;
	
	
	// 학생 로그인 초기화면
	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String mypage(Model model, RedirectAttributes ra, HttpSession session) {
		String goPage ="";
		
		// HttpSession 이용 방법
//		UserVO userVO = (UserVO)session.getAttribute("user");
		// 시큐리티 인증 시 
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		if(userVO != null) {
			StudentVO stuVO = new StudentVO();
			stuVO = mypageService.selectStudent(userVO.getUserNo());
			GraReqVO graReqVO = graService.getStuGraReq(userVO.getStuVO().getStuNo());
			Map<String, String> graScoreMap = graService.getStuGraReqScore(userVO.getStuVO().getStuNo());
			session.setAttribute("stuVO", stuVO);
			
			
			if(stuVO != null) {
				model.addAttribute("stuVO", stuVO);
				model.addAttribute("graReqVO", graReqVO);
				model.addAttribute("graScoreMap", graScoreMap);
				goPage ="student/mypage/mypage";
			}
		}else {
			ra.addFlashAttribute("msg" , "로그인 후 사용가능합니다!");
			return "redirect:/common/login";
		}		
		return goPage;		
	}
	
	@RequestMapping(value = "/modify.do", method = RequestMethod.GET)
	public String modifyStudentForm(Model model, Principal principal, HttpSession session) {
		// 세션에 정보가 있기 때문에 이 메소드는 페이지 이동만 시킨다. 세션이 로그인시에만 저장이 가능하다.
		// 모델을 불러와서 저장해주자.
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		StudentVO stuVO = mypageService.selectStudent(userVO.getUserNo());
		session.setAttribute("stuVO", stuVO);
		log.info("학생 정보 수정 창으로 이동@@@@@@@@@@@@@");		
		
		return "student/mypage/modify";
	}
	
	@RequestMapping(value = "/profileUpdate.do",method = RequestMethod.POST)
	public String modifyProfessor(RedirectAttributes ra,HttpServletRequest req, HttpSession session,
			StudentVO stuVO, Model model) {
		log.info("modifyProfessor() 실행 !!!!!");
		String goPage ="";
		ServiceResult result = mypageService.profileUpdate(req, stuVO);
		if (result.equals(ServiceResult.OK)) {
			log.info("result -->" + result);
			ra.addFlashAttribute("msg", "수정을 완료하였습니다!");
		
			
			goPage = "redirect:/student/modify.do";
			
		} else {
			log.info("result -->" +result);
			ra.addFlashAttribute("msg", "서버에러, 다시 시도해주세요!");
			model.addAttribute("stuVO", stuVO);
			return "student/mypage/modify";
		}
		
		return goPage;
	}
}
