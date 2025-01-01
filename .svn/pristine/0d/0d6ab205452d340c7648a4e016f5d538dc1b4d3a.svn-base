package kr.or.ddit.controller.professor;

import java.security.Principal;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sound.midi.MidiDevice.Info;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.professor.inter.IProMypageService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/professor")
public class ProMypageController {
	
	@Inject
	private IProMypageService mypageService;
	
	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String mypage(RedirectAttributes ra, Model model, HttpSession session) {
		String goPage ="";
		
		// HttpSession 이용 방법
//		UserVO userVO = (UserVO)session.getAttribute("user");
		// 시큐리티 인증 시 
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		if(userVO != null) {
			log.info("이 유저의 권한들은? ====> " + user.getAuthorities());
			ProfessorVO professor = mypageService.selectProfessor(user.getUsername());
		
			
			if(professor != null) {
				session.setAttribute("profVO", professor);
				goPage ="sum/professor/mypage/mypage";
			}
		}else {
			ra.addFlashAttribute("msg" , "로그인 후 사용가능합니다!");
			return "redirect:/common/login";
		}
		
		return goPage;
	}
	
	@RequestMapping(value = "/modify.do", method = RequestMethod.GET)
	public String modifyProfessorForm(Model model, Principal principal, HttpSession session) {
		log.info("modifyProfessorForm() 실행 !!!!!");
		//로그인 한 아이디
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		ProfessorVO professor = mypageService.selectProfessor(user.getUsername());
		
		DepartmentVO dept = mypageService.departmentInfo(userVO.getProfVO().getDeptNo());
		
		
		session.setAttribute("profVO", professor);
		model.addAttribute("proDep", dept);
		return "sum/professor/mypage/modify";
	}
	
	@RequestMapping(value = "/profileUpdate.do",method = RequestMethod.POST)
	public String modifyProfessor(RedirectAttributes ra,HttpServletRequest req, HttpSession session,
			ProfessorVO professorVO, Model model) {
		log.info("modifyProfessor() 실행 !!!!!");
		String goPage ="";
		ServiceResult result = mypageService.profileUpdate(req, professorVO);
		if (result.equals(ServiceResult.OK)) {
			log.info("result -->" +result);
			ra.addAttribute("msg", "수정을 완료하였습니다!");
			goPage = "redirect:/professor/modify.do";
		} else {
			log.info("result -->" +result);
			model.addAttribute("msg", "서버에러, 다시 시도해주세요!");
			model.addAttribute("professorVO", professorVO);
			return "redirect:/professor/modify.do";
		}
		
		return goPage;
	}
}
